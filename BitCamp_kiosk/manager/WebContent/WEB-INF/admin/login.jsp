<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
html {
background-color: green;
}
h1 {
font-size: 100px;
text-align: center;
color: red;
}
div {
position: relative;
}
table{
width:100px;
height:50px
}
</style>

</head>
<body>
<h1>관리자</h1>

<div align="center">
<table>
<form action='/manager/admin/login' method='post'>
<tr><td>아이디<input type="text" name='userid'></td></tr>
<tr><td>패스워드<input type="password" name='userpw'><button>로그인</button></td></tr>
</form>
</table>
</div>

</body>
</html>