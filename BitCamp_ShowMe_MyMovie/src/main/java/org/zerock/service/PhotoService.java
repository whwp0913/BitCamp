package org.zerock.service;

import java.util.List;

import org.zerock.domain.PhotoVO;
import org.zerock.domain.Criteria;

public interface PhotoService {

	public PhotoVO read(int pno);
	
	public List<PhotoVO> pageList(Criteria cri);
		
	public void write(PhotoVO vo)throws Exception;
	
	public int modify(PhotoVO vo);
	
	public int remove(int pno);
	
	public int count(Criteria cri);
	
	public List<PhotoVO> searchList(Criteria cri);	
	
	public List<PhotoVO> joinList(Criteria cri);
	
	// file method.......................
	
	public int addImage(PhotoVO vo);
	
	public int viewCnt(int pno);

	public int removeImage(int pno);
	
	public String[] searchImage(int pno);
	
	public int removeImages(String[] deleteImages);
	
	public int modiImage(PhotoVO vo);
	
}
