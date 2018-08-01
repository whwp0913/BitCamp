package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	
	public BoardVO read(int bno);
	
	public List<BoardVO> pageList(Criteria cri);
		
	public void write(BoardVO vo)throws Exception;
	
	public int modify(BoardVO vo);
	
	public int remove(int bno);
	
	public int count(Criteria cri);
	
	public List<BoardVO> searchList(Criteria cri);
	
	public List<BoardVO> bestList();
	
	// file method.......................
	
	public int addFile(BoardVO vo);
	
	public int viewCnt(int bno);

	public int removeFile(int bno);
	
	public String[] searchFile(int bno);
	
	public int removeFiles(String[] deleteFiles);
	
	public int modiFile(BoardVO vo);

}
