package org.zerock.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.LoginDTO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.RecommendVO;
import org.zerock.domain.ReviewVO;

public interface MemberService {

	public MemberVO userLogin(LoginDTO dto);
	
	public int userRegist(MemberVO vo);
	
	public void keepLogin(@Param("sessionId") String sessionId, @Param("mid")String mid, @Param("next")Date next);
	public MemberVO checkLoginBefore(String value);
	
	public int userIdCheck(String id);
	
	public List<RecommendVO> recommendMovie(String favor);
	
	/* t_auth tables */
	
	public void insertAuth(String mid);
	
	public MemberVO getUserID(String mid);
	
	public String getUserAuth(String mid);
	
	public List<ReviewVO> uRecom(String mid);
	
}
