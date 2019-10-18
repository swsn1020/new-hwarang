<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-나의 질문내역</title>
<%@ include file="../../layout/menu.jsp" %>
<%@include file="../../layout/rightUser.jsp"%>
<script>
$(function(){
	$(".btn").click(function(){
		 $("#btnCheck").attr("value",$(this).attr("name"));
	});
	
	//category 설정
	var originCategory = '${qna.category}';
	var category = originCategory.substring(0, originCategory.indexOf("_"));
	var subCategory = originCategory.substring(originCategory.indexOf("_")+1);
	$("#category option[value='"+category+"']").attr("selected", "selected");
	$("#subCategory option[value='"+subCategory+"']").attr("selected", "selected");
	
});  
	//첨부파일 이름
	function getOriginFileName(fullName){
		if(!fullName){
			return;
		}
		var idx = fullName.lastIndexOf(indexOf("_"))+1;
		return fullName.substring(idx);
	}
</script>
<style>
	.container{
		margin: 0 20% 0 20%;
		padding-left: 50px;
		padding-right: 50px;
	}
</style>
	<fmt:formatDate value="${qna.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
	<div class="container">
		<h3>내가 문의 글</h3>
		<div style="border-top: 2px solid black;"></div>
		<table class="table">
			<tr>
				<th style="width: 17%;">문의분류</th>
				<td colspan="3">
					<select id="category" name="category" class="col-md-3" disabled="disabled" style="display: inline-block;">
						<option value="info">고객정보</option>
						<option value="order">주문</option>
						<option value="Board">게시판</option>
						<option value="other">기타</option>
					</select>
					<select id="subCategory" name="subCategory" class="col-md-3" disabled="disabled" style="display: inline-block;">
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
						<option value="service">기타 서비스</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${qna.title }</td>
			</tr>
			<tr>
				<td><strong>작성자</strong>&nbsp; ${qna.memId } </td>
				<td colspan="2" style="width: 70%;;">
					<strong>작성일</strong>&nbsp; ${regDate}
				</td>
				<td>
					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
						<button class="btn btn-info btn-sm" data-toggle="collapse" data-target="#replyForm">답변등록</button>
					</sec:authorize>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;">${qna.content }<br><br><br><br><br></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<div class="fileDiv">
						<c:choose>
							<c:when test="${empty qnaImgList }">
								<p>첨부된 파일이 없습니다.</p>
							</c:when>
							<c:otherwise>
								<c:forEach items="${qnaImgList }" var="qnaImg" varStatus="vs">
									<div>
										<img src="downloadThumb?uuid=${qnaImg.uuid }">&nbsp;&nbsp;<a href="download?uuid=${qnaImg.uuid }">${qnaImg.originName }</a>
										<br><br>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</td>
			</tr>
		</table>
		<div style="border-top: 2px solid black;"></div>
		<br>
		<table class="table">
			<tr>
				<th style="width: 17%; border-top: none;" rowspan="3">답변 내용</th>
				<td colspan="3" rowspan="3" style="border-top: none; ">${qna.reply }</td>
			</tr>
			<tr>
				<!-- 답변등록Form -->
				<td colspan="4" style="border-top: none;">
					<div class="form-group collapse" id="replyForm" style="text-align: center;">
						<form action="replyModify" method="post">
							<input type="hidden" name="num" value="${qna.num }">
							<textarea class="form-control" rows="5" cols="30" name="reply" placeholder="${report.reply }" style="resize: none;"></textarea><br>
							<input class="btn btn-outline-primary btn-sm" type="submit" value="답변등록" style="text-align: right;">
						</form>
					</div>
				</td>
			</tr>
		</table>
		<br>
		<div style="border-top: 2px solid black;"></div>
		
		<div class="btnGroup" style="text-align: center; margin: 5px; padding: 10px;">
			<sec:authorize access="!hasRole('ROLE_ADMIN') && !hasRole('ROLE_MANAGER')">
				<c:if test="${qna.reply eq '미답변' || qna.reply eq null}"> <!-- 현재 로그인한 사람이 작성자이고, 미답변 상태면 수정btn 보여주기 -->
					<button type="button" class="btn btn-outline-success btn-sm" name="modify" data-toggle="modal" data-target="#checkPwModal">수정</button>
				</c:if> 
				<button type="button" class="btn btn-outline-danger btn-sm" name="delete" data-toggle="modal" data-target="#checkPwModal">삭제</button> <!-- 관리자는 삭제못함 -->
			</sec:authorize>
			<button type="button" class="btn btn-outline-dark btn-sm" onclick="history.go(-1);">목록</button>
		</div>
	</div><!-- container -->
			
	
	
		
		<!-- CheckPwModal -->
		  <div class="modal fade" id="checkPwModal"  style="text-align: center;">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">비밀번호 확인</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <!-- Modal body -->
		        <div class="modal-body">
		          <form action="checkPw" method="post">
		          	<input type="hidden" name="type" id="btnCheck"/>
		          	<input type="hidden" name="num" value="${qna.num }"> 
		          	<p>비밀번호를 입력하세요 </p>
		          	<input type="password" name="password"> <br><br>
		          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
		          	<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">닫기</button>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div>
		  
	
	
<%@ include file="../../layout/bottom.jsp"%>