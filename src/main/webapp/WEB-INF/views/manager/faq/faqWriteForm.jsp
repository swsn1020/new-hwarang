<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-FAQ</title>
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
			<form id="faqForm" action="faqWrite" method="post">
				<div class="table-responsive">
					<table class="table">
						<tr>
							<th>분류</th>
							<td>
								<select class="form-control col-sm-3" name="category">
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
							<td><input type="text" class="form-control" name="question"></td>
						</tr>
						<tr>
							<th>답변</th>
							<td>
								<textarea name="answer" class="form-control" rows="10" style="resize: none;"></textarea>
							</td>
						</tr>
					</table>
			</div>
			<div>
				<input type="submit" value="작성" class="btn btn-outline-success">> 
				<input type="reset" value="초기화" class="btn btn-outline-danger"> 
				<input type="button" onclick="location.href='faqList'" value="목록"  class="btn btn-outline-dark">
			</div>
		</form>
		</div>
	</div>
<%@ include file="../../layout/bottom.jsp"%>