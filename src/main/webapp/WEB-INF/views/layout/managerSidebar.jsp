<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal" var="pinfo" />
<!DOCTYPE html>
<html lang="en">
<script src="https://kit.fontawesome.com/1e1a69f988.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
        crossorigin="anonymous">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/manager/fontastic.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <link rel="stylesheet" href="/resources/css/manager/font-awesome.css"> -->
<link rel="stylesheet" href="/resources/css/manager/style.default.css">
<link rel="stylesheet" href="/resources/css/manager/managerSidebar.css">
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
</head>
<body>
<div class="page-wrapper chiller-theme toggled">
      <!-- Main Navbar-->
      <header class="header">
        <nav class="navbar fixed-top" style="background-color: #ffffff; height: 70px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1), -1px 0 2px rgba(0, 0, 0, 0.05); z-index: 1">
          <div class="container-fluid">
            <div class="navbar-holder d-flex align-items-center justify-content-between">
              <!-- Navbar Header-->
              <div class="navbar-header">
                <!-- Navbar Brand -->
                <a href="/admin/main" class="navbar-brand d-none d-sm-inline-block">
                  <div class="brand-text d-none d-lg-inline-block"><span>Hwarang&nbsp; </span><strong>Artground</strong></div>
                  <div class="brand-text d-none d-sm-inline-block d-lg-none"><strong>HD</strong></div>
                </a>
                <!-- Toggle Button-->
                <a id="toggle-btn" href="#" class="menu-btn active"><span></span><span></span><span></span></a>
              </div>
              <!-- Navbar Menu -->
              <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                <!-- Notifications-->
                <li class="nav-item dropdown"> <a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-bell-o fa-lg"></i><span class="badge bg-red badge-corner">12</span></a>
                  <ul aria-labelledby="notifications" class="dropdown-menu">
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-envelope bg-green"></i>You have 6 new messages </div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-twitter bg-blue"></i>You have 2 followers</div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-upload bg-orange"></i>Server Rebooted</div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-twitter bg-blue"></i>You have 2 followers</div>
                          <div class="notification-time"><small>10 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item all-notifications text-center"> <strong>view all notifications                                            </strong></a></li>
                  </ul>
                </li>
                <!-- Logout    -->
                <li class="nav-item"><a href="login.html" class="nav-link logout"> <span class="d-none d-sm-inline">Logout</span><i class="fa fa-sign-out fa-lg"></i></a></li>
              </ul>
            </div>
          </div>
        </nav>
      </header>
	<div class="page-content d-flex align-items-stretch"  style="background-color: #F3F4F5; z-index: -1">
	  <a id="show-sidebar" class="btn btn-primary" href="#">
	    <i class="fas fa-bars" style="color: black;"></i>
	  </a>
	  <nav id="sidebar" class="sidebar-wrapper" style="box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1), -1px 0 2px rgba(0, 0, 0, 0.05);">
	    <div class="sidebar-content">
	      <div class="sidebar-brand">
	        <a href="#">sidebar</a>
	        <div id="close-sidebar">
	          <i class="fas fa-times"></i>
	        </div>
	      </div>
	      <div class="sidebar-header">
	        <div class="user-info">
	          <span class="user-name">${memName } <!-- 아이디 불러오기 -->
	            <strong>(${memId })</strong>
	          </span>
	          <span class="user-role">Administrator</span>
	          <span class="user-status">
	            <i class="fa fa-circle"></i>
	            <span>Online</span> <!-- 온라인 상태 확인 -->
	          </span>
	        </div>
	      </div>
	      <!-- sidebar-header  -->
	      <!-- 
	      <div class="sidebar-search">
	        <div>
	          <div class="input-group">
	            <input type="text" class="form-control search-menu" placeholder="Search...">
	            <div class="input-group-append">
	              <span class="input-group-text">
	                <i class="fa fa-search" aria-hidden="true"></i>
	              </span>
	            </div>
	          </div>
	        </div>
	      </div>
	      <!-- sidebar-search  -->
	      <div class="sidebar-menu">
	        <ul>
	          <li class="header-menu">
	            <span>Settings</span>
	          </li>
	          <li class="sidebar-dropdown">
	            <a href="#">
	              <i class="fas fa-clipboard"></i>
	              <span><strong>Boards</strong></span>
	<!--                   'Pro'아이콘 -->
	<!--                     <span class="badge badge-pill badge-success">Pro</span> -->
	            </a>
	            <div class="sidebar-submenu">
	              <ul>
	                <li>
	                  <a href="/notice/noticeList">Notice Board <span class="badge badge-pill badge-warning">New</span>
	                  </a>
	                </li>
	                <li>
	                  <a href="/report/reportList">Report Board</a>
	                </li>
	                <li>
	                  <a href="/qna/qnaList">Q&amp;A Board</a>
	                </li>
	                <li>
	                  <a href="/faq/faqList">FAQ Board</a>
	                </li>
	                <li>
	                  <a href="/free/freeboard">Free Board</a>
	                </li>
	                <li>
	                  <a href="/exhibition">Exhibition</a>
	                </li>
	                <li>
	                  <a href="/review/reviewboard">Review Board</a>
	                </li>
	                <li>
	                  <a href="/recommend/recommendboard">Recommend Board</a>
	                </li>
	              </ul>
	            </div>
	          </li>
	          <li class="sidebar-dropdown">
	            <a href="#">
	              <i class="fa fa-users"></i>
	              <span><strong>Members</strong></span>
	<!--               <span class="badge badge-pill badge-danger">3</span> -->
	            </a>
	            <div class="sidebar-submenu active">
	              <ul>
	                <li>
	                  <a href="/admin/memberList">All Members</a>
	                </li>
	                <li>
	                  <a href="#">Authorization Settings</a>
	                </li>
	                <li>
	                  <a href="/block/blockListForManager">Block Status <span class="badge badge-pill badge-danger">${blockCnt }</span>
	                  </a>
	                </li>
	              </ul>
	            </div>
	          </li>
	          <li class="sidebar-dropdown">
	            <a href="#">
	              <i class="far fa-gem"></i>
	              <span>Components</span>
	            </a>
	            <div class="sidebar-submenu">
	              <ul>
	                <li>
	                  <a href="#">General</a>
	                </li>
	                <li>
	                  <a href="#">Panels</a>
	                </li>
	              </ul>
	            </div>
	          </li>
	        </ul>
	      </div>
	    </div>
	    <!-- sidebar-content  
	    <div class="sidebar-footer">
	      <a href="#">
	        <i class="fa fa-bell"></i>&nbsp;
	        <span class="badge badge-pill badge-warning notification">3</span>
	      </a>
	      <a href="#">
	        <i class="fa fa-envelope"></i>&nbsp;
	        <span class="badge badge-pill badge-success notification">7</span>
	      </a>
	      <a href="#">
	        <i class="fa fa-cog"></i>&nbsp;
	        <span class="badge-sonar"></span>
	      </a>
	      <a href="#">
	        <i class="fa fa-power-off"></i>&nbsp;
	      </a>
	    </div>
	    -->
	  </nav>