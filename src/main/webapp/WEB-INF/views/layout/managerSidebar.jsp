<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@page import="java.security.Principal"%>
<sec:authentication property="principal" var="pinfo" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/manager/fontastic.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/manager/style.default.css">
<link rel="stylesheet" href="/resources/css/manager/managerSidebar.css">
<script src="https://kit.fontawesome.com/1e1a69f988.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="/resources/js/sockjs.js"></script>
<script src="/resources/js/stomp.js"></script>
<script>
$(function(){
	//websocket connect
	connect();
	
	//dropdown
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
		
		//차단 개수 가져오기
		$.ajax({
			url: "/block/unCheckBlocks",
			type: "get",
			dataType: "json",
			success: function(result){
				var blockCnt = result;
				$(".blockCnt").text(blockCnt);
			}
		});
		
		var unReadCnt = 0;
		//안 읽은 알람 갯수 불러오기
		$.ajax({
			url: "/alarm/unReadCnt",
			type: "get",
			dataType: "json",
			success: function(result){
				unReadCnt = result;
// 				alert(result);
				$("#alCnt").text(unReadCnt);
				$(".alCnt").text(unReadCnt);
			},
			error: function(){
				alert("unReadCnt ajax 불러오기 에러");
			}
		});
		
		//기존 안 읽은 알람 4개 불러오기
		$.ajax({
			url: "/alarm/unReadAlarms",
			type: "get",
			dataType: "json",
			success: function(data){
				console.log("data: "+data);
				for(var i in data){
					var url = data[i].url;
					var category = data[i].category;
					var subCategory = data[i].subCategory;
					var num = data[i].alarm.num;
	//		 		alert(boardNum);
					var msg = "새로운 "+category+"_"+subCategory+"이 등록되었습니다.";
	//		 		alert(msg);
					var li = "<li id='notification-item'><a href='"+url+"' class='link dropdown-item' data-num='"+num+"'><div class='notification'><div class='notification-content'><i class='fa fa-envelope bg-violet'></i>"+msg+"</div></div></a></li>";
					$("#alarmlist").append(li);
				}
				var li = "<li id='notification-item'><a href='/alarm/alarmList' class='dropdown-item'><div class='notification'><div class='notification-content'><i class='fa fa-inbox bg-orange'></i>Alarm Box</div></div></a></li>";
				$("#alarmlist").append(li);
			},
			error: function(){
				alert("알람리스트 불러오기 ajax 에러");
			}
		});
		
	}); //onload() End
	
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
				addMsg(JSON.parse(message.body));
// 				alert(message.body);
			});
		})
	}
	
	function addMsg(message){
		var unReadCnt = Number($("#alCnt").text());
		unReadCnt += 1;
// 		alert("안읽은 알람갯수: "+unReadCnt);
		var blinky = 0;
		$("#alCnt").text(unReadCnt);
		blinky = setInterval(function(){
			$(".blinky").toggle();
		}, 300);
		var url = message.url;
		var category = message.category;
		var subCategory = message.subCategory;
		var num = message.alarm.num;
// 		alert(boardNum);
		var msg = "새로운 "+category+"_"+subCategory+"이 등록되었습니다.";
// 		alert(msg);
		var li = "<li id='notification-item'><a href='"+url+"' class='link dropdown-item' data-num='"+num+"' style='background-color: #DADCE1;'><div class='notification'><div class='notification-content'><i class='fa fa-envelope bg-violet'></i>"+msg+"</div></div></a></li>";
		$("#alarmlist").prepend(li);
		
		$(".link").on("click", function(){
			$.ajax({
				url: "/alarm/alarmCheck",
				type: "post",  
				data: {"num": num},
				success: function(result){
					if(result){
						alert("알림 확인");
					}
				},
				error: function(result){
					alert("알람 확인 에러");
				}
			});
		});
		
		$("#notifications").on("click", function(){
			clearInterval(blinky);
			$(".blinky").show();
		});
		
	}
	
