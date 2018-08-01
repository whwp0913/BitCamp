package org.zerock.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.security.UserDetailsServiceImpl;
import org.zerock.service.MemberService;
import org.zerock.utils.NaverLoginBO;

import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
public class MemberController {
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;

	/* NaverLoginBO */
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO){
		this.naverLoginBO = naverLoginBO;
	}
	
	

	@Autowired
	private MemberService service;

	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView login(@RequestParam(value="error", required=false)String error,
					@RequestParam(value="logout", required = false)String logout, HttpServletRequest request
					,HttpSession session) {
		
		System.out.println("login get.............................");
		ModelAndView model = new ModelAndView();
		/*String currentUrl = "http://" + request.getServerName()+":"+request.getServerPort()+request.getRequestURI();*/
		
        /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        String checkUri = "http://" + request.getServerName() + ":" + request.getServerPort() + "/login";
        String checkUri2 = request.getRequestURL().toString();
        String checkUri3 = "http://" + request.getServerName() + ":" + request.getServerPort() + "/signup";
        String signUpPrevPage = null;
        
        //이전 페이지 URL
		String referer = null;
		//이전 페이지가 로그인,회원가입 페이지가 아닐 경우
		if(request.getHeader("Referer").equals(checkUri) != true 
				&& request.getHeader("Referer").equals(checkUri2)!=true 
				&& request.getHeader("Referer").equals(checkUri3)!=true) 
		{
			referer = request.getHeader("Referer");
			System.out.println("referer1 : " + referer);
		}else if(request.getHeader("Referer").equals(checkUri3)==true) { //이전페이지가 회원가입 페이지였을 경우
			signUpPrevPage = session.getAttribute("signUpPrevPage").toString();
			System.out.println("signUpPrevPage : " + signUpPrevPage);
			referer = signUpPrevPage;
			System.out.println(referer);
		}else {//나머지의 경우 기본경로를 index 페이지로 준다 ( 이전페이지가 로그인페이지일 경우도 포함)
			referer = "http://" + request.getServerName() + ":" + request.getServerPort() + "/index";
			System.out.println(referer + "3");
		}

		if (error != null) {
			referer = request.getSession().getAttribute("prevPage").toString();
			
			model.addObject("error", "Invalid username and password!");
		}
		
		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		request.getSession().setAttribute("prevPage", referer);
		
		

		model.setViewName("login");
		model = new ModelAndView("login", "url", naverAuthUrl);
		return model;
	}
	
	@GetMapping("/signup")
	public void signUp(HttpServletRequest request) {
		String checkUri = "http://" + request.getServerName() + ":" + request.getServerPort() + "/login";
		String checkUri2 = "http://" + request.getServerName() + ":" + request.getServerPort() + "/login?error";
		
		System.out.println("signUp get..................");
		
		System.out.println(request.getHeader("Referer").equals(checkUri));
		System.out.println(request.getRequestURL());
		String referer = null;
		if(request.getHeader("Referer").equals(checkUri) != true 
			&& request.getHeader("Referer").equals(checkUri2) != true) {
			referer = request.getHeader("Referer");
			System.out.println("회원가입 페이지 이전페이지 저장 URL................................" + referer);
			
		}else if(request.getHeader("Referer").equals(checkUri) == true 
				|| request.getHeader("Referer").equals(checkUri2) == true){
			referer = request.getSession().getAttribute("prevPage").toString();
			System.out.println("회원가입 페이지 이전페이지 저장 URL................................" + referer);
			
		}else{
			referer = "http://" + request.getServerName() + ":" + request.getServerPort() + "/index";
			System.out.println("회원가입 페이지 이전페이지 저장 URL................................" + referer);
		}
		request.getSession().setAttribute("signUpPrevPage", referer);
	}

	@PostMapping("/signup")
	public void signUpPost(MemberVO vo, Model model, RedirectAttributes rttr, HttpSession session,
			HttpServletResponse res) throws Exception {
		
		vo.setMpw(UserDetailsServiceImpl.encoder(vo.getMpw()));
		service.userRegist(vo);
		service.insertAuth(vo.getMid());
		
		
		service.getUserID(vo.getMid());
		/*session.setAttribute("LOGIN", vo);*/


		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();

		out.println("<script>alert('회원가입되었습니다'); location.href='/login' </script>");

		
	}

	@PostMapping("/idCheck")
	public ResponseEntity<String> checkId(@RequestBody String id) {
		ResponseEntity<String> entity = null;
		entity = new ResponseEntity<String>(Integer.toString(service.userIdCheck(id)), HttpStatus.OK);	
		return entity;
	}
	
	@RequestMapping(value = "/callback")
	public ModelAndView naverCallback(
			HttpSession session, @RequestParam String code, @RequestParam String state) throws IOException {
		
		OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
		String apiResult = naverLoginBO.getUserProfile(oauthToken);
		
		session.setAttribute("naver", apiResult);
		
		return new ModelAndView("callback", "result", apiResult);

	}
	
	/*		HttpSession session = req.getSession();
	
	String redirectUrl = (String) session.getAttribute("prevPage");
	
	return redirectUrl;*/

}
