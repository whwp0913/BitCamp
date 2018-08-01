package org.zerock.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.LoginDTO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.RecommendVO;
import org.zerock.domain.ReviewVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_= {@Autowired})
	private MemberMapper mapper;
	
	
	@Override
	public MemberVO userLogin(LoginDTO dto) {
		
		return mapper.login(dto);
	}


	@Override
	public int userRegist(MemberVO vo) {
		
		return mapper.signUp(vo);
	}


	@Override
	public void keepLogin(String mid, String sessionId, Date next) {
		
	
		mapper.keepLogin(mid, sessionId, next);
	}


	@Override
	public MemberVO checkLoginBefore(String value) {
		
		return mapper.checkUserWithSessionKey(value);
	}


	@Override
	public int userIdCheck(String id) {
		
		return mapper.idCheck(id);
	}


	@Override
	public List<RecommendVO> recommendMovie(String favor) {
		
		return mapper.selectMovie(favor);
	}	
	
	/* t_auth tables */
	
	@Override
	public void insertAuth(String mid) {
		mapper.insertAuth(mid);
	}


	@Override
	public MemberVO getUserID(String mid) {
	
		return mapper.getUserID(mid);
	}


	@Override
	public String getUserAuth(String mid) {
	
		return mapper.getUserAuth(mid);
	}


	@Override
	public List<ReviewVO> uRecom(String mid) {
		
		return mapper.uRecom(mid);
	}
	
	
	
	
	
	
}
