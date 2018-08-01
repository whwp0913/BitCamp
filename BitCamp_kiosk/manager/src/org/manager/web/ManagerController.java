package org.manager.web;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.manager.data.AdminDAO;
import org.manager.data.MenuVO;
import org.manager.domain.PageUtil;
import org.manager.option.AbstractController;
import org.manager.option.JRRequest;

import lombok.extern.log4j.Log4j;

/**
 * Servlet implementation class ManagerController
 */
@Log4j
@WebServlet("/admin/*")
public class ManagerController extends AbstractController {
	private static final long serialVersionUID = 1L;
	AdminDAO dao;

	public ManagerController() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String loginGET(JRRequest req, HttpServletResponse res) throws Exception {
		log.info("나 들어왔어!");

		return "/admin/login";
	}

	public String loginPOST(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new AdminDAO();
		boolean check = dao.loginCheck(req.getParameter("userid"), req.getParameter("userpw"));

		if (check) {
			HttpSession sesstion = req.getSession();
			sesstion.setAttribute("administrator", req.getParameter("userid"));

			return "/admin/administrate";
		}

		return "/admin/login";
	}

	// product.jsp 에 메뉴전부 뿌려주는 놈
	public String lookupGET(JRRequest req, HttpServletResponse res) throws Exception {
		
		
		return "/admin/lookup";
	}
	
	public String productGET(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new AdminDAO();
		int pageNum = Integer.parseInt(req.getParameter("page"));     
		int start = PageUtil.getStart(pageNum);
		int end = PageUtil.getEnd(pageNum, dao.getPageTotal());
		boolean before = PageUtil.hasBefore(pageNum);
		boolean next = PageUtil.hasNext(pageNum, dao.getPageTotal());
		log.info("pagNum : =====" + pageNum);
		log.info("getlist : ====" + dao.getList(pageNum));
		req.setAttribute("list", dao.getList(pageNum));
		req.setAttribute("start", start);
		req.setAttribute("end", end);
		req.setAttribute("before", before);
		req.setAttribute("next", next);
		
		return "/admin/product";

	}
	public String viewGET(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new AdminDAO();
		MenuVO product = dao.getProduct(req.getParameter("mno"));
		log.info("++++++++mno+++++++"+req.getParameter("mno"));
		log.info("++++++++product+++++++"+product);
		req.setAttribute("product", product);
		return "/admin/view";
	}
	
	public String viewPOST(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new AdminDAO();
		req.setCharacterEncoding("UTF-8");
	//수정시 /manager/admin/view?mno=${product.mno} 해당 뷰로다시
	//삭제시 /manager/admin/product?page=1 게시판으로
		String[] values = req.getParameterValues("mname");;
		if(req.getParameter("means").equals("modi")){
			log.info("수정해수정해수정해수정해수정해");
			dao.updateProduct(values);
		}
		
		else if(req.getParameter("means").equals("dele")){
			log.info("삭제해삭제해삭제해삭제해제바를");
			dao.deleteProduct(Integer.parseInt(values[0]));
			
			return "redirect:/admin/product?page=1";
		}
		return "redirect:/admin/view?mno="+values[0];
	}
	
	public String addGET(JRRequest req, HttpServletResponse res) throws Exception {
		return "/admin/add";
	}
	
	public String addPOST(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new AdminDAO();
		req.setCharacterEncoding("UTF-8");
		Boolean button = req.getParameter("means").equals("add");
		String[] values = req.getParameterValues("mname");
		
		if(button) {
			dao.insertProduct(values);
		}
		
		return "redirect:/admin/product?page=1";
	}
	
	public String eventGET(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new AdminDAO();
		int pageNum = Integer.parseInt(req.getParameter("page"));
		int start = PageUtil.getStart(pageNum);
		int end = PageUtil.getEnd(pageNum, dao.getEventTotal());
		boolean before = PageUtil.hasBefore(pageNum);
		boolean next = PageUtil.hasNext(pageNum, dao.getEventTotal());
		log.info("pagNum : =====" + pageNum);
		req.setAttribute("eventlist" , dao.getEvent(pageNum));
		req.setAttribute("start", start);
		req.setAttribute("end", end);
		req.setAttribute("before", before);
		req.setAttribute("next", next);
		
		return "/admin/event";
	}
	
	public String eventViewGET(JRRequest req, HttpServletResponse res) throws Exception {
		dao = new AdminDAO();
		String eno = req.getParameter("eno");
		log.info(eno);
		req.setAttribute("event", dao.getEvent(req.getParameter("eno")));
		
		return "/admin/eventview";
	}
	
	// 만들어야 될것 eventAddGET, eventAddPOST >> eventViewGet, evetViewPOST 
	public String eventViewPOST(JRRequest req, HttpServletResponse res) throws Exception {
		
		dao = new AdminDAO();
		log.info(req.getParameter("eno"));	
		int eno = Integer.parseInt(req.getParameterValues("ename")[0]);
		dao.eventDelete(eno);
		return "/admin/event";
	}
	
	public String eventAddGET(JRRequest req, HttpServletResponse res) throws Exception {
		
		return "/admin/eventadd";
	}
	public String eventAddPOST(JRRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		dao = new AdminDAO();
		dao.insertEvent(req.getParameterValues("event"));
		return "redirect:/admin/event?page=1"; // manager/admin/event?page=1
	}
}
