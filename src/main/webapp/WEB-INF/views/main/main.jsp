<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<title>화 랑</title>
<%@include file="../layout/menu.jsp"%>
<%@include file="../layout/rightUser.jsp"%>
<script type="text/javascript">
	$(function() {
		document.domain = "localhost";
		var url = "/";
		window.opener.location.replace(url);
		window.close();
		tick2();
	});
	function tick2(){
		$('#ticker_02 li:first').slideUp( function () { $(this).appendTo($('#ticker_02')).slideDown(); });
	}
	setInterval(function(){ tick2 () }, 3000);
</script>
<style>
#div1 {
	display: inline-block;
	background-color: #fbf8f8;
	width: 100%;
	height: 700px;
	padding: 40px;
}
.carousel-inner{
	max-width: 100%;
	height: 100%;
}
.div1-img{
	left: 12%;
	display: inline-block;
	position: relative;
	max-width: 100%;
	height: 100%;
	padding-left: 200px;
}
.carousel-caption {
	position: relative;
	display: inline-block;
	z-index: 5;
	text-align: center;
	text-shadow: none !important;
	right: 0 !important;
	left: 15% !important;
	max-width: 500px;
	height: 400px;
	color: black;
	top: 50px;
}
.money_item .item .carousel-caption {
	left: 200px !important;
}
.money_item .item.active .carousel-caption {
	left: 200px !important;
}
.money_item .item.active.left .carousel-caption {
	left: 200px !important;
}
.div1-img-pattern{
	mex-width: 100%;
	height: 100%;
}
#div2{
	display: flex;
	position: relative;
	max-width: 100%;
	height: 700px;
	padding: 40px;
	text-align: center;
}
/* #div .row {
	display: inline-block;
	position: relative;
	padding-left: 90px;
	max-width: 100%;
	height: 100%
} */
.div2-img{
	display: inline-block;
	position: relative;
	max-width: 100%;
	width: inherit;
	height: 500px;
	margin-left: 50px;
}
.div2-img-top{
	max-width: 100%;
	height: 500px;
}
.div2-title{
	margin-left: 50px;
	font-weight: bold;
}
#div3{
	max-width: 100%;
	height: 500px;
	background-color: #f8fafc;
	padding: 0 15% 5% 15%;
}
.div3-div{
	max-width: 700px;
	height: 380px;
	background-color: white;
}
.exh-list{
    padding-right: 20%;
    padding-left: 20%;
}
#div3-div2{
	
}
.ticker {
	width: 500px;
	height: 40px;
	overflow: hidden;
	border: 1px solid #DDD;
	margin: 0;
	padding: 0;
	list-style: none;
	border-radius: 5px;
	box-shadow: 0px 0px 5px #DDD;
}

#ticker_02 {
	height: 250px;
}

