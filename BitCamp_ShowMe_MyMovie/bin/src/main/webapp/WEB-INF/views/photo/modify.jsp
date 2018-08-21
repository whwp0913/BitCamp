<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
#fakeContent {
	height: 600px;
	overflow:scroll;
}
</style>

<div class="col-sm-12 col-md-12 main" style="margin-top: 50px;">
	<div class="row">
	  <div class="text-center">
	    <h3>이미지 게시판</h3>
	  </div>
	</div>

	<form id="modiForm" method="post">
		<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
		<div class="form-group row">
			<div class="col-sm-8 col-sm-offset-2">
				<label for="title">Title</label>
				<div class="row">
					<div class="col-sm-12">
						<input type="text" class="form-control" name="title" value="${PhotoVO.title}" />
					</div>
				</div>
			</div>
		</div>
	
		<div class="form-group row">
		    <div class="col-sm-8 col-sm-offset-2">
		      <label for="content">Content</label>
		      <div class="form-control" id="fakeContent" contenteditable="true">
			  	<div class="col-sm-12">
			   	${PhotoVO.content}
			   	</div>
			  </div>
			  
			  <textarea id="content" name="content" class="form-control"
				rows="15" required="required" style="display: none;"></textarea>
				
		    </div>
	    </div>
	
	     <div class="form-group row">
	       <div class="col-sm-2 col-sm-offset-8">
	         <p class="text-right label label-warning pull-right">${PhotoVO.mid}</p>
	       </div>
	     </div>
	</form>
	
    <div class="row">
    	<div id="photoList" class="col-sm-8 col-sm-offset-2">
    	<c:forEach items="${images}" var="image">
    		<div class="col-sm-3">
    		<img class="img-thumbnail picture" data-add="${image }"  src="/displayImage?fileName=${image }"><button class="btn btn-xs imgBtn">X</button>
    		</div>
    	</c:forEach>
    	</div>
    </div>
    
	<div class="row">
	    <div class="col-sm-8 col-sm-offset-2">
	      <div class="row">
	        <div class="col-sm-12 text-center">
		        <button id="modify" type="button" class="btn btn-xs btn-default">Modify</button>
		        <button id="cancle" type="button" class="btn btn-xs btn-default">Cancle</button>
	        </div>
	      </div>
	    </div>
	</div>
</div>  
<form id="inform" method="post">
	<input type="hidden" name="page" value="${cri.page}">
	<input type="hidden" name="pno" value="${PhotoVO.pno}">
</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
$(document).ready(function() {
	
	$("#cancle").on("click", function(e){
		self.location = "/photo/read?page=${param.page}&perPageNum=${param.perPageNum}&pno=${param.pno}";
	});
	
	// 이미지 리스트 x -> 글 이미지 삭제 
	$("#photoList").on("click","div .imgBtn",function(e){
		var add = $(e.target)[0].parentElement.children[0].outerHTML;
		var str = $(add).attr('src');
		var imageName = str.split("=");
		var delImg = "<input type='hidden' value='"+imageName[1]+"' name='imgList'/>";
		
		 $("img[src='"+str+"']").parent().remove();		
		 $("#modiForm").append(delImg);
	});
	/* 텍스트영역에서 백스페이스로 그림 삭제할 시에 ..... */
	
	/* 파일업로드 */
	$("#fakeContent").on("dragenter dragover",function(event) {
		event.preventDefault();
	});
	$("#fakeContent").on("drop",function(event) {
		event.preventDefault();
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
		var path = 'img';	
		var formData = new FormData();
		formData.append("file", file);
		
		$.ajax({
			url : '/'+path+'/upload',
			beforeSend : function(xhr) {
				xhr.setRequestHeader('x-CSRFToken','${_csrf.token}');
			},
			data : formData,
			dataType : 'text',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
			var str = "";
			var foo = "";
			var bar = "";
			console.log('success');
			if (checkImageType(data)) {
				str = "<div style='text-align:center;'>"+ "<img src ='/displayImage?fileName="+data+"'/></div>";
				
				foo = "<div class='col-sm-3'>"
				+"<img class='img-thumbnail picture' data-add='"+data+"' src='/displayImage?fileName="+data+"'><button class='btn btn-xs imgBtn'>X</button>"
	    		+"</div>";
	    		
	    		bar = "<input type='hidden' name='images' value='"+data+"'/>";
			}
	    		console.log(foo);
				$("#fakeContent").append(str);
				$("#photoList").append(foo);
				$("#modiForm").append(bar);
			}
		});
	});
	
	/* 파일타입 체크 */
	function checkImageType(fileName) {
		var pattern = /jpg$|gif$|png$|jpeg$/i;
		return fileName.match(pattern);
	}
	
	$("#modify").on("click", function(e) {
	var str = $("#fakeContent")[0].innerHTML;
	$("#content").text(str);
	$("#modiForm").submit();	
	});
});
</script>   
<%@ include file="/WEB-INF/views/include/footer.jsp"%>