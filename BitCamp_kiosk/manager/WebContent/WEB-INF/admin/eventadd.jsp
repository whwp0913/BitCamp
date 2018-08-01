<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



<script type="text/javascript">
window.onload=function(){
populatedropdown("yeardropdown", "monthdropdown", "daydropdown")
}
</script>
<h1>event add</h1>  tbl_evet 에 등록할 정보들 이벤트 등록페이지-??? 등록하면  

<form method='post' action='/manager/admin/eventAdd'> <!-- iframe -->
<table>
<tr><td> ename<input type='text' name='event'></td></tr>
<tr><td> drate<input type='text' name='event'></td></tr>
<tr><td> dcount<input type='text' name='event'></td></tr>
<tr><td> sday<input type='date' name="event"></td></tr>
<tr><td> eday<input type='date' name="event"></td></tr> 
</table>
<input type='submit' value='등록하기' name='check'>
<input type='submit' value='취소' name='check'>
</form>

</body>
</html>