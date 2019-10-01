<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>고객센터</title>
<%@ include file="../../layout/left.jsp" %>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	table th, td {
		text-align: center;
	}
</style>
	<div class="container">
		<h3>화랑-내가 신고한 게시물</h3>
		<table class="table table-hover">
		<thead>
			<tr>
				<th style="width: 10%">번호</th>
				<th>신고번호</th>
<!-- 				<th style="width: 15%">게시판</th> -->
				<th style="width: 25%">신고사유</th>
				<th style="width: 15%">신고일</th>
				<th style="width: 15%">처리상태</th>
			</tr>
			</thead>
			<c:set var="rnum" value="${pageMaker.total - ((pageMaker.cri.pageNum-1)*10)}"/>
			<c:forEach items="${blockList }" var="block">
				<fmt:formatDate value="${block.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
				<tr>
					<td>${rnum }</td>
					<td><a href="blockView?num=${block.num}">${block.num }(${block.category })</a></td>
<%-- 					<td>${block.category }</td> --%>
					<td>${block.content }</td>
					<td>${regDate }</td>
					<c:choose>
						<c:when test="${block.reply eq '미확인' }">
							<td style="color: red;">처리 대기 중<td>
						</c:when>
						<c:otherwise>
							<td>처리완료</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<c:set var="rnum" value="${rnum-1 }"></c:set>
				</c:forEach>
		</table>
	</div>
	
	<!-- Pagination -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="blockListForUser?memId=haddie&pageNum=${pageMaker.startPage-1 }">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
					<a class="page-link" href="blockListForUser?memId=haddie&pageNum=${num}">${num}</a>
				</li>
			</c:forEach>
			<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="blockListForUser?memId=haddie&pageNum=${pageMaker.endPage+1 }">&raquo;</a>
			</li>
		</ul>
	</div>
<%@ include file="../../layout/bottom.jsp"%>