<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
div {
margin-bottom: 10px;
}
table {
width:900px;
height:500px;
text-align: center;
position: relative;
top: 60px;
font-size: 25px;

}
.final{
position: relative;
top: 50px;
margin-top: 40px;
}

</style>

</head>

<body>


<table border='2px' bordercolor="black" align="center">
<tr><td>상품명</td><td>가격</td><td>등록일</td><td>수정일</td>
<c:forEach items='${list}' var='m'>
<tr>
<td><a href='/manager/admin/view?mno=${m.mno}'>${m.mname}</a></td>
<td>${m.mprice}</td>
<td>${m.regdate}</td>
<td>${m.updatedate}</td>
</tr>
</c:forEach>
</table>

<div class='final'>
<div class="paginate" align="center">
    <a href="/manager/admin/product?page=${start}" class="first">처음 페이지</a>
    <%-- <c:if><<a href="/manager/admin/product?page=${before}" class="prev">이전 페이지</a></c:if> --%>
    <span>
        <c:forEach var="i" begin="${start}" end="${end}" step="1">
            <c:choose>
                <c:when test="${i eq param.pageNo}"><a href="/manager/admin/product?page=${i}" class="choice">${i}</a></c:when>
                <c:otherwise><a href="/manager/admin/product?page=${i}">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
    </span>
    <%-- <a href="/manager/admin/product?page=${next}" class="next">다음 페이지</a> --%>
    <a href="/manager/admin/product?page=${end}" class="last">마지막 페이지</a>
</div>
<div align="center"><a href='/manager/admin/add' ><input type="button" value="product add"></a>
<a href='/manager/admin/eventadd'><input type="button" value="event add"></a></div>
</div>

</body>
</html>