.ticker li {
	height: 30px;
	border-bottom: 1px dotted #DDD;
	padding: 5px;
	margin: 0px 5px;
}
</style>
<!--  본문시작  -->
<div id="div1" class="carousel slide" data-ride="carousel">

	<!-- Indicators -->
	<ul class="carousel-indicators">
		<li data-target="#div1" data-slide-to="0" class="active"></li>
		<li data-target="#div1" data-slide-to="1"></li>
		<li data-target="#div1" data-slide-to="2"></li>
	</ul>

	<!-- The slideshow -->
	<div class="carousel-inner">
		<div class="carousel-item active">
				<a href="/exhibition/view?seq=154311"> 
					<img class="div1-img"
					alt="item image" role="img"
					src="http://www.culture.go.kr/upload/rdf/19/09/rdf_201909271124527236.gif">
				</a>
				<div class="carousel-caption">
					<h1>
						<a href="/exhibition/view?seq=154311"
							style="font-weight: bolder; font-size: xx-large;"> 
							한글의 날을 위한 전시</a>
					</h1>
					<br>
					<h2 style="font-weight: bold;">개관 5주년 국립한글박물관</h2>
					<br>
					<h4>기획특별전 '한글의 큰 스승'</h4>
					<h4>제3회 한글실험프로젝트 '한글디자인:형태의 전환'</h4>
					<h4>상설전시실 테마전 '한글 타자기 전성시대'</h4>
					<p>
				</div>
		</div>
		<div class="carousel-item">
				<a href="/exhibition/view?seq=153132"> <img id='img'
					class="div1-img" alt="item image" role="img"
					src="http://www.culture.go.kr/upload/rdf/19/08/show_2019082813544465163.jpg">
				</a>
				<div class="carousel-caption">
					<p class="card-title">
					<h2 style="font-weight: bold;">정오시간에 듣기 좋은 음악</h2>
					<br>
					<h1>
						<a href="/exhibition/view?seq=154311"
							style="font-weight: bold; font-size: xx-large;"> '정오의 음악회'</a>
					</h1>
					<p>
						<br>
					<h3>국립극장의 대표적인 스테디셀러 공연</h3>
					<br>
					<h5>한해도 빠지지 않고 공연되어 지금도 매회 만석을 기록하며 관객들의 사랑을 받고 있는 고품격 국악 브런치
						콘서트</h5>
				</div>
			</div>
		</div>
		<div class="carousel-item">
				<a href="/exhibition/view?seq=154323"> <img id='img'
					class="div1-img" alt="item image" role="img"
					src="http://www.culture.go.kr/upload/rdf/19/09/rdf_2019093022424023261.jpg">
				</a>
				<div class="carousel-caption">
					<p class="card-title">
					<h2>
						<a href="/exhibition/view?seq=154311" style="font-weight: bold;">
						공연 예술을 느끼고 싶다면</a>
					</h2>
					<p>
					<h1 style="font-weight: bold;">'스푸트니크'</h1>
					<br>
					<h5>누구도 어디에건 속해있지 않고 정착하지 못하는,<br>모두가 부유하고 흔들리는 풍경을 담다.</h5>
				</div>
		</div>
	<!-- Left and right controls -->
	<a class="carousel-control-prev" href="#div1" data-slide="prev"> 
	<img class='div1-img-pattern' src='/resources/img/pattern.jpg'> <span class="carousel-control-prev-icon"></span>
	</a> 
	<a class="carousel-control-next" href="#div1" data-slide="next"> 
	<img class='div1-img-pattern' src='/resources/img/pattern.jpg'> <span class="carousel-control-next-icon"></span>
	</a>
</div>

<div class="exh-list album py-5 bg-light">
		<h2 class='div2-title'style="text-align: center; margin: 20px;" >POPULAR IN 화랑</h2>
		<div class="row">
				<c:forEach items="${eList}" var="e">
				<div class="col-sm-4" style="height: 600px; margin: 0 0 20px 0;">
					<div class="card mb-4 shadow-sm">
						<a href="/exhibition/view?seq=${e.exh_seq}"><img
							class="card-img-top" style="width: 100%; height: 400px;"
							alt="item image" role="img" src="${e.exh_imgurl}"></a>
					</div>
					<div class="card-body">
						<p class="card-title" style="font-weight: bold; font-size: 18px">
							<a href="/exhibition/view?seq=${e.exh_seq}">${e.exh_title}</a><span class="badge badge-primary">${e.exh_realmName}</span>
						</p>
						
						<p class="card-text">
							${fn:substring(e.exh_startDate, 0, 10)} ~ ${fn:substring(e.exh_endDate, 0, 10)}<br>${e.exh_area}&nbsp;/&nbsp;${e.exh_place}
						</p>
						
						<p class="card-text">
							<i class="far fa-thumbs-up" style="color: blue;">${e.exh_like}</i>&nbsp;/&nbsp;<i class="far fa-thumbs-down" style="color: gray;">${e.exh_unlike}</i>
							&nbsp;&nbsp;&nbsp;&nbsp;<span>즐겨찾기&nbsp;<a><i id="favStatus${e.exh_seq}" class='${e.favorite_status == 0 ? "far ":"star fas "}fa-star' data-toggle="modal" data-target='${e.favorite_status == 0 ? "#fav-AddModal":"#fav-RemoveModal"}${e.exh_seq}'></i></a></span>
						</p>
						<p class="card-text">
							
						</p>
					</div>
				</div>
				</c:forEach>
		</div>
</div>

