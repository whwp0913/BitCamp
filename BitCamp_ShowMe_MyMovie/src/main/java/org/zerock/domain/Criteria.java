package org.zerock.domain;

import org.zerock.utils.URIMaker;

import lombok.Data;


@Data
public class Criteria {
	
	private int page;
	private int perPageNum;
	private String type;
	private String keyword;
	private URIMaker um;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
		this.type = "";
		this.keyword = "";
	}
	
	public void setPage(int page) {
		if(page <= 0) {
			return;
		}else {
			this.page = page;
		}
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum < 10 || perPageNum > 50) {
			return;
		}else {
			this.perPageNum = perPageNum;
		}
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public String[] getArr() {
		if(type == null) {
			return null;
		}
		
		return this.type.split("");
	}
	
	public int getPageStart() {
		return (this.page-1) * perPageNum;			
	}
	
	
}
