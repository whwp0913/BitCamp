package org.kiosk.data;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.kiosk.option.JRRequest;

import lombok.extern.log4j.Log4j;

@Log4j
public class CookieUtill {
	
	// 쿠키의 담긴 내용을 | 기준으로 짤라줌
	public static String[] cookieSplit(String cookie) {
		log.info("cookie : " + cookie);
		String[] cookies = cookie.split("\\|");

		log.info("split cookies : " + Arrays.toString(cookies));

		return cookies;
	}
	public static void finalInsert(Cookie cookie) {
		
	}
	
	// 쿠키에 담긴 상품번호의 수량체크
	public static Map<String, MenuVO> cookieCount(String[] cookies) throws Exception { // 수량계산하는 로직
		Map<String, MenuVO> cookieMap = new HashMap<>();
		MenuDAO dao = new MenuDAO();
		MenuVO vo = null;
		log.info("cookies : ======= " + Arrays.toString(cookies));
		for (String cookie : cookies) {
			if(cookie.equals("")) {
				continue;
			}
			log.info("cookie : =====" + cookie);
			log.info("vo : =====" + dao.choice(cookie));
			vo = dao.choiceVO(cookie);
			if (cookieMap.containsKey(cookie)) {
				
				vo.setAmount(cookieMap.get(cookie).getAmount() + 1);
				cookieMap.put(cookie, vo);
				log.info("iftrue cookieMap : " + cookieMap);
			} else {
				vo.setAmount(1);
				cookieMap.put(cookie, vo);
				log.info("iffalse cookieMap : " + cookieMap);
			}
		}
		return cookieMap;
	}
	// 쿠키 삭제
	public static String deleteCookie(String cookieData, String mno) throws Exception {
		//? | 때문에 짤릴때 null 이것때문에 처음에 취소눌렀을떄 화면 menu안탐? 쿠키의 스트링값들이 들어와서
		String[] cookies = cookieSplit(cookieData);
		boolean same = true;
		String str = "";
		for (String cookie : cookies) {
			
			if (cookie.equals(mno)) { // 겹치는 번호 1개 빼주고 
				if (same) {
					same = false;
					continue;
				}
			}
			str = str + "|" + cookie; // | 합쳐주는작업
		} // end for
		log.info("list ================================================================= " + str);

		return str;
	}
	// 쿠키를 스트링으로 반환 1번
	public static String selectCookie(JRRequest req, String cookieName) throws Exception {
		Cookie cartCookie = null;
		String cookieString = null;
		Cookie[] cks = req.getCookies();

		if (cks.length > 0) {

			for (Cookie ck : cks) { // 2개
				if (ck.getName().equals(cookieName)) {
					cartCookie = ck;
					cookieString = cartCookie.getValue();
					return cookieString;
				}
			}

		}
		return null;
	}
	
	public static Cookie getCookie(Cookie[] cookies, String cookieName) throws Exception{
		Cookie[] cks = cookies;
		Cookie cartCookie = null;
		if (cks.length > 0) {

			for (Cookie ck : cks) { // 2개
				if (ck.getName().equals(cookieName)) {
					cartCookie = ck;
					return cartCookie;
				}
			}
		}
		return null;
	}
	
	public static Map<String, MenuVO> getAllItem(Cookie cookie) throws Exception {
		MenuDAO dao = new MenuDAO();
		MenuVO vo;
		Map<String, MenuVO> cookieMap = new HashMap<>(); // 
		//String
		log.info("cookie=================== :" + cookie.getValue());
		String[] cookieMno = CookieUtill.cookieSplit(cookie.getValue());
		
		for(String mno : cookieMno) {
			log.info("mno ===========================:"+ mno);
			
			if(mno.equals("")) {
				continue; //지금 무엇이문제? 1.스플릿 해결 2.값이 제대로 안넘어감
			}
			log.info("mapput ================" + dao.choice(mno).get(0));
			cookieMap.put(mno, dao.choice(mno).get(0));
			
		}
			
		return cookieMap;
	}
}