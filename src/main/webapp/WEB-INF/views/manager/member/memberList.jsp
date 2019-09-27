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
});
</script>
<div class="content-inner" style="padding-bottom: 59px;">
	<h2 style="padding-top: 40px;">Member Settings</h2><br>
	<form id="sortForm" action="memberList" method="get">
		<select class="form-control col-sm-1" name="type" style="display: inline-block;">
			<option value="" <c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}"/>>TOTAL</option>
			<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>>WEEK</option>
			<option value="M" <c:out value="${pageMaker.cri.type eq 'M' ? 'selected' : ''}"/>>MONTH</option>
			<option value="Y" <c:out value="${pageMaker.cri.type eq 'Y' ? 'selected' : ''}"/>>YEAR</option>
		</select>
		<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
		<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
		<input type="submit" class="btn btn-outline-success" value="보기"/>
	</form>
	<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>MEMEBER ID</th>
					<th>MEMEBER NAME</th>
					<th>MEMEBER EMAIL</th>
					<th>MEMEBER REGISTER DATE</th>
					<th>MEMEBER BLOCK COUNT</th>
					<th>MEMEBER STATUS</th>
					<th>MEMBER EDIT</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${memberList }" var="member" varStatus="vs">
					<fmt:formatDate value="${member.member_reg_date }" var="regDate" pattern="yyyy-MM-dd"/>
					<tr>
						<td>${member.member_id }</td>
						<td>${member.member_name }</td>
						<td>${member.member_email }</td>
						<td>${regDate }</td>
						<td>${member.member_report_count }</td>
						<td>${member.member_status }</td>
						<td>
							<button class="btn btn-outline-danger btn-sm">차단</button>
							<button id="btn-del" class="btn btn-outline-dark btn-sm" data-toggle="modal" data-target="#delModal${vs.index }">탈퇴</button>
							<!-- delMember Modal -->
						  	<div class="modal fade" id="delModal${vs.index }" style="text-align: center;">
						    	<div class="modal-dialog modal-dialog-centered">
						      		<div class="modal-content">
							        <!-- Modal Header -->
							        <div class="modal-header">
							          <h4 class="modal-title">회원탈퇴</h4>
							          <button type="button" class="close" data-dismiss="modal">&times;</button>
							        </div>
							        <!-- Modal body -->
							        <div class="modal-body">
							          <form id="delMemForm" action="delMember" method="post">
							          	<input type="hidden" name="member_id" value="${member.member_id }">
							          	${member.member_id }님을 탈퇴시키시겠습니까?<br><br>
							          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
							          	<button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal">닫기</button>
							          </form>
							        </div>
						      </div>
						    </div>
						  </div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- Pagination -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="memberList?pageNum=${pageMaker.startPage-1 }&type=${param.type}">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
					<a class="page-link" href="memberList?pageNum=${num}&type=${param.type}">${num}</a>
				</li>
			</c:forEach>
			<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="memberList?pageNum=${pageMaker.endPage+1 }&type=${param.type}">&raquo;</a>
			</li>
		</ul>
	</div>
</div>