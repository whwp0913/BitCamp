package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReviewVO;
import org.zerock.mapper.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	ReviewMapper mapper;
	
	@Override
	public void registReview(ReviewVO vo) {
		mapper.insertReview(vo);
	}

	@Override
	public List<ReviewVO> reviewList(Criteria cri) {
	
		return mapper.listReviews(cri);
	}

	@Override
	public void removeRiview(int vno) {
		mapper.deleteReview(vno);
	}

	@Override
	public int totalReview(Criteria cri) {
		
		return mapper.countReview(cri);
	}
	
	
	
	
	

	
}
