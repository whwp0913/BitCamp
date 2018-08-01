package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PhotoVO {
	
	private int pno;
	private String title, content;
	private Date regdate, updatedate;
	private String mid;
	private int views;
	private String[] images;
	private String image;
	
	
}
