package org.zerock.service;

import java.util.List;

import org.zerock.domain.MovieVO;

public interface IndexService {

	public List<MovieVO> weekList();
	public List<MovieVO> monthList();
	public List<MovieVO> yearList();
}
