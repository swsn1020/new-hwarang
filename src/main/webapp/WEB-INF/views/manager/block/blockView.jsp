<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>상세보기</title>
<%@ include file="../../layout/managerSidebar.jsp" %>
<script type="text/javascript">
	$(function(){
		$(".btn").click(function(){
			$("#btnCheck").attr("value",$(this).attr("name"));
		});
		var	reply = '${block.reply}';
		if(reply == null || reply == '미해결'){
			
		}
	});
</script>
<div class="content-inner" style="padding-bottom: 59px;">
<section class="projects no-padding-top">
	<div class="contianer-fluid">
		<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
			<h1><strong>신고 상세보기</strong></h1>
		</div>
	</div>
	<div class="project" id="project3">
	<div class="row bg-white has-shadow">
		<div class="card-body" style="padding: 20px;">
			<div class="table-responsive">
				<table class="table">
					<fmt:formatDate value="${block.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
					<fmt:formatDate value="${block.manageDate }" var="manageDate" pattern="yyyy-MM-dd"/>
					<tr>
						<th style="width: 20%">카테고리</th>
						<td colspan="4">${category }_${subCategory }</td>
					</tr>
					<tr>
						<th>신고일</th>
						<td>${regDate }</td>
						<td></td>
						<th style="width: 20%">작성자ID</th>
						<td>${block.memId }</td>
					</tr>
					<tr>
						<th>신고 사유</th>
						<td colspan="4">${block.content }<br><br></td>
					</tr>
					<tr>
						<td colspan="5" style="text-align: center;">
							<a href="#" data-toggle="collapse" data-target="#blocked"><i class="fas fa-chevron-down fa-2x"></i></a>
						</td>
					</tr>
					</table>
					<div class="collapse" id="blocked">
					<table class="table">
					<tr>
						<th>신고 대상 ID</th>
						<td colspan="2">${block.blockMemId }</td>
						<th>신고 대상 게시글 번호</th>
						<td>${block.boardNum }</td>
					</tr>
					<tr>
						<th>신고 대상 제목</th>
						<td colspan="4">${block.boardTitle }<br><br></td>
					</tr>
					<tr>
						<th>신고 대상 내용</th>
						<td colspan="4">${originContent }<br><br></td>
					</tr>
					<tr>
						<th>처리상태</th>
						<td>${block.reply }</td>
						<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
							<td><button class="btn btn-outline-info btn-sm" data-toggle="collapse" data-target="#replyForm">답변등록</button></td>
						</sec:authorize>
						<th>답변 등록일</th>
						<c:choose>
							<c:when test="${block.reply != '미해결' || block.reply != null }">
								<td>${manageDate }</td>
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
				</div>
				<!-- 답변 등록 Form -->
				<div id="replyForm" class="form-group collapse">
					<form action="replyModify" method="post" style="text-align: center;">
						<input type="hidden" name="num" value="${block.num }">
						<textarea class="form-control" rows="5" name="reply" placeholder="${block.reply }" style="resize: none;"></textarea>
						<br>
						<input class="btn btn-outline-primary btn-sm" type="submit" value="답변등록">
					</form>
				</div>
				<br><br>
				<div class="btnGroup" style="text-align: center;">
					<sec:authorize access="!hasRole('ROLE_ADMIN') && !hasRole('ROLE_MANAGER')">
						<button type="button" class="btn btn-outline-danger btn-sm" name="delete" data-toggle="modal" data-target="#checkPwModal">삭제</button>
					</sec:authorize>
					<button class="btn btn-outline-dark btn-sm" onclick="history.go(-1)">목록</button>
				</div>
			
				<!-- The Modal -->
				  <div class="modal fade" id="checkPwModal" style="text-align: center;">
				    <div class="modal-dialog modal-dialog-centered">
				      <div class="modal-content">
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h4 class="modal-title">비밀번호 확인</h4>
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				        </div>
				        <!-- Modal body -->
				        <div class="modal-body">
				          <form action="checkPw" method="post">
				          	<input type="hidden" name="type" id="btnCheck"/>
				          	<input type="hidden" name="num" value="${block.num }"> 
				          	<p>비밀번호를 입력하세요 </p>
				          	<input type="password" name="password"> <br><br>
				          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
				          	<button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal">닫기</button>
				          </form>
				        </div>
				      </div>
				    </div>
				  </div>
			  
			 </div>
		</div>   
	</div>
	</div>
</section>
</div>
