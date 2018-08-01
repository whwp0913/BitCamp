<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
button {
	font-size: 20px;
}
table{
width: 300px;
height: 300px;
}

img {
width: 200px;
height: 200px;
}
td {
text-align: center;
}

</style>



</head>


<body>
<h1>관리목록</h1>
<table border="2px" align="center">
<tr>
<td><img src='/img/product.jpg'></td>
<td><img src='/img/statistic.jpg'></td>
</tr>
<tr><td><form method='get' action='/manager/admin/lookup'>
		<button name="page" value="1">상품관리</button>
		</form></td>

	<td><form method='get' action='/manager/admin/statics'>
		<button name='statics' value='2'>통계</button>
		</form></td>
</tr>
</table>
</body>
</html>