package org.zerock.domain;

import java.util.Date;
import lombok.Data;

@Data
public class BoardVO {
	
	private int bno;
	private String title;
	private String content;
	private Date regdate;
	private Date updatedate;
	private int views;
	private String mid;
	private String kno;
	private String gno;
	private String[] files;
}
