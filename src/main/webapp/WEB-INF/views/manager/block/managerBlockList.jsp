<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-전체 신고 현황</title>
<%@ include file="../../layout/managerSidebar.jsp" %>
<script type="text/javascript">
	$(function(){
		
	});
/*
	function replyRegister(modalId){
		var blockNum = $("#"+modalId).find('input[name="bsNum"]').val();
		var reply = $("#"+modalId).find('textarea').val();
// 		var blockMemId = $("#"+modalId).find('input[name="blockMemId"]');
	//		alert(reply);
		var d = {"num": blockNum, "reply": reply};
		console.log(d);
		$.ajax({
			url: "replyModify",
			data: d,
			type: "post",
			dataType: "json",
			processData: false,
			contentType: false,
			success: function(result){
				if(result){
					alert("답변이 등록되었습니다.");
					location.reload();
				}else{
					alert("답변 등록 다시시도!");
				}
			},
			error: function(){
				alert("답변등록 ajax 오류");
			}
		});
	}
	*/
</script>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	table th, td {
		text-align: center;
/* 		background-color: #fff; */
	}
 	.btn-outline-danger { 
 		color: #D06C56; 
		border-color: #D06C56; 
 	}
	.btn-outline-danger:hover {
		border-color: #80425A;
		background-color: #80425A;
	}
</style>
<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1 style="color: #74655F"><strong>Block Status</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
          	<div class="card-body" style="padding: 20px;">
          		<div class="table-responsive">
          		<table class="table table-hover" id="blocks">
					<thead>
						<tr>
							<th style="width: 10%;">신고번호</th>
							<th >게시판</th>
							<th>게시글번호</th>
							<th style="width: 15%">작성자</th>
							<th style="width: 15%">신고일</th>
							<th colspan="2">처리상태</th>
						</tr>
					</thead>
					<c:forEach items="${blockList }" var="block" varStatus="vs">
						<fmt:formatDate value="${block.regDate }" var="regDate"	pattern="yyyy-MM-dd" />
						<tr>
							<td>${block.num }</td>
							<td>${block.category }</td>
							<td>${block.boardNum }</td>
							<td>${block.memId }</td>
							<td>${regDate }</td>
							<td>
							<c:choose>
								<c:when test="${block.reply eq '미확인' }">
									<button type="button" id="btn-reply" class="btn btn-outline-danger btn-sm" onclick="location.href='/block/blockView?num=${block.num}'">답변하기</button>
								</c:when>
								<c:otherwise>
									<button type="button" id="btn-reply" class="btn btn-outline-dark btn-sm" data-toggle="modal" data-target="#replyModal${vs.index }">답변완료</button>
								</c:otherwise>
							</c:choose>
								<!-- Reply Modal -->
								<div class="modal" id="replyModal${vs.index }">
									<div class="modal-dialog">
										<div class="modal-content">
											<!-- Modal Header -->
											<div class="modal-header">
												<h2 class="modal-title">답변작성</h2>
												<button type="button" class="close" data-dismiss="modal">×</button>
											</div>
											<!-- Modal body -->
											<div class="modal-body">
												<table class="table">
													<tr>
														<th style="width: 25%;">신고사유</th>
														<td>
															<div style="margin: 10px;">${block.content}</div>
														</td>
													</tr>
													<tr>
														<th>처리 메세지</th>
														<td>
															<textarea class="form-control" name="reply" id="reply" rows="5" style="resize: none;">${block.reply }</textarea>
														</td>
													</tr>
												</table>
											</div>
											<!-- Modal footer -->
											<div class="modal-footer">
<%-- 												<input type="hidden" name="bsNum" value="${block.num }"> --%>
<%-- 												<input type="hidden" name="blockMemId" value="${block.blockMemId }"> --%>
<%-- 												<button type="button" class="btn btn-outline-primary btn-sm" onclick="replyRegister('replyModal${vs.index }');">답변등록</button> --%>
												<button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal">닫기</button>
											</div>
										</div>
									</div>
								</div>
							</td>
						</c:forEach>
					</table>	
          	  	</div>
				<!-- Pagination -->
				<ul class="pagination justify-content-center">
					<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="blockListForManager?pageNum=${pageMaker.startPage-1 }">&laquo;</a>
					</li>
					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
						<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
							<a class="page-link" href="blockListForManager?pageNum=${num}">${num}</a>
						</li>
					</c:forEach>
					<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="blockListForManager?pageNum=${pageMaker.endPage+1 }">&raquo;</a>
					</li>
				</ul>
          	</div>
          </div>
        </div>
	</section>	
</div>
		
		
<%-- <%@ include file="../../layout/bottom.jsp"%> --%>