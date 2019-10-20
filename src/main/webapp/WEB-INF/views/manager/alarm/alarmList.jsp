<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>관리자-Alarms</title>
<%@include file="../../layout/managerSidebar.jsp"%>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	table {
		text-align: center;
	}
	.fa-check {
		color: red;
	}
	
</style>
<script>
	$(function(){
		$(".link").on("click", function(){
			var num = $(this).data("num");
			$.ajax({
				url: "alarmCheck",
				type: "post",  
				data: {"num": num},
				success: function(result){
					if(result){
						alert("알림 확인");
					}
				},
				error: function(){
					alert("알람 확인 에러");
				}
			});
		});
		
		
		$(".check").on("click", function(){
			var num = $(this).data("num");
			$(this).find("i").css("color", "green");
// 			var checked = $(this).data("check");
			/*
			$(this).find("i").toggleClass("green-bg");
			if($(this).find("i").hasClass("green-bg")){
				alert("확인됨");
				checked = "Y";
			}*/
			$.ajax({
				url: "alarmCheck",
				type: "post",  
				data: {"num": num},
				success: function(result){
					if(result){
						alert("알림 확인");
						location.reload();
					}
				},
				error: function(){
					alert("알람 확인 에러");
				}
			});
		});
		
		$(".del").on("click", function(){
			var num = $(this).data("num");
// 			alert(num);
			$.ajax({
				url: "removeAlarm",
				type: "post",
				data: {"num": num},
				success: function(result){
					if(result){
						alert("알림 삭제 성공");
						location.reload();
					}else{
						alert("알림 삭제 실패");
					}
				},
				error: function(){
					alert("알림 삭제 오류");
				}
			});
		});
		
		//checkBox 체크되면 action 수행
		$("#check").change(function(){
			if($("#check").is(":checked")){
// 				alert("체크박스 선택");
				$("#check").val('Y');
			}else{
// 				alert("체크박스 해제");
				$("#check").val('');
			}
// 			alert($("#check").val());
			$("#sortForm").submit();
		})
	});
</script>

<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1><strong>알림함</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
           <div class="card-body" style="padding: 20px;">
             <div class="form-check" style="text-align: right; padding-right: 50px;">
             	<form id="sortForm" action="alarmList" method="get">
	           		<label class="form-check-label">
	           			<input type="checkbox" id="check" name="type" class="form-check-input" value="" <c:out value="${pageMaker.cri.type eq 'Y' ? 'checked' : ''}"/>>확인된 알람
	           		</label>
	           		<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
					<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
             	</form>
             </div>
           	<div class="table-responsive">
				<table class="table table-hover">
					<thead>
						<tr>
							<th style="width: 10%;">번호</th>
							<th style="width: 20%;">알람 카테고리</th> 
							<th style="width: 40%">알람 내용</th>
							<th style="width: 15%;">등록일</th>
							<th style="width: 15%;">CHECKED</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${alarmList }" var="alarm" varStatus="vs">
							<fmt:formatDate value="${alarm.alarm.regDate }" var="regDate" pattern="yyyy-MM-dd" />
							<tr>
								<td>${alarm.alarm.num }</td>
								<c:choose>
									<c:when test="${alarm.alarm.category eq 'New_Board'}">
										<td>새로운 게시글</td>
									</c:when>
									<c:otherwise>
										<td>새로운 회원</td>
									</c:otherwise>
								</c:choose>
								<td>
									<a href="${alarm.url }" class="link" data-num="${alarm.alarm.num }">새로운 ${alarm.category }_${alarm.subCategory }이 등록되었습니다.</a>
								</td>
								<td>${regDate}</td>
								<td>
									<c:choose>
										<c:when test="${alarm.alarm.checked eq 'N' }">
											<span><a class="check" href="#" data-num="${alarm.alarm.num }" data-check="N"><i class="fas fa-check"></i></a></span>
										</c:when>
										<c:otherwise>
											<span><i class="fas fa-check" style="color: green;"></i></span>
										</c:otherwise>
									</c:choose>
									&nbsp;&nbsp;<span><a class="del" data-num="${alarm.alarm.num }" href=""><i class="fas fa-trash-alt" style="color: black;"></i></a></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
           	</div>
           	
           	<!-- Pagination -->
			<ul class="pagination justify-content-center">
				<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="alarmList?pageNum=${pageMaker.startPage-1 }&type=${param.type}">&laquo;</a>
				</li>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
					<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
						<a class="page-link" href="alarmList?pageNum=${num}&type=${param.type}">${num}</a>
					</li>
				</c:forEach>
				<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="alarmList?pageNum=${pageMaker.endPage+1 }&type=${param.type}">&raquo;</a>
				</li>
			</ul>
           </div>
          </div>
        </div>
    </section>
</div>