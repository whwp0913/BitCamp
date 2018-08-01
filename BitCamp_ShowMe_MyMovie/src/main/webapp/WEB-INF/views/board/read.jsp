<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
#wall {
	width:100%;
	height:100%;
	border:1px solid #E0F8F7;
	background-color: #F2F2F2;
	position: absolute;
	display: none;
	z-index: 100000;
	justify-content: center;
	align-items: center;
	opacity:1;
	top: 0px;
	left: 0px;
}
.picture {
	z-index:1;
	opacity: 1;
}
</style>


<div class="container-fluid col-sm-12 col-md-12 main" style="margin-top:50px;">
	<div class="row">
		<div class="col-sm-offset-2 col-sm-4">
			<h3>영화 게시판</h3>
		</div>
	</div>


<form>
	<div class="form-group row">
		<div class="col-sm-8 col-sm-offset-2">
			<label for="title">Title</label>
				<input type="text" class="form-control" id="title" value="${BoardVO.title}" readonly />
		</div>
	</div>

	<div class="form-group row">
	    <div class="col-sm-8 col-sm-offset-2">
	      <label for="content">Content</label>
	      <textarea class="form-control" rows="10" readonly>${BoardVO.content}</textarea>
	    </div>
    </div>

     <div class="form-group row">
       <div class="col-sm-2 col-sm-offset-8">
         <p class="text-right pull-right"><c:out value="작성자 : ${BoardVO.mid}"/></p>
       </div>
     </div>

     <div class="form-group row">
       <div class="col-sm-8 col-sm-offset-2 upload">
         <label for="fileList">FileList</label>
         <div class="row">
           <c:forEach items="${BoardVO.files}" var="list">
           <c:choose> 
           <c:when test="${list.contains('jpg') || list.contains('png') || list.contains('gif') }">                                 
           <span class="col-sm-2"><img src="/displayFile?fileName=${list}" class="img-thumbnail picture"></span>
           </c:when>
           <c:otherwise>         
           <a href="/displayFile?fileName=${list}"><span class="col-sm-2">${list}</span></a>
           </c:otherwise>                        
           </c:choose>
           </c:forEach>
         </div>
       </div>
     </div>
</form>

	<div id="wall">
		<div class="picture" align="center">
		</div>
	</div>
	
	<div class="row">
		<div id="replyControl" class="col-sm-8 col-sm-offset-2" style="border-top: 1px dashed black;padding:10px;">
			<a><strong>${countList} Comments</strong></a> 
		</div>
	</div>
	
	
	<div id="replyBox" style="display:none;">
		<div class="row">
		  <div class="col-sm-8 col-sm-offset-2 replyBox" 
		  style="background-color: #E0E0E0;padding:0px 0px 0px 0px;
		  		margin-bottom:20px;">
		  
		  </div>
		    
		  <div class="row">
	        <div class="col-sm-8 col-sm-offset-2">   
	          <div class="row">
	            <label>NAME <input type="text" class="replyWriter" value="${prin}" readonly/></label>	            	        
	            <label>PASSWORD <input type="text" class="replyPass" value="" readonly/></label>	            	            
	            <label>HOMEPAGE <input style="width: 410px;"type="text" class="replyHome" value="" readonly/></label>
	          </div>
	          
	          <div class="row">
	          <label><input type="checkbox">secret</label>
	          </div>
	          
	          <div class="row">
		        <textarea class="form-control replyContent" rows="10" required="required"></textarea>
		      </div>
		      
		      <div class="row">  
		        <button type="submit" class="col-sm-1 col-sm-offset-11 
		        btn btn-default btn-xs active" id="replyBtn">CONFIRM</button>
		      </div>
	          	          	          
            </div>
		  </div>  
		</div>
						 
		 <div class="row">
		  <div class="col-sm-8 col-sm-offset-2">
		    <div class="col-sm-12 text-center">
		     <ul class="pagination">
		     </ul>
		    </div>
		  </div>
		</div>	
	</div>
	
</div>
    
	<div class="row" style="margin-bottom:50px;">
	    <div class="col-sm-8 col-sm-offset-2">
	      <div class="row">
	        <div class="col-sm-12 text-center">
	        <button id="back" type="button" class="btn btn-xs btn-default">To List</button>
	        <c:if test="${prin == BoardVO.mid}">
		        <button id="modify" type="button" class="btn btn-xs btn-default">Modify</button>
		        <button id="remove" type="button" class="btn btn-xs btn-default">Delete</button>
	        </c:if>
	        </div>
	      </div>
	    </div>
	</div>
	
