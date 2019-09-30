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

<!-- Custom css -->
<link href="/resources/css/logo-left.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/manager/fontastic.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- 달력 -->
<link rel="stylesheet" type="text/css" href="/resources/css/contents.css">
<link rel="stylesheet" type="text/css" href="/resources/css/respond.css">
<style>
.star {
	color: #ffae00;
}

</style>

<!-- 추가 import -->
<script src="https://kit.fontawesome.com/1e1a69f988.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="/resources/js/reply2.js"></script>
<script type="text/javascript" src="/resources/js/favorite.js"></script>
<script type="text/javascript"src=" //dapi.kakao.com/v2/maps/sdk.js?appkey=f2ce3ae8264eed849df9ea6f9ad313b9&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/js/slick.min.js"></script>
<script type="text/javascript" src="/resources/js/common_ui.js"></script>
<script type="text/javascript" src="/resources/js/common_fn.js"></script>
<script type="text/javascript" src="/resources/js/calendar.js"></script>
<script type="text/javascript" src="/resources/js/layout.js"></script>
<script>
$(function(){
	$(".sidebar-dropdown > a").click(function() {
			$(".sidebar-submenu").slideUp(200);
			if ($(this).parent().hasClass("active")) {
				$(".sidebar-dropdown").removeClass("active");
				$(this).parent().removeClass("active");
			} else {
				$(".sidebar-dropdown").removeClass("active");
				$(this).next(".sidebar-submenu").slideDown(200);
				$(this).parent().addClass("active");
			}
		});

		$("#close-sidebar").click(function() {
			$(".page-wrapper").removeClass("toggled");
		});
		$("#show-sidebar").click(function() {
			$(".page-wrapper").addClass("toggled");
		});
		
	});
</script>
<style>
.content {
	padding: 16px;
	position: relative;
}

#navbar {
	overflow: hidden;
}
/* The sticky class is added to the navbar with JS when it reaches its scroll position */
.sticky {
	position: fixed;
	top: 0;
	width: 100%;
}
/* Add some top padding to the page content to prevent sudden quick movement (as the navigation bar gets a new position at the top of the page (position:fixed and top:0) */
.sticky+.content {
	padding-top: 100px;
}
</style>
</head>
<body>
	<!-- Hwarang Logo -->
	<div class="page-wrapper chiller-theme toggled">
		<h1>
			<a href="/"><img class="mx-auto d-block"
				src="https://trello-attachments.s3.amazonaws.com/5d6613e9716d6e23f5e579bb/312x140/3f52467f9d01dd9ce0a0f28eacece66e/%EB%A1%9C%EA%B3%A0.png"
				alt="Hwarang Logo"></a>
		</h1>
		
		<!-- Main Navbar-->
		<div id="navbar" style="z-index: 2">
        <nav class="navbar" >
            <div class="navbar-holder d-flex align-items-center justify-content-between" style="height: 60px;">
            	<!-- Navbar Header-->
              <div class="navbar-header">
              </div>
              <!-- Navbar Menu -->
              <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                <!-- Notifications-->
                <li class="nav-item dropdown"> <a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-user-cog fa-lg"></i><span class="d-none d-sm-inline">마이페이지</span></a>
                  <ul aria-labelledby="notifications" class="dropdown-menu">
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-envelope bg-green"></i>You have 6 new messages </div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div>
                        </a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-twitter bg-blue"></i>즐겨찾기</div>
                          <div class="notification-time"><small>몇개</small></div>
                        </div>
                        </a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item all-notifications text-center"><strong>Account Settings</strong></a></li>
                  </ul>
                </li>
                <!-- Logout    -->
                <li class="nav-item"><a href="login.html" class="nav-link logout"> <span class="d-none d-sm-inline">Login</span><i class="fa fa-sign-in fa-lg"></i></a></li>
                <!-- Logout    -->
                <li class="nav-item"><a href="login.html" class="nav-link logout"> <span class="d-none d-sm-inline">Logout</span><i class="fa fa-sign-out fa-lg"></i></a></li>
              </ul>
          </div>
        </nav>
       </div>
       <script>
			window.onscroll = function() {myFunction()};
			
			var navbar = document.getElementById("navbar");
			var sticky = navbar.offsetTop;
			
			function myFunction() {
			  if (window.pageYOffset >= sticky) {
			    navbar.classList.add("sticky")
			  } else {
			    navbar.classList.remove("sticky");
			  }
			}	
		</script>
	
	<div class="row content">
	<div class="col-sm-2 d-flex align-items-stretch">
		<a id="show-sidebar" class="btn" href="#">
	    	<i class="fas fa-bars"></i>
	  	</a>
		<nav id="sidebar" class="sidebar-wrapper">
			<div class="sidebar-content">
				<div class="sidebar-brand">
		        	<a href="#">MENU</a>
		        	<div id="close-sidebar">
		        	  <i class="fas fa-times"></i>
		        	</div>
		      	</div>
		      <div class="sidebar-menu">
				<ul>
					<li class="sidebar-dropdown"><a href="#"><i class="fa fa-tachometer-alt"></i><span>전시회/공연</span></a>
						<div class="sidebar-submenu">
							<ul>
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
	                    </div>
					</li>
					<li class="sidebar-dropdown"><a href="#"><i class="fa fa-tachometer-alt"></i><span>커뮤니티</span></a>
						<div class="sidebar-submenu">
							<ul>
		                        <li>
		                            <a href="/notice/noticeList">공지사항</a>
		                        </li>
		                        <li>
		                            <a href="/faq/faqList">FAQ</a>
		                        </li>
		                        <li>
		                            <a href="/qna/qnaListForUser?memId=haddie">Q&amp;A</a>
		                        </li>
		                        <li>
		                            <a href="/report/reportList">신고게시판</a>
		                        </li>
		                        <li>
		                            <a href="/free/freeboard">자유게시판</a>
		                        </li>
		                        <li>
		                            <a href="#">후기게시판</a>
		                        </li>
		                    </ul>
		                 </div>
					</li>
					<li class="sidebar-dropdown"><a href="#"><i class="fa fa-tachometer-alt"></i><span>펀딩</span></a>
						<div class="sidebar-submenu">
							<ul>
		                        <li>
		                            <a href="/funding/list">크라우드펀딩</a>
		                        </li>
							</ul>
						</div>
					</li>
				</ul>
		      	</div>
					<div class="sidebar-brand">
			        	<div id="plusfriend-addfriend-button"></div>
			        </div>
			</div>
			</nav>
		</div>
<!-- 	</div> -->
		
		<!-- 각자 내용 시작 -->
<div class="col-sm-8" style="margin-left: 30px; z-index: 1">
	<div class="align-items-center">
