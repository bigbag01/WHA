package dao;

import java.util.List;

import model.Activity;
import model.Activitycontent;
import model.User;

public interface IActivityDao extends IBaseDao<Activity>{
	public int totalOfApply(Long aid);
	public List<Activity> findActivityByStatus(String status);
	public List<Activity> findActivityByPublisher(String username);
	public List<User> findAppliers(Long aid);
	public List<Activity> findActivityLikeQry(String qry);
}
