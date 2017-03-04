package service;

import java.util.List;

import model.Message;

public interface IMessageService {
	public void saveMessage(Message message);
	public void deleteMessage(Message message);
	public void editMessage(Message message);
	public Message findMessageById(Long mid);
	
	public List<Message> findCommentByAid(Long aid);
	public List<Message> findRejectByAid(Long aid);
}
