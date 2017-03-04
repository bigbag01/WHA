package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import model.Lock;
import model.Message;
import model.User;
import service.impl.LockService;
import service.impl.MessageService;
import service.impl.UserService;

public class UserControlAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	private static final String USERNAME_PATTERN = "^[a-zA-Z0-9_\u4e00-\u9fa5]+$";
	private static final String PASSWORD_PATTERN="[a-zA-Z_0-9]{6,12}$";
	private String userName;
	private String password;
	private String email;
	private String phone;
	private String gender;
	private String msg;
	//private Date start;
	//private Date end;
	private String start;
	private String end;
	private int auth;
	private String prePage;
	private UserService userService;
	private MessageService messageService;
	private LockService lockService;
	private HttpServletResponse response = ServletActionContext.getResponse();
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	/*public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public Date getEnd() {
		return end;
	}
	public void setEnd(Date end) {
		this.end = end;
	}*/
	
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public String getPrePage() {
		return prePage;
	}
	public void setPrePage(String prePage) {
		this.prePage = prePage;
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
	public LockService getLockService() {
		return lockService;
	}
	public void setLockService(LockService lockService) {
		this.lockService = lockService;
	}
	
	public String showInfo(){
		Map<String, Object> session = ActionContext.getContext().getSession();
		String un=(String)session.get("userName");
		User user=userService.findUserById(un);
		session.put("user", user);
		return SUCCESS;
	}
	public String searchInfo() throws IOException{
		Map<String, Object> session = ActionContext.getContext().getSession();
		Map<String,String> info=new HashMap();
		User user=userService.findUserById(userName);
		Message message;
		String msg="";
		if(user.getMylock().getMid()!=null){
			message=messageService.findMessageById(user.getMylock().getMid());
			msg=message.getMsg();
		}
		info.put("userName", userName);
		info.put("email", user.getEmail());
		info.put("phone", user.getPhone());
		info.put("gender", user.getGender());
		info.put("msg", msg);
		info.put("auth",String.valueOf(user.getMylock().getAuth()));
		Gson gson = new Gson();
		String result=gson.toJson(info);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}
	public String editUser(){
		User user=new User();
		Map<String, Object> session = ActionContext.getContext().getSession();
		String un=(String)session.get("userName");
		user.setUserName(un);
		user.setEmail(email);
		user.setPhone(phone);
		user.setPassword(password);
		user.setGender(gender);
		userService.editUser(user);
		return SUCCESS;
	}
	
	public String checkUser() throws IOException{
		User user=new User();
		user.setUserName(userName);
		String res=userService.validateRegister(user);
		Map<String, Object> session = ActionContext.getContext().getSession();
		if(session.get("userName").equals(userName)) res="self";
		PrintWriter pw = response.getWriter();
		pw.print(res);
		pw.flush();
		pw.close();
		return null;
	}
	public String register() throws Exception{
		User user = new User();
		user.setUserName(userName);
		user.setPassword(password);
		user.setEmail(email);
		user.setPhone(phone);
		user.setGender("男");
		Lock mylock=new Lock();
		mylock.setUserName(userName);
		mylock.setUser(user);
		mylock.setAuth(3);
		String result="";
		Pattern pattern1,pattern2;
		Matcher matcher1,matcher2;
		pattern1=Pattern.compile(USERNAME_PATTERN);
		pattern2=Pattern.compile(PASSWORD_PATTERN);
		matcher1 = pattern1.matcher(userName);
		matcher2=pattern2.matcher(password);
		if(!matcher1.matches()) 
			result="illusn";
		else if(!matcher2.matches())
			result="illpass";
		else{
			result=userService.validateRegister(user);
			if(result.equals("ok")){
				userService.saveUser(user);
				lockService.saveLock(mylock);
			}
		}
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}
	public String login() throws IOException{
		User user=new User();
		user.setUserName(userName);
		user.setPassword(password);
		String result="";
		Map<String,String> map=new HashMap();
		result=userService.validateLogin(user);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		if(result.equals("ok")){
			result="ok";
			Map<String, Object> session = ActionContext.getContext().getSession();
			session.put("userName", userName);
		}
		map.put("result", result);
		Gson gson=new Gson();
		result=gson.toJson(map);
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}
	public String logout(){
		Map<String, Object> session = ActionContext.getContext().getSession();
		session.clear();
		return SUCCESS;
	}

	public String showAuth() throws IOException{
		Map<String, Object> session = ActionContext.getContext().getSession();
		List<Lock> list=lockService.findAllLock();
		Gson gson = new GsonBuilder()
		        .excludeFieldsWithoutExposeAnnotation()
		        .create();
		String result=gson.toJson(list);
		//设置response的ContentType解决中文乱码
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();
		return null;
	}
	
	public String lockUser() throws ParseException{
		Map<String, Object> session = ActionContext.getContext().getSession();
		User user=userService.findUserById(userName);
		Message message=new Message();
		message.setMsg(msg);
		message.setMyType("lockinfo");
		message.setReceiver(user);
		message.setSender(userService.findUserById("admin"));
		message.setTime(new Date());
		messageService.saveMessage(message);
		
		Lock mylock=user.getMylock();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		mylock.setStart(dateFormat.parse(start));
		mylock.setEnd(dateFormat.parse(end));
		mylock.setAuth(auth);
		mylock.setUser(user);
		mylock.setMid(message.getMid());
		user.setMylock(mylock);
		lockService.editLock(mylock);

		return SUCCESS;
	}
}
