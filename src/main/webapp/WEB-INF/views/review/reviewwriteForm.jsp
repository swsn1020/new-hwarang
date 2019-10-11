<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../layout/left.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/js/board.js?var=1"></script>
<title>reviewwriteForm</title>
<script type="text/javascript">
</script>
<script type="text/javascript">
$(function(){
	$("#writeForm").on("submit",function(){
		//만약에 필수요소가 제대로 채워지지 않았으면 return false;
		var result = boardCheck("writeForm");
		if(!result){		
			return false;
		}
	});
});
</script>
</head>
<body>
		<div align="center">
			<h1>관람 후기</h1>
		</div>
		<div class="form-group">
		<form action="write" method="post" id="writeForm" enctype="multipart/form-data">
			<!--  ${member_id} -->
			<sec:authentication property="principal.username" var="id"/>
			<input type="hidden" name="member_id" value="${id}">
			<table class="table">
				<tr>
					<th>Program name</th>
					<td>
						<%-- ${review_exh_name} --%> 
						<input class="form-control" type="text" name="review_exh_name" value="test_exh_name">
					</td>
				</tr>
				<tr>
					<th>Title</th>
					<td><input class="form-control" type="text" name="review_title"></td>
				</tr>
				<tr>
					<th>Content</th>
					<td><textarea class="form-control" name="review_content" rows="10" cols="50"></textarea>
					</td>
				</tr>
				<tr>
					<th>Img Upload (Max File:5MB)</th>
					<td>
						<input multiple="multiple" type="file" name="file" accept=".jpg, .jpeg, .png">
					</td>
				</tr>
			</table>
			<div align="center">
			<input style="align-content: center;" class='btn btn-link' type="submit" value="Ok"> 
			<input style="align-content: center;" class='btn btn-link' type="reset" value="Reset">
			<!-- 목록으로 돌아갈때 member_id 필요 -->
			<input style="align-content: center;" class='btn btn-link' type="button" onclick="location.href='/review/reviewboard'" value="List">
			</div>
		</form>
		</div>
<%@ include file="../layout/bottom.jsp"%>
</body>
</html>
