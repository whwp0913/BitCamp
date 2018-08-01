package org.manager.option;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class JRRequest extends HttpServletRequestWrapper {

	public JRRequest(HttpServletRequest request) {
		super(request);
	}
	
	public String param(String name) {
		return this.getParameter(name);
	}
	
	public String param(String name, String defaultValue) {
		String value = this.getParameter(name);
		return value == null?defaultValue:value;
	}

	public int paramInt(String name, int defaultValue) {	
		try {
			String value = this.getParameter(name);
			return Integer.parseInt(value);
		}catch(Exception e) {
			return defaultValue;
		}
	}
}