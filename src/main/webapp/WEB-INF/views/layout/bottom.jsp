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
</div>
<div class="container"></div>
<br>
<br>
<nav class="navbar navbar-collapse" id="myNavbar">
	<div id="plusfriend-addfriend-button"></div>	
	<table>
		<tr>
			<td><p><a href="#">introduce</a>&nbsp;&nbsp;|&nbsp;&nbsp;</p></td>
			<td><p><a href="#">infomation</a>&nbsp;&nbsp;|&nbsp;&nbsp;</p></td>
			<td><p><a href="#">help</a>&nbsp;&nbsp;|&nbsp;&nbsp;</p></td>
			<td><p><a href="#">sitemap</a></p></td>
		</tr>
	</table>

	<div id="plusfriend-chat-button"></div>
</nav>
<p class="text-muted text-center">
	<small>HWARANG by ⓒArt Ground </small>
</p>



