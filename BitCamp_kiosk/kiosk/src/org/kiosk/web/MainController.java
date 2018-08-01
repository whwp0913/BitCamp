package org.kiosk.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.kiosk.data.CookieUtill;
import org.kiosk.data.MenuDAO;
import org.kiosk.data.MenuVO;
import org.kiosk.option.AbstractController;
import org.kiosk.option.JRRequest;

import lombok.extern.log4j.Log4j;

/**
 * Servlet implementation class MainController
 */
@Log4j
@WebServlet("/main/*")
public class MainController extends AbstractController {
	private static final long serialVersionUID = 1L;
	// List<MenuVO> list = new ArrayList<>();
	// Map<String, MenuVO> cookieMap;
	// Coo1kie cartCookie = null;
	//
	// Map<Integer, List<MenuVO>> map = new HashMap<>();

	MenuDAO dao;

	public String menuGET(JRRequest req, HttpServletResponse res) throws Exception {
		log.info("***************menuGET*******************");
		return "/main/menu";
	}

	public String listPOST(JRRequest req, HttpServletResponse res) throws Exception {
		Cookie cartCookie = null;
		Map<String, MenuVO> cookieMap;
		Cookie[] cks = req.getCookies();

		String mno = req.getParameter("menuname");

		if (cks.length > 0) {

			for (Cookie ck : cks) { // 2개
				if (ck.getName().equals("mno")) {
					cartCookie = ck;
					cartCookie.setValue(cartCookie.getValue() + "|" + mno);
					break;
				} else {
					cartCookie = new Cookie("mno", mno);
				}
			}
		}

		cartCookie.setMaxAge(60 * 3);

		String[] cookies = CookieUtill.cookieSplit(cartCookie.getValue());

		cookieMap = CookieUtill.cookieCount(cookies);

		res.addCookie(cartCookie);
		req.setAttribute("cookieMap", cookieMap); // 맵 필요
		return "/main/orderlist";
	}

	public String resultPOST(JRRequest req, HttpServletResponse res) throws Exception {
		Map<String, MenuVO> cookieMap = null;
		Cookie cartCookie = null;
		try {
			cartCookie = CookieUtill.getCookie(req.getCookies(), "mno");
			cookieMap = CookieUtill.getAllItem(cartCookie);

			if (req.getParameter("check").isEmpty()) {
				cookieMap = null;
				cartCookie.setMaxAge(0);
				res.addCookie(cartCookie);

				return "redirect:/main/menu"; // 매뉴 선택하고 취소눌렀을때 타고
			}
		} catch (Exception e) {
			return "redirect:/main/menu"; // 그냥 취소 눌렀을때 타고
		}


		req.setAttribute("order", CookieUtill.cookieCount(CookieUtill.cookieSplit(CookieUtill.selectCookie(req, "mno"))));

		return "/main/result";
	}

	public String listGET(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new MenuDAO();
		List<MenuVO> list = null;

		if (req.param("what").isEmpty()) {
			list = dao.getSpeical();
		} else {
			list = dao.getList(req.param("what"));

		}

		req.setAttribute("list", list);

		return "/main/list";
	}

	public String successPOST(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new MenuDAO();
		Cookie cartCookie = CookieUtill.getCookie(req.getCookies(), "mno");
		Map<String, MenuVO> cookieMap = CookieUtill.getAllItem(cartCookie);





		String takeout = req.getParameter("takeout");
		log.info("takeout +++++++++++++++++++++++" + takeout);
		dao.insertONO(Integer.parseInt(takeout));


		dao.insertOrders(CookieUtill.cookieCount(CookieUtill.cookieSplit(CookieUtill.getCookie(req.getCookies(), "mno").getValue())));

		int ono = dao.getONO();
		dao.finalOrder(ono);

		req.setAttribute("ordernum", ono);

		cartCookie.setMaxAge(0);
		res.addCookie(cartCookie);

		return "/main/success";
	}

	public String orderListGET(JRRequest req, HttpServletResponse res) throws Exception {

		Cookie cartCookie = CookieUtill.getCookie(req.getCookies(), "mno");
		Map<String, MenuVO> cookieMap = CookieUtill.getAllItem(cartCookie);

		log.info("orderlist의 cookieMap : ==========" + cookieMap);
		// 여기는 리스트POST에서 리스폰스 해줘서 리퀘스트 쿠키로 값을 받는다;
		log.info("orderlist의 cookie[] : =================" + cartCookie);

		log.info("(((((((((((((((In orderListGET)))))))))))))))");
		String cookieString = CookieUtill.selectCookie(req, "mno"); // 쿠키의 스트링이 넘어감 (쿠키의 내용들)
		log.info("(((((((((((((((cookieString)))))))))))))))" + cookieString);
		cookieString = CookieUtill.deleteCookie(cookieString, req.getParameter("mno")); // 해당번호 수량삭제 첫번짼 실행 // 문제
		log.info("(((((((((((((((deleteCookie)))))))))))))))"
				+ CookieUtill.deleteCookie(cookieString, req.getParameter("mno")));
		cartCookie.setValue(cookieString);
		cookieMap = CookieUtill.cookieCount(CookieUtill.cookieSplit(cookieString));
		res.addCookie(cartCookie);
		req.setAttribute("cookieMap", cookieMap);

		return "/main/orderlist";
	}
}
