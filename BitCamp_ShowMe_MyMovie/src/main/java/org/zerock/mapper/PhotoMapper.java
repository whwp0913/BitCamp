package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.PhotoVO;
import org.zerock.domain.Criteria;

public interface PhotoMapper {

	public List<PhotoVO> list(Criteria cri);
	
	public PhotoVO read(int pno);
	
	public int insert(PhotoVO vo);
	
	public int update(PhotoVO vo);
	
	public int delete(int pno);
	
	public int count(Criteria cri);
	
	public List<PhotoVO> searchList(Criteria cri);

	public int addViews(int pno);
	
	public List<PhotoVO> joinList(Criteria cri);
	
	//  업로드 
	public int addImage(PhotoVO vo);
	// 이미지 삭제
	public int removeImage(int pno);
	// 이미지 조회 
	public String[] searchImage(int pno);
	// 글 수정 시 이미지 삭제
	public int removeImages(String[] deleteImages);
	// 글 수정 시 이미지 등록
	public int modiImage(PhotoVO vo);
	
}
