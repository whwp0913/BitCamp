<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>

    <style>
        td {
            padding: 10px;
        }
        input {
            width: 330px;
            height: 35px;
            margin: 5px;
            position: relative;
            left: 5px;
        }
        table {
            margin-bottom: 5px;
            width: 500px;
            height: 500px;
        }
        .check {
            width: 150px;
        }
    </style>



</head>
<body>
<center>
    <form action='/manager/admin/view' method='post'>
        <table border="2px" style="border-color: black">
            <tr><td>상품번호 :<input type='text' value='${product.mno}' name='mname' readonly="readonly"></td></tr>
            <tr><td>상품이름 :<input type='text' value='${product.mname}' name='mname'></td></tr>
            <tr><td>상품가격 :<input type='text' value='${product.mprice}' name='mname'></td></tr>
            <tr><td>상품이미지 :<input type='text' value='${product.img}' name='mname'></td></tr>
            <tr><td>상품분류 :<input type='text' value='${product.mclass}' name='mname'></td></tr>
            <tr><td>할인가격 :<input type='text' value='${product.discost}' name='mname' readonly="readonly"></td></tr>
            <tr><td>판매여부 :<input type='text' value='${product.sellcheck}' name='mname'></td></tr>
            <tr><td>등 록 일 :<input type='text' value='${product.regdate}' name='mname'></td></tr>
            <tr><td>수 정 일 :<input type='text' value='${product.updatedate}' name='mname'></td></tr>
            <tr><td>할인정보 :<input type='text' value='${product.eno}' name='mname'></td></tr>
        </table>

        <input type="submit" name="means" value="modi" class="check">
        <input type="submit" name="means" value="dele" class="check">
    </form>
</center>
</body>
</html>