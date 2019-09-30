<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layout/left.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recommendboardFrom</title>
<script type="text/javascript">

</script>
</head>
<body>
		<div align="center">
			<h1>추천 게시판</h1>
		</div>
		<div class="table-responsive">
		 	<sec:authentication property="username" var="id"/>
		 	<c:if test="${id.username eq post.username}">
			 	<input type="hidden" name="username" id="member_id" value="${id.username}">
				<button onclick="location.href='write?id=${id.username}'" class="btn btn-link">Write</button>		 	
		 	</c:if>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>No</th>
						<th>Title</th>
						<th>Writer</th>
						<th>Date</th>
						<th>Count</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${recommendList}" var="recomm">
						<tr align="center">
							<td>${recomm.recomm_num}</td>
							<td><a href="view?num=${recomm.recomm_num}">${recomm.recomm_title}</a>
								<c:if test="${recomm.reply_count != 0}">
									<span class="badge">${recomm.reply_count }</span>
								</c:if>
							</td><!-- 댓글수 -->
							<td>${recomm.member_id}</td>
							<td><fmt:formatDate value="${recomm.recomm_reg_date}" pattern="yyyy-MM-dd"/></td>
							<td>${recomm.recomm_read_count}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div style="text-align: center;">
				<form id="searchForm" action="/recommend/recommendboard" method="get">
					<select name="type">
						<option value="" 
							<c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}"/>>검색
						</option>
						<option value="T" 
							<c:out value="${pageMaker.cri.type eq 'T'? 'selected' : ''}"/>>제목
						</option>
						<option value="I" 
							<c:out value="${pageMaker.cri.type eq 'I' ? 'selected': ''}"/>>작성자
						</option>
						<option value="C" 
							<c:out value="${pageMaker.cri.type eq 'C' ? 'selected': ''}"/>>내용
						</option>
						<option value="TC" 
							<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected': ''}"/>>제목+내용
						</option>
						<option value="TI" 
							<c:out value="${pageMaker.cri.type eq 'TI' ? 'selected': ''}"/>>제목+작성자
						</option>
						<option value="TIC" 
							<c:out value="${pageMaker.cri.type eq 'TIC' ? 'selected': ''}"/>>제목+작성자+내용
						</option>
					</select>
					<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="<c:out value="${pageMaker.cri.keyword }"/>">
					<%-- <c:out value="${pageMaker.cri.pageNum }"/> --%>
					
					<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
					<button class="btn btn-primary">검색</button>
				</form>
		</div> 
		<%-- 네비게이션 표시 --%>
		<div class="container" align="center">
			<ul class="pagination justify-content-center">
				<li class='${pageMaker.prev == true ? "page-item ":"page-item disabled"}'>
					<a class="page-link" href="recommendboard?pageNum=${pageMaker.startPage-1}&type=${param.type}&keyword=${param.keyword}">이전</a>
				</li>
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class='${pageMaker.cri.pageNum == num ? "page-item":"page-item active"}'>
						<a class="page-link" href="recommendboard?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">${num}</a>
					</li>
				</c:forEach>
				<li class=' ${pageMaker.next == true ? "page-item":"page-item disabled"}'>
					<a class="page-link" href="recommendboard?pageNum=${pageMaker.endPage+1}&type=${param.type}&keyword=${param.keyword}">다음</a>
				</li>
			</ul>
		</div>
<%@ include file="../layout/bottom.jsp"%>

</body>
</html>