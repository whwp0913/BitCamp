package org.zerock.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.LoginDTO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.RecommendVO;
import org.zerock.domain.ReviewVO;

public interface MemberMapper {

	public MemberVO login(LoginDTO dto);
	
	public int signUp(MemberVO vo);
	
	public void keepLogin(@Param("mid")String mid,@Param("sessionId") String sessionId,  @Param("next")Date next);
	
	public MemberVO checkUserWithSessionKey(String value);
	
	public int idCheck(String id);
	
	public List<RecommendVO> selectMovie(String favor);
	
	/* t_auth tables */
	
	public void insertAuth(String mid);
	
	public MemberVO getUserID(String mid);
	
	public String getUserAuth(String mid);
	
	public List<ReviewVO> uRecom(String mid);
}
