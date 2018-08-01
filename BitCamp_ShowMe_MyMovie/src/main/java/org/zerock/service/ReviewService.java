package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReviewVO;

public interface ReviewService {
	
	public void registReview(ReviewVO vo);
	
	public List<ReviewVO> reviewList(Criteria cri);
	
	public void removeRiview(int vno);

	public int totalReview(Criteria cri);
}
