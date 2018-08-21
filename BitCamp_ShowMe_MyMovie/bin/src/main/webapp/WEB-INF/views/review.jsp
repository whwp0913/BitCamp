<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
img {
width : 130px;
height: 200px;
margin-right:20px;

}
.popover-content {
	width: 780px;
}
.popover {
	max-width: 1000px;
}
.recom-title{
	text-align: center;
	font-size: 20px;
	margin-bottom: 6px;
}

.target {
	color: red;	
}
</style>
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="/resources/star.css" />

<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="searchModal" role="dialog">
    <div class="modal-dialog">   

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        
        <div class="modal-body">
 		  <div class="row">
  			
  			<div id="showMovie" class="col-sm-offset-1 col-sm-10">
			</div>
	  			
			<div class="row" style="margin-bottom:50px;">
      		  <div class="col-sm-offset-1 col-sm-10">
			    <span class="star-input">
		  		  <span class="input">
		    	    <input type="radio" name="star-input" value="1" id="p1">
				    <label for="p1">0.5</label>
				    <input type="radio" name="star-input" value="2" id="p2">
		    		<label for="p2">1.0</label>
				    <input type="radio" name="star-input" value="3" id="p3">
				    <label for="p3">1.5</label>
				    <input type="radio" name="star-input" value="4" id="p4">
				    <label for="p4">2.0</label>
				    <input type="radio" name="star-input" value="5" id="p5">
				    <label for="p5">2.5</label>
				    <input type="radio" name="star-input" value="6" id="p6">
				    <label for="p6">3.0</label>
				    <input type="radio" name="star-input" value="7" id="p7">
				    <label for="p7">3.5</label>
				    <input type="radio" name="star-input" value="8" id="p8">
				    <label for="p8">4.0</label>
				    <input type="radio" name="star-input" value="9" id="p9">
				    <label for="p9">4.5</label>
				    <input type="radio" name="star-input" value="10" id="p10">
				    <label for="p10">5.0</label>
		  		  </span>
		  		  <output for="star-input"><b id="rating">0</b>점</output>						
			    </span>
   	  		  </div>
    	    </div>
    
    		<div class="row">
      		  <div class="col-sm-offset-1 col-sm-10">
      	        <label>Comment</label>
    			<div style="border: 1px solid grey; width: 100%; height: 100px;"
    			  contenteditable="true" id="comment">
    			</div>
    			<div class="text-right">
    	  		  <button class="text-right" id="reviewBtn">등록</button>
    			</div>
   	  		  </div>
    		</div>
	  		
	      </div>
	    </div>    
	  </div>
	  
	</div>
  </div>
