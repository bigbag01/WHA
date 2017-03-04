package dao;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import model.Activity;
import model.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:WebContent/WEB-INF/applicationContext.xml")
public class ActivityDaoTest extends AbstractJUnit4SpringContextTests {
	@Resource
	private IActivityDao activityDao;
	
	private Activity activity=new Activity();
	
	
	@Test
	public void testAdd(){
		activity.setHead("一个新活动");
		activity.setActend(new Date());
		activity.setActstart(new Date());
		activity.setAplend(new Date());
		activity.setAplstart(new Date());
		activity.setCategory(1);
		activityDao.add(activity);
	}
	@Test
	public void testUpdate(){
		activity=activityDao.findById((long)7);
		activity.setHead("更改新活动");
		activityDao.update(activity);
	}
	@Test
	public void testDelete(){
		activity=activityDao.findById((long)7);
		activityDao.delete(activity);
	}
	@Test
	public void testFindAll(){
		List<Activity> l=activityDao.findAll();
		for(Activity a:l)
			System.out.println(a.getHead());
	}
	@Test
	public void testTotalOfApply(){
		int total=activityDao.totalOfApply((long)1);
		Assert.assertEquals(1, total);
	}
	@Test
	public void testFindActivityByStatus(){
		List<Activity> p=activityDao.findActivityByStatus("passed");
		List<Activity> w=activityDao.findActivityByStatus("waiting");
		List<Activity> e=activityDao.findActivityByStatus("end");
		List<Activity> r=activityDao.findActivityByStatus("reject");
		for(Activity a:p)
			System.out.println('p'+a.getHead());
		for(Activity a:w)
			System.out.println('w'+a.getHead());
		for(Activity a:e)
			System.out.println('e'+a.getHead());
		for(Activity a:r)
			System.out.println('r'+a.getHead());
		
	}
	@Test
	public void testFindActivityByPublisher(){
		List<Activity> l=activityDao.findActivityByPublisher("maomao");
		for(Activity a: l)
			System.out.println(a.getHead());
	}
	@Test
	public void testFindAppliers(){
		List<User> l=activityDao.findAppliers((long)2);
		for(User u:l)
			System.out.println(u.getUserName());
	}
	@Test
	public void testFindActivityLikeQry(){
		List<Activity> l=activityDao.findActivityLikeQry("人");
		for(Activity a:l)
			System.out.println(a.getHead());
	}
}
