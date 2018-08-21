<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="container-fluid col-sm-12 col-md-12 main" style="margin-top:10px;">

	<div class="row">
		<div class="col-sm-offset-2 col-sm-4">
			<h3>영화 게시판</h3>
		</div>
	</div>

 <form method="post" id="modiForm">
  <input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
  <div class="form-group row">
    <div class="col-sm-8 col-sm-offset-2">
      <label for="title">Title</label>
      <div class="row">
        <div class="col-sm-10">
          <input type="text" class="form-control" id="title" name="title" required="required" value="${BoardVO.title}"/>
        </div>
        <div class="col-sm-1">
          <h4 class="text-center"><span class="label label-primary">${BoardVO.kno eq '10' ? '질문': BoardVO.kno eq '20' ? '후기' : '일반'}</span></h4>
        </div>
        <div class="col-sm-1">
          <h4><span class="label label-primary">${BoardVO.gno eq '100' ? 'Comedy' : BoardVO.gno eq '200' ? 'Action' : 'Drama' }</span></h4>
        </div>
      </div>
    </div>
  </div>

  <div class="form-group row">
    <div class="col-sm-8 col-sm-offset-2">
      <label for="content">Content</label>
      <textarea class="form-control" name="content" rows="10" required="required">${BoardVO.content}</textarea>
    </div>
  </div>

  <div class="form-group row">
    <div class="col-sm-2 col-sm-offset-8">
      <p class="text-right label label-warning pull-right">${BoardVO.mid}</p>
    </div>
  </div>
  
	<div class="form-group row">
		<div class="col-sm-8 col-sm-offset-2">
			<label for="uploadFile">uploadFile</label>
			<div class="row uploadList" style="min-height: 100px; background-color: #f5f5f5;">
			<div class="col-sm-12 text-center">
			<p style="margin-top: 38px;">File Drop Here</p>
			</div>
			</div>
		</div>
	</div>
	
	<div class="form-group row">
		<div class="col-sm-8 col-sm-offset-2">
			<label for="fileList">FileList</label>
			<div class="row fileList">
				<c:forEach items="${BoardVO.files }" var="list">
					<c:choose> 
						<c:when test="${list.contains('jpg') || list.contains('png') || list.contains('gif') }">                     
							<a href="/displayFile?fileName=${list}"><span class="col-sm-2" data-add="${list}"><button class="btn btn-xs">X</button><img src="/displayFile?fileName=${list}" class="img-thumbnail"></span></a>         
						</c:when>
						<c:otherwise>         
							<a href="/displayFile?fileName=${list}"><span class="col-sm-2" data-add="${list}"><button class="btn btn-xs">X</button>${list}</span></a>
						</c:otherwise>                        
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>

</form>

	<div class="row">
	  <div class="col-sm-8 col-sm-offset-2">
	    <div class="row">
	      <div class="col-sm-12 text-center">
	        <button id="modify" type="button" class="btn btn-xs btn-default">Modify</button>
	        <button id="delete" type="button" class="btn btn-xs btn-default">Cancle</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
$(document).ready(function(){
	 var prinMid = '${prin}';
	 var mid = '${BoardVO.mid}';
	 if(prinMid != mid){
	 	alert("글 작성자만 수정 가능합니다");
	 	window.history.go(-2);
	 }
	
	 var formObj = $("#modiForm");
	 $("#modify").on("click", function(e){
	   formObj.submit();
	 });
	 $("#delete").on("click", function(e){
	   self.location = "/board/read?page=${param.page}&perPageNum=${param.perPageNum}&bno=${BoardVO.bno}";
	 });
	 
	 var fileBtn = $(".fileList");
	 console.log(fileBtn)
	 fileBtn.on("click","a span button",function(e){
	 e.preventDefault();
	 console.log(e);
	 console.log($(e.target).parent().parent().remove());
	 var add = $(e.target).parent().data('add');
	 var str = "<input type='hidden' name='deleteFiles' value='"+add+"' />";
	 $("#modiForm").append(str);
	 });
	 
	//파일 업로드
	$(".uploadList").on("dragenter dragover",function(event) {
		event.preventDefault();
	});
	$(".uploadList").on("drop",function(event) {
		event.preventDefault();
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
		var path = 'board';
		console.log(file);
	
		var formData = new FormData();
		formData.append("file", file);
		console.log(files);
	
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
	
			if (checkImageType(data)) {								
					str = "<a href='/dispalyFile?fileName="+data+"'><span class='col-sm-2' data-add='"+data+"'><button class='btn btn-xs'>X</button><img src='/displayFile?fileName="+data+"' class='img-thumbnail'></span><input type='hidden' name='files' value='"+data+"'/></a>";
				} else {
					str = "<a href='/dispalyFile?fileName="+data+"'><span class='col-sm-2' data-add='"+data+"'><button class='btn btn-xs'>X</button>"+data+"</span><input type='hidden' name='files' value='"+data+"'/></a>";
				}
				$(".fileList").append(str);
			}
		});
	});
	
	function checkImageType(fileName) {
		var pattern = /jpg$|gif$|png$|jpeg$/i;
		return fileName.match(pattern);
	}
 });
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
    