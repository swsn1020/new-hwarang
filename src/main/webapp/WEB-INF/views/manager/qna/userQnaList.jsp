<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>화랑-마이페이지-문의내역</title>
<%@ include file="../../layout/left.jsp" %>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	th {
		text-align: center;
	}
</style>
<div class="container">
	<h3>${param.memId }-작성한 문의</h3>
	<div class="buttondiv" style="text-align: center; float: right; margin-bottom: 10px;">
		<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='qnaWrite'">문의작성</button>
	</div>
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
<%@ include file="../../layout/bottom.jsp"%>