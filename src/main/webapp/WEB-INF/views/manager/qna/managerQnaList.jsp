<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-1:1문의</title>
<%@ include file="../../layout/left.jsp" %>
<script>
	$(function(){
		
	});
/*
	function replyRegister(modalId){
		var qnaNum = $("#"+modalId).find('input').val();
		var reply = $("#"+modalId).find('textarea').val();
// 		alert(reply);
		var d = {"num": qnaNum, "reply": reply};
		$.ajax({
			url: "replyModify",
			data: d,
			type: "post",
			dataType: "json",
			success: function(result){
				if(result){
					alert("답변이 등록되었습니다.");
					$("#"+modalId).modal("hide");
					location.reload();
				}else{
					alert("답변 등록 다시시도!");
				}
			},
			error: function(){
				alert("답변등록 ajax 오류");
			}
		});
	}
*/

</script>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	th {
		text-align: center;
	}
</style>
	<div class="container" style="padding-left: 50px; padding-right: 50px;">
		<h3>관리자-1:1문의현황</h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>분류</th>
					<th>제목</th>
					<th>작성자ID</th>
					<th>등록일</th>
					<th>답변상태</th>
				</tr>
			</thead>
			<c:forEach items="${qnaList }" var="qna">
				<fmt:formatDate value="${qna.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
					<tr>
						<td style="text-align: center;">${qna.num }</td>
						<td style="text-align: center;">${qna.category }</td>
						<td><a href="qnaView?num=${qna.num }">${qna.title }</a></td>
						<td style="text-align: center;">${qna.memId }</td>
						<td style="text-align: center;">${regDate }</td>
						<c:choose>
							<c:when test="${qna.reply  eq '미답변'}">
								<td style="color: red; text-align: center;">미답변</td>
							</c:when>
							<c:otherwise>
								<td style="text-align: center;">답변완료</td>
							</c:otherwise>
						</c:choose>
					</tr>
			</c:forEach>
		</table>
		
		<!-- Pagination -->
		<div class="container">
			<ul class="pagination justify-content-center">
				<li class='${pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="qnaList?pageNum=${pageMaker.startPage-1 }">&laquo;</a>
				</li>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
					<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
						<a class="page-link" href="qnaList?pageNum=${num}">${num}</a>
					</li>
				</c:forEach>
				<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="qnaList?pageNum=${pageMaker.endPage+1 }">&raquo;</a>
				</li>
			</ul>
		</div>
		
	</div>
<%@ include file="../../layout/bottom.jsp"%>