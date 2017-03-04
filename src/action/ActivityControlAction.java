package action;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import model.*;
import service.impl.ActivityService;
import service.impl.MessageService;
import service.impl.UserService;

public class ActivityControlAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final static String uploadaddr = "/upload";
	private final static String absoluteaddr="E:/Projects/upload";
	private Long aid;
	private Long mid;
	private String head;
	private int category;
	private String location;
	private String sponsor;
	private String aplstart;
	private String aplend;
	private String actstart;
	private String actend;
	private int limitation;
	private String content;
	private String plaintext;
	private File poster;
	private String posterFileName;
	private String posterContentType;
	private String msg;
	private String receivernm;
	private String res;
	private String qry;
	private UserService userService;
	private ActivityService activityService;
	private MessageService messageService;
	private HttpServletResponse response = ServletActionContext.getResponse();
	public Long getAid() {
		return aid;
	}
	public void setAid(Long aid) {
		this.aid = aid;
	}
	public Long getMid() {
		return mid;
	}
	public void setMid(Long mid) {
		this.mid = mid;
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
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getSponsor() {
		return sponsor;
	}
	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}
	public int getLimitation() {
		return limitation;
	}
	public String getAplstart() {
		return aplstart;
	}
	public void setAplstart(String aplstart) {
		this.aplstart = aplstart;
	}
	public String getAplend() {
		return aplend;
	}
	public void setAplend(String aplend) {
		this.aplend = aplend;
	}
	public String getActstart() {
		return actstart;
	}
	public void setActstart(String actstart) {
		this.actstart = actstart;
	}
	public String getActend() {
		return actend;
	}
	public void setActend(String actend) {
		this.actend = actend;
	}
	public void setLimitation(int limitation) {
		this.limitation = limitation;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPlaintext() {
		return plaintext;
	}
	public void setPlaintext(String plaintext) {
		this.plaintext = plaintext;
	}
	public File getPoster() {
		return poster;
	}
	public void setPoster(File poster) {
		this.poster = poster;
	}
	public String getPosterFileName() {
		return posterFileName;
	}
	public void setPosterFileName(String posterFileName) {
		this.posterFileName = posterFileName;
	}
	public String getPosterContentType() {
		return posterContentType;
	}
	public void setPosterContentType(String posterContentType) {
		this.posterContentType = posterContentType;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getReceivernm() {
		return receivernm;
	}
	public void setReceivernm(String receivernm) {
		this.receivernm = receivernm;
	}
	public String getRes() {
		return res;
	}
	public void setRes(String res) {
		this.res = res;
	}
	public String getQry() {
		return qry;
	}
	public void setQry(String qry) {
		this.qry = qry;
	}
	
	/*
	 * 检查活动结束时间，如果当前时间已结束，就将活动状态设为end
	 */
	public void endActs(){
		List<Activity> acts=activityService.listPassedActivities();
		Iterator<Activity> it=acts.iterator();
		while(it.hasNext()){
			Activity act=it.next();
			Date now=new Date();
			if(now.after(act.getActend())){
				act.setStatus("end");
				activityService.editActivity(act);
			}
		}
	}
	
	/*
	 * 保存用户上传活动信息的action
	 * 上传的活动状态都先设为“waiting”即待审核状态
	 * 上传成功后跳转到活动详细信息页面
	 */
	public String upactivity() throws ParseException, FileNotFoundException, IOException{
		Activitycontent activitycontent=new Activitycontent();
		//时间处理
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		activitycontent.setActend(dateFormat.parse(actend));
		activitycontent.setActstart(dateFormat.parse(actstart));
		activitycontent.setAplend(dateFormat.parse(aplend));
		activitycontent.setAplstart(dateFormat.parse(aplstart));
		//基本信息录入
		activitycontent.setHead(head);
		activitycontent.setCategory(category);
		activitycontent.setLocation(location);
		activitycontent.setLimitation(limitation);
		activitycontent.setSponsor(sponsor);
		//刚刚由用户发布上来的活动状态为待审核（waiting）
		activitycontent.setStatus("waiting");
		Map<String, Object> session = ActionContext.getContext().getSession();
		String un=(String)session.get("userName");
		User user=userService.findUserById(un);
		activitycontent.setPublisher(user);
		if(un.equals("admin")) activitycontent.setStatus("passed");
		activitycontent.setContent(content);
		activitycontent.setPosterpath(posterFileName);
		activityService.saveActivity(activitycontent);		
		Long id=activitycontent.getAid();
		
		String destPath = ServletActionContext.getServletContext().getRealPath(uploadaddr);
		//String destPath=absoluteaddr;
		if(poster!=null){
			File dir=new File(destPath+ "/" + id);
			File backup=new File(absoluteaddr+"/"+id);
			if(!dir.exists()){
				dir.mkdirs();
			}
			if(!backup.exists()) backup.mkdirs();
			File dest=new File(dir,posterFileName);
			if(!dest.getParentFile().exists()){
				dest.getParentFile().mkdirs();
			}
			FileUtils.copyFile(poster, dest);
			FileUtils.copyDirectory(dir, backup);
		}
		setAid(id);
		setRes("preview");
		session.put("activity", activitycontent);
		return SUCCESS;
	}
	
	/*
	 * 活动发布者修改活动信息的action
	 * 上传成功后跳转到活动详细信息页面
	 */
	public String editActivity() throws ParseException, IOException{
		Map<String, Object> session = ActionContext.getContext().getSession();
		Activity act=activityService.findActivityById(aid);
		Activitycontent activity=(Activitycontent)act;
		activity.setHead(head);
		activity.setCategory(category);
		activity.setLocation(location);
		activity.setSponsor(sponsor);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		activity.setActend(dateFormat.parse(actend));
		activity.setActstart(dateFormat.parse(actstart));
		activity.setAplend(dateFormat.parse(aplend));
		activity.setAplstart(dateFormat.parse(aplstart));
		activity.setLimitation(limitation);
		activity.setContent(content);
		String oldposter=activity.getPosterpath();
		if(poster!=null){
			activity.setPosterpath(posterFileName);
		}
		activityService.editActivity(activity);
		String destPath = ServletActionContext.getServletContext().getRealPath(uploadaddr);
		
		if(poster!=null){
			File dir=new File(destPath+ "/" + aid);
			File backup=new File(absoluteaddr+"/"+aid);
			if(!dir.exists()){
				dir.mkdirs();
			}
			if(!backup.exists()) backup.mkdirs();
			File dest=new File(dir,posterFileName);
			if(!dest.getParentFile().exists()){
				dest.getParentFile().mkdirs();
			}
			FileUtils.copyFile(poster, dest);
			FileUtils.copyDirectory(dir, backup);
			File old=new File(dir,oldposter);
			File oldbackup=new File(backup,oldposter);
			if(old.isFile()) {
				old.delete();
				oldbackup.delete();
			}
		}
		if(activity.getStatus().equals("waiting")) setRes("preview");
		return SUCCESS;
	}
	
	/*
	 * 跳转首页时触发的action，负责获取所有通过审核的活动缩略信息并显示在首页
	 * TODO 分页
	 */
	public String showactivities(){
		endActs();
		List<Activity> list=activityService.listPassedActivities();
		Map<String, Object> session = ActionContext.getContext().getSession();
		session.put("activities", list);
		return SUCCESS;
	}

	/* 
	 * 单击活动缩略信息时激发的action
	 * 根据活动aid获取具体活动信息，存入session
	 */
	public String showdetail(){
		Activity act=activityService.findActivityById(aid);
		if(act==null) return "noResource";
		Map<String, Object> session = ActionContext.getContext().getSession();
		session.put("activity", act);
		if(res!=null) {
			if(res.equals("edit"))
				return "editAct";
			if(res.equals("preview"))
				return "preview";
		}
		List list=messageService.findCommentByAid(aid);
		session.put("comment",list);
		int numOfApply=activityService.totalOfApply(aid);
		session.put("numOfApply",numOfApply);
		String userName="";
		userName=(String)session.get("userName");
		User user=userService.findUserById(userName);
		Set<User> su=act.getUsers();
		Map<String,Integer> rates=act.getRanks();
		//若已打过分则显示所打的分，若已报名未打分则初始为0
		int initval=(rates.get(userName)==null?0:rates.get(userName));
		if(su!=null&&su.size()>0&&su.contains(user)){			
			session.put("in",initval);
		}
		else session.put("in", -1);
		return SUCCESS;
	}
	
	/*
	 * 把所有waiting状态即待审核的活动放入session
	 */
	public String showWaiting(){
		List<Activity> list=activityService.listWaitingActivities();
		Map<String,Object> session=ActionContext.getContext().getSession();
		session.put("waitings", list);
		return SUCCESS;
	}
	
	/*
	 * 将活动状态设为通过审核
	 */
	public String pass(){
		Activity activity=activityService.findActivityById(aid);
		activity.setStatus("passed");
		activityService.editActivity(activity);
		return SUCCESS;
	}
	
	/*
	 * 将活动状态设为未通过审核，
	 * 并向活动发布者发送反馈意见
	 */
	public String fail(){
		Activity activity=activityService.findActivityById(aid);
		activity.setStatus("failed");
		Date date=new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.format(date);
		User sender=userService.findUserById("admin");
		User receiver=activity.getPublisher();
		Message message=new Message();
		message.setMsg(msg);
		message.setReceiver(receiver);
		message.setSender(sender);
		message.setTime(date);
		message.setMyType("reject");
		message.setActivity(activity);
		messageService.saveMessage(message);
		activityService.editActivity(activity);
		return SUCCESS;
	}

	/*
	 * 显示我发布的活动
	 */
	public String showMyPub(){
		Map<String,Object> session=ActionContext.getContext().getSession();
		String userName=(String) session.get("userName");
		List<Activity> list=activityService.findActivityByPublisher(userName);
		session.put("myPub", list);
		return SUCCESS;
	}
	
	/*
	 * 显示我参与的活动
	 */
	public String showMyAttend(){
		Map<String,Object> session=ActionContext.getContext().getSession();
		String userName=(String)session.get("userName");
		List<Activity> list=userService.findAttendsById(userName);
		session.put("myAttend", list);
		return SUCCESS;
	}

	/*
	 * 显示我收到的信息
	 */
	public String showMyMessage(){
		Map<String,Object> session=ActionContext.getContext().getSession();
		String userName=(String)session.get("userName");
		List<Message> list=new ArrayList();
		list=userService.findReceiptsById(userName);
		session.put("myMessages", list);
		return SUCCESS;
	}

	/*
	 * 保存评论，成功后刷新页面
	 */
	public String saveComment(){
		Map<String,Object> session=ActionContext.getContext().getSession();
		Activity activity=activityService.findActivityById(aid);
		String userName=(String)session.get("userName");
		User sender=userService.findUserById(userName);
		User receiver=activity.getPublisher();
		if(receivernm!=null&&receivernm.length()>0&&!receivernm.equals(userName))
			receiver=userService.findUserById(receivernm);
		Date time=new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.format(time);
		Message message=new Message();
		message.setActivity(activity);
		message.setMsg(msg);
		message.setReceiver(receiver);
		message.setSender(sender);
		message.setTime(time);
		message.setMyType("comment");
		messageService.saveMessage(message);
		
		
		return SUCCESS;
	}

	/*
	 * 邀请同伴，向指定用户名同伴发送邀请消息，成功后刷新页面
	 */
	public String invite(){
		Activity activity=activityService.findActivityById(aid);
		User receiver=userService.findUserById(receivernm);
		Map<String,Object> session=ActionContext.getContext().getSession();
		String userName=(String)session.get("userName");
		User sender=userService.findUserById(userName);
		if(receiver==null||receivernm.equals(userName)) return SUCCESS;
		Date time=new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.format(time);
		Message message=new Message();
		message.setActivity(activity);
		message.setMsg(msg);
		message.setMyType("invitation");
		message.setReceiver(receiver);
		message.setSender(sender);
		message.setTime(time);
		messageService.saveMessage(message);
		return SUCCESS;
	}
	
	/*
	 * 管理员删除评论并向评论者反馈信息
	 */
	public String removeComment(){
		Map<String,Object> session=ActionContext.getContext().getSession();
		Message comment=messageService.findMessageById(mid);
		Activity activity=activityService.findActivityById(aid);
		User receiver=comment.getSender();
		User sender=userService.findUserById("admin");
		Date time=new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.format(time);
		Message message=new Message();
		message.setActivity(activity);
		message.setReceiver(receiver);
		message.setSender(sender);
		message.setMyType("message");
		message.setTime(time);
		String backmsg="您的评论"
				+ "“"+comment.getMsg()+"”"
				+"被删除。原因是："
				+msg;
		message.setMsg(backmsg);
		messageService.saveMessage(message);
		messageService.deleteMessage(comment);
		return SUCCESS;
	}
	
	/*
	 * 根据活动aid返回该活动未通过审核的详细信息
	 */
	public String getBackMsg() throws IOException{
		List l=messageService.findRejectByAid(aid);
		String back="";
		if(l!=null&&l.size()>0){
			Message backmsg=(Message)l.get(0);
			back=backmsg.getMsg();
		}
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw=response.getWriter();
		pw.print(back);
		pw.flush();
		pw.close();
		return null;
	}
	
	/*
	 * 按标题搜索活动
	 */
	public String searchActivity(){
		List<Activity> list=activityService.findActivityLikeQry(qry);
		Map<String, Object> session = ActionContext.getContext().getSession();
		session.put("activities", list);
		return SUCCESS;
	}
	
	/*
	 * admin删除活动，将活动状态设为del,并向发布者和报名者发送信息,发布者仍可查看活动详情
	 * 发布活动者删除活动，则将活动从数据库中删除，并向报名者发送信息
	 */
	public String removeActivity(){

		Activity activity=activityService.findActivityById(aid);
		Map<String,Object> session=ActionContext.getContext().getSession();
		String userName=(String)session.get("userName");
		User actor=userService.findUserById(userName);
		String publishernm=activity.getPublisher().getUserName();
		String head=activity.getHead();
		Date time=new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.format(time);
		Set<User> appliers=activity.getUsers();
		Iterator it=appliers.iterator();
		while(it.hasNext()){
			User applier=(User)it.next();
			Message message=new Message();
			message.setMyType("delinfo");
			message.setActivity(activity);
			message.setReceiver(applier);
			message.setSender(actor);
			message.setTime(time);
			message.setMsg("您所报名参加的活动【"+head+"】被删除，原因是："+msg);
			messageService.saveMessage(message);
		}
		if(userName.equals(publishernm)){
			activityService.deleteActivity(activity);
			String destPath = ServletActionContext.getServletContext().getRealPath(uploadaddr)+"/"+aid+"/";
			File dir=new File(destPath);
			if(dir.exists()&&dir.isDirectory()){
				File[] files=dir.listFiles();
				for (int i = 0; i < files.length; i++) {  
			       files[i].delete();
			    }
				dir.delete();
			}
				
		}else{
			activity.setStatus("del");
			activityService.editActivity(activity);
			Message message=new Message();
			message.setMyType("delinfo");
			message.setReceiver(activity.getPublisher());
			message.setSender(actor);
			message.setTime(time);
			message.setMsg("您所发布的活动【"+head+"】被管理员删除，原因是："+msg);
			messageService.saveMessage(message);
		}

		return SUCCESS;
	}

}
