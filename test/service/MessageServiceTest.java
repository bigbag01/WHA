package service;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Before;  
import org.junit.Test;  
import org.junit.runner.RunWith;  
import org.springframework.test.context.ContextConfiguration;  
import org.springframework.test.context.junit4.*;

import model.Message;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:WebContent/WEB-INF/applicationContext.xml")
public class MessageServiceTest extends AbstractJUnit4SpringContextTests {
	
	@Resource
	private IMessageService messageService;
	
	@Test
	public void findCommentByAidTest(){
		List<Message> cmt=messageService.findCommentByAid((long)1);
		for(Message m:cmt)
			System.out.println(m.getMsg());
	}
	@Test
	public void findRejectByAidTest(){
		List<Message> rej=messageService.findRejectByAid((long)1);
		for(Message m:rej)
			System.out.println(m.getMsg());
	}
}
