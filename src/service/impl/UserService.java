package service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import dao.impl.UserDao;
import model.Activity;
import model.Message;
import model.User;
import service.IUserService;

public class UserService implements IUserService{
	
	private UserDao userDao;
	public UserService(){
		
	}
	public UserService(UserDao userDao){
		this.userDao=userDao;
	}
	
	public UserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	@Override
	public void saveUser(User user) {
		if(user==null) return;
		if(user.getUserName()==null)return;
		this.userDao.add(user);
	}

	@Override
	public void deleteUser(User user) {
		if(user==null) return;
		if(user.getUserName()==null)return;
		this.userDao.delete(user);
		
	}

	@Override
	public void editUser(User user) {
		if(user==null) return;
		if(user.getUserName()==null)return;
		this.userDao.update(user);
		
	}

	@Override
	public List<User> findAllUser() {
		return this.userDao.findAll();
	}

	@Override
	public User findUserById(String id) {
		if(id==null)return null;
		return this.userDao.findById(id);
	}

	/*@Override
	public List<User> getUserList(String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}*/

	@Override
	public int getUserTotal(){
		if(this.userDao.findAll()!=null) return this.userDao.findAll().size();
		return 0;
	}

	@Override
	public String validateRegister(User user) {
		User usr=(User) userDao.findById(user.getUserName());
		if (usr!=null)
			return "exists";
		return "ok";
	}

	@Override
	public String validateLogin(User user) {
		User usr=(User) userDao.findById(user.getUserName());
		if(usr!=null){
			if(user.getPassword().equals(usr.getPassword())){
				return "ok";
			}
			return "pass";
		}
		return "usn";
	}
	@Override
	public List<Activity> findAttendsById(String id) {
		User user=(User) userDao.findById(id);
		Set<Activity> acts=user.getActivities();
		List<Activity>l=new ArrayList<Activity>(acts);
		return l;
	}
	@Override
	public List<Message> findReceiptsById(String id) {
		User user=(User) userDao.findById(id);
		Set<Message> messages=user.getMyreceipts();
		List<Message> l=new ArrayList<Message>(messages);
		return l;
	}


}
