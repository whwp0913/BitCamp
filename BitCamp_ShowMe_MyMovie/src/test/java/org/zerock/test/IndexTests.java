package org.zerock.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.IndexMapper;
import org.zerock.mapper.RecommendMapper;
import org.zerock.utils.RecommendSystem;

import com.zaxxer.hikari.HikariDataSource;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class IndexTests {

	@Setter(onMethod_= {@Autowired})
	private IndexMapper mapper;
	
//	@Autowired
//	private RecommendMapper rmapper;
//	
//	@Autowired
//	private HikariDataSource ds;
	
	@Test
	public void weekListTest() {
		log.info(mapper.weekList());
	}
	
//	@Test
//	public void recom()throws Exception {
//		rmapper.addRecommend(RecommendSystem.startRecommend(ds));
//	}
}
