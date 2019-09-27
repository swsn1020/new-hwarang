<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
*{
	margin: 0 auto;
	padding: 0;
	box-sizing: border-box;
}
ul, ol, li {
    list-style: none;
}
div{
	display: block;
}
</style>
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
function findId(){
	if(document.findIdForm.member_name.value == ""){
		alert("이름을 입력해주세요.");
		document.findIdForm.member_name.focus();
		return;
	}
	if(document.findIdForm.member_email.value == ""){
		alert("이메일을 입력해주세요.");
		document.findIdForm.member_email.focus();
		return;
	}
	document.findIdForm.method = "get";
	document.findIdForm.action = "/member/findId";
	document.findIdForm.submit();
}
</script>
</head>
<body>
	<div class="container">
		<div class="jumbotron text-center">
			<h1>HWARANG</h1>
			<p>Your own exhibition</p>
		</div>
		<div id="containers" style="width: 720px; margin: 0 auto;">
			<div class="form-group" style="float: none; width: 350px;">
				<h3 align="center">아이디 찾기</h3>
				<div>
					<form name="findIdForm" id="findIdForm">
						<input type="text" id="member_name" name="member_name" class="form-control" placeholder="이름">
						<br>
						<input type="email" id="member_email" name="member_email" class="form-control" placeholder="이메일">
						<br><button type="button" id="checkId"  onclick="javascript:findId();" class="btn btn-primary" style="height: 50px; width: 350px; ">확인</button>
					</form>
				</div>
				<c:if test="${param.findResult eq 'success'}">
					<div align="center">
						<br>
						<h4>ID : ${param.member_id}</h4>
						<br>
						<button type="button" onclick="location.href='/member/loginForm'" class="btn btn-primary">로그인</button>
						<button type="button" onclick="location.href='/member/findpwForm'" class="btn btn-primary">비밀번호 찾기</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>