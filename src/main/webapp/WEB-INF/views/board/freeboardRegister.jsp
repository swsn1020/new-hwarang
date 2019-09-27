<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 게시물 등록</title>
</head>
<body>
	<div>
		<h1>게시글 등록</h1>
		<form action="register" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th>작성자</th>
					<td><input type="text" name="userid"></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="40" name="content">
						</textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="file" name="file" multiple="multiple">
						<input type="submit" value = "등록">
						<input type="reset"  value = "다시작성">
						<input type="button" value ="목록" onclick="location.href='freeboard'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>