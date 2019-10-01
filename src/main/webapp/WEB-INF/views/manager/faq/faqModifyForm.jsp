<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-자주하는질문-수정</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript" src="/resources/js/manager/validationCheck.js"></script>
<script type="text/javascript">
$(function(){
	$("#faqForm").on("submit", function(){
		var validation = valCheck("faqForm");
		if(!validation){
			return false;
		}
	});
});
</script>
	<div class="container">
		<div class="form-group">
			<form id="faqForm" action="faqModify" method="post">
				<input type="hidden" name="num" value="${faq.num}"/>
				<table class="table">
					<tr>
						<th style="width: 15%;">분류</th>
						<td>
							<select id="category" name="category" class="form-control col-md-3">
								<!-- 중요는 top에 올리기 -->
								<option value="[공지]" selected="selected">공지사항</option>
								<option value="[문의]">문의사항</option>
								<option value="[주문/결제]">주문/결제</option>
								<option value="[게시판]">게시판</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>질문</th>
						<td>
							<input type="text" name="question" class="form-control col-md-6" value="${faq.question }" >
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<textarea class="form-control" rows="15" name="answer" style="resize: none;">${faq.answer }</textarea>
						</td>
					</tr>
				</table>
				<div class="btnDiv" style="text-align: center;">
					<input type="submit" value="수정" class="btn btn-outline-success btn-sm"/>
					<input type="reset" value="초기화" class="btn btn-outline-dark btn-sm">
					<input type="button" onclick="location.href='faqList'" value="목록" class="btn btn-outline-info btn-sm">
				</div>
			</form>
		</div>
	</div>
<%@ include file="../../layout/bottom.jsp"%>