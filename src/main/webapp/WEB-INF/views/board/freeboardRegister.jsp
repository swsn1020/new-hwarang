<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>자유게시판 게시물 등록</title>
<%@ include file="../layout/left.jsp" %>
<%@include file="../layout/rightUser.jsp"%>
	<div class="container">
		<h4>게시글 등록</h4>
		<div class="form-group">
		<form action="register" method="post" enctype="multipart/form-data">
			<sec:authentication property="principal.username" var="userid"/>
			<input type="hidden" name="userid" value="${userid}">
			<table class="table">
				<tr>
					<th>제목</th>
					<td><input class="form-control col-md-6" type="text" name="title"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea class="form-control" rows="20" name="content" style="resize: none;"></textarea>
					</td>
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
	</div>
<%@include file="../layout/bottom.jsp"%>