<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고게시판</title>
<%@ include file="../../layout/menu.jsp" %>
<%@include file="../../layout/rightUser.jsp"%>
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
<script>
$(function(){
	var table = $(".table");
	$.ajax({
		url: "/notice/noticeTop3",
		type: "get",
		dataType: "json",
		success: function(data){
			for(var i in data){
				var num = data[i].num;
				var title = data[i].title;
				var content = data[i].content;
				var regDate = data[i].regDate;
				var readCnt = data[i].readCnt;
				var tr = "<tr><td style='text-align: center;'><span class='badge badge-pill badge-danger'>공지</span></td><td><a href='/notice/noticeView?num="+num+"'>"+title+"</a></td><td style='text-align: center;'>관리자</td><td style='text-align: center;'>"+regDate+"</td><td style='text-align: center; color: #5D485B; font-weight: bold;'>공지사항</td></tr>";
				table.prepend(tr);
			}
		}
	});
});
</script>
<br><br><br>
	<div class="container">
		<div class="button-div">
			<h3 style="float: left;">신고게시판</h3>
			<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='reportWrite'" style="float: right;">신고글 작성</button>
		</div>
		<br>
		<div style="border-top: 2px solid black; margin-top: 20px;"></div>
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
		<div style="border-top: 2px solid black;"></div>
	</div>
	<br>
		
		
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
		
