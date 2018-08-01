package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MovieVO {

	private int num;
	private String img;
	private String tit;
	private String grade;
	private String open;
	private Date regdate;
	private String infoLink;
	private String des;
	
}
