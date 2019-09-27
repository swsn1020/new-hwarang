<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layout/left.jsp"%>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<title>게시글목록</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
		<table>
			<tr>
				<td colspan="5">
					<button onclick="location.href='register'">게시글 등록</button>
				</td>
			</tr>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천</th>
			</tr>
			<c:forEach items="${freeboard}" var="fboard">
				<tr>
					<td>${fboard.num}</td>
					<td><a href="freeboardView?num=${fboard.num}">${fboard.title}
					<span style="color:red">
					<c:if test="${fboard.replyCount != 0}">[${fboard.replyCount }]</c:if> 
					</span>
					</a></td>
					<td>${fboard.userid}</td>
					<td>${fboard.regDate}</td>
					<td>${fboard.readCount}</td>
					<td>${fboard.recommCount}</td>
				</tr>
			</c:forEach>
				<tr>
					<td colspan="5">
						<form id= "searchForm" action="/free/board/freeboard" method="get">
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
							<input type="text" name="keyword" placeholder="검색어를 입력하세요"
								value="<c:out value="${pageMaker.cri.keyword}"/>"/>
							
							<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
							<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>
							<button class="btn btn-default">검색</button>
						</form>
					</td>
				</tr>
		</table>	
			<ul class="pagination justify-content-center">
			<li class='${pageMaker.prev == true ? "page-item ":"page-item disabled"}'><a class="page-link" href="freeboard?pageNum=${pageMaker.startPage -1}&type=${param.type}&keyword=${param.keyword}">이전</a></li>
			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "page-item":"page-item active"}'>
					<a class="page-link" href="freeboard?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">[${num}]</a>
				</li>
			</c:forEach>
			<li class=' ${pageMaker.next == true ? "page-item":"page-item disabled"}'><a class="page-link" href="freeboard?pageNum=${pageMaker.endPage +1}&type=${param.type}&keyword=${param.keyword}">다음</a>
			</li>
		</ul>
		</div>
<%@include file="../layout/bottom.jsp"%>
</body>
</html>
