<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>화랑 - 관심목록</title>
<%@include file="../layout/left.jsp"%>
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
<div class="container mt-3 ">
	<form action="" method="post">
		<select name="group">
			<option selected>현재 -${pGroup} </option>
			<c:forEach items="${group}" var="g">
				<option value="${g}">${g}</option>			
			</c:forEach>
		</select>
		<button type="submit" class="btn btn-primary">Submit</button>
	</form>
</div>
<div class="container">
	<h2>나의 관심 목록</h2>
	<form action="/exhibition/removeFavorite" method="post">
	<input type="hidden" name="group" value="${param.group}">
	<table class="table">
		<thead>
			<tr>
				<th><div class="form-check">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" id="allCheck">전체 선택
						</label>
					</div></th>
				<th></th>
				<th><button type="submit" class="btn btn-primary text-right">선택 삭제</button></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${fList}" var="f">
				<tr>
					<td>
						<div class="form-check">
							<label class="form-check-label"> <input type="checkbox"	class="form-check-input" name="seq" value="${f.exh_seq}">
							</label>
						</div>
					</td>
					<td><a href="/exhibition/view?seq=${f.exh_seq}"><img src="${f.exh_imgurl}" style="height: 280px;"></a></td>
					<td>
						<ul class="nav ">
							<li class="nav-item col-sm-12" id="side_item">
								<h5><a class="nav-link" href="/exhibition/view?seq=${f.exh_seq}">${f.exh_title}<span class="badge badge-primary">${f.exh_realmName}</span></a></h5></li>
							<li class="nav-item col-sm-12" id="side_item">${f.exh_place}</li>
							<li class="nav-item col-sm-12" id="side_item">${f.exh_price}</li>
							<li class="nav-item col-sm-12" id="side_item">${fn:substring(f.exh_startDate, 0, 10)} ~ ${fn:substring(f.exh_endDate, 0, 10)}</li>
						</ul>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
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
