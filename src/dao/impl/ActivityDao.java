package dao.impl;



import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import dao.IActivityDao;
import model.Activity;
import model.Activitycontent;
import model.User;



public class ActivityDao extends BaseDao<Activity> implements IActivityDao{

	@Override
	public int totalOfApply(Long aid) {
		return this.sessionFactory.getCurrentSession().createSQLQuery("select * from apply where aid="+aid).list().size();
	}
	@Override
	public List<Activity> findActivityByStatus(String status) {
		return this.sessionFactory.getCurrentSession().createQuery("from Activity where status='"+status+"'").list();
	}

	@Override
	public List<Activity> findActivityByPublisher(String username) {
		return this.sessionFactory.getCurrentSession().createQuery("from Activity where publisher='"+username+"'").list();
	}

	@Override
	public List<User> findAppliers(Long aid) {
		return this.sessionFactory.getCurrentSession().createSQLQuery("select * from apply natural join user where apply.aid="+aid).addEntity(User.class).list();
	}


	@Override
	public List<Activity> findActivityLikeQry(String qry) {
		String hql="from Activity where HEAD like '%"+qry+"%'"
				+ " and ( STATUS='passed' or STATUS='end' )";
		return this.sessionFactory.getCurrentSession().createQuery(hql).list();
	}

}
