package dao;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import model.Message;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:WebContent/WEB-INF/applicationContext.xml")
public class MessageDaoTest extends AbstractJUnit4SpringContextTests {
	@Resource
	private IMessageDao messageDao;
	private Message message=new Message();
	
	@Test
	public void testAdd(){
		message.setMsg("addMessage");
		message.setMyType("comment");
		message.setTime(new Date());
		messageDao.add(message);
	}
	@Test
	public void testUpdate(){
		message=messageDao.findById((long)32);
		message.setMsg("updateMessage");
		messageDao.update(message);
	}
	@Test
	public void testDelete(){
		message=messageDao.findById((long)32);
		messageDao.delete(message);
	}
	@Test
	public void testFindCommentByAid(){
		List<Message> l=messageDao.findCommentByAid((long)1);
		for(Message m:l)
			System.out.println(m.getMsg());
	}
	@Test
	public void testFindRejectByAid(){
		List<Message> l=messageDao.findRejectByAid((long)2);
		for(Message m:l)
			System.out.println(m.getMsg());
	}
}
