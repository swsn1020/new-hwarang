<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>화랑-마이페이지-문의내역</title>
<%@ include file="../../layout/menu.jsp" %>
<style>
	.container{
		margin: 0 20% 0 20%;
		padding-left: 50px;
		padding-right: 50px;
	}
	th {
		text-align: center;
	}
</style>
<div class="container">
	<div class="button-div">
		<h3 style="float: left;">내가 작성한 문의글</h3>
		<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='qnaWrite'" style="float: right;">문의하기</button>
	</div>
	<br>
	<div style="border-top: 2px solid black; margin-top: 20px;"></div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>답변상태</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="rnum" value="${pageMaker.total - ((pageMaker.cri.pageNum-1)*12)}"/>
			<c:forEach items="${qnaList }" var="qna">
				<fmt:formatDate value="${qna.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
				<tr>
					<td style="text-align: center;">${rnum}</td>
					<td><a href="qnaView?num=${qna.num }">${qna.title }</a>
						<span class="badge bg-teal"><i class="fa fa-lock fa-sm"></i></span>
					</td>
					<td style="text-align: center;">${regDate }</td>
					<c:choose>
						<c:when test="${qna.reply eq '미답변' || qna.reply eq null}">
							<td style="color: red; text-align: center;">답변 대기중</td>
						</c:when>
						<c:otherwise>
							<td style="text-align: center;">답변 완료</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<c:set var="rnum" value="${rnum-1 }"></c:set>
			</c:forEach>
		</tbody>
	</table>
	<div style="border-top: 2px solid black;"></div>
</div>
<br>

<div class="container">
	<ul class="pagination justify-content-center">
		<li class='${pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
			<a class="page-link" href="qnaListForUser?memId=haddie&pageNum=${pageMaker.startPage-1 }">&laquo;</a>
		</li>
		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
			<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
				<a class="page-link" href="qnaListForUser?memId=haddie&pageNum=${num}">${num}</a>
			</li>
		</c:forEach>
		<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
			<a class="page-link" href="qnaListForUser?memId=haddie&pageNum=${pageMaker.endPage+1 }">&raquo;</a>
		</li>
	</ul>
</div>
