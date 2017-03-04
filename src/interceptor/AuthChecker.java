package interceptor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import model.Lock;
import model.Message;
import model.User;
import service.impl.LockService;
import service.impl.MessageService;
import service.impl.UserService;

public class AuthChecker extends AbstractInterceptor{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1359756641043850115L;
	private UserService userService;
	private LockService lockService;
	private MessageService messageService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public LockService getLockService() {
		return lockService;
	}
	public void setLockService(LockService lockService) {
		this.lockService = lockService;
	}
	public MessageService getMessageService() {
		return messageService;
	}
	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		Map session= invocation.getInvocationContext().getSession();
	    String userName=(String)session.get("userName");  
	    //未登录，或会话已过期，结果会直接跳转到提醒登录页面
        if (userName==null)
            return  "noLogin";
        //用户为admin，最高权限，可以进入任何action
        else if(userName.equals("admin")){
        	return invocation.invoke();
        }
        //根据用户名查找对应的权限等级，限制进入一些action
        else{
        	//获取当前用户权限的具体信息
			Lock mylock=lockService.findLockById(userName);
			int auth=mylock.getAuth();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	         //拦截的action的名字
			String action = invocation.getInvocationContext().getName();
			Map tip=new HashMap();
			int type;
			if(auth<3){
				Date now=new Date();
				if(now.after(mylock.getEnd())){
					mylock.setAuth(3);
					mylock.setEnd(null);
					mylock.setStart(null);
					mylock.setMid(null);
					lockService.editLock(mylock);
					auth=3;
				}
			}
			switch(action){
				case "showAuth":
				case "lockUser":
				case "searchUserInfo":
				case "waiting":
				case "pass":
				case "fail":
				case "rmvCmt":{
					//type=4表示需要管理员权限
					tip.put("type", 4);
					session.put("tip", tip);
					return "noPower";
				}
				case "upActivity":
				case "editActivity":
				case "rmvAct":
				case "refuse":{
					type=3;
					break;
				}
				case "submitComment":{
					type=2;
					break;
				}
				case "apply":
				case "cancel":
				case "rate":
				case "invite":
				case "checkUser":
				case "showAppliers":{
					type=1;
					break;
				}
				default:
					type=0;	
			}
			
			if(auth<type){
				String start=dateFormat.format(mylock.getStart());
				String end=dateFormat.format(mylock.getEnd());
				Message message=messageService.findMessageById(mylock.getMid());
				tip.put("type", type);
				tip.put("auth", auth);
				tip.put("start", start);
				tip.put("end", end);
				tip.put("reason", message.getMsg());
				session.put("tip",tip);
				return "noPower";
			}
			else 
				return invocation.invoke();
			
        }
	}

}
