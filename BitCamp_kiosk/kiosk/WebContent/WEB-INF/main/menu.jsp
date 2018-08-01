<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
    img {
        width: 200px;
        height: 50px;
    }
    iframe {
        background: white;
        border-color: black;

    }
    .b2 {
        margin:auto;
        width: 50px;
        height: 30px;
        
        
    }
    h1 {
        text-align: center;
    }
    html { 
        background-image: url(http://inutechdesign.co.kr/wp-content/uploads/2015/11/%EB%B2%84%EA%B1%B0%ED%82%B9-%EC%9A%B8%EC%82%BC%EC%A0%900208_1_easd.jpg); 
        no-repeat: center center fixed;
        background-size: cover;    
    }
</style>
</head>

<body>
  <h1>BIT BurgerKing</h1>
    <table align="center">
        <tr>
            <td><a href="/main/list?what=''" target=frame1 onclick="menuLink();"><img src="/img/event.jpg"></a></td>
            <td><a href="/main/list?what=set" target="frame1" onclick="menuLink();"><img src="/img/setMenu.jpg"></a></td>
            <td><a href="/main/list?what=burger" target="frame1" onclick="menuLink();"><img src="/img/burger.jpg"></a></td>
            <td><a href="/main/list?what=drink" target="frame1" onclick="menuLink();"><img src="/img/drink.jpg"></a></td>
            <td><a href="/main/list?what=side" target="frame1" onclick="menuLink();"><img src="/img/side.jpg"></a></td>
        </tr>
    </table>
    
<center>

<iframe name='frame0' width="1020" height="500" src="https://www.youtube.com/embed/9PbUeTeSetY?autoplay=1&list=PLzuFfUlL19NPRo7UT2ROSoqAXclCqcwry&loop=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
 
    <p><iframe  name='frame1' width="1020px" height="450px" align="center" style="display:none;"></iframe></p>
    <p><iframe  name='frame2' width="1020px" height="200px" align="center" style="display:none;"></iframe></p>


    <form  method='post' action='/main/result'>
        <button class='b2' name="check" value="pay" style='display:none;'>결제</button>
        <button class='b2' name="check" value="" style='display:none;'>취소</button>
    </form>

</center>
            
<script>
function menuLink(e) {
	document.getElementsByTagName('iframe')[0].style = 'display:none;';
	document.getElementsByTagName('iframe')[1].style = 'display:;';
	document.getElementsByTagName('iframe')[2].style = 'display:;';
	document.getElementsByTagName('button')[0].style = 'display:;';
	document.getElementsByTagName('button')[1].style = 'display:;';
}
    
</script>

</body>
</html>