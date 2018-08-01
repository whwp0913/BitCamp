package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> list(Criteria cri);
	
	public BoardVO read(int bno);
	
	public int insert(BoardVO vo);
	
	public int update(BoardVO vo);
	
	public int delete(int bno);
	
	public int count(Criteria cri);
	
	public List<BoardVO> searchList(Criteria cri);

	public int addViews(int bno);
	
	public List<BoardVO> bestList();
	
	// file method.................
	 
	public int addFile(BoardVO vo);
	
	public int removeFile(int bno);
	 
	public String[] searchFile(int bno);
	
	public int removeFiles(String[] deleteFiles);
	
	public int modiFile(BoardVO vo);

}
