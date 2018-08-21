<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.photo {
	margin-top: 20px;
}

#size {
	width:100%;
	height:200px;
}
</style>
<div class="col-sm-12 col-md-12 main" style="margin-top: 50px;">
	<div class="row">
	  <div class="text-center">
	    <h3>이미지 게시판</h3>
	  </div>
	</div>

	<div class="row">
		<div class="col-sm-offset-1 col-sm-10">
			<div class="list-group photo row">
				<c:forEach items="${join}" var="list">				
					<div class='col-sm-3'>
						<a class="fancybox" rel="lightbox" href="/displayImage?fileName=${list.image}">
						<img id="size" class="img-responsive img-rounded thumbnail center-block" alt=""
						src="/displayFile?fileName=${fn:replace(list.image,'s_','')}" /></a>
						<div class='text-right text-center'>
							<p>
								<a href="/photo/read?page=${pageMaker.cri.page}&perPageNum=${pageMaker.cri.perPageNum}&pno=${list.pno}">
								<c:out value="${list.title}" /></a>																								
							</p>
							<p>
								<small class='text-muted'><c:out value="작성자 :${list.mid }" /></small>
							</p>
						</div>					
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-9 col-sm-offset-1">
			<div class="col-sm-12 text-center">
				<div id="pagination">
					<ul class="pagination">
						<li><span style="background-color: white;">Page
								${pageMaker.cri.page} of ${pageMaker.endPage}</span></li>
						<c:if test="${pageMaker.prev}">
							<c:choose>
								<c:when test="${pageMaker.cri.type eq '' && pageMaker.cri.keyword eq '' }">
									<li><a class="btn btn-info"
										href="photo/list?page=${pageMaker.startPage -1}">prev</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="btn btn-info"
										href="photo/list?page=${pageMaker.startPage -1}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">prev</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>

						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
							<c:choose>
								<c:when test="${pageMaker.cri.type eq '' && pageMaker.cri.keyword eq '' }">
									<li ${pageMaker.cri.page == idx ? 'class=active':''}><a
										id="pageLink" class="btn btn-secondary"
										href="/photo/list?page=${idx}">${idx}</a></li>
								</c:when>
								<c:otherwise>
									<li ${pageMaker.cri.page == idx ? 'class=active':''}><a
										id="pageLink" class="btn btn-secondary"
										href="/photo/list?page=${idx}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">${idx}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${pageMaker.next}">
							<c:choose>
								<c:when test="${pageMaker.cri.type eq '' && pageMaker.cri.keyword eq '' }">
									<li><a class="btn btn-info"
										href="list?page=${pageMaker.endPage + 1}">next</a></li>
								</c:when>
								<c:otherwise>
									<li><a class="btn btn-info"
										href="list?page=${pageMaker.endPage + 1}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">next</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
					</ul>
				</div>
			</div>
		</div>

		<div class="col-sm-1">
			<button id="btn_write" class="btn btn-xs btn-info">등록</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		//FANCYBOX
		//https://github.com/fancyapps/fancyBox
		$(".fancybox").fancybox({
			openEffect : "none",
			closeEffect : "none"
		});

		$("#btn_write").on("click", function(e) {
			e.preventDefault();
			location.href = "/photo/write"
		});
	});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>