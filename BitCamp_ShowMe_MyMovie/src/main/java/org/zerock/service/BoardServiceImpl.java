package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_= {@Autowired})
	private BoardMapper mapper;
	
	@Setter(onMethod_= {@Autowired})
	private ReplyMapper mapper2;

	
	@Override
	public BoardVO read(int bno) {
		return mapper.read(bno);
	}

	@Override
	public List<BoardVO> pageList(Criteria cri) {
		return mapper.list(cri);
	}
	
	@Transactional
	@Override
	public void write(BoardVO vo)throws Exception{
		mapper.insert(vo);
		if(vo.getFiles() != null) {
		mapper.addFile(vo);	
		}
	}
	@Transactional
	@Override
	public int modify(BoardVO vo) {
		if(vo.getFiles() != null) {
			mapper.modiFile(vo);
		}
		return mapper.update(vo);
	}
	@Transactional
	@Override
	public int remove(int bno) {
		int row = mapper.removeFile(bno);
		mapper2.deleteAll(bno);
		mapper.delete(bno);
		return row;
	}

	@Override
	public int count(Criteria cri) {
		return mapper.count(cri);
	}

	@Override
	public List<BoardVO> searchList(Criteria cri) {
		return mapper.searchList(cri);
	}
	
	
	// file method..................
	@Override
	public int addFile(BoardVO vo) {
		return mapper.addFile(vo);
	}

	@Override
	public int viewCnt(int bno) {
		return mapper.addViews(bno);
	}

	
	@Override
	public int removeFile(int bno) {
		return mapper.removeFile(bno);
	}
	
	@Override
	public String[] searchFile(int bno) {
		return mapper.searchFile(bno);
	}
	 
	@Override
	public int removeFiles(String[] deleteFiles) {
		return mapper.removeFiles(deleteFiles);
	}
	 
	@Override
	public int modiFile(BoardVO vo) {		
		return mapper.modiFile(vo);
	}

	@Override
	public List<BoardVO> bestList() {
		return mapper.bestList();
	}
				
}
