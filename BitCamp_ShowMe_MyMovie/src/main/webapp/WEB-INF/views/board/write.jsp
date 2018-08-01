<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.fileDrop {
	width: 100%;
	height: 100px;
	border: gray;
 	background-color: #FAF6F6;
/* 	background-image: URL("https://i.stack.imgur.com/aTW7T.png");
	background-repeat: no-repeat;
	background-size: 100%;
	background-attachment: fixed;
	background-position: 50% 50%; */
}
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
</style>

<div class="col-sm-12 col-md-12 main" style="margin-top: 50px;">

	<div class="row">

		<div class="col-sm-8 col-sm-offset-2">
			<form  id="post-form form1" name="post-form" method="post">
				<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />

				<div class="form-group">
					<div class="row">
						<div class="col-sm-3">
							<select class="form-control kno" name="kno">
								<option value="30">일반</option>
								<option value="20">후기</option>
								<option value="10">질문</option>
							</select>
						</div>
						<div class="col-sm-3">

							<select class="form-control col-sm-3" name="gno">
								<option value="100">Comedy</option>
								<option value="200">Action</option>
								<option value="300">Drama</option>

							</select>
						</div>
					</div>
				</div>


				<div class="form-group">
					<label for="title">Title</label> <input id="title" name="title"
						type="text" class="form-control title" placeholder="Text input" required="required">
				</div>
				<label for="content">Content</label>
				<p>
					<textarea id="content" name="content" class="form-control content"
						rows="15" required="required"></textarea>
				</p>
				<label>Writer</label>
				<p>
					<input id="mid" name="mid" type="text" class="form-control-s mid"
						placeholder="Text input" value="${id}" readonly>
				</p>
				<div>
					<div class="form-group">
						<label for="exampleInputFile">파일 업로드</label> <input type="file"
							id="exampleInputFile">
					</div>

					<div class="fileDrop" ><img src="https://cdn.formidableforms.com/wp-content/uploads/2016/06/drag-drop-uploader.png" width="100%" height="100%"></div>

					<div id="uploadList"></div>
				</div>


					<div class="row" style="margin-top: 10px;">
						<div class="col-md-12 col-sm-12">
							<div class="row">
							<div class="col-md-offset-5 col-sm-offset-5">
							<button class="btn btn-info btnc">등록</button>

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
<body onload="document.forms[0].reset()">
<script>
$(document).ready(function() {
	
	$("body").on("load", function(e) {
		$("#form1")[0].reset();
	});
	
	$("#back").on("click", function(e) {
		self.location = "/board/list";
	});
	
	// 파일 업로드
	$(".fileDrop").on("dragenter dragover",function(event) {
		event.preventDefault();
	});
	$(".fileDrop").on("drop",function(event) {
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
				str = "<div>"+ "<img src ='/displayFile?fileName="+data+"'/>"+data+"</div>" + "<input type='hidden' name='files' value='"+data+"'/>"
				} else {
				str = "<div>"+ data +"<input type='hidden' name='files' value='"+data+"'/>"+"</div>";
				}
				$("#uploadList").append(str);
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