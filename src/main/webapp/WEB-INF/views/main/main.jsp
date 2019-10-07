<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<title>화 랑</title>
<%@include file="../layout/left.jsp"%>
<!--  본문시작  -->
<div class="album py-5">
	<h2 class="text-center">Popular / Review top 3</h2>
	<div class="container">
		<!--  사진 나오는 부분 -->
		<div class="row " style="padding: 20px;">
			<c:forEach items="${eList}" var="e">
				<div class="col-sm-4 ">
					<div class="card mb-4 shadow-sm">
						<a href="/exhibition/view?seq=${e.exh_seq}"><img
							class="card-img-top" style="width: 100%;" alt="item image"
							role="img" src="${e.exh_imgurl}"></a>
					</div>
					<div class="card-body">
						<p class="card-title">
							<a href="/exhibition/view?seq=${e.exh_seq}">${e.exh_title}</a>
						<p>
						<p class="card-text">
							${fn:substring(e.exh_startDate, 0, 10)} ~ ${fn:substring(e.exh_endDate, 0, 10)}
						</p>
						<i class="far fa-thumbs-up" style="color: blue;"></i>&nbsp;&nbsp;<i
							class="far fa-thumbs-down" style="color: gray;"></i>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- Nav Tabs HJ -->
	<section class="container py-5">
        <div class="row">
            <div class="col-md-12">
                <ul id="tabsJustified" class="nav nav-tabs">
                    <li class="nav-item"><a href="" data-target="#notice" data-toggle="tab" class="nav-link active">공지사항</a></li>
                    <li class="nav-item"><a href="" data-target="#profile1" data-toggle="tab" class="nav-link">자주하는 질문</a></li>
                    <li class="nav-item"><a href="" data-target="#messages1" data-toggle="tab" class="nav-link">Messages</a></li>
                </ul>
                <div id="tabsJustifiedContent" class="tab-content">
                    <div id="notice" class="tab-pane fade active show" style="padding: 1.5rem; text-align: center">
                        <div class="table-responsive d-flex align-items-center">
                        	<table class="table table-striped table-sm">
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
                        				<td style="text-align: center">${vs.index+1}</td>
                        				<td><a href="/noctice/noticeView?num=${notice.num}">${notice.title }</a></td>
                        				<td style="text-align: center">${regDate }</td>
                        				<td style="text-align: center">${notice.readCnt }</td>
                        			</tr>
                        		</c:forEach>
                        	</table>
                        </div>
                    </div>
                    <div id="profile1" class="tab-pane fade">
                        <div class="row pb-2">
                            <div class="col-md-7">
                                <p>Tabs can be used to contain a variety of content &amp; elements. They are a good way to group 
                                	<a href="" class="link">relevant content</a>. Display initial content in context to the user. Enable the user to flow through
                                    <a href="" class="link">more</a> information as needed.
                                </p>
                            </div>
                            <div class="col-md-5"><img src="//dummyimage.com/1005x559.png/5fa2dd/ffffff" class="float-right img-fluid img-rounded"></div>
                        </div>
                    </div>
                    <div id="messages1" class="tab-pane fade">
                        <div class="list-group">
                       		<ul>
	                        	<c:forEach items="${faqList }" var="faq">
	                        		<fmt:formatDate value="${faq.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
	                        			<li class="list-group-item d-inline-block">
	                        				<a href="/faq/faqVies?num=${faq.num }">
	                        					<span class="title">${faq.question }</span><br>
	                        					<span class="content">${faq.answer }</span><br>
	                        					<span class="date">${regDate }</span>
	                        				</a>
	                        			</li>
	                        	</c:forEach>
                       		</ul>
                        	<a href="" class="list-group-item d-inline-block"><span class="float-right badge badge-pill badge-dark">44</span> Message 1</a> 
                        	<a href="" class="list-group-item d-inline-block"><span class="float-right badge badge-pill badge-dark">8</span> Message 2</a>                            
                        	<a href="" class="list-group-item d-inline-block"><span class="float-right badge badge-pill badge-dark">23</span> Message 3</a> 
                        	<a href="" class="list-group-item d-inline-block text-muted">Message n..</a></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</div>

<!--  오른쪽 사이드 바 -->
<%@include file="../layout/bottom.jsp"%>

