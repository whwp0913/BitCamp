package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageMaker;
import org.zerock.domain.ReviewVO;
import org.zerock.service.ReviewService;


@Controller
public class ReviewController {

	@Autowired
	private ReviewService service;

	@RequestMapping(value = "/review", method = RequestMethod.GET)
	public void reviewGET(Model model, Criteria cri) {
		
		if(service.reviewList(cri).size() != 0) {
			PageMaker pm = new PageMaker();
			pm.setCri(cri);
			pm.setTotal(service.totalReview(cri));
			
			model.addAttribute("pm", pm);
			model.addAttribute("list", service.reviewList(cri));
		}
	}

	@RequestMapping(value="/review", method=RequestMethod.POST)
	public void reviewPOST(@RequestBody ReviewVO vo, Model model) {
		System.out.println(vo);
		service.registReview(vo);
	
	}
	
}
