<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 수정 화면 </title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$("a[name='fileDeleteBtn']").on("click", function() {
		$(this).parent().remove();
		var d = $(this).data("uuid");
		$.ajax({
			url: "fileDelete",
			data: {"uuid" : d},
			type: "post",
			dataType: "json",
			success: function(result){
				if(result){
					alert("file ajax() 삭제 성공");
				}else{
					alert("file ajax() 삭제 실패");
				}
			},
			error: function(){
				alert("file ajax() 삭제 오류");
			}
		});
	});
});

</script>
</head>
<body>
<div class="container">
	<h1>게시글 수정</h1>
	<form action="modify" method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}">
			<input type="hidden" name="num" value="${fboard.num}">
		<table>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="userid" value="${fboard.userid}"readonly="readonly"></td>
			</tr>
			<tr>	
				<th>제목</th>
				<td><input type="text" name="title" value="${fboard.title}"></td>
			</tr>	
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="10" cols="40" name="content">${fboard.content}</textarea>
				</td>
				</tr>
		<tr>
			<th></th>
				<td>
						<c:choose>
							<c:when test="${empty freeImgList}">
								<p><input type="file" name="file" multiple="multiple"></p>
							</c:when>
								<c:otherwise> 
									<c:forEach items="${freeImgList}" var="freeImg">
										<div>
											${freeImg.originName}
											<a href="#this" name="fileDeleteBtn" class="btn" data-uuid="${freeImg.uuid}">삭제</a>	
										</div>									
	        						</c:forEach>
	        						<!-- 파일 추가하기 -->
	        						<div>
	        						<input type="file" name="file" multiple="multiple">
	        						</div>
								</c:otherwise>
						</c:choose>
			</td>
		</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value = "수정">
						<input type="reset"  value = "다시작성">
						<input type="button" value ="목록" onclick="location.href='freeboard'">
					</td>
				</tr>
		</table>
	</form>
</div>
</body>
</html>