<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>화랑 - 최근본공연</title>
<%@include file="../layout/menu.jsp"%>
<script type="text/javascript">
$(function(){ //전체선택 체크박스 클릭
	$("#allCheck").click(function(){ 
		//만약 전체 선택 체크박스가 체크된상태일경우 
		if($("#allCheck").prop("checked")) { 
			//해당화면에 전체 checkbox들을 체크해준다 
			$("input[type=checkbox]").prop("checked",true);
			// 전체선택 체크박스가 해제된 경우 
			} else { 
				//해당화면에 모든 checkbox들의 체크를해제시킨다. 
				$("input[type=checkbox]").prop("checked",false); 
			} 
	});
	$(".btn-primary").click(function(e) {
		if($("input[type=checkbox]:checked").length==0){
			alert("삭제할 공연을 체크해주세요!");
			e.preventDefault();
		}	
	});
}) 	
</script>

<div class="container">
	<h2 style="font-weight: bold;">최근 본 상품</h2>
	<form action="/exhibition/removeRecentlyView" method="post">
	<div style="border-top: 2px solid black;"></div>
	<table class="table">
		<thead>
			<tr>
				<th style="padding: 20px;"><div class="form-check">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" id="allCheck">&nbsp;&nbsp;
						</label>
					</div></th>
				<th></th>
				<th><button type="submit" class="btn btn-outline-dark">선택 삭제</button></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${rList}" var="r">
				<tr>
					<td style="padding: 20px;">
						<div class="form-check">
							<label class="form-check-label"> <input type="checkbox"	class="form-check-input" name="seq" value="${r.exh_seq}">
							</label>
						</div>
					</td>
					<td><a href="/exhibition/view?seq=${r.exh_seq}"><img src="${r.exh_imgurl}" style="width:300; height: 400px;"></a></td>
					<td>
						<ul class="nav ">							
							<li class="nav-item col-sm-12" id="side_item">
								<h5 style="font-weight: bold;"><a class="nav-link"  style="padding: 0px;"  href="/exhibition/view?seq=${r.exh_seq}">${r.exh_title}<span class="badge badge-primary">${r.exh_realmName}</span></a></h5></li>
							<li class="nav-item col-sm-12" id="side_item" style="font-weight : bold; ">본 일시 ${r.recently_date}</li>
							<li class="nav-item col-sm-12" id="side_item">${r.exh_place}</li>
							<li class="nav-item col-sm-12" id="side_item">${r.exh_price}</li>
							<li class="nav-item col-sm-12" id="side_item">${fn:substring(r.exh_startDate, 0, 10)} ~ ${fn:substring(r.exh_endDate, 0, 10)}</li>
						</ul>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</form>
		<ul class="pagination justify-content-center" style="margin:20px 0"> 
			<li class='page-item ${pageMaker.prev == true ? "":"disabled"}'>
				<a class="page-link" href='/exhibition/recentlyView?pageNum=${pageMaker.startPage -1}'>Previous</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active":"page-item"}'>
					<a class="page-link" href="/exhibition/recentlyView?pageNum=${num}">${num}</a>
				</li>
			</c:forEach>
			<li class='page-item ${pageMaker.next == true ? "":"disabled"}'>
				<a class="page-link"  href='/exhibition/recentlyView?pageNum=${pageMaker.endPage +1}'>Next</a>
			</li>
		</ul>
</div>



<%@include file="../layout/bottom.jsp"%>
