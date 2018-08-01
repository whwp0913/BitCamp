package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.zerock.domain.IRecomVO;

public interface RecommendMapper {

	public void addRecommend(List<IRecomVO> list);
	
	public void removeRecom();
	
	public List<Map<String,String>> listIRecom(int code);
}
