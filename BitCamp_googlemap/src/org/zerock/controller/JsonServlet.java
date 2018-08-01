package org.zerock.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.zerock.domain.LocalVO;

import com.google.gson.Gson;

/**
 * Servlet implementation class JsonServlet
 */
@WebServlet("/data")
public class JsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JsonServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Gson gson = new Gson();
		response.setContentType("application/json; charset=UTF-8");
		String json = null;
		LocalVO vo = new LocalVO();
		List<LocalVO> name = LocalVO.locals;
		try {
//			name = vo.getlocals(request.getParameter("name"));
			if (name.size() < 1) {
				name = vo.getlocals();
				};            
			json = gson.toJson(name);

			response.getWriter().println(json);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Post... Start!!");
		String json = null;
		Proxy proxy = new Proxy();
		response.setContentType("text/xml; charset=UTF-8");
		String local = request.getParameter("location");
		System.out.println(local);
		try {
			json = proxy.getData(local);
			response.getWriter().println(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

