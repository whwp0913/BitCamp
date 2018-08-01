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
    <form action='/manager/admin/eventView' method='post'>
        <table border="2px" style="border-color: black">
            
        
            <tr><td>이벤트 번호 :<input type='text' value='${event.eno}' name='ename' readonly="readonly"></td></tr>
            <tr><td>이벤트 이름 :<input type='text' value='${event.ename}' name='ename' readonly="readonly"></td></tr>
            <tr><td>할인 율 :<input type='text' value='${event.drate * 100}%' name='ename' readonly="readonly"></td></tr>
            <tr><td>할인 가 :<input type='text' value='${event.dcount}' name='ename' readonly="readonly"></td></tr>
            <tr><td>이벤트 시작일 :<input type='text' value='${event.sday}' name='ename' readonly="readonly"></td></tr>
            <tr><td>이벤트 마감일 :<input type='text' value='${event.eday}' name='ename' readonly="readonly"></td></tr>
            
        </table>
        <input type="submit" name="means" value="dele" class="check">
    </form>
</center>
</body>
</html>