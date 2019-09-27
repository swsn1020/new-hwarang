<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-공지사항</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript">
</script>
	<h3>공지사항</h3>
	<div class="container">
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
					<td>${notice.num }</td>
					<td><a href="noticeView?num=${notice.num }">${notice.title }</a>
						<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${notice.replyCnt }</span>
					</td>
					<td>${regDate }</td>
					<td>${notice.readCnt }</td>
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
	<div class="buttondiv">
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='noticeWrite'">글 쓰기</button>
	</div>
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
<%@ include file="../../layout/bottom.jsp"%>