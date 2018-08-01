<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

</style>

</head>

<body>
<h1>상품관리</h1>

<table align="center" border="2px" bordercolor="black">
<c:forEach items='${eventlist}' var='m'>
<tr>
<td>글번호${m.eno}</td>
<td><a href='/manager/admin/eventView?eno=${m.eno}'>${m.ename}</a></td>
<td>${m.sday}</td>
<td>${m.eday}</td>
<td></td>
</tr>
</c:forEach>
</table>

<div class="paginate">
    <a href="/manager/admin/event?page=${start}" class="first">처음 페이지</a>
    <%-- <c:if><<a href="/manager/admin/product?page=${before}" class="prev">이전 페이지</a></c:if> --%>
    <span>
        <c:forEach var="i" begin="${start}" end="${end}" step="1">
            <c:choose>
                <c:when test="${i eq param.pageNo}"><a href="/manager/admin/event?page=${i}" class="choice">${i}</a></c:when>
                <c:otherwise><a href="/manager/admin/event?page=${i}">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <%-- <a href="/manager/admin/product?page=${next}" class="next">다음 페이지</a> --%>
    <a href="/manager/admin/event?page=${end}" class="last">마지막 페이지</a>
</div>
<a href='/manager/admin/eventAdd'><input type="button" value="event add"></a>


</body>
</html>