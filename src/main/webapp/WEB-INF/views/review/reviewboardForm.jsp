<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reviewboardFrom</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
		<div class="jumbotron text-center">
			<h1>HWARANG</h1>
			<p>Your own exhibition</p>
		</div>
		<div class="table-responsive">
			<!-- member_id : 아이디
			[댓글수] 만들어보기
		 -->
			<button onclick="location.href='write?member_id=test1'" class="btn btn-link">Write</button>
			<table class="table table-hover">
				<!-- <tr>
				<td colspan="5">
					<form action="reviewboard">
						검색-> 검색 게시글 목록
						<select name="type">
							<option value="1">제목</option>
							<option value="2">내용</option>
							<option value="3">제목+내용</option>
							<option value="4">작성자</option>
						</select> 
						<input type="text" name="keyword" placeholder="검색어를입력하세요">
						<input type="submit" value="검색">
					</form>
				</td>
			</tr> -->
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
					<c:forEach items="${reviewList}" var="review">
						<tr align="center">
							<td>${review.review_num}</td>
							<td><a href="view?num=${review.review_num}">${review.review_title}</a>
							<span class="badge">${review.reply_count}</span></td>
							<td>${review.member_id}</td>
							<td><fmt:formatDate value="${review.review_reg_date}" pattern="yyyy-MM-dd"/></td>
							<td>${review.review_read_count}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<%-- 네비게이션 표시 --%>
		<div align="center">
			<ul class="pagination justify-content-end">
				<li class='${pageMaker.prev == true ? "page-item ":"disabled"}'>
					<a href='${pageMaker.startPage -1}'>Previous</a>
				</li>
				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li class='${pageMaker.cri.pageNum == num ? "active":"page-item"}'>
						<a class="page-link" href="reviewboard?pageNum=${num}">${num}</a>
					</li>
				</c:forEach>
				<li class=' ${pageMaker.next == true ? "page-item":"disabled"}'>
					<a href='${pageMaker.endPage +1}'>Next</a>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>