<form id="inform" method="post">
  <input type="hidden" name="page" value="${cri.page}">
  <input type="hidden" name="bno" value="${BoardVO.bno}">
  <input type="hidden" name="type" value="${cri.type}">
  <input type="hidden" name="keyword" value="${cri.keyword}">
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
$(document).ready(function() {
	var formObj = $("#inform");
	var wall= $("#wall");
	var picture=$(".picture");
	var download=$(".download");  
	var mid = '${BoardVO.mid}';
	var user = '${prin}';  
	var pattern = /[$<>-]/;
 // 패턴에 마이너스(-) 추가하면 점(.)까지 사용금지되는 문제 있음
   
$(".upload").on("click","div span img",function(e) {
	console.log("span clicked");
	var address = $(e.target)[0].src;
	var target1 = address.substring(0, address.indexOf('s_'));
	var target2 = address.substring(address.indexOf('s_')+2);
	var originalName = target1 + target2;
	var add = "<img src='"+originalName+"'/>";
	picture.html(add);
	wall.show("slow");
});

	wall.on("click", function(e) {
		wall.hide("slow");
	});
	download.on("click", function(e) {
		console.log(e.target);
		e.preventDefault();
		var fileName = $(e.target).text();
		var result = confirm("download?");
		if(result){
			location.replace('/displayFile?fileName='+fileName);
		};
	});
	
 	$("#back").on("click", function(e) {
  	 self.location = "/board/list?page=${cri.page}&perPageNum=${cri.perPageNum}";
	});
 	$("#modify").on("click", function(e) {
 		if(user != "" && user != mid){
			 alert("글 작성자만 수정 가능합니다");
 			 e.preventDefault();
 			 return false;
 		}
   	self.location = "/board/modify?page=${cri.page}&perPageNum=${cri.perPageNum}&bno=${BoardVO.bno}";
 	});
	 	
 	$("#remove").on("click", function(e) {  		
 		 if(user != "" && user != mid){
 			 alert("글 작성자만 삭제 가능합니다");
 			 e.preventDefault();
 			 return false;
 		 }
 		 if(user === ""){
 			 alert("로그인이 필요한 기능입니다")
 			 location.href = "/login";
 			 return false
 		 }
 		 if(confirm("정말 삭제하시겠습니까?")){
 	    	formObj.attr("action", "/board/delete");
 	    	formObj.submit();
 		 }  		
 	});
	 
	 /* 댓글 페이지 로딩 */
	 function pageList(page) {
	   if(typeof page == "undefined"){
	     var page = 1;
	   }    
	   $.getJSON("/replies/${param.bno}/"+page, function(data){
	    var str = "";
	    
	    $(data.list).each(function(){
	    var content = this.content;
	    var calendar = new Date(this.regdate);
	    var cal = calendar.getFullYear() +"/"+ (calendar.getMonth()+1) +"/" + calendar.getDate() + "/" + calendar.getHours() + ":" + calendar.getMinutes();
	    
	 	str += "<div style='margin: 10px 0px 10px 0px;' class='row' data-rno='"+this.rno+"' data-content='"+this.content+"' data-mid='"+this.mid+"' data-event='regist'>"
			      +"<div class='col-sm-10' style='font-size:15px;'><strong>"+this.mid+"</strong>"
			      +"<button class='btn-xs btn-link active' id='reModiBtn'>수정</button>"
			      +"<button class='btn-xs btn-link active' id='redeleteBtn'>삭제</button></div>"			   
				  +"<div class='col-sm-2 text-right'>"+cal+"</div>"				  	  
	       		  +"<div class='col-sm-12'>"+this.content+"</div>"
	   	   +"</div>";
	     });
	    if($(data.list).length ==0){
	    
	   	 str += "<div class='row' style='font-size:15px; text-align:center'>등록된 댓글이 없습니다.</div>";
	    }
	     $(".replyBox").html(str);
	     replyPaging(data.pm);
	   });
	 };
	 pageList();
	 
	 /* 댓글 추가 */
	 $("#replyBtn").on("click", function(e){    
	   if( $("#replyBtn").attr('event') !== 'modify') {      
	    var content = $(".replyContent").val();
	    var writer = $(".replyWriter").val();
	    var bno = '${param.bno}';
	    
	    
	    if(content === ""){
	    	alert("내용을 입력해주세요");
	    	return false;
	    }
	    
	    if(pattern.test(content) == true){
	    	alert("사용할 수 없는 문자열이 있습니다.");
	    	return false;
	    }
	
	    $.ajax({
	      type: "post",
	      url : "/replies/new",
	      beforeSend : function(xhr) {
				xhr.setRequestHeader('x-CSRFToken','${_csrf.token}');
		  },
	      dataType : "text",
	      headers : {
	        "content-type" : "application/json",
	        "x-http-method-override" : "post"
	      },
	      data : JSON.stringify({
	        content : content,
	        mid : writer,
	        bno : bno
	      }),
	      success : function(result) {
	        alert(result);
	        $(".replyContent").val("");
	        pageList();	        
	      } 
	    });
	   } else {
		var content = $(".replyContent")[0].value;
		var rno = $("#replyBtn").attr('rno');
		var mid = $("#replyBtn").attr('mid');      
	    if(pattern.test(content) == true){
	    	alert("사용할 수 없는 문자열이 있습니다.");
	    	return false;
	    }
	     	$.ajax({
	        type: "PUT",
	        url : "/replies/${param.bno}/1",
	        beforeSend : function(xhr) {
				xhr.setRequestHeader('x-CSRFToken','${_csrf.token}');
			},
	        dataType : "text",
	        headers : {
	          "content-type" : "application/json",
	          "x-http-method-override" : "PUT"
	        },
	        data : JSON.stringify({
	          content : content,
	          rno : rno,
	          mid : mid
	        }),
	        success : function(result) {
	            alert(result);  
	            $("#replyBtn")[0].innerText = "Apply";
	            $("#replyBtn").attr('event', 'regist');
	            $(".replyContent").val("");
	            pageList();
	        } 
	     	});
	   }
	 });
	
	 /* 댓글 수정 */
	$(".replyBox").on("click","div #reModiBtn",function(e){    
	var target = e.target;
	var replyMid = target.parentElement.childNodes[0].innerText;
	
	if(replyMid === user) {	  
	   	var applyBtn = $("#replyBtn");
	   	applyBtn[0].innerText = "Modify";
	   	
	    var replyText = $(e.target).closest('div').parents('div');
	    
	    console.log(replyText);
	    console.log(replyText[0]);
	    var rno = replyText.data('rno');
	    var mid = replyText.data('mid');
	    var content = replyText.data('content');
	   
	    $(".replyContent")[0].value = content;
	    $(".replyWriter")[0].value = mid;
	    
	    applyBtn.attr("rno", rno);
	    applyBtn.attr("content", content);
	    applyBtn.attr("mid", mid);
	    applyBtn.attr("event", "modify");
		}else{
			alert("댓글 작성자만 수정 가능합니다")
			return;
		}
	 });
	       
	 /* 댓글 삭제 시작*/
	$(".replyBox").on("click","div #redeleteBtn",function(e){  
	var target = e.target;
	var replyMid = target.parentElement.childNodes[0].innerText;
	
	var random = $(target).closest('div').parents('div');
	console.log(random);
	   var bno = "${param.bno}";
	   var rno = random.data('rno');
	   
	   if(replyMid === user && confirm("삭제하시겠습니까?")){
	    $.ajax({
	    type : 'delete',
	    url : "/replies/"+bno+"/"+rno,
	    beforeSend : function(xhr) {
			xhr.setRequestHeader('x-CSRFToken','${_csrf.token}');
		},
	    headers : {
	      "Content-Type" : "application/json",
	      "X-HTTP-Method-Override" : "DELETE"
	    },  
	    dataType : 'text',
	    success : function(result){
	      console.log("result: " + result)
	      if(result == 'SUCCESS'){
	        alert("댓글이 삭제되었습니다");
	        pageList();
	      }
	      }
	    });
	   }
	   if(replyMid != user){
		console.log("사용자 불일치!");
	   	alert("댓글 작성자만 삭제 가능합니다.");
	   	return;
	   };
	 });
	 
	 /* 댓글 하단 페이징 */
	 function replyPaging(pm){    
	   var ddd = "";    
	   if(pm.prev){      
	     ddd += "<li><a href = '"+(pm.startPage -1)+"'> << </a></li>";
	   }    
	   for(var i = pm.startPage, len = pm.endPage; i< len+1; i++){
	   	if(pm.cri.page == i){
	   		ddd += "<li class='active'><a class='btn btn-xs btn-secondary' href='"+i+"'>"+i+"</a></li>";
	   	}else{
	   		ddd += "<li><a class='btn-xs btn btn-secondary' href='"+i+"'>"+i+"</a></li>";
	   	}
	   }
	   if(pm.next){      
	     ddd += "<li><a href = '"+(pm.endpage +1)+"'> >> </a></li>";
	   }
	   $('.pagination').html(ddd);
	 };
	   
	   /* reply number paging */
	   $(".pagination").on("click","li a",function(e){
	     e.preventDefault();
	     var page = $(e.target).text(); // page number
	     pageList(page);
	   });  
	
	 /* 파일 리스트 로딩 */
	 (function fileList() {
	var fileList = $(".upload").children()[1].childElementCount;
	var str;

	if(fileList == 0){
	  	   str = "<div style='font-size:15px; text-align:center'>첨부된 파일이 없습니다.</div>";
	  	   $(".upload").append(str);
	   }
	 })();
	 
	 /* file download */
	 $(".download").on("click",function(e){
	  if(confirm("download??")){
		  location.replace("/displayFile?fileName=${BoardVO.files}");
	  } 
	 });
	 
	 $("#replyControl").on("click",function(e){
	 var box = $("#replyBox");
	 if( box.attr('style') == 'display:none;') {
		 box.attr('style',' ');
	 }else if ( box.attr('style') == ' ') {
		 box.attr('style', 'display:none;');
	 }
	 });
  
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>