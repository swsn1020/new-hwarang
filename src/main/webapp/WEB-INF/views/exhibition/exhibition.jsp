<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>화랑 - 전시회/공연 리스트</title>
<%@include file="../layout/menu.jsp"%>
<%@include file="../layout/rightUser.jsp"%>
<script type="text/javascript">
$(function() {
	//없는페이지막는로직
	$('.disabled').click(function(e) {
		alert("더 이상 페이지가 없습니다.");
		e.preventDefault();
		return false;
	});
});
//관심추가로직
function addFavorite(seq,id) {
	var groupValue = $("#favGroup"+seq).val();
	var fav = {
		exh_seq	: seq,
		member_id : id,
		favorite_group : groupValue
	};
	
	favService.add(fav, function(result) {
		if(result){
			alert("관심 등록 완료 되었습니다.");
			$("#favStatus"+seq).attr("class","star fas fa-star");
			$("#favStatus"+seq).attr("data-target","#fav-RemoveModal"+seq);
			$(".close").click();
		}else{
			alert("관심 등록이 실패 되었습니다.");	
		}
		return false;
	})
};
//관심삭제로직
function removeFavorite(seq,id) {
	var fav = {
		exh_seq	: seq,
		member_id : id
	};

	favService.remove(fav, function(result) {
		if(result){
			alert("관심 삭제가 완료 되었습니다.");
			$("#favStatus"+seq).attr("class","far fa-star");
			$("#favStatus"+seq).attr("data-target","#fav-AddModal"+seq);
			$(".close").click();
		}else{
			alert("관심 삭제가 실패 되었습니다.");	
		}
		return false;
	})
};
//새로운그룹명추가로직
function addFavGroup(seq) {
	var basicGroup = $("#basic-group"+seq);
	var addGroupVal = $("#addFavGroup"+seq).val();
	basicGroup.attr("value",addGroupVal);
	basicGroup.text("새로운 그룹 - "+addGroupVal);
	alert(addGroupVal+" 이 입력 되었습니다.");
	$(".favGroup").append("<option value='"+addGroupVal+"'>"+addGroupVal+"</option>");
};
</script>
<style>
.exh-list{
    padding-right: 15%;
    padding-left: 15%;
}
.star{
  color: #f0d90e;
}
</style>
<div class="container mt-3 " style="text-align: center;">
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.Username" var="id" />
	</sec:authorize> 
	<form action="#">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}"> 
		<select name="exh_realmName">
			<option selected value="">전체</option>
			<c:forEach items="${realmname}" var="r">
				<option value="${r}" <c:out value="${param.exh_realmName  eq r ?'selected':''}"/>>${r}</option>			
			</c:forEach>
		</select> 
		<select name="exh_area">
			<option selected value="">지역</option>
			<c:forEach items="${area}" var="a">
				<option value="${a}" <c:out value="${param.exh_area  eq a ?'selected':''}"/>>${a}</option>			
			</c:forEach>
		</select>
		<input type="text" class="form_date" id="srchFr" name="exh_startDate" title="시작일" value="${param.exh_startDate}" placeholder="시작일" readonly style="width: 120px;">
        <button type="button" class="far fa-calendar-alt" onclick="openCalendar(document.getElementById('srchFr'));">달력</button>
        <input type="text" class="form_date" id="srchTo" name="exh_endDate" title="종료일" value="${param.exh_endDate}" placeholder="종료일" readonly style="width: 120px;">
        <button type="button" class="far fa-calendar-alt" onclick="openCalendar(document.getElementById('srchTo'));">달력</button>
		<select name="sort">
			<option selected value="0">최신순</option>
			<option value="1" <c:out value="${param.sort  eq 1 ?'selected':''}"/>>지역순</option>
			<option value="2" <c:out value="${param.sort  eq 2 ?'selected':''}"/>>분류순</option>
			<option value="3" <c:out value="${param.sort  eq 3 ?'selected':''}"/>>낮은 가격순</option>
			<option value="4" <c:out value="${param.sort  eq 4 ?'selected':''}"/>>높은 가격순</option>
			<option value="5" <c:out value="${param.sort  eq 5 ?'selected':''}"/>>늦은 시작일</option>
			<option value="6" <c:out value="${param.sort  eq 6 ?'selected':''}"/>>빠른 시작일</option>
			<option value="7" <c:out value="${param.sort  eq 7 ?'selected':''}"/>>늦은 종료일</option>
			<option value="8" <c:out value="${param.sort  eq 8 ?'selected':''}"/>>빠른 종료일</option>
			<option value="9" <c:out value="${param.sort  eq 9 ?'selected':''}"/>>높은 추천수</option>
			<option value="10" <c:out value="${param.sort  eq 10 ?'selected':''}"/>>높은 비추천수</option>
		</select>
		<select name="type">
			<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>----</option>
			<option value="t" <c:out value="${pageMaker.cri.type eq 't' ?'selected':''}"/>>제목</option>
			<option value="p" <c:out value="${pageMaker.cri.type eq 'p' ?'selected':''}"/>>장소</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="${param.keyword}"> 
		<button type="submit" class="btn btn-outline-dark">검색</button>
	</form>
	<div style="border-top: 2px solid black; margin: 20px 0 20px 0;"></div>
	<p style="text-align: left;">	검색 결과 : 총 ${pageMaker.total} 건</p>
