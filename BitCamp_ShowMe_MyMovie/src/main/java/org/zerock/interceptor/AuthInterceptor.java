package org.zerock.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private MemberService service;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		if (session.getAttribute("LOGIN") == null) {

			saveURI(request);

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

			if (loginCookie != null) {
				MemberVO vo = service.checkLoginBefore(loginCookie.getValue());
				log.info("MemberVO: " + vo);
				if (vo != null) {
					session.setAttribute("LOGIN", vo);
					return true;
				}
			}

			response.sendRedirect("/login");

			return false;
		}
		return true;
	}

	private void saveURI(HttpServletRequest req) {
		String uri = req.getRequestURI();
		String query = req.getQueryString();
		log.info("URI: " + uri);
		log.info("QueryString: " + query);
		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}

		if (req.getMethod().equals("GET")) {
			log.info("final URI: " + uri + query);
			req.getSession().setAttribute("URI", uri + query);
		}
	}

}
