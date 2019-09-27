<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>상세보기</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript">
	$(function(){
		$(".btn").click(function(){
			$("#btnCheck").attr("value",$(this).attr("name"));
		});
		
	});
</script>
	<div class="container">
		<h3>화랑-신고-상세보기</h3>
		<table class="table">
			<fmt:formatDate value="${block.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
			<fmt:formatDate value="${block.manageDate }" var="manageDate" pattern="yyyy-MM-dd"/>
			<tr>
				<th>카테고리</th>
				<td colspan="3">${category }_${subCategory }</td>
			</tr>
			<tr>
				<th>신고 대상 ID</th>
				<td>${block.blockMemId}</td>
				<th>신고 대상 번호</th>
				<td>${block.boardNum }</td>
			</tr>
			<tr>
				<th>신고일</th>
				<td>${regDate }</td>
				<th>답변 등록일</th>
				<td>${manageDate }</td>
			</tr>
			<tr>
				<th>신고 대상 내용</th>
				<td colspan="3">${originContent }</td>
			</tr>
			<tr>
				<th>신고 사유</th>
				<td colspan="3">${block.content }</td>
			</tr>
			<tr>
				<th>처리상태</th>
				<td colspan="2">${block.reply }</td>
				<td>
<%-- 					<c:if test="">	<!-- 관리자이면 버튼 보이기 --> --%>
						<button class="btn btn-outline-info btn-sm" data-toggle="collapse" data-target="#replyForm">답변 등록</button>
<%-- 					</c:if>	 --%>
				</td>
			</tr>
			
			
		</table>
<%-- 			<c:choose> --%>
<%-- 				<c:if test="${block.memId  eq 'h' }"> --%>
					<div id="replyForm" class="form-group collapse">
						<form action="replyModify" method="post">
							<input type="hidden" name="num" value="${block.num }">
							<textarea class="form-control" rows="5" name="reply" placeholder="${block.reply }" style="resize: none;"></textarea>
							<br>
							<input class="btn btn-outline-primary btn-sm" type="submit" value="답변등록하기">
						</form>
					</div>
<%-- 					</c:if> --%>
<%-- 				</c:when> --%>
<%-- 				<c:otherwise>  --%>
<%-- 					<c:if test="${block.reply eq '미확인' || block.reply eq null}"> --%>
<!-- 						<button type="button" class="btn btn-outline-success btn-sm" name="modify" data-toggle="modal" data-target="#checkPwModal">수정</button> -->
<%-- 					</c:if>  --%>
					<button type="button" class="btn btn-outline-danger btn-sm" name="delete" data-toggle="modal" data-target="#checkPwModal">삭제</button>
<%-- 				</c:otherwise> --%>
<%-- 			</c:choose> --%>
			
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
			          	<input type="hidden" name="memId" value="haddie">
			          	<input type="hidden" name="num" value="${block.num }"> 비밀번호를 입력하세요 <br><br>
			          	<input type="password" name="password"> <br><br>
			          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
			          	<button type="button" class="btn btn-outline-dark btn-sm" data-dismiss="modal">Close</button>
			          </form>
			        </div>
			      </div>
			    </div>
			  </div>
		    <button class="btn btn-outline-dark btn-sm" onclick="history.go(-1)">목록</button>
	</div>
<%@ include file="../../layout/bottom.jsp"%>