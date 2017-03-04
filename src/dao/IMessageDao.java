package dao;

import java.util.List;

import model.Message;

public interface IMessageDao extends IBaseDao<Message>{
	
	public List<Message> findCommentByAid(Long aid);
	public List<Message> findRejectByAid(Long aid);
}
