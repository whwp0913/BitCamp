package org.zerock.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.PhotoVO;
import org.zerock.mapper.PhotoMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PhotoTests {

	@Autowired
	private PhotoMapper mapper;

	@Test
	public void insertPhoto() {
		for (int i = 0; i < 50; i++) {

			PhotoVO vo = new PhotoVO();
			vo.setTitle("더미데이터 입니다 " + i);
			vo.setContent("Hello" + i);
			vo.setMid("nara");
			mapper.insert(vo);
		}
	}
	
	@Test
	public void readPhoto() {
		log.info(mapper.read(50));
	}
	
	@Test
	public void listPhoto() {
		Criteria cri = new Criteria();
		cri.setPage(1);
		mapper.list(cri).forEach(vo -> log.info(vo));
	}
}
