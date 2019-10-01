${mem }<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고게시판</title>
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
		<h3>신고게시판</h3>
		<div class="buttondiv" style="text-align: center; float: right; margin-bottom: 10px;">
			<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='reportWrite'">신고글 작성</button>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>처리상태</th>
				</tr>
			</thead>
			<c:forEach items="${reportList }" var="report">
				<fmt:formatDate value="${report.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
				<tr>
					<td style="text-align: center;">${report.num }</td>
					<td>
						<a href="reportView?num=${report.num }">${report.title }</a>
						<span><i class="fa fa-lock fa-sm"></i></span>
					</td>
					<td style="text-align: center;">${report.memId }</td>
					<td style="text-align: center;">${regDate }</td>
					<c:choose>
						<c:when test="${report.reply eq '미해결' || report.reply eq null }">
							<td style="color: red; text-align: center;">처리 중</td>
						</c:when>
						<c:otherwise>
							<td style="text-align: center;">처리 완료</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
	</div>
		
		<!-- Pagination -->
		<div class="container">
			<ul class="pagination justify-content-center">
				<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="reportList?pageNum=${pageMaker.startPage-1 }">&laquo;</a>
				</li>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
					<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
						<a class="page-link" href="reportList?pageNum=${num}">${num}</a>
					</li>
				</c:forEach>
				<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="reportList?pageNum=${pageMaker.endPage+1 }">&raquo;</a>
				</li>
			</ul>
		</div>
<%@ include file="../../layout/bottom.jsp"%>