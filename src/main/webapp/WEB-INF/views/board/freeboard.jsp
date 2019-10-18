<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>게시글목록</title>
<%@ include file="../layout/menu.jsp" %>
<%@include file="../layout/rightUser.jsp"%>
	<div class="container">
	<h3>자유게시판</h3>
	<div id="table-responsive">
		<div class="buttondiv" style="margin-top: 10px; margin-bottonm: 10px;">
		<!-- 로그인이 안되있을 경우 글쓰는 권한 X -->
		<sec:authorize access="hasRole('ROLE_USER')">
		<button type ="button" class="btn btn-outline-secondary" onclick="location.href='register'">게시글 등록</button>
		</sec:authorize>
		</div>
		<div style="border-top: 2px solid black;"></div>		
		<table class="table table-hover">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천</th>
			</tr>
			<c:forEach items="${freeboard}" var="fboard">
					<fmt:formatDate value="${fboard.regDate }" var="regDate" pattern="yyyy-MM-dd" />
				<tr>
					<td>${fboard.num}</td>
					<td><a href="freeboardView?num=${fboard.num}">${fboard.title}
						<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${fboard.replyCount}</span>
					</a></td>
					<td>${fboard.userid}</td>
					<td>${regDate}</td>
					<td>${fboard.readCount}</td>
					<td>${fboard.recommCount}</td>
				</tr>
			</c:forEach>
				<tr>
					<td colspan="5">
						<form id= "searchForm" action="/board/freeboard" method="get">
							<select name="type">
								<option value=""								
								<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected': ''}"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected': ''}"/>>내용</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W'?'selected': ''}"/>>작성자</option>
								<option value="TC"
									<c:out value="${pageMaker.cri.type eq 'TC'?'selected': ''}"/>>제목+내용</option>
								<option value="TW"
									<c:out value="${pageMaker.cri.type eq 'TW'?'selected': ''}"/>>제목+작성자</option>
								<option value="TCW"
									<c:out value="${pageMaker.cri.type eq 'TCW'?'selected': ''}"/>>제목+내용+작성자</option>										
								</select>
							<input type="text" name="keyword" placeholder="검색어를 입력하세요" value="<c:out value="${pageMaker.cri.keyword}"/>"/>							
							<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
							<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>
							<button class="btn btn-default">검색</button>
						</form>
					</td>
				</tr>
		</table>	
		<div style="border-top: 2px solid black;"></div>	
		<br>			
		</div>
			<ul class="pagination justify-content-center">
			<li class='${pageMaker.prev == true ? "page-item ":"page-item disabled"}'><a class="page-link" href="freeboard?pageNum=${pageMaker.startPage -1}&type=${param.type}&keyword=${param.keyword}">이전</a></li>
			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "page-item active" : "page-item"}'>
					<a class="page-link" href="freeboard?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">[${num}]</a>
				</li>
			</c:forEach>
			<li class=' ${pageMaker.next == true ? "page-item":"page-item disabled"}'><a class="page-link" href="freeboard?pageNum=${pageMaker.endPage +1}&type=${param.type}&keyword=${param.keyword}">다음</a>
			</li>
		</ul>
		</div>
<%@include file="../layout/bottom.jsp"%>