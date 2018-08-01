<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<title>Leaf Viliage</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="/resources/loginResources/images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/css/util.css">
	<link rel="stylesheet" type="text/css" href="/resources/loginResources/css/main.css">
	
	<script src="/resources/loginResources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="/resources/loginResources/vendor/animsition/js/animsition.min.js"></script>
	<script src="/resources/loginResources/vendor/bootstrap/js/popper.js"></script>
	<script src="/resources/loginResources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="/resources/loginResources/vendor/select2/select2.min.js"></script>
	<script src="/resources/loginResources/vendor/daterangepicker/moment.min.js"></script>
	<script src="/resources/loginResources/vendor/daterangepicker/daterangepicker.js"></script>
	<script src="/resources/loginResources/vendor/countdowntime/countdowntime.js"></script>
	<script src="/resources/loginResources/js/main.js"></script>
</head>
<style>
.rememberMe{
padding: 10px;
text-align: left;
font-size: 14px;
margin-top: 5px;
}


</style>
<body>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50">
				<form id="frm" class="login100-form validate-form" action="/login" method="post">
				
				 	<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				
					<span class="login100-form-title p-b-33">
						Account Login
					</span>

					<div class="wrap-input100 validate-input" data-validate="ID를 입력해주세요">
						<input class="input100" type="text" name="mid" placeholder="ID">
						<span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>


					<div class="wrap-input100 rs1 validate-input" data-validate="비밀번호를 입력해주세요">
						<input class="input100" type="password" name="mpw" placeholder="Password">
						<span class="focus-input100-1"></span>
						<span class="focus-input100-2"></span>
					</div>
					
					<div>
<!-- 						<span class="login100-form-title p-b-33 rememberMe">
							<input type="checkbox" name="remember-me">&nbsp;Remember Me
						</span> -->
						<label class="p-t-15">
						  <input class="m-r-3" name="remember-me" 
						  style="top:5px; width: 17px; height: 17px; vertical-align: text-bottom;" 
						  type="checkbox">
						   로그인 유지
						</label>
						
						<span class="pull-right p-t-10">
							<a href="">아이디/비밀번호 찾기</a>&nbsp;|&nbsp;<a href="/signup">회원가입</a>
						</span>
					</div>
					
					
					<div class="container-login100-form-btn m-t-20">
						<input value="로그인" type="submit" id="sub" class="login100-form-btn"/>
							
						
					</div>
					<div class="text-center" style="margin-top: 10px;">
						<a href="${url}">
							<img src="resources/img/naverLogin1.PNG" style="width: 280px; height: 57px;"/>
						</a>
					</div>



						<c:if test="${not empty error}">
							<div class="error">${error}</div>
						</c:if>
						<c:if test="${not empty msg}">
							<div class="msg">${msg}</div>
						</c:if>
				</form>
			</div>
		</div>
	</div>
<script src="/resources/loginResources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="/resources/loginResources/vendor/animsition/js/animsition.min.js"></script>
<script src="/resources/loginResources/vendor/bootstrap/js/popper.js"></script>
<script src="/resources/loginResources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/loginResources/vendor/select2/select2.min.js"></script>
<script src="/resources/loginResources/vendor/daterangepicker/moment.min.js"></script>
<script src="/resources/loginResources/vendor/daterangepicker/daterangepicker.js"></script>
<script src="/resources/loginResources/vendor/countdowntime/countdowntime.js"></script>
<script src="/resources/loginResources/js/main.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	var frm = $("#sub");
	var mid = $("#mid");
	var mpw = $("#mpw");

});
</script>
</body>
</html>