</div>
<!-- Modal end -->
<div class="main" >
  <div class="col-sm-12 col-md-12" style="margin:50px 0px 50px 0px;">      
    
    <!-- 위에는 영화 평점+리뷰 리스트가 나와야함 -->
    <div class="row">
      <div class="col-sm-offset-1 col-sm-10 text-right">
        <label>영화검색기</label>
	    <input class="form-inline" id="searchMovie" type="text">
	    <button id="searchBtn" class="btn btn-sm btn-default" style="vertical-align:bottom;">검색</button>    
   	  </div>
    </div>
    
    
    <div class="row reviewList">
      <div class="col-sm-offset-1 col-sm-10 text-center">
    	<table class="table">
	    	<tr>
	    	  <td>번호 </td>
	    	  <td>사진 </td>
	    	  <td>평점 </td>
	    	  <td>후기 </td>
	    	  <td>글쓴이/등록일</td>
	    	</tr>
	    	<c:forEach var="list" items="${list}">
	    	<tr>
	    	  
	    	  <td>${list.vno }</td>    	
	    	  <td><input type="hidden" value="${list.code }"/><img src="${list.link }"></td>
	    	  <td>${list.rating }
	    		<span class="star-input">	    		
	    			<span class="input focus">
	    				<label style="display: inline-block;
	    							vertical-align: middle;
	    							background: url(resources/img/grade_img.png)no-repeat;
	    							background-size: 150px;
	    							background-position: 0 bottom;" for="${list.rating}"></label>
	    			</span>    		
	    		</span>
	    	</td>	    		    	
	    	<th><p style="color: red;">${list.title}</p><p><c:out value="${list.comment}"/></p></th>
	    	<th><p style="color: blue;">${list.mid}</p> 
	    	    <p><fmt:formatDate value='${list.regdate }' pattern="yyyy.MM.dd"/>
		    	    <c:if test="${list.mid eq pageContext.request.userPrincipal.name}">
		    	    <form id="${list.vno}">
				    	    <input type="hidden" name="${list.vno}"> 
				    	    <button id="removeBtn">삭제</button>
		    	    </form>
		    	    </c:if>
		    	 </p>
	    	</th>
	    	</tr>
    	</c:forEach>
    	</table>
   	  </div>
    </div>

		<form class="form-inline text-center" method="get">
			    <select name="type" id="type" class="form-control">
				    <option value="">-----</option>
				    <option value="w" ${pm.cri.type eq 'w'? "selected": '' }>작성자</option>
				    <option value="t" ${pm.cri.type eq 't'? "selected": '' }>관련 영화</option>
			    </select>
				<input class="form-control" type="text" id="keyword" name="keyword" value="${pm.cri.keyword}"/>
	  
			    <button id="serarchBtn" class="btn btn-info">검색</button>
	
		</form>
    
    
    <div class="row">
		<div class="col-sm-12">
			<div class="col-sm-12 text-center">
				<div id="pagination">
					<ul class="pagination">
						<c:set var="totalPage" value="${pm.total/10 }"/>
						<fmt:parseNumber var="pages" value="${totalPage + (1-(totalPage%1))%1}" integerOnly="true"></fmt:parseNumber>
						<li><span style="background-color: white;" >Page ${pm.cri.page} of ${pages}</span></li>
	
						<c:if test="${pm.prev}">
							<c:choose>
							<c:when test="${pm.cri.type eq '' && pm.cri.keyword eq '' }">
							<li><a class="btn btn-info"
								href="review?page=${pm.startPage -1}">prev</a></li>
							</c:when>
							<c:otherwise>
							<li><a class="btn btn-info"
								href="review?page=${pm.startPage -1}&type=${pm.cri.type}&keyword=${pm.cri.keyword}">prev</a></li>
							</c:otherwise>
						</c:choose>
						</c:if>
	
					<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="idx">
						<c:choose>
						<c:when test="${pm.cri.type eq '' && pm.cri.keyword eq '' }">
						<li ${pm.cri.page == idx ? 'class=active':''}><a id="pageLink" class="btn btn-secondary"
							href="/review?page=${idx}">${idx}</a></li>
						</c:when>
						<c:otherwise>
						<li ${pm.cri.page == idx ? 'class=active':''}><a id="pageLink" class="btn btn-secondary"
							href="/review?page=${idx}&type=${pm.cri.type}&keyword=${pm.cri.keyword}">${idx}</a></li>
						</c:otherwise>
						</c:choose>
					</c:forEach>
	
					<c:if test="${pm.next}">
						<c:choose>
						<c:when test="${pm.cri.type eq '' && pm.cri.keyword eq '' }">
						<li><a class="btn btn-info"
							href="review?page=${pm.endPage + 1}">next</a></li>
						</c:when>
						<c:otherwise>
						<li><a class="btn btn-info"
							href="review?page=${pm.endPage + 1}&type=${pm.cri.type}&keyword=${pm.cri.keyword}">next</a></li>
						</c:otherwise>
						</c:choose>
					</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
  	  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	  crossorigin="anonymous"></script>
