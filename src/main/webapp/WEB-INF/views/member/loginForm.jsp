<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>loginForm</title>
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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
// 사용할 앱의 JavaScript 키를 설정해 주세요.
$(function(){
	document.domain = "localhost";
	Kakao.init('2d9e59632a95ce30b56830828ea0f3ed');
	Kakao.Auth.createLoginButton({
		container : '#kakao-login-btn',
		success : function(authObj) {
			//var data = JSON.stringify(authObj);
			//이메일과 성별 제공 동의를 했는지 확인
			postLogin(authObj);				
		},
		fail : function(err) {
			//alert(JSON.stringify(err));
		}
	});
});
function postLogin(authObj){
	$.ajax({
		url:"/member/kakaoLogin",
		data: authObj,
		type: "post",
		dataType: "json",
		success: function(result){
			if(result == true){
				location.href = "/index?kakaoResult=success";
				window.close();
			}else{
				location.href = "/member/loginForm";
				window.close();
			}
		}
	});
}

function naverPopup(){
	var url = '${url}';
	window.open(url, 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=600, height=550');
	window.focus();
}
//회원 아이디와 비밀번호 입력 체크 
function goLogin(){
	if(document.loginForm.member_id.value == ""){
		alert("아이디를 입력해주세요.");
		document.loginForm.member_id.focus();
		return;
	}
	if(document.loginForm.member_password.value == ""){
		alert("비밀번호를 입력해주세요.");
		document.loginForm.member_password.focus();
		return;
	}
	document.loginForm.method = "post";
	document.loginForm.action = "/login";
	document.loginForm.submit();
}
</script>
</head>
<body>
	<div class="container">
		<div class="jumbotron text-center ">
			<h1>HWARANG</h1>
			<p>Your own exhibition</p>
		</div>
		${sessionScope }
		<div class="" style="margin: 0 auto; width: 720px; overflow: hidden;">
			<div class="form-group" style="float: left; width: 350px;">
				<h3  align="center">HWARANG Login</h3>
				<fieldset>
					<form name="loginForm" id="loginForm">
						<input type="text" name="username" id="member_id" class="form-control" placeholder="아이디"><br>
						<input type="password" name="password" id="member_password" class="form-control" placeholder="비밀번호"><br>
						<button type="button" id="checkLogin" onclick="javascript:goLogin();" class="btn btn-primary" style="height: 50px; width: 350px; ">Login</button><br><br>
					</form>
				</fieldset>
				<div style="margin: 20px auto 0; overflow: hidden; width: 280px;">
					<ul>
						<li style="float: left;"><a href="/member/findidForm">아이디 찾기</a>&nbsp;&nbsp;|</li>
						<li style="float: left;">&nbsp;&nbsp;<a href="/member/findpwForm">비밀번호 찾기</a>&nbsp;&nbsp;|
						</li>
						<li style="float: left;">&nbsp;&nbsp;<a href="/member/joinForm">회원가입</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="" style=" width: 300px; height: 400px; float: left; padding-left: 60px; margin-left: 65px;">
				<h3  align="center">SNS Simple Login</h3>
				<ul style="align-content: center;">
					<li>
						<br>
						  <div id="naver_id_login">
						<!-- onclick="window.open(this.href, 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=600, height=550'); return false" -->
						  <a href="#" onclick="naverPopup()">
						  <img height="50" src="http://static.nid.naver.com/oauth/big_g.PNG"/></a>
						  </div>
						<br><br>
					</li>
					<li>
						<a id="kakao-login-btn"></a>
					</li>
				</ul>
				<h2><c:out value="${param.error}"/>1</h2>
			</div>
		</div>
	</div>
</body>
</html>