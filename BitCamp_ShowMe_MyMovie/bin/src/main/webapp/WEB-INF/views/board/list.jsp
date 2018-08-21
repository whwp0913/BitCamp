<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
@media ( max-width : 767px) {
	.selectType {
		width: 35%;
		height: 28px;
		font-size: 11px;
	}
	.keywordInput {
		width: 40%;
		height: 28px;
		font-size: 11px;
	}
	
	.btn{
	line-height: 1.25;
	}
	#btn_write{
	height: 28px;
	margin-top: 10px;
	margin-left: 280px;
	}
	#btn_search{
	height: 28px;
	}
}

@media ( min-width : 768px){

.searchDiv{

text-align: right;
margin-top: 5px;
margin-right: 270px;

}

}
</style>



<div class="col-sm-12 col-md-12 main" style="margin-top: 50px;">

	
		<div class="col-sm-offset-2 col-sm-8" style="background-color: #e9faff;">
			<div class="row">
				<div class="col-sm-12">
					<div class="text-center" style="border-bottom: 1px solid black; padding-top:10px;"><p sytle="font-size: 10px;">오늘의 HOT게시글</p></div>
					<table class="table" style="padding-bottom : 0px;" >
					<tr>
					<c:forEach items="${bestList}" var="list" begin="0" end="9" varStatus="status">
					<td class="col-sm-6"><span><c:out value="[${list.kno}]"/></span> <a href="/board/read?page=${pm.cri.page}&perPageNum=${pm.cri.perPageNum}&bno=${list.bno}"><c:out value="${list.title}"/></a></td>
					<c:if test="${status.index%2 == 1}">
					</tr>
					<tr>
					</c:if>
					</c:forEach>											
					</table>
				</div>
					
			</div>									
		</div>


	<div class="row">

	  <div class="col-sm-offset-2 col-sm-4">
	    <h3>영화 게시판</h3>
	  </div>

	</div>

	<div class="row">

		<div class="col-sm-offset-2 col-sm-8 table-responsive">
			
			<table class="table table-hover">

				<thead>
					<tr>
						<th class="hidden-xs" style="width: 10%; text-align: center;" >글번호</th>
						<th style="text-align: center;">제목</th>
						<th style="text-align: center;">작성자</th>
						<th style="text-align: center;">작성일</th>
						<th style="text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${BoardVO}" var="board">
						<tr style="text-align: center">
							<td class="hidden-xs"><c:out value="${board.bno}" /></td>
							<c:choose>
								<c:when test="${pm.cri.type eq '' && pm.cri.keyword eq '' }">
									<td style="text-align: left"><span><c:out value="[${board.kno}]"/></span> <a
										href="/board/read?page=${pm.cri.page}&perPageNum=${pm.cri.perPageNum}&bno=${board.bno}"><c:out
												value="${board.title}" /></a></td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left"><a
										href="/board/read?page=${pm.cri.page}&perPageNum=${pm.cri.perPageNum}&bno=${board.bno}&type=${pm.cri.type}&keyword=${pm.cri.keyword}"><c:out
												value="${board.title}" /></a></td>
								</c:otherwise>
							</c:choose>
							<td><c:out value="${board.mid}" /></td>
							<td><fmt:formatDate value='${board.regdate}'
									pattern="yyyy.MM.dd hh:mm:ss" /></td>
							<td class="center"><c:out value="${board.views}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
	</div>

<form class="form-inline text-center searchDiv" method="get">
   <div class="form-group">
              <select name="type" id="selectType" class="form-control pull-left selectType">
                <option value="">----</option>
                <option value="t" ${pm.cri.type eq 't'? "selected": '' }>TITLE</option>
                <option value="c" ${pm.cri.type eq 'c'? "selected": '' }>CONTENT</option>
                <option value="m" ${pm.cri.type eq 'm'? "selected": '' }>WRITER</option>
                <option value="tc" ${pm.cri.type eq 'tc'? "selected": '' }>TITLE+CONTENT</option>
                <option value="tm" ${pm.cri.type eq 'tm'? "selected": '' }>TITLE+WRITER</option>
                <option value="tcm" ${pm.cri.type eq 'tcm'? "selected": '' }>TITLE+CONTENT+WRITER</option>
              </select>
            <input class="form-control pull-left keywordInput" type="text" id="keyword" name="keyword" value="${pm.cri.keyword}"/>
            </div>
            <button id="btn_search" class="btn btn-primary">SEARCH</button>
            <button id="btn_write" class="btn btn-info">글등록</button>
   
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
						href="list?page=${pm.startPage -1}">prev</a></li>
					</c:when>
					<c:otherwise>
					<li><a class="btn btn-info"
						href="list?page=${pm.startPage -1}&type=${pm.cri.type}&keyword=${pm.cri.keyword}">prev</a></li>
					</c:otherwise>
					</c:choose>
					</c:if>

				<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="idx">
					<c:choose>
					<c:when test="${pm.cri.type eq '' && pm.cri.keyword eq '' }">
					<li ${pm.cri.page == idx ? 'class=active':''}><a id="pageLink" class="btn btn-secondary"
						href="/board/list?page=${idx}">${idx}</a></li>
					</c:when>
					<c:otherwise>
					<li ${pm.cri.page == idx ? 'class=active':''}><a id="pageLink" class="btn btn-secondary"
						href="/board/list?page=${idx}&type=${pm.cri.type}&keyword=${pm.cri.keyword}">${idx}</a></li>
					</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${pm.next}">
					<c:choose>
					<c:when test="${pm.cri.type eq '' && pm.cri.keyword eq '' }">
					<li><a class="btn btn-info"
						href="list?page=${pm.endPage + 1}">next</a></li>
					</c:when>
					<c:otherwise>
					<li><a class="btn btn-info"
						href="list?page=${pm.endPage + 1}&type=${pm.cri.type}&keyword=${pm.cri.keyword}">next</a></li>
					</c:otherwise>
					</c:choose>
				</c:if>
				</ul>
			</div>

			</div>
		</div>
	</div>

</div>
	
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script>

$(document).ready(function() {
	var msg = '${msg}';
	if(msg=="regist"){
		alert("등록이 완료되었습니다.");
		location.reload();
	}
});

	var btn = $("#btn_search")
	var selectType = $("#selectType")
	var writeBtn = $("#btn_write") 
	var keyword = $("#keyword")
	var pageLink = $("#pageLink")

	btn.on("click", function(e) {
		console.log("click........................")
		if (selectType.val() == "" || keyword.val() == "") {
			alert("검색조건이나 검색어가 입력되지 않았습니다");
			e.preventDefault();
		}

	});

    writeBtn.on("click", function(e) {
    	e.preventDefault();
		location.href = "/board/write"
	});
    
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
