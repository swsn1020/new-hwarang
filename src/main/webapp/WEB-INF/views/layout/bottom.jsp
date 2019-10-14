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
<<<<<<< HEAD
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
=======
>>>>>>> refs/remotes/origin/master
<div class="container"></div>
<nav class="navbar navbar-collapse" id="myNavbar">
	<ul class="nav navbar-nav navbar-right">
		<li><a href="#">introduce</a></li>
		<li><a href="#">infomation</a></li>
		<li><a href="#">help</a></li>
		<li><a href="#">sitemap</a></li>
		<li>
		<div id="plusfriend-addfriend-button"></div>		
		</li>
	</ul>
	<div id="plusfriend-chat-button"></div>
</nav>
<p class="text-muted text-center">s
	<small>The page and links are prepared for ready. it`s not
		along be there:</small>
</p>



