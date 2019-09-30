<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>공지사항-작성</title>
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
		<h3>공지사항 작성하기</h3>
		<div class="form-group">
		<form id="noticeForm" action="noticeWrite" method="post">
			<!-- security Token -->
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="hidden" name="memId" value="">
			<div class="table-responsive">
			<table class="table">
				<tr>
					<th>분류</th>
					<td>
					<select name="category" class="form-control col-md-3">
						<!-- 중요는 top에 올리기 -->
						<option value="import" selected="selected">공지</option>
						<option value="notice">기본</option>
					</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" class="form-control col-md-6"></td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea class="form-control" rows="10" name="content" style="resize: none;" ></textarea>
					</td>
				</tr>
			</table>
			</div>
			<input type="submit" value="작성"> 
			<input type="reset" value="초기화"> 
			<input type="button" onclick="location.href='noticeList'" value="목록">
		</form>
		</div>
	</div>
<%@ include file="../../layout/bottom.jsp"%>