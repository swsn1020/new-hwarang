<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-문의내역 수정</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript" src="/resources/js/manager/validationCheck.js"></script>
<script>
$(function(){
	$("a[name='fileDeleteBtn']").on("click", function() {
		$(this).parent().remove();
		var d = $(this).data("uuid");
		alert(d);
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
	
	$("#qnaForm").on("submit", function(){
		var validation = valCheck("qnaForm");
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
		<h3>질문 수정</h3>
		<div class="form-group">
		<form id="qnaForm" action="qnaModify" method="post" enctype="multipart/form-data">
			<input type="hidden" name="num" value="${qna.num }">
			<!-- 	write한사람이랑 같아야, 로그인한 사람과 일치		<input type="hidden" name="memId" value="haddie"> -->
			<table class="table">
				<tr>	
					<!-- 문의 종류 -->
					<th style="width: 17%">문의분류</th>
					<td>
						<select id="category" name="category" class="form-control col-md-3" style="display: inline-block;"  onchange="doChange(this, 'subCategory')">
							<option value="info">고객정보</option>
							<option value="order">주문</option>
							<option value="Board">게시판</option>
							<option value="other">기타</option>
						</select>
						<select id="subCategory" name="subCategory" class="form-control col-md-3" style="display: inline-block;">
							<option value="modiInfo">정보수정</option>
							<option value="delInfo">회원탈퇴</option>
							<option value="pay">결제</option>
							<option value="cancel">취소</option>
							<option value="change">변경</option>
							<option value="refund">환불</option>
							<option value="Exhibit">전시</option>
							<option value="Notice">공지게시판</option>
							<option value="Report">신고게시판</option>
							<option value="Free">자유게시판</option>
							<option value="Recommend">추천게시판</option>
							<option value="Funding">펀딩게시판</option>
							<option value="Review">후기게시판</option>
							<option value="Ticket">티켓나눔게시판</option>
							<option value="service">기타 서비스</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input class="form-control" type="text" name="title" value="${qna.title}">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea class="form-control" rows="15" name="content" style="resize: none;">${qna.content }</textarea>
					</td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td>
							<c:forEach items="${qnaImgList }" var="qnaImg">
								<div>
									${qnaImg.originName }
									<a href="#this" name="fileDeleteBtn" class="btn" data-uuid="${qnaImg.uuid }">삭제</a>
								</div>
							</c:forEach>
							<!-- 파일 추가하기 -->
							<p style="margin: 5px;"><input type="file" name="file" multiple="multiple"></p>
					</td>
				</tr>
			</table>
			<div class="btnGroup" style="text-align: center;"> 
				<input type="submit" class="btn btn-outline-primary btn-sm" value="수정">
				<input type="button" class="btn btn-outline-dark btn-sm" value="목록" onclick="location.href='qnaListForUser?memId=${qna.memId}'">
			</div>
		</form>
		</div>
	</div>
<%@ include file="../../layout/bottom.jsp"%>