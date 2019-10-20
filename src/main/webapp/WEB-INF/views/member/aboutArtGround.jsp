<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/menu.jsp" %>    
<%@ include file="../layout/rightUser.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화랑 - 화랑안내</title>
<style type="text/css">
.about-div{
	margin: 5% 20% 5% 20%;
	width: 100%;
	height: 500px;
}
.div1{
	display: inline-block;
	position: relative;
	height: 500px;
}
.div2{
	display: inline-block;
	position: relative;
	float: right;
}
</style>
</head>
<body>
<div class="about-div container">
	<div class="div1">
		<br><br><br><br><br><br>
		일상에 지친 우리에게 기분전환을 위한 취미생활이 필요하다 !<br>
		내 취향을 저격할 만한 전시, 공연을  <br>
		쭉~ 뽑아주는 홈페이지는 없을까?	<br>
		에서 시작한 저희는 전시와 공연을 볼 수 있는 홈페이지를 만들었습니다.<br>
		메뉴바에 화랑을 누르시면 분야별,지역별 또는 지도를 이용한 전시와 공연 장소를 알 수 있습니다.<br>
		예매를 하셔서 관람후기 작성을 하며 커뮤니티를 이용한 사용자의 편리성을 보장하고 <br>
		크라우드 펀딩을 이용해 참여하실 수 있습니다. <br>
		개발자 : 김창영, 신종민, 안지현, 이혜지, 한재근
	</div>
	<div class="div2">
		<img src="/resources/img/bg.png" class="rounded-circle" width="500px" height="500px">
	</div>
</div>
<%@ include file="../layout/bottom.jsp" %>
</body>
</html>