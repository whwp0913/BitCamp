package org.zerock.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.zerock.mapper.RecommendMapper;

import com.zaxxer.hikari.HikariDataSource;

@Service
public class RecommendScheduler {
	
//	@Autowired
//	RecommendMapper rmapper;
//
//	@Autowired
//	HikariDataSource ds;
//	
//	@Scheduled(cron = "0 47 * * * *")
//	public void startRe()throws Exception {
//		
//		rmapper.removeRecom();
//		
//		rmapper.addRecommend(RecommendSystem.startRecommend(ds));
//	}

}
