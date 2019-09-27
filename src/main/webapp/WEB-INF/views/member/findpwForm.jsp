<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
function findPw(){
	if(document.findPwForm.member_id.value == ""){
		alert("아이디를 입력해주세요.");
		document.findPwForm.member_id.focus();
		return;
	}
	if(document.findPwForm.member_name.value == ""){
		alert("이름을 입력해주세요.");
		document.findPwForm.member_name.focus();
		return;
	}
	if(document.findPwForm.member_email.value == ""){
		alert("이메일를 입력해주세요.");
		document.findPwForm.member_email.focus();
		return;
	}
	document.findPwForm.method = "get";
	document.findPwForm.action = "/member/findPw";
	document.findPwForm.submit();
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
				<h3 align="center">비밀번호 찾기</h3>
				<div>
					<form name="findPwForm" id="findPwForm">
						<input type="text" id="member_id" name="member_id" class="form-control" placeholder="아이디">
						<br>
						<input type="text" id="member_name" name="member_name" class="form-control" placeholder="이름">
						<br>
						<input type="email" id="member_email" name="member_email" class="form-control" placeholder="이메일">
						<br><button type="button" id="checkId"  onclick="javascript:findPw();" class="btn btn-primary" style="height: 50px; width: 350px; ">확인</button>
					</form>
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>