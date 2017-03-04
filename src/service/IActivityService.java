package service;

import java.util.List;

import model.Activity;
import model.Activitycontent;
import model.User;

public interface IActivityService {
	public void saveActivity(Activity activity);
	public void deleteActivity(Activity activity);
	public void editActivity(Activity activity);
	public Activity findActivityById(Long id);
	public List<Activity> findAllActivity();
	public int totalOfApply(Long aid);
	//public boolean hasApplied(String userName,Long aid);
	public List<Activity> listWaitingActivities();
	public List<Activity> listPassedActivities();
	public List<Activity> findActivityByPublisher(String userName);
	public List<User> findAppliersById(Long aid);
	//public List<Activity> findActivityByAttender(String userName);
	public List<Activity> findActivityLikeQry(String qry);
}
