<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>공지사항-수정</title>
<%@include file="../../layout/managerSidebar.jsp"%>
<script type="text/javascript" src="/resources/js/manager/validationCheck.js"></script>
<script>
$(function(){
	$("#noticeForm").on("submit", function(){
		var validation = valCheck("noticeForm");
		if(!validation){
			return false;
		}
	});
});
</script>
<style>
	h1{
		color: #725974;
	}
	.form-control:focus {
		border-color: #9C869C;
		-webkit-box-shadow: 0 0 0 0.2rem rgba(156, 134, 156, 0.25);
  		box-shadow: 0 0 0 0.2rem rgba(156, 134, 156, 0.25);
	}
</style>
<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1><strong>공지 수정</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
           <div class="card-body" style="padding: 20px;">
			<div class="form-group">
				<form id="noticeForm" action="noticeModify" method="post">
					<input type="hidden" name="num" value="${notice.num }">
					<table class="table">
						<tr>
							<th style="width: 15%;">분류</th>
							<td>
								<select class="form-control col-md-3" name="category">
									<!-- 중요는 top에 올리기 -->
									<option value="import" selected="selected">공지</option>
									<option value="notice">기본</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>
								<input type="text" name="title" class="form-control col-md-6" value="${notice.title }">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<textarea class="form-control" name="content" rows="15" style="resize: none;">${notice.content }</textarea>
							</td>
						</tr>
						</table>
						
						<div class="btnDiv" style="text-align: center;">
							<!-- 수정확인 버튼+modal -->
							<button type="button" class="btn btn-outline-success btn-sm" data-toggle="modal" data-target="#modiModal">수정</button>
							<input type="reset" class="btn btn-outline-dark btn-sm" value="초기화">
							<input type="button" class="btn btn-outline-info btn-sm" onclick="location.href='noticeListForManager'" value="목록">
						</div>
						<!-- The Modal -->
						  <div class="modal fade" id="modiModal" style="text-align: center;">
						    <div class="modal-dialog modal-dialog-centered">
						      <div class="modal-content">
						        <!-- Modal Header -->
						        <div class="modal-header">
						          <h4 class="modal-title">수정</h4>
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						        </div>
						        <!-- Modal body -->
						        <div class="modal-body" style="text-align: center;">
						        	<p>공지사항을 수정하시겠습니까?</p>
						          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
						          	<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">닫기</button>
						        </div>
						      </div>
						    </div>
						  </div>
				        <!-- The Modal end -->
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
</div>