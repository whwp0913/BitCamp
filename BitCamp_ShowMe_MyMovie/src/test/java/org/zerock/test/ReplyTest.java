package org.zerock.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyTest {

	@Setter(onMethod_= {@Autowired})
	private ReplyMapper mapper;
	

	
	// 댓글리스트 테스트 
	@Test
	public void listTest() {
		log.info(mapper.list(4));
		
	}
	
	@Test
	public void listPaginTest() {
		Criteria cri = new Criteria();
		cri.setPage(1);
		log.info(mapper.listPage(4, cri));
	}
	
	// 업데이트 테스트
	@Test
	public void updateTest() {
		ReplyVO vo = new ReplyVO();
		vo = mapper.read(17);
		vo.setContent("Hello World");
		mapper.update(vo);
		log.info(mapper.read(17));
	}
	
	//삭제테스트 
	@Test
	public void deleteTest() {
		mapper.delete(8);
	}
	
	//해당글에대한 댓글 총 갯수 테스트 
//	@Test
//	public void countTest()	{
//		Criteria cri = new Criteria();
//		log.info(mapper.count(4));
//	}
	

}
