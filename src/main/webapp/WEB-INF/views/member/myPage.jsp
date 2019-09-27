<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<div id="containers" style="width: 720px; margin: 0 auto;">
			<!-- 회원의 기본정보 -->
			<div>
				<table class="table">
					<tbody>
						<tr>
							<td>${member.member_name} 님 <br>
							나의 포인트 : ${member.member_point}</td>
						</tr>
						<tr align="right">
							<!-- 개인정보 수정 -->
							<td>
								<button type="button" onclick="location.href='/member/modifyForm?id=${param.id}'">개인정보 수정</button>
							<!-- 회원 탈퇴 -->
								<button type="button" onclick="location.href='/member/deleteForm?id=${param.id}'">회원탈퇴</button>						
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 포인트 내역 -->
			<div>
				<h3>포인트 내역</h3>
				<table class="table">
					<tbody>
					<tr align="center"> 
						<th>번호</th>
						<th>날짜</th>
						<th colspan="3">내용</th>
						<th>포인트</th>
					</tr>
					<c:forEach items="${points}" var="point">
					<tr>
						<td>${point.point_num}</td>
						<td>
						<c:if test="${point.point_use_date eq null}">
							<fmt:formatDate value="${point.point_get_date}" pattern="yyyy-MM-dd kk:mm:ss"/>							
						</c:if>
						<c:if test="${point.point_get_date eq null}">
							<fmt:formatDate value="${point.point_use_date}" pattern="yyyy-MM-dd kk:mm:ss"/>						
						</c:if>
						</td>
						<td colspan="3">${point.point_memo}</td>
						<c:if test="${point.point_use_date eq null}">
							<td>${point.point_get_amount}</td>						
						</c:if>
						<c:if test="${point.point_get_date eq null}">
							<td>${point.point_use_amount}</td>
						</c:if>
					</tr>
					</c:forEach>			
					</tbody>
				</table>
			</div>
			<!-- 예매내역 -->
			<div>
				<h3>예매 내역</h3>
				<table class="table">
					<tbody>
					
					</tbody>
				</table>
			</div>
			<!-- 나의 게시글 -->
			<div>
				<h3>나의 게시글</h3>
				<table class="table">
					<tbody>
						
					</tbody>
				</table>
			</div>
			<!-- 신고내역 -->
			<div>
				<h3>신고 내역</h3>
				<table class="table">
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>