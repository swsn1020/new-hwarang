<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-공지사항</title>
<%@ include file="../../layout/logoleft2.jsp" %>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	th {
		text-align: center;
	}
</style>
<script type="text/javascript">
</script>
	<div class="container" style="padding-left: 50px; padding-right: 50px;">
	<h3>공지사항</h3>
	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
	<div class="buttondiv" style="text-align: center; float: right; margin-bottom: 10px;">
		<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='noticeWrite'">공지작성</button>
	</div>
	</sec:authorize>
	<table class="table table-hover" id="noticeTable">
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
	<div class="container" style="text-align: center;">
				<form id="searchForm" action="noticeList" method="get">
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
<%-- 					<c:out value="${pageMaker.cri.pageNum }"/> --%>
					<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
					<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
					<button class="btn btn-primary">검색</button>
					</form>
			</div>
			
	</div>
	<!-- 권한 확인하기 -->
	<!-- Pagination -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="noticeList?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
					<a class="page-link" href="noticeList?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">[${num}]</a>
				</li>
			</c:forEach>
			<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="noticeList?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
			</li>
		</ul>
	</div>
<%-- <%@ include file="../../layout/bottom.jsp"%> --%>