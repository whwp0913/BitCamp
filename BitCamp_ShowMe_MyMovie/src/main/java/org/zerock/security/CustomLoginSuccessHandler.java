package org.zerock.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.zerock.domain.ReviewVO;
import org.zerock.service.MemberService;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler
		implements AuthenticationSuccessHandler {

	@Autowired
	private MemberService mservice;

	public CustomLoginSuccessHandler() {

	}

	public CustomLoginSuccessHandler(String defaultTargetUrl) {
		setDefaultTargetUrl(defaultTargetUrl);
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		String mid = request.getParameter("mid");
		String favor = mservice.getUserID(mid).getFavor();
		List<ReviewVO> list = mservice.uRecom(mid);
		
		HttpSession session = request.getSession();
		
		session.setAttribute("favor", mservice.recommendMovie(favor));
		session.setAttribute("list", list);

		if (session != null) {
			String redirectUrl = (String) session.getAttribute("prevPage");
			
			if (redirectUrl != null) {
				session.removeAttribute("prevPage");
				getRedirectStrategy().sendRedirect(request, response, redirectUrl);
				
			} else {
				super.onAuthenticationSuccess(request, response, authentication);
			}
			
		} else {
			super.onAuthenticationSuccess(request, response, authentication);
		}
	}

}
