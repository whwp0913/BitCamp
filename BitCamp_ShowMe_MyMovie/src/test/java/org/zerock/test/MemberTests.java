package org.zerock.test;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.RecommendVO;
import org.zerock.domain.ReviewVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml, file:src/main/webapp/WEB-INF/spring/security-context.xml")
@Log4j
public class MemberTests {

	
	@Setter(onMethod_= {@Autowired})
	private MemberMapper mapper;
	
	@Test
	public void cookieTest() {
		mapper.keepLogin("loginCookie", "zero", new Date());
	}
	@Test
	public void test2() {
		mapper.checkUserWithSessionKey("loginCookie");
	}
	
	@Test
	public void idCheckTest() {
		
		int result = mapper.idCheck("hahaha");
		if(result ==1) {
			log.info("�̹� �����ϴ� ���̵��Դϴ�.");
		}else {
			log.info("��� ������ ���̵��Դϴ�");
		}
	}
	
	@Test
	public void recommendTest() {
		
		List<RecommendVO> list = mapper.selectMovie("�ڹ̵�");
		
		log.info(list);
	}
	
	@Test
	public void uRecomTest() {
		List<ReviewVO> list = mapper.uRecom("user3");
		log.info(list);
	}


}
