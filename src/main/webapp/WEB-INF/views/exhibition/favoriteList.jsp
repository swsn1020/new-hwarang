<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>화랑 - 관심목록</title>
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
	$("#deleteFav").click(function(e) {
		if($("input[type=checkbox]:checked").length==0){
			alert("삭제할 공연을 체크해주세요!");
			e.preventDefault();
		}	
	});
	$("#orderFav").click(function(e) {
		if($("input[type=checkbox]:checked").length==0){
			alert("결제할 공연을 체크해주세요!");
			e.preventDefault();
		}	
	});
}) 	


</script>
<div class="container mt-3 ">
	<form action="" method="post">
		<select name="group">
			<option selected>현재 -${pGroup} </option>
			<c:forEach items="${group}" var="g">
				<option value="${g}">${g}</option>			
			</c:forEach>
		</select>
		<button type="submit" class="btn btn-outline-dark">Submit</button>
	</form>
</div>

<div class="container">
	<h2 style="font-weight: bold; margin: 10px;">나의 관심 목록</h2>
	<form action="/exhibition/removeFavorite" method="post">
	<input type="hidden" name="group" value="${param.group}">
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
				<th><button type="submit" id="deleteFav" class="btn btn-outline-dark">선택 삭제</button></th>
			</tr>
				
		</thead>
		<tbody>
			<c:forEach items="${fList}" var="f">
				<tr>
					<td style="padding: 20px;">
						<div class="form-check">
							<label class="form-check-label"> <input type="checkbox"	class="form-check-input" name="seq" value="${f.exh_seq}">
							</label>
						</div>
					</td>
					<td><a href="/exhibition/view?seq=${f.exh_seq}"><img src="${f.exh_imgurl}" style="width:300; height: 400px;"></a></td>
					<td>
						<ul class="nav ">
							<li class="nav-item col-sm-12" id="side_item">
								<h5 style="font-weight: bold;"><a class="nav-link" style="padding: 0px;" href="/exhibition/view?seq=${f.exh_seq}">${f.exh_title}<span class="badge badge-primary">${f.exh_realmName}</span></a></h5></li>
							<li class="nav-item col-sm-12" id="side_item">${f.exh_place}</li>
							<li class="nav-item col-sm-12" id="side_item">${f.exh_price}</li>
							<li class="nav-item col-sm-12" id="side_item">${fn:substring(f.exh_startDate, 0, 10)} ~ ${fn:substring(f.exh_endDate, 0, 10)}</li>
						</ul>
							<a class="btn btn-outline-dark" style="float: right;" href="/order/orderGoodsForm?seq=${f.exh_seq}">결제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="border-top: 2px solid black;"></div>
	</form>
		<ul class="pagination justify-content-center" style="margin:20px 0"> 
			<li class='page-item ${pageMaker.prev == true ? "":"disabled"}'>
				<a class="page-link" href='/exhibition/favoriteList?pageNum=${pageMaker.startPage -1}'>Previous</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active":"page-item"}'>
					<a class="page-link" href="/exhibition/favoriteList?pageNum=${num}">${num}</a>
				</li>
			</c:forEach>
			<li class='page-item ${pageMaker.next == true ? "":"disabled"}'>
				<a class="page-link"  href='/exhibition/favoriteList?pageNum=${pageMaker.endPage +1}'>Next</a>
			</li>
		</ul>
</div>



<%@include file="../layout/bottom.jsp"%>
