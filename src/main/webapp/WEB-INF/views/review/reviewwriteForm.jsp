<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	String contextPath = request.getContextPath();
	request.setAttribute("contextPath", contextPath);
%>
<script type="text/javascript" src="${contextPath}/resources/js/board.js?var=1"></script>
<title>reviewwriteForm</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
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
	<div  class="container">
		<div class="jumbotron text-center">
			<h1>HWARANG</h1>
			<p>Your own exhibition</p>
		</div>
		<div class="form-group">
		<form action="write" method="post" id="writeForm" enctype="multipart/form-data">
			<!--  ${member_id} -->
			<input type="hidden" name="member_id" value="test">
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
				<!-- 
				<tr>
					<th>Img Upload (Max File:5MB)</th>
					<td>
						<input class="form-control" type="file" name="file" accept=".jpg, .jpeg, .png" multiple > 
					</td>
				</tr> 
				-->
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
			<input style="align-content: center;" class='btn btn-link' type="button" onclick="location.href='reviewboard'" value="List">
			</div>
		</form>
		</div>
	</div>
</body>
</html>
