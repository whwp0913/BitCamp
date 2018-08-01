package org.zerock.test;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReviewMapper;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardTests {

	
	@Setter(onMethod_= {@Autowired})
	private BoardMapper mapper;
	
	@Autowired
	private ReviewMapper mapper2;

	@Test
	public void testList() {
		BoardVO vo = new BoardVO();
		

		for(int i =0; i<20 ; i++) {
			vo.setContent("Test........" + i);
			vo.setContent("Test Content............" + i);
			vo.setTitle("Test Title..............." + i);
			vo.setMid("zero" + i);
			vo.setGno("100");
			vo.setKno("10");
			
			mapper.insert(vo);
		}


	}
	
	@Test
	public void reviewCount() {

		Criteria cri = new Criteria();
		
		System.out.println(mapper2.countReview(cri));
	}
	

	
	
}
