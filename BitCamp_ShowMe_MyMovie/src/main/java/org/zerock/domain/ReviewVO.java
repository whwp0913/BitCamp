package org.zerock.domain;

import java.util.Date;
import lombok.Data;

@Data
public class ReviewVO {
	
	private int vno;
	private int mno;	// 회원 번호 추가
	private String mid;
	private int code;	// 영화 코드 추가
	private String title;
	private String comment;
	private float rating;
	private String imgLink;
	private String link;
	private Date regdate;
}