<!-- Nav Tabs HJ -->
<div id="div3" style="font-weight: bold;">
        <div class="div3-div row" style="display: inline-block; position: relative;">
            <div class="col-md-12" style="margin-top: 20px;">
                <ul id="tabsJustified" class="nav nav-tabs">
                    <li class="nav-item"><a href="" data-target="#notice" data-toggle="tab" class="nav-link active">공지사항</a></li>
                    <li class="nav-item"><a href="" data-target="#faq" data-toggle="tab" class="nav-link">FAQ</a></li>
                    <li class="nav-item"><a href="" data-target="#freeboard" data-toggle="tab" class="nav-link">자유게시판</a></li>
                </ul>
                <div id="tabsJustifiedContent" class="tab-content">
                    <div id="notice" class="tab-pane fade active show" style="padding: 1.5rem; text-align: center">
                        <div class="table-responsive d-flex align-items-center">
                        	<table class="table">
                        		<thead style="text-align: center">
                        			<tr>
                        				<th>No</th>
                        				<th>Title</th>
                        				<th>Date</th>
                        				<th>Views</th>
                        			</tr>
                        		</thead>
                        		<c:forEach items="${noticeList }" var="notice" varStatus="vs">
                        			<fmt:formatDate value="${notice.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
                        			<tr>
                        				<td style="text-align: center">${vs.index+1 }</td>
                        				<td><a href="/notice/noticeView?num=${notice.num}">${notice.title }</a></td>
                        				<td style="text-align: center">${regDate }</td>
                        				<td style="text-align: center">${notice.readCnt }</td>
                        			</tr>
                        		</c:forEach>
                        	</table>
                        </div>
                    </div>
                    <div id="faq" class="tab-pane fade" style="height:300px; padding: 1.5rem; text-align: center; white-space: inherit; overflow: auto; text-overflow: ellipsis;">
                        <table class="table">
	                        	<c:forEach items="${faqList }" var="faq" varStatus="vs">
	                        		<fmt:formatDate value="${faq.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
		                       		<tr>
	                        			<td>
											<div id="accordion">
												<div><a data-toggle="collapse" href="#content${vs.index }">${faq.question }</a></div>
												
												<div id="content${vs.index }" class="collapse"  data-parent="#accordion"><hr>${faq.answer }</div>
											</div>
										</td>
		                       		</tr>
	                        	</c:forEach>
                       	</table>
                    </div>
                    <div id="freeboard" class="tab-pane fade" style="padding: 1.5rem; text-align: center">
                        <table class="table">
                        		<thead style="text-align: center">
                        			<tr>
                        				<th>No</th>
                        				<th>Title</th>
                        				<th>Date</th>
                        				<th>Views</th>
                        			</tr>
                        		</thead>
                        		<c:forEach items="${freeList }" var="free" varStatus="vs">
                        			<fmt:formatDate value="${free.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
                        			<tr>
                        				<td style="text-align: center">${vs.index+1}</td>
                        				<td><a href="/board/freeboardView?num=${free.num}">${free.title }</a></td>
                        				<td style="text-align: center">${regDate }</td>
                        				<td style="text-align: center">${free.readCount }</td>
                        			</tr>
                        		</c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
		<%-- <div class='div3-div2' style="display: inline-block; overflow: hidden; width:600px; height: 380px; float: right; background-color: white; padding: 40px;">
			<h4 style="font-weight: bold; padding-bottom: 10px;">관람후기</h4>
			<div style="width:450px; height: 300px; overflow: hidden; position: relative;" onmouseover="stopRepeat();" onmouseout="startRepeat();">
			<table class="table" id="myTable" border="1" style="width: 100%; position: absolute;">
				<tbody>
					<c:forEach items="${review}" var="r">
					<tr style="font-weight: bold; padding: 20px;">
						<td style="padding: 5px; wi"><a href="/review/view?num=${r.review_num}">${r.review_title}</a><br>
						${r.member_id}&nbsp;&nbsp;&nbsp;&nbsp;조회수 ${r.review_read_count}&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${r.review_reg_date }" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</div> --%>
		<div style="display: inline-block; overflow: hidden; width:600px; height: 380px; float: right; background-color: white; padding: 40px;">
			<h4 style="font-weight: bold; padding-bottom: 20px;">관람후기</h4>
			<ul id="ticker_02" class="ticker">
				<c:forEach items="${review}" var="r">
					<li><a href="/review/view?num=${r.review_num}">${r.review_title}</a>
					&nbsp;&nbsp;${r.member_id}&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${r.review_reg_date }" pattern="yyyy-MM-dd"/></li>
				</c:forEach>
			</ul>
		</div>
</div> 


<!--  오른쪽 사이드 바 -->
<%@include file="../layout/bottom.jsp"%>

