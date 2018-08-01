package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReviewVO;

public interface ReviewMapper {
	
	public void insertReview(ReviewVO vo);
	
	public List<ReviewVO> listReviews(Criteria cri);
	
	public int countReview(Criteria cri);

	public void deleteReview(int vno);
	
}
