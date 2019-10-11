<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	$(function() {
		Kakao.init('f2ce3ae8264eed849df9ea6f9ad313b9');
		Kakao.PlusFriend.createAddFriendButton({
			container : '#plusfriend-addfriend-button',
			plusFriendId : '_xingBT' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
		});
		Kakao.PlusFriend.createChatButton({
			container : '#plusfriend-chat-button',
			plusFriendId : '_xingBT' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
		});
	});
</script>
<c:if test="${ not empty pageContext.request.userPrincipal }">
	<link rel="stylesheet" href="/resources/css/nav_notice.css"/>
	<script src="/resources/js/nav_notice.js"></script>
	<script>
	$(function() {
		var login_member_id = $("#userid").val();
	getNoticeCount(login_member_id);
	setInterval(function() {
		getNoticeCount(login_member_id)
	}, 40000)
	$(".nav-link").on("click",function()){
		$.ajax({
			url :"getUserNotice"
			dataType:"json",
			cache: false,
			data : {member_id : login_member_id},
			success : function(ret){
			}
		})					
		}
	}
	});
	</script>
</c:if>
</div>
<div class="col-sm-2" style="padding: 0px;">
	<ul class="nav ">
		<li class="nav-item col-sm-12 alert alert-danger" id="side_item"><a
			class="nav-link" href="#"> 멤버 페이지</a></li>
		<sec:authorize access="isAuthenticated()">
		<li class="nav-item col-sm-6" id="side_item"><a
			class="nav-link fas fa-user-cog" href="/member/myPage">Detail</a></li>
		<li class="nav-item col-sm-6" id="side_item"><a
			class="nav-link fas fa-sign-out-alt" href="/logout">Logout</a></li>
		<li class="nav-item col-sm-12" id="side_item"><a
			class="nav-link fas fa-star" href="/exhibition/favoriteList">즐겨찾기</a></li>	
		<li class="nav-item col-sm-12" id="side_item"><a
			class="nav-link fas fa-eye" href="/exhibition/recentlyView">최근본상품</a><div></div></li>
			<input id="userid" type="hidden" value='<sec:authentication property="principal.Username"/>'>
				<li class="nav-item dropdown">
					<a class="nav-link" id="dLabel" role="button" data-toggle="dropdown" data-target="#"
						href="/page.html"> 
						<i class="fas fa-bell"></i>알림
						<span class="label label-warning" style="color:white">0</span>
					</a>
					<ul class="dropdown-menu notifications" role="menu"
						aria-labelledby="dLabel" style="left: -200px; position: absolute;">

						<div class="notification-heading">
							<h2 class="tm-block-title" style="margin-bottom: 0px;">알림</h2>
						</div>
						<li class="divider"></li>

						<div id="notifications-current" class="notifications-wrapper">
						</div>
						
						<div id="notifications-past" class="notifications-wrapper" style="display: none">
						</div>
						
						<li class="divider"></li>
						<div class="notification-footer">
							<p id="change-notice" class="notice-current" style="float: right; cursor: pointer; margin: 0">지난 알림보기</p>
						</div>
					</ul>
			</li>		
		</sec:authorize>
		<sec:authorize access="isAnonymous()">
		<li class="nav-item col-sm-6" id="side_item"><a
			class="nav-link fas fa-user-plus" href="/member/joinForm">Sign Up</a></li>
		<li class="nav-item col-sm-6" id="side_item"><a
			class="nav-link fas fa-sign-in-alt" href="/member/loginForm">Login</a></li>
		</sec:authorize>
	</ul>
</div>
</div>
<div class="container"></div>
<nav class="navbar navbar-collapse" id="myNavbar">
	<ul class="nav navbar-nav navbar-right">
		<li><a href="#">introduce</a></li>
		<li><a href="#">infomation</a></li>
		<li><a href="#">help</a></li>
		<li><a href="#">sitemap</a></li>
	</ul>
	<div id="plusfriend-addfriend-button"></div>
	<div id="plusfriend-chat-button"></div>
</nav>
<p class="text-muted text-center">s
	<small>The page and links are prepared for ready. it`s not
		along be there:</small>
</p>



