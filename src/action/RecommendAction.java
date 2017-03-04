package action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;

import java.lang.Math;
import com.hankcs.hanlp.HanLP;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import model.Activity;
import model.User;
import service.impl.ActivityService;
import service.impl.UserService;

public class RecommendAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long aid;
	private String plaintext;
	private String sponsor;
	private String head;
	private ActivityService activityService;
	private UserService userService;

	public Long getAid() {
		return aid;
	}
	public void setAid(Long aid) {
		this.aid = aid;
	}
	public String getPlaintext() {
		return plaintext;
	}
	public void setPlaintext(String plaintext) {
		this.plaintext = plaintext;
	}
	public String getSponsor() {
		return sponsor;
	}
	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public ActivityService getActivityService() {
		return activityService;
	}
	public void setActivityService(ActivityService activityService) {
		this.activityService = activityService;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	/*
	 * 当活动上传完成后，从活动描述及标题中抽取本活动关键词，记入数据库，作为ItemProfile
	 * 将活动类别和发起者也加入keywordlist。
	 */
	public String extract(){
		//从标题和活动描述中提取5个关键词，标题比较重要，所以重复来提高比重
		Activity activity=activityService.findActivityById(aid);
		List<String> keywordList =new ArrayList(); 
		keywordList	= HanLP.extractKeyword(StringUtils.repeat(head, 4)+plaintext, 5);
		//相同的发起者可能会发起类似的活动，所以将发起者直接作为一个关键词
		keywordList.add(activity.getSponsor());
		//相同类别的活动可能内容也相似，所以将类别也作为一个关键词
		keywordList.add("c"+activity.getCategory());
		activity.setKeywords(keywordList);
		activityService.editActivity(activity);
		return SUCCESS;
	}
	/*
	 * 计算用户和活动之间的距离（余弦相似度），按从大到小将前8个有效相似活动放入List recActs中，再放入session
	 * 有效相似活动指计算出来的余弦相似度不为0的
	 * 如果获取的有效相似活动少于8个，则加入全站中最热门活动（报名人数最多的）前几项
	 */
	public String calDist(){
		//获取所有已通过审核的活动
		List<Activity> activities=activityService.listPassedActivities();
		Map<String, Object> session = ActionContext.getContext().getSession();
		if (session.get("userName")==null) return ERROR;
		String username=(String) session.get("userName");
		User user=userService.findUserById(username);
		//存放activity，按sim值从小到大。
		Map<Activity,Double> sims=new HashMap();
		Map<Activity,Integer> apl=new HashMap();
		Map <String,String> userProfile=new HashMap();
		userProfile=user.getUserProfile();
		//计算每个活动和这个用户的相似度（sim），加入list sims中
		//查找每个活动报名人数，加入 list apl中
		for(int i=0;i<activities.size();i++){
			double sim;
			Activity cur=activities.get(i);
			Set<User> appliers=cur.getUsers();
			if(appliers.contains(user)) continue;
			Set<String> keys=new HashSet();
			List<String> keywords=cur.getKeywords();
			Set<String> keywordsSet=new HashSet(keywords);
			keys=userProfile.keySet();
			keywordsSet.addAll(keys);
			
			double UA=0,U2=0,A2=0;
			Iterator<String> it=keywordsSet.iterator();
			//遍历这个用户和这个活动的所有关键词，计算∑Uk*Ak（UA）,∑Uk^2(U2),∑Ak*2(A2）
			while(it.hasNext()){
				String k=it.next();
				String[] params;
				double Uk=0;
				if(userProfile.containsKey(k)){
					params=userProfile.get(k).split("a");
					Uk=Double.parseDouble(params[1]);
				}
				int Ak=(keywords.contains(k)?1:0);
				UA+=Uk*Ak;
				U2+=Uk*Uk;
				A2+=Ak*Ak;
			}
			double tmp=java.lang.Math.sqrt(U2)*java.lang.Math.sqrt(A2);
			sim=(tmp==0)?0:(UA/tmp);
			if(sim>0)
				sims.put(cur,sim);
			int total=activityService.totalOfApply(cur.getAid());
			if(total>0)
				apl.put(cur, total);
		}
		//对sims和apl进行降序排序
		List<Map.Entry<Activity, Double>> simslist=new ArrayList<Map.Entry<Activity, Double> >(sims.entrySet());
		Collections.sort(simslist,new Comparator<Map.Entry<Activity,Double>>(){
			public int compare(Entry<Activity, Double> o1,
                    Entry<Activity,Double> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
		});
		List<Map.Entry<Activity,Integer>> apllist=new ArrayList<Map.Entry<Activity,Integer>>(apl.entrySet());
		Collections.sort(apllist,new Comparator<Map.Entry<Activity, Integer>>(){
			public int compare(Entry<Activity,Integer> o1,
					Entry<Activity,Integer> o2){
				return o2.getValue().compareTo(o1.getValue());
			}
		});
		//将相似度不为0的按相似度从大到小放入list recActs中
		List<Activity> recActs=new ArrayList();
		Iterator it=simslist.iterator();
		while(it.hasNext()&&recActs.size()<8){
			Activity act=((Entry<Activity, Double>) it.next()).getKey();
			recActs.add(act);
		}
		//如果相似度不为0的活动数量小于8，则补充以报名人数多的热门活动（避免对未报名用户无推荐活动的情况）
		it=apllist.iterator();
		while(it.hasNext()&&recActs.size()<8){
			Activity act=((Entry<Activity, Double>) it.next()).getKey();
			if(!recActs.contains(act))
				recActs.add(act);
		}
		session.put("recommend", recActs);
		return SUCCESS;
	}
}
