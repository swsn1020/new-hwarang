<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>고객센터</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript">
	$(function(){
// 		$("#btn-view").on("click", function(){
// 			//css변경하기
//  			alert("답변보기 클릭");
// 			$("#viewForm").on("submit", function(){
				
// 			});
			
// 		});
	});
</script>
	<div class="container">
		<h3>화랑-내가 신고한 게시물</h3>
		<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>신고접수번호</th>
				<th>게시판</th>
				<th>신고일</th>
				<th>처리상태</th>
			</tr>
			</thead>
			<c:set var="rnum" value="${pageMaker.total - ((pageMaker.cri.pageNum-1)*12)}"/>
			<c:forEach items="${blockList }" var="block">
				<fmt:formatDate value="${block.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
				<tr>
					<td>${rnum }</td>
					<td><a href="blockView?num=${block.num}">${block.num }</a></td>
					<td>${block.category }</td>
					<td>${regDate }</td>
					<c:choose>
						<c:when test="${block.reply eq '미확인' }">
							<td style="color: red;">처리 대기 중<td>
						</c:when>
						<c:otherwise>
							<td>처리완료</td>
	<!-- 						<form name="viewForm" action="blockView" method="post"> -->
	<%-- 							<input type="hidden" name="num" value="${block.num }"> --%>
	<%-- 							<input type="hidden" name="category" value="${block.category }"> --%>
	<%-- 							<input type="hidden" name="boardNum" value="${block.boardNum }"> --%>
	<!-- 						</form> -->
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