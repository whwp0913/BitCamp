package org.zerock.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.zerock.service.BoardService;

import com.mysql.jdbc.StringUtils;

import lombok.Setter;


public class ViewCountInterceptor extends HandlerInterceptorAdapter {
	
	@Setter(onMethod_= {@Autowired})
	private BoardService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		int bno = Integer.parseInt(request.getParameter("bno"));
		Cookie cookies[] = request.getCookies();
		Map<String,String> cookieMap = new HashMap<>();
		
		if(request.getCookies() != null ) {
			for(int i = 0; i < cookies.length; i++) {
			Cookie cookieObj = cookies[i];
			cookieMap.put(cookieObj.getName(), cookieObj.getValue());
			}	
		}
		
		String cookieViews = (String)cookieMap.get("views");
		String cookie_viewCnt = "|" + bno;
		if(cookieViews == null) {
			cookieViews = "views";
		}
		
		if(StringUtils.indexOfIgnoreCase(cookieViews, cookie_viewCnt) == -1) {
			Cookie cookie = new Cookie("views" ,  cookieViews+ cookie_viewCnt);
			cookie.setMaxAge(60 * 60 * 24);
			response.addCookie(cookie);
			service.viewCnt(bno);
	   }
		return true;
	}
		
}