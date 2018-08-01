package org.zerock.utils;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import org.zerock.domain.Criteria;

import lombok.Data;

@Data
public class URIMaker {

	private String type, keyword;
	private int page, perPageNum;

	public URIMaker(Criteria cri) {
		this.type = cri.getKeyword();
		this.keyword = cri.getKeyword();
		this.page = cri.getPage();
		this.perPageNum = cri.getPerPageNum();

	}

	public String URICre(String path) {
		UriComponents builder = UriComponentsBuilder.newInstance().path(path).queryParam("type", type)
				.queryParam("keyword", keyword).queryParam("page", page).queryParam("perPageNum", perPageNum).build();
		return builder.toString();
	}

}
