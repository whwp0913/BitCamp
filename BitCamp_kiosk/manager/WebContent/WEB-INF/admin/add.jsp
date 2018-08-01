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
        .add {
        width:150px;
        height:50px;
        }
        select {
        width: 330px;
            height: 35px;
            margin: 5px;
            position: relative;
            left: 5px;
        }
        
    </style>



</head>
<body>
<center>

    <form action='/manager/admin/add' method='post'>
        <table border="2px" style="border-color: black">
            <tr><td>상품이름 :<input type='text' name='mname'></td></tr>
            <tr><td>상품가격 :<input type='text' name='mname'></td></tr>
            <tr><td>상품이미지 :<input type='text' value="none.jpg" name='mname'></td></tr>
            <tr><td>상품분류 :<select name='mname'>
					<option value='set'>set</option>
					<option value='burger'>burger</option>
					<option value='drink'>drink</option>
					<option value='side'>side</option>
					</select></td></tr>
            <tr><td>판매여부 :<select name='mname'>
								<option value='Y'>SELL</option>
								<option value='N'>SOLD OUT</option>
							</select></td></tr>
        </table>

        <input type="submit" name="means" value="add" class='add'>
        <input type="submit" name="means" value="back" class='back'> 
    </form>
</center>
</body>
</html>