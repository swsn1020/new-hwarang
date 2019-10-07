<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<title>화 랑</title>
<%@include file="../layout/menu.jsp"%>
<script type="text/javascript">
$(function(){
	document.domain = "localhost";
	var url = "/";
	window.opener.location.replace(url);
	window.close();
});
</script>
<!--  본문시작  -->
<div class="album py-5">
	<h2 class="text-center">Populor / Review top 3</h2>
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
						<i class="far fa-thumbs-up" style="color: blue;"></i>&nbsp&nbsp<i
							class="far fa-thumbs-down" style="color: gray;"></i>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!--  탭 구현 부분 -->
	<div class="container">
		<ul class="nav nav-tabs">
			<li><a data-toggle="tab" href="#map">공지사항</a></li>
			<li><a data-toggle="tab" href="#review">FAQ</a></li>
			<li><a data-toggle="tab" href="#reply">어쩌구</a></li>
		</ul>

		<div class="tab-content">
			<div id="map" class="tab-pane fade in active">
				<h3>Menu 2</h3>
				<p>공지 공지</p>
			</div>
			<div id="review" class="tab-pane fade">
				<h3>Menu 1</h3>
				<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco
					laboris nisi ut aliquip ex ea commodo consequat.</p>
			</div>
			<div id="reply" class="tab-pane fade">
				<h3>Menu 2</h3>
				<p>Sed ut perspiciatis unde omnis iste natus error sit
					voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
			</div>

		</div>
	</div>

</div>

<!--  오른쪽 사이드 바 -->
<%@include file="../layout/bottom.jsp"%>

