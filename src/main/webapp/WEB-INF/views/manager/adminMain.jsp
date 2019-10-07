<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-Manager_메인페이지</title>
<%@include file="../layout/managerSidebar.jsp"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<!-- Google fonts - Poppins -->
<script src="https://kit.fontawesome.com/1e1a69f988.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
<script	src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<script type="text/javascript">
$(function(){
	//차트 그림그리기
    // ------------------------------------------------------- //
    // Bar Chart
    // ------------------------------------------------------ //
    var BARCHARTHOME = $('#barChartHome');
    var barChartHome = new Chart(BARCHARTHOME, {
        type: 'bar',
        options:
        {
            scales:
            {
                xAxes: [{
                   
                }],
                yAxes: [{
                	 barPercentage: 0.1,
 	            	categoryPercentage: 0.1,
 	            	barThickness: 1,
 	                ticks: {
 	                    min: 0,
 	                    max: 90,
 	                    stepSize: 15
 	                }
                }],
            },
            legend: {
                display: true
            }
        },
        data: {
            labels: ["NOTICE", "FREE", "REPORT", "BLOCK", "REVIEW", "RECOMMEND"],
            datasets: [
                {
                    label: "Posted today each board",
                    data: ['${qnaTC}', '${freeBTC}', '${reportTC}', '${blockTC}', '${reviewBTC}', '${recommBTC}'],
                    backgroundColor: [
                    	'rgba(255, 99, 132, 0.2)',
    	                'rgba(54, 162, 235, 0.2)',
    	                'rgba(255, 206, 86, 0.2)',
    	                'rgba(75, 192, 192, 0.2)',
    	                'rgba(153, 102, 255, 0.2)',
    	                'rgba(255, 159, 64, 0.2)',
                    ],
                    borderColor: [
                        'rgb(121, 106, 238)',
                        'rgb(121, 106, 238)',
                        'rgb(121, 106, 238)',
                        'rgb(121, 106, 238)',
                        'rgb(121, 106, 238)',
                        'rgb(121, 106, 238)',
                    ],
                    borderWidth: 1,
                }
            ]
        }
    });
	
    var totalFP = numberWithCommas('${totalFP}');
//     alert(totalFP);
	$(".counter").text(totalFP).append("<small style='color: black;'>원</small>");
	$("#review0").addClass('active');
});	//onload End
    
    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
</script>
<style>
	.carousel-indicators li {
    width: 10px;
    height: 10px;
    border-radius: 100%;
    background: gray;
	}
	.carousel-indicators li.active  {
	background-color: #B2A49A;
	}
	.carousel-control-prev-icon {
	outline: black;
	}
 	.carousel-item { 
 	  white-space: nowrap;  
 	  overflow: hidden; 
 	  text-overflow: ellipsis;  
 	} 
	.carousel-inner .content {
		width: 100%;
   		height: 100%;
	}
	
	
