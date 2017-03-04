package service;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Before;  
import org.junit.Test;  
import org.junit.runner.RunWith;  
import org.springframework.test.context.ContextConfiguration;  
import org.springframework.test.context.junit4.*;

import model.Activity;
import model.Message;
import model.User;  

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:WebContent/WEB-INF/applicationContext.xml")
public class UserServiceTest extends AbstractJUnit4SpringContextTests {
	@Resource
	private IUserService userService;
	private User user;
	@Before
	public void setUp(){
		
	}
	@Test
	public void saveTest(){
		User user = new User();
		user.setUserName("aa");
		user.setPassword("abcdefg");
		userService.saveUser(user);
	}
	@Test
	public void deleteTest(){
		userService.deleteUser(user);
	}
	@Test
	public void updateTest(){
		user=userService.findUserById("犀牛");
		user.setEmail("ff@qq.com");
		user.setGender("男");
		user.setPhone("1122-44");
		userService.editUser(user);
	}
	@Test
	public void findTest() throws Exception{
		List l=userService.findAllUser();
		System.out.println(l);
		int total=userService.getUserTotal();
		System.out.println(total);
		User user=userService.findUserById("maomao");
		String email=user.getEmail();
		Assert.assertEquals("maomao@qq.com", email);
	}
	@Test
	public void validateRegisterTest(){
		User userok=new User();
		User userex=new User();
		userok.setUserName("new");
		userok.setPassword("2333");
		userex.setUserName("maomao");
		userex.setPassword("hhh");
		String ok=userService.validateRegister(userok);
		String exists=userService.validateRegister(userex);
		Assert.assertEquals("ok", ok);
		Assert.assertEquals("exists", exists);
	}
	@Test
	public void validateLoginTest(){
		User userok=new User();
		User userusn=new User();
		User userpass=new User();
		userok.setUserName("maomao");
		userok.setPassword("maomao");
		userusn.setUserName("usn");
		userusn.setPassword("hh");
		userpass.setUserName("betty");
		userpass.setPassword("24");
		String ok=userService.validateLogin(userok);
		String usn=userService.validateLogin(userusn);
		String pass=userService.validateLogin(userpass);
		Assert.assertEquals("ok", ok);
		Assert.assertEquals("usn", usn);
		Assert.assertEquals("pass", pass);
	}
	@Test
	public void findAttendsTest(){
		List<Activity> l=userService.findAttendsById("maomao");
		for(Activity a:l)
			System.out.println(a.getHead());
	}
	@Test
	public void findReceiptsTest(){
		List<Message>l=userService.findReceiptsById("maomao");
		for(Message m:l)
			System.out.println(m.getMsg());
	}
}