<script src="/resources/bootstrap-3.3.2/js/tooltip.js"></script>
<script src="/resources/bootstrap-3.3.2/js/popover.js"></script>
<script>
$(document).ready(function(){
	var prinName = '${pageContext.request.userPrincipal.name}';
	var naverName = sessionStorage.getItem("naverName");
	
    $('img').popover({
    	  html: true,
    	  trigger: 'click',
    	  placement: 'right',
    	  content: function() {    	
 		  	var code = $(this).closest("td").find("input").val();
 		  	var $img = $(this);
 		  	console.log("code:",code);
 		  	
 		  	$.ajax({
 		  		url: "recommend/"+code,
 		  		type: "get",
 		  		async: false,
 		  		dataType: "json",
 		  		success: function(result) {
 		  			console.log("result :",result);
 		  			$(result).each(function(index){
 	 		  			$img.attr('title'+index,this.title);
 	 		  			$img.attr('link'+index,this.link);
 	 		  		}); 		  			 		  			 			  	
 		  		}
 		  	}); 		  	 		
	 		/* $.getJSON("/recommend/"+code, function(data){
	 			$(data).each(function(index){
 		  			$img.attr('title'+index,this.title);
 		  			$img.attr('link'+index,this.imgLink);
 		  		});
 		  	}); */		 	
 		  	var foo =
 		  		"<div class='recom-title text-info'>다른 <span class='target'>사용자</span>가 함께 본 영화</div>"
 		  		+"<img src='"+$img.attr('link0')+"' />" 		  		
		  		+"<img src='"+$img.attr('link1')+"' />"
		  		+"<img src='"+$img.attr('link2')+"' />"
		  		+"<img src='"+$img.attr('link3')+"' />"
		  		+"<img src='"+$img.attr('link4')+"' />" 				  				  			 	 		  	
 		  	return foo;
    	  }
   	});
		
	/* naver movie api */
	$("#searchBtn").on("click",function(e){	
		var _searchMoive = $("#searchMovie");
		var _showMovie = $("#showMovie");
		var keyword = _searchMoive.val();
		
		if(keyword == "") {
			alert("검색어를 입력하세요...");
			_searchMoive.focus();
			
			return false;
		}
		_showMovie.html("");				
		$.getJSON("/reviews/"+keyword, function(data){
			console.log(data);
			$(data).each(function(e){
				
				var str = "";
				if(this.imgSrc == "") {
					this.imgSrc = "https://ssl.pstatic.net/static/movie/2012/06/dft_img203x290.png";
				}
				str =
					"<div class='col-sm-3'>"
					+"<div class='text-center' style='margin-bottom: 5px;'>"
					+"<input type='radio' name='movie_info' data-link='"+this.imgSrc+"'value='"+this.title+"'>"
					+"</div>"
					+"<div><img class='movieImg' src='"+this.imgSrc+"'/></div>"
					+"<div>제 목 : "+this.title+"</div>"
					+"<div>개봉일 : "+this.pubDate+"</div>"
					+"<div>감 독 : "+this.director+"</div>"
					+"<div>유저평점 : "+this.userRating+"</div>"
					+"<input type='hidden' name='code' value='"+this.uniqueCode+"'/>"
					+"</div>";
					
				_showMovie.append(str);
			});
		});	
		$("#searchModal").modal();
	});
	
	/* review submit */
	$("#reviewBtn").on("click",function(e){
		var _input = $("input[name=movie_info]:radio:checked").closest('div');
		var imgLink = _input.find('input').data('link');
		var title = _input.find('input').val();
		var rating = parseFloat($("#rating").text());
		var code = parseInt(_input.parent().find("input[name=code]").val());
		var _comment = $("#comment").text();
		var mid;
		if(naverName != ""){
			mid = naverName; 
		}
		if(prinName != ""){
			mid = prinName;
		}
		$.ajax({
		      type: "post",
		      url : "/review",
		      beforeSend : function(xhr) {
					xhr.setRequestHeader('x-CSRFToken','${_csrf.token}');
			  },
		      dataType : "text",
		      headers : {
		        "content-type" : "application/json",
		        "x-http-method-override" : "post"
		      },
		      data : JSON.stringify({
		        mid : mid,
		        title : title,
		        comment : _comment,
		        rating : rating,
		        link : imgLink,
		        code : code
		      }),
		      success : function(result) {		
				self.location = "/review";	    
		      }		      
		});
	});
	
	$(".reviewList").on("click","div #removeBtn",function(e){
		
		e.preventDefault();
		var target = e.target;
		var vno = target.parentElement[0].name;

		if(confirm("정말 삭제하시겠습니까?")){
			
		    $.ajax({
			    type : 'delete',
			    url : "/reviews/remove/"+vno,
			    beforeSend : function(xhr) {
					xhr.setRequestHeader('x-CSRFToken','${_csrf.token}');
				},
			    headers : {
			      "Content-Type" : "application/json",
			      "X-HTTP-Method-Override" : "DELETE"
			    },  
			    dataType : 'text',
			    success : function(result){
			    	self.location = "/review";
			      }
			 });		
		}	
	});
	
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>