package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	
	public void insert(ReplyVO vo);
	
	public List<ReplyVO> list(int bno);
	
	public List<ReplyVO> listPage(@Param("bno")int bno, @Param("cri")Criteria cri);
	
	public void update(ReplyVO vo);
	
	public void delete(int rno);
	
	public int count(int bno);
	
	public ReplyVO read(int rno);
	
	public void deleteAll(int bno);

}
