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
<p class="text-muted text-center">
	<small>The page and links are prepared for ready. it`s not
		along be there:</small>
</p>

</body>
</html>