<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<sec:authentication property="principal" var="pinfo" />
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
<script src="/resources/js/sockjs.js"></script>
<script src="/resources/js/stomp.js"></script>
<!-- menu css -->
<!-- <link href="http://www.blueb.co.kr/data/201010/IJ12873478039948/style.css" media="all" rel="stylesheet" type="text/css" /> -->
<!-- font -->
<!-- <link href="https://fonts.googleapis.com/css?family=Prompt:400,500,700" rel="stylesheet"> -->
<!-- kakao login -->
<script>
$(document).ready(function(){
	$(document).on('mouseover', '.topMenu span', function() {
	    $('.dept01').slideDown(400);
	});
	$(document).on('mouseover', 'div', function () {
	    if (!$(this).hasClass('topMenu')) {
	        $('.dept01').slideUp(400);
	    }
	});
});
</script>
<style>
@font-face { font-family: 'GyeonggiBatang'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/GyeonggiBatang.woff') format('woff'); font-weight: normal; font-style: normal; }
*{
	/* font-family: 'Arita-dotum-Medium'; */
	font-family: 'GyeonggiBatang';
}
.topMenu {width: 100%; margin-bottom: 20px; text-align: center; height: 40px; z-index: 8; margin-left: 30%;}
.topMenu:after {content: ""; display: block; clear: both; }
.menu01>li {float: left; width: 160px; line-height: 40px;}
.topMenu li {list-style: none;}
.menu01 span {font-size: 25px; font-weight: bold; }            
.dept01 {display: none; padding: 20px 0;  position: relative; font-size: 20px; font-weight: bold;}            
#nop {float: none;}     
.none:after {content: ""; display: block; clear: both; width: 100%; height: 1px;}
.nono{ display: block; width: 100%;height: 1px;}
.header-div{
	font-family: 'GyeonggiBatang';
	padding-left: 42%;
	padding-top: 10px;
	margin: 0 auto;
	border: 1px solid none;
}
.header-title{
	display: block;
	padding-top: 10px;
}
.header-login{
	padding-top: 50px;
	justify-content: flex-end;
	margin-left: 300px;
}
.header-menu{
	display: flex;
	border-bottom: 1px solid nono;
	font-family: 'Arita-dotum-Medium';
	padding-left: 33%;
	margin-left: 15px;
	font-size: 20px;
}
.pagination, .page-item a {
	color: #5C5A5C ;
	font-weight: normal ;
}

.pagination li.active a{
	color: #5C5A5C ;
	background-color: #E1DAD2;
	font-weight: bold;
}
.dropdown-item:hover {
	background-color: #E1DAD2;
}

</style>
</head>
<body>
	<header>
		<div class='header-div'>
			<div class='header-title'>
				<h1>
					<a href="/"><img class="header_img maintitle"
						src="https://trello-attachments.s3.amazonaws.com/5d6613e9716d6e23f5e579bb/312x140/3f52467f9d01dd9ce0a0f28eacece66e/%EB%A1%9C%EA%B3%A0.png"
						alt="Cinque Terre"></a>
				</h1>
			</div>
		</div> 
				<div class="container bootstrap snippet" style="text-align: center; padding-left: 3%;">
					<div class="row">
						<div class="col-lg-12">
							<div class="ibox float-e-margins">
								<div class="ibox-content">
									<h2>
										<span class="text-navy"></span>
									</h2>
									<div class="search-form">
										<form id="searchList" action="/layout/searchList" method="get">
											<input type="text" name="key" placeholder="검색어를 입력하세요"
												value="<c:out value="${param.key}"/>" /> <input
												type="hidden" name="pageNum"
												value="<c:out value="${pageMaker.cri.pageNum}"/>" /> <input
												type="hidden" name="amount"
												value="<c:out value="${pageMaker.cri.amount}"/>" />
											<button class="btn btn-default">검색</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
		<div class="topMenu">
            <ul class="menu01">
                <li><span>이용안내</span>
                    <ul class="dept01">
                        <li id="nop"><a href="/member/about">화랑안내</a></li>
                        <li id="nop"><a href="/notice/noticeList">공지사항</a></li>
                        <li id="nop"><a href="/faq/faqList">FAQ</a></li>
                    </ul>
                </li>
                <li><span>화랑</span>
                    <ul class="dept01">
                        <li id="nop"><a href="/exhibition">공연·전시</a></li>
                        <li id="nop"><a href="/exhibition/mapList">공연 위치 지도</a></li>
                        <li id="nop">&nbsp;</li>
                    </ul>
                </li>
                <li><a href="/review/reviewboard"><span>관람후기</span></a>
                	<ul class="dept01">
                        <li id="nop">&nbsp;</li>
                        <li id="nop">&nbsp;</li>
                        <li id="nop">&nbsp;</li>
                    </ul>
                </li>
                <li><span>커뮤니티</span>
                    <ul class="dept01">
                        <li id="nop"><a href="/board/freeboard">자유게시판</a></li>
                        <li id="nop"><a href="/recommend/recommendboard">홍보게시판</a></li>
                        <li id="nop"><a href="/report/reportList">신고</a></li>
                    </ul>
                </li>
                <li><a href="/funding/list"><span>&nbsp;&nbsp;크라우드펀딩</span></a>
                	<ul class="dept01">
                        <li id="nop">&nbsp;</li>
                        <li id="nop">&nbsp;</li>
                        <li id="nop">&nbsp;</li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="none">
        </div>
</header>

