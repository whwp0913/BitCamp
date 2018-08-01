package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.MovieVO;

public interface IndexMapper {

	public List<MovieVO> weekList();
	
	public List<MovieVO> monthList();
	
	public List<MovieVO> yearList();
	
}
