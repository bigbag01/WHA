package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import model.Activity;
import model.Activitycontent;
import model.Message;
import model.User;
import service.impl.ActivityService;
import service.impl.MessageService;
import service.impl.UserService;

public class ApplyAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String username;
	private Long aid;
	private String data;
	private int rating;
	private ActivityService activityService;
	private UserService userService;
	private MessageService messageService;
	private HttpServletResponse response = ServletActionContext.getResponse();
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Long getAid() {
		return aid;
	}
	public void setAid(Long aid) {
		this.aid = aid;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
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
	public MessageService getMessageService() {
		return messageService;
	}
	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}
	
	/*
	 * 当用户对活动打分后，将该活动关键词记入UserProfile,每个key对应的value就是这个词所占比重
	 * 词的比重：每次出现时所在活动的rank之平均 
	 * 用 关键词出现的次数（cnt）和 关键词的平均权重 avg 构造字符串，记入数据库
	 * 用split函数得到cnt和avg
	 */
	public void recKeyword(User user,Activity activity,int rating){
		Map<String,String> map=user.getUserProfile();
		List<String> keywords=activity.getKeywords();
		Map<String,Integer> ranks=activity.getRanks();

		for(int i=0;i<keywords.size();i++){
			String e=keywords.get(i);
			String weight;
			if(map.containsKey(e)){
				weight=map.get(e);
				String[] params=weight.split("a");
				int cnt=Integer.parseInt(params[0]);
				double avg=Double.parseDouble(params[1]);
				avg=(avg*cnt+rating)/(cnt+1);
				weight=String.valueOf(cnt+1)+"a"+String.valueOf(avg);
			}else{
				weight=String.valueOf(1)+"a"+String.valueOf(rating);
			}
			map.put(e, weight);
		}
		user.setUserProfile(map);
		userService.editUser(user);
		return;
	}
	
	/*
	 * 用户报名，如果已报名人数已经大于等于限制则返回“exceed”,如果当前用户已报过名，返回“applied”，否则成功返回“ok”
	 */
	public String apply() throws IOException{
		Activity activity=activityService.findActivityById(aid);
		User user=userService.findUserById(username);
		Set<User>users=activity.getUsers();
		String result;
		PrintWriter pw=response.getWriter();
		if(activityService.totalOfApply(aid)>=activity.getLimitation()){
			result="exceed";
		}else if(users.contains(user)) {
			result="applied";
		}else if(activity.getAplend().before(new Date())){
			result="late";
		}else{
			users.add(user);
			activity.setUsers(users);
			//Map<String,Integer> ranks=activity.getRanks();
			//ranks.put(username, 3);
			//activity.setRanks(ranks);
			activityService.editActivity(activity);
			//recKeyword(user,activity);
			result="ok";
		}
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}

	/*
	 * 根据前端传回的aid，获取报名者的信息。
	 */
	public String showAppliers() throws IOException{
		Map<String, Object> session = ActionContext.getContext().getSession();
		if(!session.containsKey("userName")) return ERROR;
		List<User> appliers=activityService.findAppliersById(aid);

		Gson gson = new GsonBuilder()
		        .excludeFieldsWithoutExposeAnnotation()
		        .create();

		String result=gson.toJson(appliers);
		//设置response的ContentType解决中文乱码
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}

	/*
	 * 取消报名,同时如果打过分，则删除打分记录。
	 */
	public String cancelApply() throws IOException{
		
		Activity activity=activityService.findActivityById(aid);
		User user=userService.findUserById(username);
		Set<User>users=activity.getUsers();
		Map<String,Integer> ranks=activity.getRanks();
		String result;
		Date now=new Date();
		if(now.after(activity.getAplend())) result="late";
		else{
			users.remove(user);
			ranks.remove(username);
			activity.setUsers(users);
			activity.setRanks(ranks);
			activityService.editActivity(activity);
			result="ok";
		}
		PrintWriter pw=response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}
	
	/*
	 * 拒绝报名者
	 */
	public String refuse() throws IOException{
		Map<String, Object> session = ActionContext.getContext().getSession();
		if(!session.containsKey("userName")) return ERROR;
		String result;
		Gson gson=new Gson();
		String[] names=gson.fromJson(data, String[].class);
		Date now=new Date();
		Activity activity=activityService.findActivityById(aid);
		if(now.after(activity.getActstart())) result="late";
		else{
			Set<User> appliers=activity.getUsers();
			Map<String,Integer> ranks=activity.getRanks();
			Date date=new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			dateFormat.format(date);
			User publisher=activity.getPublisher();
			String head=activity.getHead();
			for(int i=0;i<names.length;i++){
				User user=userService.findUserById(names[i]);
				appliers.remove(user);
				ranks.remove(names[i]);
				Message message=new Message();
				message.setActivity(activity);
				message.setMyType("failApl");
				message.setReceiver(user);
				message.setSender(publisher);
				message.setTime(date);
				message.setMsg("抱歉，您被拒绝参与活动 【"+head+"】");
				messageService.saveMessage(message);
			}
			activity.setUsers(appliers);
			activity.setRanks(ranks);
			activityService.editActivity(activity);
			result="ok";
		}
		PrintWriter pw=response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}

	/*
	 * 报名者对活动进行打分
	 */
	public String rate() throws IOException{
		Activity activity=activityService.findActivityById(aid);
		Map<String,Integer> rates=activity.getRanks();
		Map<String, Object> session = ActionContext.getContext().getSession();
		if(!session.containsKey("userName")) return ERROR;
		PrintWriter pw=response.getWriter();
		int result;
		String userName=(String)session.get("userName");
		if(rates.containsKey(userName)) result=rates.get(userName);
		else result=rating;
		rates.put(userName, rating);
		activity.setRanks(rates);
		recKeyword(userService.findUserById(userName),activity,rating);
		activityService.editActivity(activity);
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}
}
