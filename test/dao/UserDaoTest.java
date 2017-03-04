package dao;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import model.User;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:WebContent/WEB-INF/applicationContext.xml")
public class UserDaoTest extends AbstractJUnit4SpringContextTests{
	@Resource
	private IUserDao userDao;

	private User user=new User();
	@Before
	public void setUp(){
		
	}
	@Test
	public void testAdd(){
		user.setUserName("新用户2");
		user.setPassword("new222");
		userDao.add(user);
	}
	@Test
	public void testDelete(){
		user=userDao.findById("新用户2");
		userDao.delete(user);
	}
	@Test
	public void testUpdate(){
		user=userDao.findById("新用户");
		user.setPhone("3344556");
		user.setGender("女");
		userDao.update(user);
	}
	@Test
	public void testFindAll(){
		List<User> l=userDao.findAll();
		for(User u:l)
			System.out.println(u.getUserName());
	}
	
}
