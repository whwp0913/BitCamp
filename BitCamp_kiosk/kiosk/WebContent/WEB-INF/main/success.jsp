<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
    html { 
        background-image: url(http://inutechdesign.co.kr/wp-content/uploads/2015/11/%EB%B2%84%EA%B1%B0%ED%82%B9-%EC%9A%B8%EC%82%BC%EC%A0%900208_1_easd.jpg); 
        no-repeat: center center fixed;
        background-size: cover;    
    }
    
    div {
    display:block; 
    position: relative;
	top: 400px;
	background-color: rgba(255,0,0,0.5);
    }
    h1 {
    
   color: white;
    }
</style>
<script>
history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
};
setTimeout(function() {
    self.location  = "/main/menu";
}, 3000);
</script>
</head>

<body>
<center>
<div>
<h1>감사합니다! 주문완료! 번호를 확인해주세요.</h1>
<h1>주문완료 주문번호는 ${ordernum}</h1>
</div>
</center>
</body>
</html>