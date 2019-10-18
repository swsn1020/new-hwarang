<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>Members Authorization</title>
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
<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1><strong>회원 권한 설정</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
           <div class="card-body" style="padding: 20px;">
          	<div class="left-col col-lg-6 d-flex align-items-center justify-content-between">
              <div class="project-title d-flex align-items-center">
                <div class="text">
               		<form id="sortForm" action="memberAuth" method="get">
						<select class="form-control-sm" name="type" id="selBox" onchange="selectFunc();">
							<option value="" <c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}"/>>TOTAL</option>
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
								<th style="width: 10%;">No</th>
								<th>ID</th>
								<th>NAME</th>
								<th>REGISTER DATE</th>
								<th style="width: 10%;">BLOCK COUNT</th>
								<th>STATUS</th>
								<th>EDIT</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="rnum" value="${((pageMaker.cri.pageNum-1)*10) +1}"/>
							<c:forEach items="${memberList }" var="member" varStatus="vs">
								<fmt:formatDate value="${member.member_reg_date }" var="regDate" pattern="yyyy-MM-dd"/>
								<tr>
									<td>${rnum }</td>
									<td id="memId">${member.member_id }</td>
									<td>${member.member_name }</td>
									<td>${regDate }</td>
									<td>${member.member_report_count }</td>
									<c:choose>
										<c:when test="${member.member_status eq 'disabled' }">
											<td style="color: #9E1C20; font-weight: bold;">${member.member_status }</td>
										</c:when>
										<c:otherwise>
											<td>${member.member_status }</td>
										</c:otherwise>
									</c:choose>
									<td>
										<c:if test="${member.member_status != 'disabled'}">
											<button id="block-btn" class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target="#blockModal${vs.index }">차단</button>
										</c:if>
										<!-- blockMember Modal -->
									  	<div class="modal fade" id="blockModal${vs.index }" style="text-align: center;">
									    	<div class="modal-dialog modal-dialog-centered">
									      		<div class="modal-content">
										        <!-- Modal Header -->
										        <div class="modal-header">
										          <h4 class="modal-title">회원차단</h4>
										          <button type="button" class="close" data-dismiss="modal">&times;</button>
										        </div>
										        <!-- Modal body -->
										        <div class="modal-body">
										          <form id="bMemForm" action="/block/blockMember" method="post">
										          	<input type="hidden" name="member_id" value="${member.member_id }">
										          	${member.member_id }님을 활동정지 시키겠습니까?<br><br>
										          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
										          	<button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal">닫기</button>
										          </form>
										        </div>
									      </div>
									    </div>
									  </div>
										
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
								<c:set var="rnum" value="${rnum+1 }"></c:set>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<ul class="pagination justify-content-center">
					<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="memberAuth?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
					</li>
					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
						<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
							<a class="page-link" href="memberAuth?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">${num}</a>
						</li>
					</c:forEach>
					<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="memberAuth?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
					</li>
				</ul>
            </div>
          </div>
        </div>
     </section>
	</div>          
