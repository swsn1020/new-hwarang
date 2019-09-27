<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script type="text/javascript">

$(function(){
	document.domain = "localhost";
	var naverUser = '${snsUser}';
	if(naverUser == "naver"){
		var url = "/index?naverResult=success&id='${param.id}'";
		window.opener.location.replace(url);
		window.close();
	}	
}); 
</script>
</head>
<body>
	<div class="container">
		<div class="jumbotron text-center">
			<h1>HWARANG</h1>
			<p>Your own exhibition</p>
		</div>
		<div id="containers" style="width: 720px; margin: 0 auto;">
		<table class="table">
		<c:choose>
			<c:when test="${param.kakaoResult eq 'success'}">
				<tr>
					<td>
						${kakaoName}님 <br>
						<button type="button" onclick="location.href='/member/myPage?id=${id}'" >마이페이지</button>
						<button type="button" >로그아웃</button>
					</td>
				</tr>
			</c:when>
			<c:when test="${param.naverResult eq 'success'}">
				<tr>
					<td>
						${naverName}님 <br>
						<button type="button" onclick="location.href='/member/myPage?id=${id}'">마이페이지</button>
						<button type="button" >로그아웃</button>
					</td>
				</tr>
			</c:when>
			<c:when test="${param.result eq 'success'}">
				<tr>
					<td>
						${param.id}님 <br>
						<button type="button" onclick="location.href='/member/myPage?id=${param.id}'">마이페이지</button>
						<button type="button" >로그아웃</button>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
					<tr>
						<td>
							<button type="button" onclick="location.href='/member/loginForm'">로그인</button>
						</td>
					</tr>
			</c:otherwise>
		</c:choose>
		</table>
		</div>
	</div>
</body>
</html>