</script>
</head>
<body>
<div class="page-wrapper chiller-theme toggled">
      <!-- Main Navbar-->
      <header class="header">
        <nav class="navbar fixed-top" style="background-color: #ffffff; height: 80px; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1), -1px 0 2px rgba(0, 0, 0, 0.05); z-index: 1">
          <div class="container-fluid">
            <div class="navbar-holder d-flex align-items-center justify-content-between">
              <!-- Navbar Header-->
              <div class="navbar-header">
                <!-- Navbar Brand 
                <a href="/admin/main" class="navbar-brand d-none d-sm-inline-block">
                  <div class="brand-text d-none d-lg-inline-block" style="font-weight: 1000;"><span>Hwarang&nbsp; </span><strong>Artground</strong></div>
                  <div class="brand-text d-none d-sm-inline-block d-lg-none"><strong>HD</strong></div>
                </a>-->
                <a href="/">
                	<img class="header_img maintitle" src="/resources/img/logop2.png" height="58px;">
                	<img class="header_img maintitle" src="/resources/img/logohr.png" alt="Cinque Terre" height="58px;">
				</a>
                <!-- Toggle Button-->
                <a id="toggle-btn" href="#" class="menu-btn active"><span></span><span></span><span></span></a>
              </div>
              <!-- Navbar Menu -->
              <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                <!-- Notifications-->
                <li class="nav-item dropdown"> <a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-bell-o fa-lg"></i><span class="badge badge-danger badge-corner blinky" id="alCnt"></span></a>
                  <ul id="alarmlist" aria-labelledby="notifications" class="dropdown-menu">
                  	<!-- 
                    <li id="notification-item">
                    	<a rel="nofollow" href="/alarm/alarmList" class="dropdown-item"> 
	                        <div class="notification">
	                          <div class="notification-content"><i class="fa fa-inbox bg-orange"></i>Alarm Box</div>
	                        </div>
                        </a>
                    </li>
                     -->
                  </ul>
                </li>
                <!-- Logout    -->
                <li class="nav-item"><a href="/logout" class="nav-link logout"><span class="d-none d-sm-inline">Logout</span><i class="fa fa-sign-out fa-lg"></i></a></li>
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
	        <a href="/admin/main"><strong>ADMIN PAGE</strong></a>
	        <div id="close-sidebar">
	          <i class="fas fa-times"></i>
	        </div>
	      </div>
	      <div class="sidebar-header">
	        <div class="user-info">
	          <span class="user-name"> <!-- 아이디 불러오기 -->
	            <strong>${memName}님 (${memId })</strong>
	          </span>
	          <span class="user-role">Administrator</span>
	          <span class="user-status">
	            <i class="fa fa-circle"></i>
	            <span>Online</span> <!-- 온라인 상태 확인 -->
	          </span>
	        </div>
	      </div>
	      <!-- sidebar-header  -->
	      <div class="sidebar-menu">
	        <ul>
	          <li class="header-menu">
	            <span>Settings</span>
	          </li>
	          <li class="sidebar-dropdown">
	            <a href="#">
	              <i class="fas fa-cog"></i>
	              <span><strong>Board Management</strong></span>
	            </a>
	            <div class="sidebar-submenu">
	              <ul>
	                <li>
	                  <a href="/notice/noticeListForManager">Notice Board<span class="badge badge-pill badge-warning">New</span>
	                  </a>
	                </li>
	                <li>
	                  <a href="/faq/faqListForManager">FAQ Board</a>
	                </li>
	                <li>
	                  <a href="/qna/qnaListForManager">Q&amp;A Board </a>
	                </li>
	                <li>
	                  <a href="/report/reportListForManager">Report Board</a>
	                </li>
	                <li>
	                  <a href="/block/blockListForManager">Block Status <span class="badge badge-pill badge-danger blockCnt"></span>
	                  </a>
	                </li>
	                 <li>
	                  <a href="/alarm/alarmList">Alarm Box<span class="badge badge-pill badge-success alCnt"></span></a>
	                </li>
	              </ul>
	            </div>
	          </li>
	          <li class="sidebar-dropdown">
	            <a href="#">
	              <i class="fa fa-users"></i>
	              <span><strong>Member</strong></span>
	<!--               <span class="badge badge-pill badge-danger">3</span> -->
	            </a>
	            <div class="sidebar-submenu active">
	              <ul>
	                <li>
	                  <a href="/admin/memberList">All Members</a>
	                </li>
	                <li>
	                  <a href="/admin/memberAuth">Authorization Settings</a>
	                </li>
	              </ul>
	            </div>
	          </li>
	        </ul>
	        <ul>
        	  <li class="header-menu">
          		<span>General</span>
              </li>
              <li class="sidebar-dropdown">
	            <a href="#">
	              <i class="fa fa-clipboard"></i>
	              <span><strong>Boards</strong></span>
	<!--               <span class="badge badge-pill badge-danger">3</span> -->
	            </a>
	            <div class="sidebar-submenu"  style="display: none;">
	              <ul>
	                <li>
	                  <a href="/exhibition">Exhibition</a>
	                </li>
	                <li>
	                  <a href="/report/reportList">Report Board</a>
	                </li>
	                <li>
	                  <a href="/board/freeboard">Free Board</a>
	                </li>
	                <li>
	                  <a href="/review/reviewboard">Review Board</a>
	                </li>
	                <li>
	                  <a href="/recommend/recommendboard">Recommend Board</a>
	                </li>
	                <li>
	                  <a href="/funding/fundingList">Funding Board</a>
	                </li>
	              </ul>
	            </div>
	          </li>
	        </ul>
	      </div>
	    </div>
	    <!-- sidebar-content  -->
	  </nav>