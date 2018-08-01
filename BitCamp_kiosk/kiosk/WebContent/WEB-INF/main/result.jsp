<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<title>Insert title here</title>

<script>
	history.pushState(null, null, location.href);
	window.onpopstate = function() {
		history.go(1);
	};
</script>

<style>
    html { 
        background-image: url(http://inutechdesign.co.kr/wp-content/uploads/2015/11/%EB%B2%84%EA%B1%B0%ED%82%B9-%EC%9A%B8%EC%82%BC%EC%A0%900208_1_easd.jpg); 
        no-repeat: center center fixed;
        background-size: cover;    
    }
    
    table{
    border: 2px black;
    background-color: #DAD9FF;
    border-collapse: collapse;
    width: 70%;
    margin: 10px;
    }

#title {
font-size: large;
text-align: center;
}
form {
display: inline;
}
#contents {
padding: 10px;
}
label {
font-size: 20px;
}
div {
background-color: rgba(255, 217, 236, 0.7);
display:inline;
border: 2px ridge;

}

#select {
opacity:
}
</style>

</head>
<body>
<center>
	<h1>결제화면</h1>
	<form method='post' action='/main/success'>
		<div>
		<input type="radio" name="takeout" value="0" id='select' checked="checked"> 
		<label id='select'>매장</label> 
		<input type="radio" name="takeout" value="1" id='select'> 
		<label id='select'>포장</label>
		<input value='결제하기' type="submit">
		
	</form>
	<form method='post' action='/main/result'>
		<button name="check" value="">취소</button>
		</div>
	</form>
	
	<table name='product' border='2px' style="border-color: white">
	<tr id='title'>
	<td><h3>상품명</h3></td>
	<td><h3>가격</h3></td>
	<td><h3>수량</h3></td>
	<td><h3>금액</h3></td>
	</tr>

	<c:set var = "sum" value = "0" />
	<c:forEach items='${order}' var='m'>
	<tr>
	<td id='contents'>${m.value.mname}</td>
	<td id='contents'>${m.value.mprice}</td>
	<td id='contents'>${m.value.amount}</td>
	<td id='contents'>${m.value.amount * (m.value.eno > 0? m.value.discost : m.value.mprice)}</td>
	</tr>
	<c:set var= "sum" value="${sum + m.value.amount * (m.value.eno > 0? m.value.discost : m.value.mprice)}"/>
	</c:forEach>
	<tr id='title'>
	<td><h4>총금액</h4></td>
	<td colspan='2'>ㆍ</td>
	<td><h4><c:out value="${sum}"/></h4></td>
	</tr>
	</table>
	</form>
	
</center>



</body>
</html>