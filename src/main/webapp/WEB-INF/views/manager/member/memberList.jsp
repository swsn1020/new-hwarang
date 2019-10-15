<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>Administrator - Members</title>
<%@include file="../../layout/managerSidebar.jsp"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!-- Google fonts - Poppins -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
<script	src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<script>
$(function(){
	if($("#selBox").val() == 'I'){
		$("#search").removeAttr("disabled");
	}
});
	function selectFunc() {
		var state = $("#selBox option:selected").val();
		if(state == 'I'){
			$("#search").attr("placeholder", "아이디를 입력하세요.");
			$("#search").attr("disabled", false);
		}else {
			$("#search").val("");
			$("#search").attr("disabled", true);
		}
	}
</script>
<style>
	th {
		text-align: center;
	}
</style>
<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1><strong>회원목록</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
           <div class="card-body" style="padding: 20px;">
          	<div class="left-col col-lg-6 d-flex align-items-center justify-content-between">
              <div class="project-title d-flex align-items-center">
                <div class="text">
               		<form id="sortForm" action="memberList" method="get">
						<select class="form-control-sm" name="type" id="selBox" onchange="selectFunc();">
							<option value="" <c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}"/>>TOTAL</option>
							<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>>WEEK</option>
							<option value="M" <c:out value="${pageMaker.cri.type eq 'M' ? 'selected' : ''}"/>>MONTH</option>
							<option value="Y" <c:out value="${pageMaker.cri.type eq 'Y' ? 'selected' : ''}"/>>YEAR</option>
							<option value="I" <c:out value="${pageMaker.cri.type eq 'I' ? 'selected' : ''}"/>>ID</option>
						</select>
						<input type="text" class="form-control-sm" name="keyword" id="search" disabled="disabled" value="<c:out value="${pageMaker.cri.keyword }"/>">
						<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
						<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
						<input type="submit" class="btn btn-outline-primary btn-sm" value="검색">
					</form>
                </div>
              </div>
            </div>
            	<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th style="width: 5%;">No</th>
								<th>ID</th>
								<th>NAME</th>
								<th>EMAIL</th>
								<th>REGISTER DATE</th>
								<th>ADDRESS</th>
								<th>Info</th>
							</tr>
						</thead>
						<tbody>
<%-- 							<c:set var="rnum" value="${pageMaker.total - ((pageMaker.cri.pageNum-1)*10)}"/> --%>
							<c:set var="rnum" value="${((pageMaker.cri.pageNum-1)*10) +1}"/>
							<c:forEach items="${memberList }" var="member" varStatus="vs">
								<fmt:formatDate value="${member.member_reg_date }" var="regDate" pattern="yyyy-MM-dd"/>
								<tr>
									<td style="text-align: center;">${rnum }</td>
									<td id="memId">${member.member_id }</td>
									<td style="text-align: center;">${member.member_name }</td>
									<td>${member.member_email }</td>
									<td style="text-align: center;">${regDate }</td>
									<td>${member.member_address }
									<td style="text-align: center;">
										<button id="memInfo" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#memModal${vs.index }">회원정보</button>
										<!-- The Modal -->
										  <div class="modal" id="memModal${vs.index }">
										    <div class="modal-dialog">
										      <div class="modal-content">
										        <!-- Modal Header -->
										        <div class="modal-header">
										          <h1 class="modal-title">'${member.member_name }'님의 회원정보</h1>
										          <button type="button" class="close" data-dismiss="modal">×</button>
										        </div>
										        <!-- Modal body -->
										        <div class="modal-body">
										        	<table class="table">
										        		<tr>
										        			<th>아이디</th>
										        			<td colspan="3">${member.member_id }</td>
										        		</tr>
										        		<tr>
										        			<th style="width: 20%;">이름</th>
										        			<td style="width: 40%;">${member.member_name }</td>
										        			<th>성별</th>
										        			<c:choose>
										        			<c:when test="${member.member_gender eq 0}">
										        				<td>남자</td>
										        			</c:when>
										        			<c:otherwise>
										        				<td>여자</td>
										        			</c:otherwise>
										        			</c:choose>
										        			
										        		</tr>
										        		<tr>
										        			<th>이메일</th>
										        			<td colspan="3">${member.member_email }</td>
										    			</tr>
										        		<tr>
										        			<th>주소</th>
										        			<td colspan="3">${member.member_address }</td>
										    			</tr>
										    			<tr>
										        			<th>가입일</th>
										        			<td colspan="3">${member.member_reg_date}</td>
										    			</tr>
										    			<tr>
										    				<th>신고수</th>
										    				<td colspan="3">${member.member_report_count }</td>
										    			</tr>
										    			<tr>
										    				<th>계정 상태</th>
										    				<td>${member.member_status }</td>
										    			</tr>
										        	</table>
										        	<br><br>
										        </div>
										        <!-- Modal footer -->
										        <div class="modal-footer">
										          <button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal">Close</button>
										        </div>
										      </div>
										    </div>
										  </div>
  
									</td>
								</tr>
<%-- 								<c:set var="rnum" value="${rnum-1 }"></c:set> --%>
								<c:set var="rnum" value="${rnum+1 }"></c:set>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<ul class="pagination justify-content-center">
					<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="memberList?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
					</li>
					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
						<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
							<a class="page-link" href="memberList?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">${num}</a>
						</li>
					</c:forEach>
					<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="memberList?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
					</li>
				</ul>
            </div>
          </div>
        </div>
     </section>
	</div>          
