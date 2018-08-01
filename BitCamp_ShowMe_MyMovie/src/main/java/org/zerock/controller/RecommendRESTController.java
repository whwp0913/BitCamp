package org.zerock.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.mapper.RecommendMapper;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/recommend")
@Log4j
public class RecommendRESTController {
	
	@Autowired
	private RecommendMapper mapper;

	@RequestMapping(value = "/{code}", method = RequestMethod.GET)
	public ResponseEntity<List<Map<String,String>>> 
		listIRecom(@PathVariable("code") int code) {
		log.info(code);
		log.info("........................................................");
		
		ResponseEntity<List<Map<String,String>>> entity = null;		
		try {
			
			List<Map<String,String>> list = null;
			
			list = mapper.listIRecom(code);
			
			System.out.println("list :" +list.toString());
			entity = new ResponseEntity<List<Map<String,String>>>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			e.getMessage();
		}
		return entity;
	}
}
