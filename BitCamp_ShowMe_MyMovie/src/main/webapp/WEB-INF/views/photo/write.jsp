<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.form-control-s {
	display: block;
	width: 150px;
	height: 34px;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	color: #555;
	background-color: #fff;
	background-image: none;
	border: 1px solid #ccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow
		ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out
		.15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
#fakeContent {
	border: 1px solid;
	height: 600px;
	overflow:scroll;
}
</style>

<div class="col-sm-12 col-md-12 main" style="margin-top: 50px;">
	<div class="row">
		<div class="col-sm-8 col-sm-offset-2">
			<form  id="post-form" name="post-form" method="post">
			
				<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
							
				<div class="form-group">
					<label for="title">Title</label> <input id="title" name="title"
						type="text" class="form-control" placeholder="Text input" required="required">
				</div>
			
				<label for="content">Content</label>
				<div class="form-control" id="fakeContent" contenteditable="true"></div>
				
				<p>
					<textarea id="content" name="content" class="form-control"
						rows="15" required="required" style="display: none;"></textarea>
				</p>
				
				<label>Writer</label>
				<p>
					<input id="mid" name="mid" type="text" class="form-control-s"
						placeholder="Text input" required="required" value="${prin}" readonly>
				</p>
				
				<div class="row">
					<div class="col-md-9 col-sm-9 col-md-offset-1 col-sm-offset-1">
						<div class="row">
						<div class="col-md-offset-5 col-sm-offset-5">
						<button id="addBtn" class="btn btn-info btnc">등록</button>
						<button id="back" type="button" class="btn btn-danger ">취소</button>
						</div>
						</div>
					</div>
				</div>
				
			</form>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script>
$(document).ready(function() {
	
	$("#back").on("click", function(e) {
		self.location = "/photo/list";
	});
	
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
			console.log('success');
			if (checkImageType(data)) {
				str = "<div style='text-align:center;'>"+ "<img class='readimg' src ='/displayImage?fileName="+data+"'/></div>"
				}
				foo = "<input type='hidden' name='images' value='"+data+"'/>";
				$("#post-form").append(foo);
				$("#fakeContent").append(str);
			}
		});
	});
	
	
	/* 파일타입 체크 */
	function checkImageType(fileName) {
		var pattern = /jpg$|gif$|png$|jpeg$/i;
		return fileName.match(pattern);
	}
	/* 파일타입 체크 */
	$("#addBtn").on("click", function(e){
		if($("input[name=images]").length == 0) {
			e.preventDefault();
			alert("이미지 파일을 올려주세요 ... ")
			return;
		}
		var str = $("#fakeContent")[0].innerHTML;
		$("#content").text(str);
		$("#post-form").submit();	
	});
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

