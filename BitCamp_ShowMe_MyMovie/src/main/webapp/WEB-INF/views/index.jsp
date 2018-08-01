<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- CSS -->
<link href="/resources/carousel.css" rel="stylesheet">

<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- <script src="/resources/bootstrap-3.3.2/dist/js/bootstrap.min.js"></script> -->

<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
<script src="/resources/bootstrap-3.3.2/docs/assets/js/vendor/holder.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/resources/bootstrap-3.3.2/docs/assets/js/ie10-viewport-bug-workaround.js"></script>


<style>
.movimg {
	margin-bottom : 5px;
}
/* .wrap_desc{
	left:0;
	top:0;
	width:50%;
	height:290px;
	padding-top:24px;
	opacity:1;
	height: auto;
    overflow: hidden;
    text-overflow: ellipsis;
    -webkit-box-orient: vertical;
    display: -webkit-box;
    -webkit-line-clamp: 8;
    border: 1px solid black;
}
li {
list-style: none;
} */
</style>

<!-- Carousel -->
<div id="myCarousel" class="carousel slide" data-ride="carousel">
	<!-- Indicators -->
	<ol class="carousel-indicators" style="margin-bottom: 25px;">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
	</ol>
	<div class="carousel-inner" role="listbox" style="margin-bottom: 10px;">
		<div class="item active" >
			<img class="first-slide"
				src="https://www.suyongso.com/files/attach/images/115/733/477/014/9060e163a43cd0a58f88813dbf53d12a.png"

				alt="First slide">
			<div class="container">
				<div class="carousel-caption">
					<h1>What's your name?</h1>
					<p>
						<code>Sign up and let me know your name.</code>
					</p>
					<p>
						<a style="color: white" href="/signup">회원가입페이지 이동</a>
					</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img class="second-slide"
				src="https://2.bp.blogspot.com/-eSC4Gupz5ns/WNCnusetmrI/AAAAAAAAAQg/oG3xz6lXO7UZuzJYgqTE4_cX3-Bxl0biwCLcB/s1600/%25EB%2584%2588%25EC%259D%2598%2B%25EC%259D%25B4%25EB%25A6%2584%25EC%259D%2580%2B%25EB%25B0%25B0%25EA%25B2%25BD%25ED%2599%2594%25EB%25A9%25B4%2B%25EA%25B3%25A0%25ED%2599%2594%25EC%25A7%2588-2.jpg"
				alt="Second slide">
			<div class="container">
				<div class="carousel-caption">
					<h1>Reviews of movies</h1>
					<p><code>Please write a movie review.</code></p>
					<p>
						<a style="color: white;" href="/board/list" role="button">게시판 이동</a>
					</p>
				</div>
			</div>
		</div>
		<div class="item">
			<img class="third-slide"
				src="http://mblogthumb3.phinf.naver.net/MjAxNzExMjZfNjEg/MDAxNTExNzA4Mjk1NTYy.4SXS_LsnEU28hSmgwnyu0KAhwTNGPqWfa7f4kwVuEEog.47VS0GKZACI3hkDdzEhRmm8GgKBq7BvRBeqDanMgjfYg.JPEG.bongdoly123/743487.jpg?type=w2"
				alt="Third slide">
			<div class="container">
				<div class="carousel-caption">
					<h1>Great pictures</h1>
					<p><code>Go to the gallery and watch the pictures.</code></p>
					<p>
						<a style="color: white;" href="/photo/list" role="button">갤러리 이동</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<a class="left carousel-control" href="#myCarousel" role="button"
		data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
		aria-hidden="true"></span> <span class="sr-only">Previous</span>
	</a> <a class="right carousel-control" href="#myCarousel" role="button"
		data-slide="next"> <span class="glyphicon glyphicon-chevron-right"
		aria-hidden="true"></span> <span class="sr-only">Next</span>
	</a>
</div>


