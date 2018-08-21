<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
#fakeContent {
	height: 600px;
	overflow: scroll;
}
</style>

<div class="col-sm-12 col-md-12 main" style="margin-top: 50px;">
	<div class="row">
		<div class="text-center">
			<h3>이미지 게시판</h3>
		</div>
	</div>

	<form id="readForm">
		<input type="hidden" name="pno" value="${PhotoVO.pno}">
		<div class="form-group row">
			<div class="col-sm-8 col-sm-offset-2">
				<label for="title">Title</label>
				<div class="row">
					<div class="col-sm-12">
						<input type="text" class="form-control" id="title"
							value="${PhotoVO.title}" readonly />
					</div>
				</div>
			</div>
		</div>

		<div class="form-group row">
			<div class="col-sm-8 col-sm-offset-2">
				<label for="content">Content</label>

				<div class="form-control" id="fakeContent" contenteditable="false">
					<div class="col-sm-12">${PhotoVO.content}</div>
				</div>
			</div>
		</div>

		<div class="form-group row">
			<div class="col-sm-2 col-sm-offset-8">
				<p class="text-right label label-warning pull-right">${PhotoVO.mid}</p>
			</div>
		</div>
	</form>

	<div class="row">
		<div class="col-sm-8 col-sm-offset-2">
			<div class="row">
				<div class="col-sm-12 text-center">
					<button id="back" type="button" class="btn btn-xs btn-default">To List</button>
					<c:if test="${prin == PhotoVO.mid}">
						<button id="modify" type="button" class="btn btn-xs btn-default">Modify</button>
						<button id="remove" type="button" class="btn btn-xs btn-default">Delete</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
$(document).ready(
function() {
	var formObj = $("#inform");
	var mid = '${PhotoVO.mid}';
	var user = '${prin}';
	var readForm = $("#readForm");

	/* 뒤로가기 */
	$("#back").on("click", function(e) {
		self.location = "/photo/list?page=${cri.page}&perPageNum=${cri.perPageNum}";
	});
	
	/* 게시글 수정 */
	$("#modify").on("click", function(e) {
		if (user != "" && user != mid) {
			alert("글 작성자만 수정 가능합니다");
			e.preventDefault();
			return false;
		}
		self.location = "/photo/modify?page=${cri.page}&perPageNum=${cri.perPageNum}&pno=${PhotoVO.pno}";
	});

	/* 게시글 삭제 */
	$("#remove").on("click", function(e) {
		if (user != "" && user != mid) {
			alert("글 작성자만 삭제 가능합니다");
			e.preventDefault();
			return false;
		}
		if (user === "") {
			alert("로그인이 필요한 기능입니다")
			location.href = "/login";
			return false;
		}
		if (confirm("정말 삭제하시겠습니까?")) {
			readForm.attr("method", "POST");
			readForm.attr("action", "/photo/delete");
			readForm.submit();
		}
	});
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
