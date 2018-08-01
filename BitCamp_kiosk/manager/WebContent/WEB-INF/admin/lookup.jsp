<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <style>

        iframe {
            width: 1000px;
            height: 750px;
            border-color: white;
            background-color: white;
        }
        html {
            background-color: green;
        }
        h1 {
            color: red;
            text-align: center;
        }
        div {
            margin-bottom: 20px;
        }
        button {
            font-size: 15px;
            border-color: black;
        }

    </style>
</head>

<body>
<h1>상품관리</h1>
<div align="center"><iframe name='view'></iframe></div>
<div align="center"><a href="/manager/admin/product?page=1" target='view'><button>상품리스트</button></a>
    <a href="/manager/admin/event?page=1" target='view'><button>이벤트리스트</button></a></div>


</body>
</html>