<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>공지사항-수정</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript" src="/resources/js/manager/validationCheck.js"></script>
<script>
$(function(){
	$("#noticeForm").on("submit", function(){
		var validation = valCheck("noticeForm");
		if(!validation){
			return false;
		}
	});
});
</script>
	<div class="container">
		<div class="form-group">
		<form id="noticeForm" action="noticeModify" method="post">
			<input type="hidden" name="num" value="${notice.num }">
			<!-- security Token -->
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<table class="table">
				<tr>
					<td>분류</td>
					<td>
						<select class="form-control col-md-3" name="category">
							<!-- 중요는 top에 올리기 -->
							<option value="import" selected="selected">공지</option>
							<option value="notice">기본</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="title" class="form-control col-md-6" value="${notice.title }">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea class="form-control" name="content" style="resize: none;">${notice.content }</textarea>
					</td>
				</tr>
				</table>
				
				<!-- 수정확인 버튼+modal -->
				<button type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#modiModal">수정</button>
				<!-- The Modal -->
				  <div class="modal fade" id="modiModal">
				    <div class="modal-dialog modal-dialog-centered">
				      <div class="modal-content">
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h4 class="modal-title">수정</h4>
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				        </div>
				        <!-- Modal body -->
				        <div class="modal-body" style="text-align: ceneter;">
				        	<p>공지사항을 수정하시겠습니까?</p>
				          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
				          	<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
				        </div>
				      </div>
				    </div>
				  </div>
		        <!-- The Modal end -->
				<input type="reset" class="btn btn-outline-dark btn-sm" value="초기화">
				<input type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='noticeList'" value="목록">
		</form>
		</div>
	</div> <!-- container -->
<%@ include file="../../layout/bottom.jsp"%>