package org.manager.data;

import java.util.Date;

import lombok.Data;
@Data
public class EventVO {

	private int eno;
	private String ename;
	private double drate;
	private int dcount;
	private Date sday;
	private Date eday;
	
}