</div>
<div class="exh-list album py-5 bg-light">
	<div class="row">
		<c:forEach items="${eList}" var="e">
			<div class="col-sm-3" style="height: 650px; margin: 0 0 20px 0;">
				<div class="card mb-3 shadow-sm">
					<a href="/exhibition/view?seq=${e.exh_seq}"><img
						class="card-img-top" style="width: 100%; height: 400px;"
						alt="item image" role="img" src="${e.exh_imgurl}"></a>
				</div>
				<div class="card-body">
					<p class="card-title" style="font-weight: bold; font-size: 18px">
						<a href="/exhibition/view?seq=${e.exh_seq}">${e.exh_title}</a><span class="badge badge-primary">${e.exh_realmName}</span>&nbsp;[${e.exh_recomm_cnt}]
					</p>
					
					<p class="card-text">
						${fn:substring(e.exh_startDate, 0, 10)} ~ ${fn:substring(e.exh_endDate, 0, 10)}<br>${e.exh_area}&nbsp;/&nbsp;${e.exh_place}<br>가격&nbsp;:&nbsp;${e.exh_value}
					</p>
					<p class="card-text">
						
					</p>
					
					<p class="card-text">
						<i class="far fa-thumbs-up" style="color: blue;">${e.exh_like}</i>&nbsp;/&nbsp;<i class="far fa-thumbs-down" style="color: gray;">${e.exh_unlike}</i>
						&nbsp;&nbsp;&nbsp;&nbsp;<span>즐겨찾기&nbsp;<a><i id="favStatus${e.exh_seq}" class='${e.favorite_status == 0 ? "far ":"star fas "}fa-star' data-toggle="modal" data-target='${e.favorite_status == 0 ? "#fav-AddModal":"#fav-RemoveModal"}${e.exh_seq}'></i></a></span>
					</p>
					<p class="card-text">
						
					</p>
				</div>
			</div>
			<!-- 관심추가  Modal -->
			<div class="modal" id="fav-AddModal${e.exh_seq}">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<p class="modal-title">관심목록 추가</p>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal body -->
						<div class="content" style="margin: 10px;">
							<div>
								<input id="addFavGroup${e.exh_seq}" type="text"
									placeholder="새로운 그룹 이름  추가"> <a
									class="btn btn-outline-dark" onclick="addFavGroup(${e.exh_seq})">그룹추가</a>
							</div>
							<select name="group" id="favGroup${e.exh_seq}" class="favGroup">
								<option selected value="찜 목록" id="basic-group${e.exh_seq}">기본
									- 찜 목록</option>
								<c:forEach items="${group}" var="g">
									<option value="${g}">${g}</option>
								</c:forEach>
							</select>
							<p class="info">
								<strong>${e.exh_title}</strong> (가)이 추가됩니다. <br />추가하시겠습니까?
							</p>	
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<a onclick="addFavorite(${e.exh_seq},'${id}')" class="btn btn-outline-dark">추가하기</a> 
							<a data-dismiss="modal" class="btn btn-outline-dark">취소하기</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 관심삭제  Modal -->
			<div class="modal" id="fav-RemoveModal${e.exh_seq}">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<p class="modal-title">관심목록 삭제</p>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal body -->
						<div class="content" >
							<p class="info" style="margin: 10px;">
								<strong>${e.exh_title}</strong> (가)이 삭제됩니다. 
								<br />정말로 삭제 하시겠습니까?
							</p>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<a class="btn btn-outline-dark" onclick="removeFavorite(${e.exh_seq},'${id}')">삭제하기</a>
							<a data-dismiss="modal" class="btn btn-outline-dark">취소하기</a>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<ul class="pagination justify-content-center" style="margin: 20px 0">
		<li class='page-item ${pageMaker.prev == true ? "":"disabled"}'>
			<a class="page-link"
			href='/exhibition?pageNum=${pageMaker.startPage -1}&amount=${pageMaker.cri.amount}&exh_realmName=${param.exh_realmName}&exh_area=${param.exh_area}&exh_startDate=${param.exh_startDate}&exh_endDate=${param.exh_endDate}&sort=${param.sort}&type=${param.type}&keyword=${param.keyword}'>Previous</a>
		</li>
		<c:forEach var="num" begin="${pageMaker.startPage}"
			end="${pageMaker.endPage}">
			<li class='page-item ${pageMaker.cri.pageNum == num ? "active":""}'>
				<a class="page-link" href="/exhibition?pageNum=${num}&amount=${pageMaker.cri.amount}&exh_realmName=${param.exh_realmName}&exh_area=${param.exh_area}&exh_startDate=${param.exh_startDate}&exh_endDate=${param.exh_endDate}&sort=${param.sort}&type=${param.type}&keyword=${param.keyword}">${num}</a>
			</li>
		</c:forEach>
		<li class='page-item ${pageMaker.next == true ? "":"disabled"}'>
			<a class="page-link"
			href='/exhibition?pageNum=${pageMaker.endPage +1}&amount=${pageMaker.cri.amount}&exh_realmName=${param.exh_realmName}&exh_area=${param.exh_area}&exh_startDate=${param.exh_startDate}&exh_endDate=${param.exh_endDate}&sort=${param.sort}&type=${param.type}&keyword=${param.keyword}'>Next</a>
		</li>
		</ul>
		<form action="#">
			<select name="amount">
				<option value="4" <c:out value="${pageMaker.cri.amount  eq 4 ?'selected':''}"/>>4개</option>
				<option value="8" <c:out value="${pageMaker.cri.amount  eq 8 ?'selected':''}"/>>8개</option>
				<option value="12" <c:out value="${pageMaker.cri.amount  eq 12 ?'selected':''}"/>>12개</option>
				<option value="16" <c:out value="${pageMaker.cri.amount  eq 16 ?'selected':''}"/>>16개</option>
				<option value="20" <c:out value="${pageMaker.cri.amount  eq 20 ?'selected':''}"/>>20개</option>
				<option value="40" <c:out value="${pageMaker.cri.amount  eq 40 ?'selected':''}"/>>40개</option>
			</select>
			<button type="submit" class="btn btn-outline-dark">모아보기</button>	 
			<input type="hidden" name="exh_realmName"  value="${param.keyword}">
			<input type="hidden" name="exh_area" value="${param.keyword}">
			<input type="hidden" name="exh_startDate" value="${param.keyword}">
			<input type="hidden" name="exh_endDate" value="${param.keyword}">
			<input type="hidden" name="sort" value="${param.keyword}">
			<input type="hidden" name="type" value="${pageMaker.cri.type}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
</div>

<%@include file="../layout/bottom.jsp"%>
