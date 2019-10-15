<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <%@ include file="layout/left.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
</script>
<script type="text/javascript">

$(function(){
	document.domain = "localhost";
	window.close();
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
		<div align="center">
			<h1>로그인후 페이지</h1>
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
<%@ include file="layout/bottom.jsp"%>
</body>
</html>