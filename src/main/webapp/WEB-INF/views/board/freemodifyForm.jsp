<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>자유게시판 수정 화면 </title>
<%@ include file="../layout/menu.jsp" %>
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
<div class="container">
	<div style="border-top: 2px solid black;"></div>		
	<h4>게시글 수정</h4>
	<div class="form-group">
	<form action="modify" method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}">
			<input type="hidden" name="num" value="${fboard.num}">
		<table class="table">
			<tr>	
				<th>제목</th>
				<td><input class="form-control col-md-6" type="text" name="title" value="${fboard.title}"></td>
			</tr>	
			<tr>
				<th>내용</th>
				<td>
					<textarea class="form-control" rows="20" name="content">${fboard.content}</textarea>
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
</div>
<%@include file="../layout/bottom.jsp"%>