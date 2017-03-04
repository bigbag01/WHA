package dao.impl;

import java.util.List;

import dao.IMessageDao;
import model.Message;

public class MessageDao extends BaseDao<Message> implements IMessageDao {

	@Override
	public List<Message> findCommentByAid(Long aid) {
		return this.sessionFactory.getCurrentSession().createQuery("from Message where aid="+aid+" and myType='comment'").list();
	}

	@Override
	public List<Message> findRejectByAid(Long aid) {
		return this.sessionFactory.getCurrentSession().createQuery("from Message where aid="+aid+" and myType='reject'").list();
	}


}