<div class="row imgbox">
	<div class="col-sm-12">	
		<div style="margin-bottom: 10px;"class="col-sm-12">
			<h1 style="color: black;">주간 인기영화 </h1>
		</div>
	</div>
					
	<div class="col-sm-12">	
		<c:forEach items="${week}" var="week" begin="0" end="5">
			<div class="col-sm-2">
				<div class="info" style="border:3px solid black;"><a href="https://${week.infoLink}"><img class="movimg" style="width: 100%;" src="https://${week.img}"></a>
					<div>${week.tit }</div>									
					<div>평점 : ${week.grade }</div>
					<div>${week.open }</div>					
				</div>				
			</div>		
		</c:forEach>
	</div>
	
	<%-- <div class="col-sm-12">
		<ul class="list_movie">	
		<c:forEach items="${week}" var="week" begin="0" end="5">
			<li class="col-sm-2">
	
				<div class="line text-center" style="height:275px;">
					<span>
						<a href="https://${week.infoLink}"><img class="movimg" style="width: 90%;" src="https://${week.img}"></a>
					</span>
					<div style="display:none;width:100%;height:100%"class="wrap_desc">${week.des}</div>
				</div>
				
				<div>
					<div>${week.tit }</div>
					<span>평점 : ${week.grade }</span>
					<span>${week.open }</span>
				</div>				
			</li>		
		</c:forEach>
		</ul>
	</div> --%>
		
	<div class="col-sm-12">
		<div style="margin-bottom: 10px;" class="col-sm-12">
			<h1 style="color: black;">월간 인기영화 </h1>
		</div>
	</div>	
	
	<%-- <div class="col-sm-12">
		<c:forEach items="${month}" var="month" begin="0" end="5">
				<div class="col-sm-2">
					<div class="info"><a href="https://${month.infoLink}"><img class="movimg" style="width: 90%;" src="https://${month.img}"></a></div>
					<div>${month.tit }</div>
					<div>평점 : ${month.grade }</div>
					<div>${month.open }</div>					
				</div>		
		</c:forEach>
	</div> --%>
	
	<div class="col-sm-12">	
		<c:forEach items="${month}" var="month" begin="0" end="5">
			<div class="col-sm-2">
				<div class="info" style="border:3px solid black;"><a href="https://${month.infoLink}"><img class="movimg" style="width: 100%;" src="https://${month.img}"></a>
					<div>${month.tit }</div>									
					<div>평점 : ${month.grade }</div>
					<div>${month.open }</div>					
				</div>				
			</div>		
		</c:forEach>
	</div>
	
	<div class="col-sm-12">
		<div style="margin-bottom: 10px;" class="col-sm-12">
			<h1 style="color: black;">연간 인기영화 </h1>
		</div>
	</div>
		
	<%-- <div class="col-sm-12">
		<c:forEach items="${year}" var="year" begin="0" end="5">
				<div class="col-sm-2">
					<div class="info"><a href="https://${year.infoLink}"><img class="movimg" style="width: 90%;" src="https://${year.img}"></a></div>
					<div>${year.tit }</div>
					<div>평점 : ${year.grade }</div>
					<div>${year.open }</div>
				</div>		
		</c:forEach>
	</div> --%>
	
	<div class="col-sm-12">	
		<c:forEach items="${year}" var="year" begin="0" end="5">
			<div class="col-sm-2">
				<div class="info" style="border:3px solid black;"><a href="https://${year.infoLink}"><img class="movimg" style="width: 100%;" src="https://${year.img}"></a>
					<div>${year.tit }</div>									
					<div>평점 : ${year.grade }</div>
					<div>${year.open }</div>					
				</div>				
			</div>		
		</c:forEach>
	</div>
</div>
<script>	
$(document).ready(function(){

	$('.info').on("click",function(e){
		
		e.preventDefault();
		var infosrc = $(e.target)[0].parentElement.href;
		
		window.open(infosrc,"영화정보",
		"width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
		
		console.log(infosrc);

	}); 
	
	/* $(".line").mouseenter(function(e){
		console.log('mouseenter is call! ', this);
		var $target = $(this);
		if ($target.find('img').is(':visible')) {
			$img = $target.find('img');
			//$img.fadeOut('fast');
			$img.hide();
			$target.find('.wrap_desc').fadeIn(100);
		}
	});
	
	$(".line").mouseleave(function(e){	
		console.log('mouseleave is call! ', this);
		var $target = $(this);
		$target.find('.wrap_desc').hide();
		console.log($target.find('img'));
		$target.find('img').show();
	}); */
	
});
</script>	
    <!-- Wrap the rest of the page in another container to center all the content. -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>