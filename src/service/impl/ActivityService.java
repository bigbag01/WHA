package service.impl;

import java.util.List;

import dao.impl.ActivityDao;
import model.Activity;
import model.Activitycontent;
import model.User;
import service.IActivityService;

public class ActivityService implements IActivityService{
	private ActivityDao activityDao;

	public ActivityDao getActivityDao() {
		return activityDao;
	}

	public void setActivityDao(ActivityDao activityDao) {
		this.activityDao = activityDao;
	}
	public void saveActivity(Activity activity){
		if(activity==null) return;
		this.activityDao.add(activity);
	}

	@Override
	public void deleteActivity(Activity activity) {
		if(activity==null) return;
		this.activityDao.delete(activity);
		
	}

	@Override
	public void editActivity(Activity activity) {
		if(activity==null) return;
		this.activityDao.update(activity);
	}

	@Override
	public Activity findActivityById(Long id) {
		if(id==null)return null;
		return this.activityDao.findById(id);
	}

	@Override
	public List<Activity> findAllActivity() {
		return this.activityDao.findAll();
	}

	@Override
	public int totalOfApply(Long aid) {
		return this.activityDao.totalOfApply(aid);
	}

	/*@Override
	public boolean hasApplied(String userName,Long aid) {
		return this.activityDao.hasApplied(userName,aid);
	}*/

	@Override
	public List<Activity> listWaitingActivities() {
		return this.activityDao.findActivityByStatus("waiting");
	}

	@Override
	public List<Activity> listPassedActivities() {
		List l1=this.activityDao.findActivityByStatus("passed");
		List l2=this.activityDao.findActivityByStatus("end");
		if(l1==null)
			return l2;
		else if(l2==null)
			return l1;
		else {
			l1.addAll(l2);
			return l1;
		}
		
	}
	
	
	@Override
	public List<Activity> findActivityByPublisher(String userName) {
		return this.activityDao.findActivityByPublisher(userName);
	}

	@Override
	public List<User> findAppliersById(Long aid) {
		return this.activityDao.findAppliers(aid);
	}

	/*@Override
	public List<Activity> findActivityByAttender(String userName) {
		return this.activityDao.findActivityByAttender(userName);
	}*/

	@Override
	public List<Activity> findActivityLikeQry(String qry) {
		return this.activityDao.findActivityLikeQry(qry);
	}


	
}

