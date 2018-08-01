package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SearchResult;
import org.zerock.service.ReviewService;
import org.zerock.utils.SearchAPI;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/reviews")
@Log4j
public class ReviewRESTController {
	

	@Autowired
	private ReviewService service;
	
	
	//네이버 영화 검색 API 결과 리스트
	@RequestMapping(value = "/{keyword}", method = RequestMethod.GET)
	public ResponseEntity<List<SearchResult>> 
		listMovies(@PathVariable("keyword") String keyword) {

		ResponseEntity<List<SearchResult>> entity = null;		
		try {
			List<SearchResult> list = null;
			list = SearchAPI.searchMovie(keyword);
									
			entity = new ResponseEntity<List<SearchResult>>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			e.getMessage();
		}
		return entity;
	}
	
	//리뷰 삭제
	@RequestMapping(value = "/remove/{vno}", method =RequestMethod.DELETE)
	public ResponseEntity<String> removeReview(@PathVariable("vno") int vno) {		
		log.info("Review remove..........." + vno);		
		ResponseEntity<String> entity  = null;
		
		try {
			
			service.removeRiview(vno);			
			entity = new ResponseEntity<String>("삭제되었습니다",HttpStatus.OK);
			
		} catch (Exception e) {
			e.getMessage();
		}
		return entity;
	}
	
}