</style>
<!-- content-inner -->
<!-- 신규가입자(수), 신규게시물(수), 신규 댓글(수),  -->
<div class="content-inner" style="padding-bottom: 59px;">
	<!-- Dashboard Counts Section-->
	<section class="dashboard-counts no-padding-bottom">
		<div class="container-fluid">
			<div class="row bg-white has-shadow">
				<div style="width: 100%; margin-bottom: 10px; text-align: center;">
					<h1 style="color: #4A4445"><strong>Total Statistics</strong></h1>
				</div>
				<!-- Item -->
				<div class="col-xl-4 col-sm-8">
					<div class="item d-flex align-items-center">
						<div class="icon bg-violet">
							<i class="icon-user fa-lg" style="padding-top: 5px;"></i>
						</div>
						<div class="title">
							<span>Total<br>Members<br>
							</span>
							<div class="progress">
								<div role="progressbar" style="width: 25%; height: 4px;"
									aria-valuenow="${totalMembers }" aria-valuemin="0" aria-valuemax="100"
									class="progress-bar bg-violet">
								</div>
							</div>
						</div>
						<!--                     신규 가입자 수 -->
						<div class="number">
							<strong>${totalMembers }</strong>
						</div>
					</div>
				</div>
				<!-- Item -->
				<div class="col-xl-4 col-sm-8">
					<div class="item d-flex align-items-center">
						<div class="icon bg-red">
							<i class="fas fa-pencil-alt fa-lg" style="padding-top: 10px;"></i>
						</div>
						<div class="title">
							<span>Total<br>Posts
							</span>
							<div class="progress">
								<div role="progressbar" style="width: 70%; height: 4px;"
									aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"
									class="progress-bar bg-red fa-lg"></div>
							</div>
						</div>
						<!--                     신규 게시글 -->
						<div class="number">
							<strong>${totalPosts }</strong>
						</div>
					</div>
				</div>
				<!-- Item -->
				<div class="col-xl-4 col-sm-8">
					<div class="item d-flex align-items-center">
						<div class="icon bg-green">
							<i class="fas fa-comment-dots fa-lg" style="padding-top: 10px;"></i>
						</div>
						<div class="title">
							<span>Total<br>Replies
							</span>
							<div class="progress">
								<div role="progressbar" style="width: 40%; height: 4px;"
									aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"
									class="progress-bar bg-green"></div>
							</div>
						</div>
						<div class="number">
							<strong>${totalReplies }</strong>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br><br><br>
	<!-- Dashboard Header Section    -->
    <section class="dashboard-header">
      <div class="container-fluid">
      	<div style="width: 100%; margin-bottom: 10px; text-align: center;">
			<h1 style="color: #4A4445"><strong>Recently Posted</strong></h1>
		</div>
        <div class="row">
          <!-- Statistics -->
          <div class="statistics col-lg-3 col-12">
            <div class="statistic d-flex align-items-center bg-white has-shadow">
              <div class="icon bg-red"><i class="fa fa-tasks fa-lg" style="padding-top: 10px;"></i></div>
              <div class="text"><strong><a href="/admin/memberList?type=W">${newMemCount }</a></strong><br><small>New Members within a week</small><br></div>
            </div>
            <div class="statistic d-flex align-items-center bg-white has-shadow">
              <div class="icon bg-green"><i class="fa fa-calendar-o fa-lg" style="padding-top: 10px;"></i></div>
              <div class="text"><strong><a href="/exhibition">${ExhiCountMonth}</a></strong><br><small>EXHIBITION</small></div>
            </div>
            <div class="statistic d-flex align-items-center bg-white has-shadow">
              <div class="icon bg-orange"><i class="fa fa-paper-plane-o fa-lg" style="padding-top: 10px;"></i></div>
              <div class="text"><strong><a href="/funding"><span class="counter"></span></a></strong><br><small>TOTAL FUNDING PRICE</small></div>
            </div>
          </div>
          <div class="chart col-lg-6 col-12">
				<!-- Bar Chart   -->
				<div class="bar-chart has-shadow bg-white">
					<div class="title">
						<strong class="text-violet">Posted Today</strong><br>
						<%
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							String date = sdf.format(new Date());
						%>
						<small><%=date %> 등록된 게시글</small>
					</div>
					<canvas id="barChartHome"></canvas>
				</div>
			</div>
			<!-- images -->
			<div class="images col-lg-3 col-12" style="text-align: center;">
				<div class="image d-flex align-items-center bg-white has-shadow">
					<div id="img" class="carousel slide" data-ride="carousel" style="width: 100%; height: 100%;">
						<p><strong class="text-red">REVIEW BOARD</strong></p>
						 <!-- Indicators -->
						  <ul class="carousel-indicators">
						    <li data-target="#img" data-slide-to="0" class="active"></li>
						    <li data-target="#img" data-slide-to="1"></li>
						    <li data-target="#img" data-slide-to="2"></li>
						     <li data-target="#img" data-slide-to="3"></li>
						      <li data-target="#img" data-slide-to="4"></li>
						  </ul>
