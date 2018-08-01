package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.MovieVO;
import org.zerock.mapper.IndexMapper;

@Service
public class IndexServiceImpl implements IndexService {

	@Autowired
	private IndexMapper mapper;

	@Override
	public List<MovieVO> weekList() {

		return mapper.weekList();
	}

	@Override
	public List<MovieVO> monthList() {

		return mapper.monthList();
	}

	@Override
	public List<MovieVO> yearList() {

		return mapper.yearList();
	}
	




}
