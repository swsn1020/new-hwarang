<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../layout/menu.jsp" %>
<%@include file="../layout/rightUser.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.div{
	margin: 0 auto;
	padding: 0;
	box-sizing: border-box;
	display: block;
}
ul, ol, li {
    list-style: none;
}
</style>
<meta charset="UTF-8">
<title>화랑 - 로그인</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
// 사용할 앱의 JavaScript 키를 설정해 주세요.
$(function(){
	document.domain = "localhost";
	Kakao.init('fb9aed23f848063a34eed98d2d7ea36b');
	Kakao.Auth.createLoginButton({
		container : '#kakao-login-btn',
		success : function(authObj) {
			var data = JSON.stringify(authObj);
			//이메일과 성별 제공 동의를 했는지 확인
			postLogin(authObj);				
		},
		fail : function(err) {
			alert(JSON.stringify(err));
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
				window.close();
				window.location.href = "/";
			}else{
				window.close();
				window.location.href = "/member/loginForm";
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
	<div class="container" style="background: #f8fafc; padding: 10px; ">

		<h1 align="center" style="margin-top: 20px;">로그인</h1>
<!-- 		<div style="border: 1px solid black;"></div> -->
		<br>
		<br>
		<%-- ${sessionScope } --%>
		<div class="" style="margin: 0 auto; width: 720px; overflow: hidden;">
			<div class="form-group" style="float: left; width: 350px;">
				<h3 align="center">화랑 ID 로그인</h3>
				<fieldset>
					<form name="loginForm" id="loginForm">
						<input type="text" name="username" id="member_id" class="form-control" placeholder="아이디"><br>
						<input type="password" name="password" id="member_password" class="form-control" placeholder="비밀번호"><br>
						<button type="button" id="checkLogin" onclick="javascript:goLogin();" class="btn btn-outline-dark" style="height: 50px; width: 350px; ">로그인</button><br><br>
						<p style="color: red;"><c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">아이디 또는 비밀번호를 잘못 입력하셨습니다.<br>
						아이디 찾기 / 비밀번호 찾기를 이용하여 개인정보를 확인해 주세요.</c:if></p>
						<div class="checkbox">
							<label><input type="checkbox" name="remember-me">자동 로그인</label>
						</div>
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
				<h3  align="center">SNS 간편 로그인</h3>
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
			</div>
		</div>
	</div>
<%@ include file="../layout/bottom.jsp"%>
</body>
</html>