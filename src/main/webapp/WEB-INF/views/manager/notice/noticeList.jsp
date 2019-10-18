<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-공지사항</title>
<%@ include file="../../layout/menu.jsp" %>
<style>
	.notice-div{
		margin: 0 20% 0 20%;
	}
	th {
		text-align: center;
	}
</style>
<script type="text/javascript">
$(function(){
	var table = $(".table");
	$.ajax({
		url: "noticeTop3",
		type: "get",
		dataType: "json",
		success: function(data){
			for(var i in data){
				var num = data[i].num;
				var title = data[i].title;
				var content = data[i].content;
				var regDate = data[i].regDate;
				var readCnt = data[i].readCnt;
				var tr = "<tr><td style='text-align: center;'><span class='badge badge-pill badge-danger'>공지</span></td><td><a href='noticeView?num="+num+"'>"+title+"</a></td><td style='text-align: center;'>"+regDate+"</td><td style='text-align: center;'>"+readCnt+"</td></tr>";
				table.prepend(tr);
			}
		}
	});
});
</script>
	<br><br><br>
	<div class="notice-div container">
		<div class="button-div">
			<h3 style="float: left;">공지사항</h3>
			<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
				<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='noticeWrite'" style="float: right;">공지작성</button>
			</sec:authorize>
		</div>
		<br>
	<div style="border-top: 2px solid black; margin-top: 20px;"></div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${noticeList }" var="notice">
				<fmt:formatDate value="${notice.regDate }" var="regDate" pattern="yyyy-MM-dd" />
				<tr>
					<td style="text-align: center;">${notice.num }</td>
					<td><a href="noticeView?num=${notice.num }">${notice.title }</a>
						<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${notice.replyCnt }</span>
					</td>
					<td style="text-align: center;">${regDate }</td>
					<td style="text-align: center;">${notice.readCnt }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="border-top: 2px solid black;"></div>
	<div class="container" style="margin: 10px;">
		<form id="searchForm" action="noticeList" method="get" style="text-align: center;">
			<select name="type">
				<option value="" <c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}"/>>검색
				</option>
				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected' : ''}"/>>제목
				</option>
				<option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected': ''}"/>>카테고리
				</option>
				<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected': ''}"/>>내용
				</option>
				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected': ''}"/>>제목+내용
				</option>
				<option value="TA" <c:out value="${pageMaker.cri.type eq 'TA' ? 'selected': ''}"/>>제목+카테고리
				</option>
				<option value="TAC" <c:out value="${pageMaker.cri.type eq 'TAC' ? 'selected': ''}"/>>제목+카테고리+내용
				</option>
			</select>
			<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="<c:out value="${pageMaker.cri.keyword }"/>">
			<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
			<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
			<button class="btn btn-outline-dark btn-sm">검색</button>
		</form>
	</div>
	<!-- Pagination -->
	<div class="container" style="margin-top: 10px;">
		<ul class="pagination justify-content-center" style="text-align: center;">
			<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="noticeList?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
					<a class="page-link" href="noticeList?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">${num}</a>
				</li>
			</c:forEach>
			<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="noticeList?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
			</li>
		</ul>
	</div>
</div>
