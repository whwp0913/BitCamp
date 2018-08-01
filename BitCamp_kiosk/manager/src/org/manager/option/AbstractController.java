package org.manager.option;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.log4j.Log4j;


@Log4j
public abstract class AbstractController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, 
			HttpServletResponse res) throws ServletException, IOException {
	
		System.out.println("====================");
		
		Class clz = this.getClass();
		String spath = req.getServletPath(); // managercontroller        --> /admin
		String conPath = req.getServletContext().getContextPath();  // manager
		String path = req.getRequestURI(); // /manager/admin/login
		
		log.info("spath :" + spath);
		log.info("conPath :" + conPath);
		log.info("path :" + path);
		
		int temp = (conPath + spath).length();
			
		String methodName = path.substring(temp + 1) + req.getMethod();
		
		log.info("methodName : " + methodName);
		
		try {
			Method method = clz.getDeclaredMethod(methodName,
					JRRequest.class, HttpServletResponse.class);
			log.info("method : " + method);
			
			Object result = method.invoke(this, new JRRequest(req), res);
			
			String resultStr = (String)result;
			log.info("아놔 빡치네 :"+resultStr);
			if(resultStr.startsWith("redirect:")) {
				log.info("res : " + res);
				res.sendRedirect(conPath + resultStr.substring(9));
				
			}else {
				log.info("req : " + req);
				req.getRequestDispatcher("/WEB-INF"+resultStr+".jsp").forward(req, res);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}	
	
	
}