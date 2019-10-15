<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal" var="pinfo" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap import -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- 추가 import -->
<script src="https://kit.fontawesome.com/1e1a69f988.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="/resources/js/reply2.js"></script>
<script type="text/javascript" src="/resources/js/favorite.js"></script>
<script type="text/javascript"src=" //dapi.kakao.com/v2/maps/sdk.js?appkey=f2ce3ae8264eed849df9ea6f9ad313b9&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/contents.css">
<link rel="stylesheet" type="text/css" href="/resources/css/respond.css">
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/js/slick.min.js"></script>
<script type="text/javascript" src="/resources/js/common_ui.js"></script>
<script type="text/javascript" src="/resources/js/common_fn.js"></script>
<script type="text/javascript" src="/resources/js/calendar.js"></script>
<script type="text/javascript" src="/resources/js/layout.js"></script>
<script type="text/javascript" src="/resources/js/sockjs.js"></script>
<script type="text/javascript" src="/resources/js/stomp.js"></script>
<script>
// function connect(){
	
// 	var ws = new WebSocket("ws://localhost:8081/replyEcho?bno=1234");
	
// 	ws.onopen = function(){
// 		console.log('Info.connection opened');
// // 		setTimeout(function(){connect(); },1000);
		
// 	};
	
// 	ws.onmessage = function(event){
// 		console.log(event.data+'\n');
// 	};
	
// 	ws.onclose = function(event){
// 		console.log('Info:connection closed.');
// 		//setTimeout(function(){connect(); },1000);
// 	};
// 	ws.onerror = function(err) {console.log('Errror:, err');};
	
// }
// $('#btnSend').on('click',function(evt){
// 	evt.preventDefault();
// 	if(socket.readyState!==1) return;
// 		let msg = $('input#msg').val();
// 		ws.send(msg);
	
// });
</script>
<style>
.star {
	color: #ffae00;
}
.article_writer {
    position: relative;
    clear: both;
    padding: 8px 8px 9px 17px;
    margin-bottom: 20px;
    z-index: 11;
</style>
<script>
/*
$(function(){
	connect();
});
var sock;
var stompClient;
function connect(){
	console.log("연결됨.");
	sock = new SockJS("/chat");
	stompClient = Stomp.over(sock);
	stompClient.connect({}, function(){
		
		stompClient.subscribe("/category/msg/id1", function(message){
			console.log("message: "+JSON.stringify(message));
			console.log("message: "+message.body);
			alert(message.body);
		});
	});
}
*/
</script>
</head>
<body>

<div>
	<h1 class="font-weight-bold">
		<a href="/"><img class="mx-auto d-block"
			src="https://trello-attachments.s3.amazonaws.com/5d6613e9716d6e23f5e579bb/312x140/3f52467f9d01dd9ce0a0f28eacece66e/%EB%A1%9C%EA%B3%A0.png"
			alt="Cinque Terre"></a>
	</h1>
</div>

<div class="row">

	<div class="col-sm-2 text-center" style="padding: 10px;">
		<nav class="navbar">
			<ul class="navbar-nav">
				<li class="nav-item">
					<h2>Menu <i class="fas fa-align-left"></i></h2></li>
				<li class="nav-item"><a class="nav-link" href="#exhiSubmenu" data-toggle="collapse" aria-expanded="false">전시회/공연</a>
					<ul class="collapse list-unstyled" id="exhiSubmenu">
                        <li>
                            <a href="/exhibition">전시&amp;공연</a>
                        </li>
                        <li>
                            <a href="/exhibition/mapList">전시회_지도</a>
                        </li>
                        <li>
                            <a href="#">박람회</a>
                        </li>
                    </ul>
				</li>
				<li class="nav-item"><a class="nav-link" href="#commSubmenu" data-toggle="collapse" aria-expanded="false">커뮤니티</a>
					<ul class="collapse list-unstyled" id="commSubmenu">
                        <li>
                            <a href="/notice/noticeList">공지사항</a>
                        </li>
                        <li>
                            <a href="/faq/faqList">FAQ</a>
                        </li>
                        <li>
                            <a href="/qna/qnaListForUser?memId=">Q&amp;A</a>
                        </li>
                        <li>
                            <a href="/report/reportList">신고게시판</a>
                        </li>
                        <li>
                            <a href="/board/freeboard">자유게시판</a>
                        </li>
                        <li>
                            <a href="/review/reviewboard">관람후기</a>
                        </li>
                        <li>
                            <a href="/recommend/recommendboard">홍보게시판</a>
                        </li>
                    </ul>
				</li>
				<li class="nav-item"><a class="nav-link" href="#FundSubMenu" data-toggle="collapse" aria-expanded="false">펀딩</a>
					<ul class="collapse list-unstyled" id="FundSubMenu">
                        <li>
                            <a href="/funding/list">크라우드펀딩</a>
                        </li>
					</ul>
				</li>
				<li class="nav-item"><div id="plusfriend-addfriend-button"></div></li>
			</ul>
		</nav>
	</div>
	
	<div class="col-sm-8">