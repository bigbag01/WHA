package service;

import java.util.List;

import model.Activity;
import model.Message;
import model.User;

public interface IUserService{
	public void saveUser(User user);
	public void deleteUser(User user);
	public void editUser(User user);
	public List<User> findAllUser();
	public User findUserById(String id);
	public List<Activity> findAttendsById(String id);
	public List<Message>findReceiptsById(String id);
	//public List<User> getUserList(String page, String rows);
	public int getUserTotal() throws Exception;
	/*
	 * 注册验证
	 * 如果用户名已存在，返回“exists”;注册成功，返回“ok”
	 */
	public String validateRegister(User user);

	/*
	 * 验证用户名密码
	 * 如果用户名不存在，返回“usn”；密码错误，返回“pass”；登录成功，返回“ok”；
	 */
	public String validateLogin(User user);
}