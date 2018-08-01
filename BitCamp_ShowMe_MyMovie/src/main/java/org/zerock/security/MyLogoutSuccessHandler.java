package org.zerock.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

public class MyLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler implements LogoutSuccessHandler{

	
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		if (authentication != null) {

			System.out.println(authentication.getName() + "---------------------------------------------");
        }
		
		HttpSession session = request.getSession();
		if(session.getAttribute("naver") != null) {
			session.invalidate();
			response.setStatus(HttpStatus.OK.value());
			response.sendRedirect(request.getHeader("referer"));
			
		}
		
		response.setStatus(HttpStatus.OK.value());
		response.sendRedirect(request.getHeader("referer"));
		
		
        /*setDefaultTargetUrl("/login");*/

		
		super.onLogoutSuccess(request, response, authentication);
	}

	
	
}
