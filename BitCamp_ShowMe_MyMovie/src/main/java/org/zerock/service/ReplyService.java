package org.zerock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	
	public void register(ReplyVO vo);
	
	public List<ReplyVO> listReplies(int bno);
	
	public List<ReplyVO> listReplyPage(@Param("bno") int bno, @Param("cri")Criteria cri);
	
	public void modify(ReplyVO vo);
	
	public void remove(int rno);
	
	public int count(int bno);
	
	public ReplyVO read(int rno);
	
	public void removeAll(int bno);

}
