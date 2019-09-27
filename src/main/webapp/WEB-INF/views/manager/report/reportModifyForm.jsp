<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고게시판-수정</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript" src="/resources/js/manager/validationCheck.js"></script>
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
	
	var originCategory = '${report.category}';
	var category = originCategory.substring(0, originCategory.indexOf("_"));
	var subCategory = originCategory.substring(originCategory.indexOf("_")+1);
	$("#category option[value='"+category+"']").attr("selected", "selected");
	$("#subCategory option[value='"+subCategory+"']").attr("selected", "selected");
	
	$("#replyForm").on("submit", function(){
		var validation = valCheck("replyForm");
		if(!validation){
			return false;
		}
	});
});

function doChange(srcE, targetId){
    var val = srcE.options[srcE.selectedIndex].value;
    var targetE = document.getElementById(targetId);
    removeAll(targetE);

    if(val == 'Notice'){
		var newOption = new Option('댓글', 'Reply', true, true);
		$("#subCategory").append(newOption);
    } else if(val == ''){
    	
    }
    else {
    	var newOption1 = new Option('게시글', 'Board', true, true);
		$("#subCategory").append(newOption1);
		var newOption2 = new Option('댓글', 'Reply');
		$("#subCategory").append(newOption2);
    }
}

function removeAll(e){
    for(var i = 0, limit = e.options.length; i < limit - 1; ++i){
        e.remove(1);
    }
}
</script>
	<div class="container">
		<div class="form-group">
		<!-- 이미지 넣기 -->
		<form id="replyForm" action="reportModify" method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="hidden" name="num" value="${report.num }">
<!-- 			<input type="hidden" name="memId" value="haddie"> -->
			<table class="table">
				<tr>
					<th>게시판 종류</th>
					<td>
						<select id="category" name="category" class="form-control col-sm-3" onchange="doChange(this, 'subCategory')" style="display: inline-block;">
							<option value="default">--게시판 선택--</option>
							<option value="Notice">공지게시판</option>
							<option value="Free">자유게시판</option>
							<option value="Review">후기게시판</option>
							<option value="Exhibition">전시게시판</option>
							<option value="Ticket">티켓나눔게시판</option>
							<option value="Funding">펀딩게시판</option>
							<option value="Party">파티원게시판</option>
						</select>
						<select id="subCategory" name="subCategory" class="form-control col-sm-3" style="display: inline-block;">
							<option value="default">--분류--</option>
							<option value="Board">게시글</option>
							<option value="Reply">댓글</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input class="form-control" type="text" name="title" value="${report.title }">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea class="form-control" rows="10" name="content" style="resize: none;">${report.content }</textarea>
					</td>
				</tr>
				<tr>
					<th>파일 첨부</th>
					<td>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${empty reportImgList }"> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
								<c:forEach items="${reportImgList }" var="reportImg">
									<div>
										${reportImg.originName }
										<a href="#this" name="fileDeleteBtn" class="btn" data-uuid="${reportImg.uuid }">삭제</a>
									</div>
								</c:forEach>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
							<p style="margin: 5px;"><input type="file" name="file" multiple="multiple"></p>
					</td>
				</tr>
			</table>
			<div class="btn-div" style="text-align: center;">
				<input type="submit" class="btn btn-outline-primary" value="수정">
				<input type="button" class="btn btn-outline-info" value="목록" onclick="location.href='reportList'">
			</div>
		</form>
		</div>
	</div>
<%@ include file="../../layout/bottom.jsp"%>