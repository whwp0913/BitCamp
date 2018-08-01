<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<h1>난 안끊겨요 ${cookieMap}</h1>

<form action="/main/orderList" method="get" target="frame2">
<c:forEach items="${cookieMap}" var="name">

<p>상품이름 : ${name.value.mname} 상품수량 : ${name.value.amount} 금액 : ${name.value.amount * (name.value.eno > 0? name.value.discost : name.value.mprice)} <button name="mno" value="${name.value.mno}">(-)</button></p>
</c:forEach>
</form>
</body>
</html>