<!-- 						  style="width: 100%; height: 100%; padding-left: 30px; padding-right: 30px; padding-top: 20px; padding-bottom: 10px;" -->
						  <!-- The slideshow -->
						  <div class="carousel-inner" style="padding-left: 30px; padding-right: 30px;">
						  	<c:forEach items="${reviewList }" var="review" varStatus="vs">
							    <div class="carousel-item" id="review${vs.index }">
							      <div class="content">
							      	<h5><a href="/review/view?num=${review.review_num}">${review.review_title }</a></h5>
							      	<br><br><br><span> ${review.review_content }</span>
							      </div>
							    </div>
						  	</c:forEach>
						  </div>
						  <!-- Left and right controls -->
						  <a class="carousel-control-prev" href="#img" data-slide="prev">
						    <span class="carousel-control-prev-icon"></span>
						  </a>
						  <a class="carousel-control-next" href="#img" data-slide="next">
						    <span class="carousel-control-next-icon"></span>
						  </a>
					</div>
				</div>
			</div>
          </div>
        </div>
    </section>
    <br><br><br>
    <!-- Projects Section-->
    <section class="projects no-padding-top">
      <div class="container-fluid">
      	<div style="width: 100%; margin-bottom: 10px; text-align: center;">
			<h1 style="color: #4A4445"><strong>Board Status</strong></h1>
		</div>
        <!-- Project-->
        <div class="project">
          <div class="row bg-white has-shadow">
            <div class="left-col col-lg-6 d-flex align-items-center justify-content-between">
              <div class="project-title d-flex align-items-center">
                <div class="text">
                  <h3 class="h4"><a href="/qna/qnaListForManager">Q&amp;A</a></h3><small>최근 등록된 문의</small>
                </div>
              </div>
              <div class="project-date"><span class="hidden-sm-down"><%=date %></span></div>
            </div>
            <div class="right-col col-lg-6 d-flex align-items-center">
           		 <%	
           		 	sdf = new SimpleDateFormat("hh:mm a");
					String date2 = sdf.format(new Date());
				 %>
              <div class="time"><i class="fa fa-clock-o"></i><%=date2 %> </div>
              <div class="project-progress">
                <div class="progress">
                  <div role="progressbar" style="width: 45%; height: 6px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" class="progress-bar bg-yellow"></div>
                </div>
              </div>
            </div>
            <div class="card-body">
            	<div class="table-responsive">
            	<table id="qnaList" class="table table-striped table-hover">
            		<thead>
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>등록일</th>
						<th>답변처리상태</th>
					</tr>
					</thead>
					<c:forEach items="${qnaList }" var="qna">
						<fmt:formatDate value="${qna.regDate }" var="regDate"
							pattern="yyyy-MM-dd" />
						<tr>
							<td>${qna.num }</td>
							<td>${qna.category }</td>
							<td><a href="/qna/qnaView?num=${qna.num}" style="color: #666"  onmouseover="this.style.color='black'" onmouseout="this.style.color='#666'">${qna.title }</a></td>
							<td>${regDate }</td>
							<c:choose>
								<c:when test="${qna.reply  eq '미답변' || qna.reply eq null}">
									<td style="color: #BA4E59;"><strong>미답변</strong></td>
								</c:when>
								<c:otherwise>
									<td><strong>답변완료</strong></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
				</div>
            </div>
          </div>
        </div>
        <!-- Project-->
        <div class="project" id="project2">
				<div class="row bg-white has-shadow">
					<div
						class="left-col col-lg-6 d-flex align-items-center justify-content-between">
						<div class="project-title d-flex align-items-center">
							<div class="text">
								<h3 class="h4">
									<a href="/block/blockListForManager" style="color: none;">Block Status</a>
								</h3>
								<small>최근 신고된 게시물</small>
							</div>
						</div>
						<div class="project-date">
							<span class="hidden-sm-down"><%=date %></span>
						</div>
					</div>
					<div class="right-col col-lg-6 d-flex align-items-center">
						<div class="time">
							<i class="fa fa-clock-o"></i><%=date2 %>
						</div>
						<div class="project-progress">
							<div class="progress">
								<div role="progressbar" style="width: 60%; height: 6px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" class="progress-bar bg-red"></div>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table id="blockList" class="table table-striped table-hover">
								<thead>
									<tr>
										<th>번호</th>
										<th>게시판</th>
										<th>분류</th>
										<th>등록일</th>
										<th>처리상태</th>
									</tr>
								</thead>
								<c:forEach items="${blockList }" var="block" varStatus="vs">
									<fmt:formatDate value="${block.regDate }" var="regDate"
										pattern="yyyy-MM-dd" />
									<tr>
										<td>${block.num }</td>
										<c:set var="category" value="${block.category }" />
										<td>${fn:substringBefore(category, "_") }</td>
										<td>${fn:substringAfter(category, "_") }</td>
										<td>${regDate }</td>
										<td><a href="/block/blockView?num=${block.num}">${block.reply }</a></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
    </section>
	<!-- Updates Section -->
	<!-- 
	<section class="updates no-padding-top">
		<div class="container-fluid">
			<div class="row">
				<!-- Recent Updates-->
				<!-- 
				<div class="col-lg-4">
					<div class="recent-updates card">
						<div class="card-close">
							<div class="dropdown">
								<button type="button" id="closeCard6" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false"
									class="dropdown-toggle">
									<i class="fa fa-ellipsis-v"></i>
								</button>
								<div aria-labelledby="closeCard6"
									class="dropdown-menu dropdown-menu-right has-shadow">
									<a href="#" class="dropdown-item remove"> <i
										class="fa fa-times"></i>Close
									</a><a href="#" class="dropdown-item edit"> <i
										class="fa fa-gear"></i>Edit
									</a>
								</div>
							</div>
						</div>
						<div class="card-header">
							<h3 class="h4">Recent Updates</h3>
						</div>
						<div class="card-body no-padding">
							<!-- Item-->
							<!-- 
							<div class="item d-flex justify-content-between">
								<div class="info d-flex">
									<div class="icon">
										<i class="icon-rss-feed"></i>
									</div>
									<div class="title">
										<h5>Lorem ipsum dolor sit amet.</h5>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit sed.</p>
									</div>
								</div>
								<div class="date text-right">
									<strong>24</strong><span>May</span>
								</div>
							</div>
							<!-- Item-->
							<!-- 
							<div class="item d-flex justify-content-between">
								<div class="info d-flex">
									<div class="icon">
										<i class="icon-rss-feed"></i>
									</div>
									<div class="title">
										<h5>Lorem ipsum dolor sit amet.</h5>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit sed.</p>
									</div>
								</div>
								<div class="date text-right">
									<strong>24</strong><span>May</span>
								</div>
							</div>
							<!-- Item        -->
							<!-- 
							<div class="item d-flex justify-content-between">
								<div class="info d-flex">
									<div class="icon">
										<i class="icon-rss-feed"></i>
									</div>
									<div class="title">
										<h5>Lorem ipsum dolor sit amet.</h5>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit sed.</p>
									</div>
								</div>
								<div class="date text-right">
									<strong>24</strong><span>May</span>
								</div>
							</div>
							<!-- Item-->
							<!-- 
							<div class="item d-flex justify-content-between">
								<div class="info d-flex">
									<div class="icon">
										<i class="icon-rss-feed"></i>
									</div>
									<div class="title">
										<h5>Lorem ipsum dolor sit amet.</h5>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit sed.</p>
									</div>
								</div>
								<div class="date text-right">
									<strong>24</strong><span>May</span>
								</div>
							</div>
							<!-- Item-->
							<!-- 
							<div class="item d-flex justify-content-between">
								<div class="info d-flex">
									<div class="icon">
										<i class="icon-rss-feed"></i>
									</div>
									<div class="title">
										<h5>Lorem ipsum dolor sit amet.</h5>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit sed.</p>
									</div>
								</div>
								<div class="date text-right">
									<strong>24</strong><span>May</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Daily Feeds -->
				<!-- 
				<div class="col-lg-4">
					<div class="daily-feeds card">
						<div class="card-close">
							<div class="dropdown">
								<button type="button" id="closeCard7" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false"
									class="dropdown-toggle">
									<i class="fa fa-ellipsis-v"></i>
								</button>
								<div aria-labelledby="closeCard7"
									class="dropdown-menu dropdown-menu-right has-shadow">
									<a href="#" class="dropdown-item remove"> <i
										class="fa fa-times"></i>Close
									</a><a href="#" class="dropdown-item edit"> <i
										class="fa fa-gear"></i>Edit
									</a>
								</div>
							</div>
						</div>
						<div class="card-header">
							<h3 class="h4">Daily Feeds</h3>
						</div>
						<div class="card-body no-padding">
							<!-- Item-->
							<!-- 
							<div class="item">
								<div class="feed d-flex justify-content-between">
									<div class="feed-body d-flex justify-content-between">
										<a href="#" class="feed-profile"><img
											src="" alt="person"
											class="img-fluid rounded-circle"></a>
										<div class="content">
											<h5>Aria Smith</h5>
											<span>Posted a new blog </span>
											<div class="full-date">
												<small>Today 5:60 pm - 12.06.2014</small>
											</div>
										</div>
									</div>
									<div class="date text-right">
										<small>5min ago</small>
									</div>
								</div>
							</div>
							<!-- Item-->
							<!-- 
							<div class="item">
								<div class="feed d-flex justify-content-between">
									<div class="feed-body d-flex justify-content-between">
										<a href="#" class="feed-profile"><img
											src="" alt="person"
											class="img-fluid rounded-circle"></a>
										<div class="content">
											<h5>Frank Williams</h5>
											<span>Posted a new blog </span>
											<div class="full-date">
												<small>Today 5:60 pm - 12.06.2014</small>
											</div>
											<div class="CTAs">
												<a href="#" class="btn btn-xs btn-secondary"><i
													class="fa fa-thumbs-up"> </i>Like</a><a href="#"
													class="btn btn-xs btn-secondary"><i class="fa fa-heart">
												</i>Love </a>
											</div>
										</div>
									</div>
									<div class="date text-right">
										<small>5min ago</small>
									</div>
								</div>
							</div>
							<!-- Item-->
							<!-- 
							<div class="item clearfix">
								<div class="feed d-flex justify-content-between">
									<div class="feed-body d-flex justify-content-between">
										<a href="#" class="feed-profile"><img
											src="" alt="person"
											class="img-fluid rounded-circle"></a>
										<div class="content">
											<h5>Ashley Wood</h5>
											<span>Posted a new blog </span>
											<div class="full-date">
												<small>Today 5:60 pm - 12.06.2014</small>
											</div>
										</div>
									</div>
									<div class="date text-right">
										<small>5min ago</small>
									</div>
								</div>
								<div class="quote has-shadow">
									<small>Lorem Ipsum is simply dummy text of the printing
										and typesetting industry. Lorem Ipsum has been the industry's
										standard dummy text ever since the 1500s. Over the years.</small>
								</div>
								                  <div class="CTAs pull-right"><a href="#" class="btn btn-xs btn-secondary"><i class="fa fa-thumbs-up"> </i>Like</a></div>
							</div>
						</div>
					</div>
				</div>
				<!-- Check List -->
				<!-- 
				<div class="col-lg-4">
					<div class="checklist card">
						<div class="card-close">
							<div class="dropdown">
								<button type="button" id="closeCard5" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false"
									class="dropdown-toggle">
									<i class="fa fa-ellipsis-v"></i>
								</button>
								<div aria-labelledby="closeCard5"
									class="dropdown-menu dropdown-menu-right has-shadow">
									<a href="#" class="dropdown-item remove"> <i
										class="fa fa-times"></i>Close
									</a><a href="#" class="dropdown-item edit"> <i
										class="fa fa-gear"></i>Edit
									</a>
								</div>
							</div>
						</div>
						<div class="card-header d-flex align-items-center">
							<h2 class="h3">To Do List</h2>
						</div>
						<div class="card-body no-padding">
							<div class="item d-flex">
								<input type="checkbox" id="input-1" name="input-1"
									class="checkbox-template"> <label for="input-1">Lorem
									ipsum dolor sit amet, consectetur adipisicing elit.</label>
							</div>
							<div class="item d-flex">
								<input type="checkbox" id="input-2" name="input-2"
									class="checkbox-template"> <label for="input-2">Lorem
									ipsum dolor sit amet, consectetur adipisicing elit.</label>
							</div>
							<div class="item d-flex">
								<input type="checkbox" id="input-3" name="input-3"
									class="checkbox-template"> <label for="input-3">Lorem
									ipsum dolor sit amet, consectetur adipisicing elit.</label>
							</div>
							<div class="item d-flex">
								<input type="checkbox" id="input-4" name="input-4"
									class="checkbox-template"> <label for="input-4">Lorem
									ipsum dolor sit amet, consectetur adipisicing elit.</label>
							</div>
							<div class="item d-flex">
								<input type="checkbox" id="input-5" name="input-5"
									class="checkbox-template"> <label for="input-5">Lorem
									ipsum dolor sit amet, consectetur adipisicing elit.</label>
							</div>
							<div class="item d-flex">
								<input type="checkbox" id="input-6" name="input-6"
									class="checkbox-template"> <label for="input-6">Lorem
									ipsum dolor sit amet, consectetur adipisicing elit.</label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>



	<!-- 신규가입자(사진, 아이디), 신고 수(팝업+게시판), 1:1문의 목록
	<div class="user-pic">
          <img class="img-responsive img-rounded" src="https://raw.githubusercontent.com/azouaoui-med/pro-sidebar-template/gh-pages/src/img/user.jpg"
            alt="User picture">
    </div>
     -->


</div>

