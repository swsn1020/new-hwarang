<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-FAQ</title>
<%@ include file="../../layout/managerSidebar.jsp" %>
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
<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1 style="color: #74655F"><strong>FAQ 작성</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
          	<div class="card-body" style="padding: 20px;">
				<div class="form-group">
					<form id="faqForm" action="faqWrite" method="post">
						<div class="table-responsive">
							<table class="table">
								<tr>
									<th style="width: 10%;">분류</th>
									<td>
										<select class="form-control col-md-3" name="category">
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
									<td><input type="text" class="form-control col-md-8" name="question"></td>
								</tr>
								<tr>
									<th>답변</th>
									<td>
										<textarea name="answer" class="form-control" rows="15" style="resize: none;"></textarea>
									</td>
								</tr>
							</table>
						</div>
						<div class="btnGroup" style="text-align: center;">
							<input type="submit" value="작성" class="btn btn-outline-primary btn-sm">
							<input type="reset" value="초기화" class="btn btn-outline-dark btn-sm"> 
							<input type="button" onclick="location.href='faqList'" class="btn btn-outline-info btn-sm" value="목록">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
</div>
