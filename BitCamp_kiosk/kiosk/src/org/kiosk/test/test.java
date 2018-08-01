package org.kiosk.test;
import java.util.Arrays;

import org.junit.Before;
import org.junit.Test;
import org.kiosk.data.CookieUtill;

import lombok.extern.log4j.Log4j;

@Log4j
public class test {
	
	
	
	@Before
	public void setUp() throws Exception {
		
	}

	@Test
	public void test() throws Exception {
		log.info(CookieUtill.deleteCookie("1|2|2|3|3|1|1", "1"));

	}

}
