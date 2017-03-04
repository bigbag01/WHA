package service.impl;

import java.util.List;

import dao.impl.MessageDao;
import model.Message;
import service.IMessageService;

public class MessageService implements IMessageService {
	private MessageDao messageDao;
	
	public MessageDao getMessageDao() {
		return messageDao;
	}

	public void setMessageDao(MessageDao messageDao) {
		this.messageDao = messageDao;
	}

	@Override
	public void saveMessage(Message message) {
		this.messageDao.add(message);
	}

	@Override
	public void deleteMessage(Message message) {
		this.messageDao.delete(message);
	}

	@Override
	public void editMessage(Message message) {
		this.messageDao.update(message);
	}


	@Override
	public List<Message> findCommentByAid(Long aid) {
		return this.messageDao.findCommentByAid(aid);
	}

	@Override
	public Message findMessageById(Long mid) {
		return this.messageDao.findById(mid);
	}

	@Override
	public List<Message> findRejectByAid(Long aid) {
		return this.messageDao.findRejectByAid(aid);
	}

}
