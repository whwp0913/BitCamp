<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<style>
.fileDrop {
	width: 600px;
	height: 600px;
	border: gray;
	background-color: #FAF6F6;
}
</style>

<body>

	<form method="post" enctype="multipart/form-data">
		<div>
			첨부파일 등록
			<div class="fileDrop"></div>

			<div id="uploadList"></div>
		</div>
	</form>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>

	<script>
		$(".fileDrop").on("dragenter dragover", function(event) {
			event.preventDefault();

		});
		$(".fileDrop").on("drop", function(event) {
			event.preventDefault();
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];

			console.log(file);

			var formData = new FormData();
			formData.append("file", file);
			console.log(files);

			$.ajax({
				url : 'upload',
				data : formData,
				dataType : 'text',
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					alert(data);
				}
			});
		});
	</script>

</body>
</html>