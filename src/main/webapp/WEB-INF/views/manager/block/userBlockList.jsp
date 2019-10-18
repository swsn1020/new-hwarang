<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>고객센터</title>
<%@ include file="../../layout/menu.jsp" %>
<style>
	.container{
		margin: 0 20% 0 20%;
		padding-left: 50px;
		padding-right: 50px;
	}
	table th, td {
		text-align: center;
	}
</style>
	<div class="container">
		<h3>내가 신고한 게시물</h3>
		<div style="border-top: 2px solid black;"></div>
		<table class="table table-hover">
		<thead>
			<tr>
				<th style="width: 10%">신고번호</th>
				<th>제목</th>
				<th>신고내용</th>
				<th style="width: 15%">신고일</th>
				<th style="width: 15%">처리상태</th>
			</tr>
			</thead>
			<c:forEach items="${blockList }" var="block">
				<fmt:formatDate value="${block.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
				<tr>
					<td>${block.num }</td>
					<c:set var="category" value="${block.category }"/>
					<c:choose>
					<c:when test="${fn:contains(category, 'Reply')}">
						<td>${block.boardTitle }_댓글</td>
					</c:when>
					<c:otherwise>
						<td>${block.boardTitle }_게시글</td>
					</c:otherwise>
					</c:choose>
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
				</c:forEach>
		</table>
	<div style="border-top: 2px solid black;"></div>
	</div>
	<br><br>
	<!-- Pagination -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="blockListForUser?pageNum=${pageMaker.startPage-1 }">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
					<a class="page-link" href="blockListForUser?pageNum=${num}">${num}</a>
				</li>
			</c:forEach>
			<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="blockListForUser?pageNum=${pageMaker.endPage+1 }">&raquo;</a>
			</li>
		</ul>
	</div>
<%@ include file="../../layout/bottom.jsp"%>