package service;

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
public class ActivityServiceTest extends AbstractJUnit4SpringContextTests {
	@Resource
	private IActivityService activityService;
	@Test
	public void totalApplyTest(){
		int total=activityService.totalOfApply((long) 2);
		Assert.assertEquals(2,total);
	}
	@Test
	public void findAppliersTest(){
		List<User> l=activityService.findAppliersById((long) 2);
		for(User u:l){
			System.out.println(u.getUserName());
		}
	}
	@Test
	public void findActivityByPublisherTest(){
		List<Activity> l2=activityService.findActivityByPublisher("maomao");
		System.out.println("publisher");
		for(Activity a:l2)
			System.out.println(a.getHead());
	}
	@Test
	public void findActivityLikeQryTest(){
		List<Activity> l=activityService.findActivityLikeQry("人");
		for(Activity a:l)
			System.out.println(a.getHead());
	}
	@Test
	public void findActivityByStatus(){
		List<Activity>waiting=activityService.listWaitingActivities();
		List<Activity> passed=activityService.listPassedActivities();
		for(Activity a:waiting)
			System.out.println('w'+a.getHead());
		for(Activity a:passed)
			System.out.println('p'+a.getHead());
	}
}
