package org.manager.data;

import java.util.Date;

import lombok.Data;

@Data
public class MenuVO {

	private int mno;
	private String mname;
	private int mprice;
	private String img;
	private int discost;
	private String mclass;
	private String sellcheck;
	private Date regdate;
	private Date updatedate;
	private int eno;
	private int amount = 0;
	
}
