<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
img {
width: 200px;
height: 200px;
}
h1 {
text-align: center;
}
td {
width: 40%;
}
</style>
</head>
<body>
	<h1>메뉴를 선택하십시오.</h1>
    




	<form method="post" action="/main/list" target='frame2'>
    <c:set var='i' value='0' />
    <c:set var='j' value='3' />
    <center><table>
    <tr>
		<c:forEach items='${list}' var='m'>
        <c:if test="${i%j == 0}">
        <tr>
        </c:if>
				<td><button name='menuname' value='${m.mno}'><img src="/img/${m.img}"></button></td>
                <c:if test="${i%j == j-1 }">
                </tr>
                </c:if>
                <c:set var='i' value="${i+1 }" />
		</c:forEach>
        
    </table></center>
	</form>
    
    
</body>
</html>