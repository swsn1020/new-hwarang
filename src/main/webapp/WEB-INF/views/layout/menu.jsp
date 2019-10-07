<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- 추가 import -->
<script src="https://kit.fontawesome.com/1e1a69f988.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="/resources/js/reply2.js"></script>
<script type="text/javascript" src="/resources/js/favorite.js"></script>
<script type="text/javascript"
	src=" //dapi.kakao.com/v2/maps/sdk.js?appkey=f2ce3ae8264eed849df9ea6f9ad313b9&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/contents.css">
<link rel="stylesheet" type="text/css" href="/resources/css/respond.css">
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/js/slick.min.js"></script>
<script type="text/javascript" src="/resources/js/common_ui.js"></script>
<script type="text/javascript" src="/resources/js/common_fn.js"></script>
<script type="text/javascript" src="/resources/js/calendar.js"></script>
<script type="text/javascript" src="/resources/js/layout.js"></script>
<style>
.header{
	text-align: center;
}
.header_menu{
	font-size: x-large;
	padding-left: 45%;
	padding-right: 45%;
}
</style>
</head>
<body>
	<header class='header'>
		<div>
			<h1 class="header_img">
				<a href="/"><img class="header_img title"
					src="https://trello-attachments.s3.amazonaws.com/5d6613e9716d6e23f5e579bb/312x140/3f52467f9d01dd9ce0a0f28eacece66e/%EB%A1%9C%EA%B3%A0.png"
					alt="Cinque Terre"></a>
			</h1>
		</div>
		<div class="header_menu">
			<nav class="navbar navbar-expand-sm">
				<div class="collapse navbar-collapse" id="navbarsExample03">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown03"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">이용안내</a>
							<div class="dropdown-menu" aria-labelledby="dropdown03">
								<a class="dropdown-item" href="#">화랑안내</a> 
								<a class="dropdown-item" href="/notice/noticeList">공지사항</a> 
								<a class="dropdown-item" href="/faq/faqList">FAQ</a>
								<a class="dropdown-item" href="/qna/qnaListForUser?memId=haddie">Q&amp;A</a>
								<a class="dropdown-item" href="/report/reportList">신고</a>
							</div>
						</li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown03"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">공연·전시</a>
							<div class="dropdown-menu" aria-labelledby="dropdown03">
								<a class="dropdown-item" href="/exhibition/mapList">네비게이션</a>
							</div>
						</li>
						<li class="nav-item">
        					<a class="nav-link" href="#">관람&amp;후기</a>
        				</li>
        				<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown03"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">커뮤니티</a>
							<div class="dropdown-menu" aria-labelledby="dropdown03">
								<a class="dropdown-item" href="/recommend/recommendboard">홍보</a>
							</div>
						</li>
        				<li class="nav-item">
        					<a class="nav-link" href="#">크라우드&amp;펀딩</a>
        				</li>
					</ul>
				</div>

			</nav>
		</div>

	</header>
	<!-- 

<div class="row">

	
	<div class="col-sm-8"> -->