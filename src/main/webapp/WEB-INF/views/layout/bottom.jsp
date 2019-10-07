<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</div>
<div class="col-sm-2" style="padding: 0px;">
	<ul class="nav ">
		<li class="nav-item col-sm-12 alert alert-danger" id="side_item">
			<a class="nav-link" href="#"> 멤버 페이지</a>
		</li>
		<sec:authorize access="isAuthenticated()">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		<li class="nav-item col-sm-6" id="side_item">
			<a	class="nav-link fas fa-user-cog" href="/admin/main">관리자</a>
		</li>
		</sec:authorize>
		<sec:authorize access="!hasRole('ROLE_ADMIN')">
		<li class="nav-item col-sm-6" id="side_item">
			<a	class="nav-link fas fa-user-cog" href="/member/myPage">Detail</a>
		</li>
		</sec:authorize>
		<li class="nav-item col-sm-6" id="side_item"><a
			class="nav-link fas fa-sign-out-alt" href="/logout">Logout</a></li>
		<li class="nav-item col-sm-12" id="side_item"><a
			class="nav-link fas fa-star" href="/exhibition/favoriteList">즐겨찾기</a></li>	
		<li class="nav-item col-sm-12" id="side_item"><a
			class="nav-link fas fa-eye" href="/exhibition/recentlyView">최근본상품</a><div></div></li>
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
<p class="text-muted text-center">
	<small>The page and links are prepared for ready. it`s not
		along be there:</small>
</p>

</body>
</html>