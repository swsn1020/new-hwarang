<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-나의 질문내역</title>
<%@ include file="../../layout/left.jsp" %>
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

	<fmt:formatDate value="${qna.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
	<div class="container">
	<table class="table">
		<tr>
			<th>문의분류</th>
			<td colspan="3">
				<select id="category" name="category" class="form-control col-md-3" disabled="disabled" style="display: inline-block;">
					<option value="info">고객정보</option>
					<option value="order">주문</option>
					<option value="Board">게시판</option>
					<option value="other">기타</option>
				</select>
				<select id="subCategory" name="subCategory" class="form-control col-md-3" disabled="disabled" style="display: inline-block;">
					<option value="modiInfo">정보수정</option>
					<option value="delInfo">회원탈퇴</option>
					<option value="point">포인트</option>
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
			<td colspan="3">${qna.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${qna.memId }</td>
			<th>작성일</th>
			<td>${regDate }</td>
		</tr>
		<tr>
			<td colspan="4" style="text-align: center;">${qna.content }</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
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
		<tr>
			<th>답변</th>
			<td colspan="2">${qna.reply }</td>
			<td>
				<c:if test="${qna.memId eq 'haddie' }"> <!-- 현재 로그인한 사람이 관리자이면 띄우기 -->
					<button class="btn btn-info btn-sm" data-toggle="collapse" data-target="#replyForm">답변등록</button>
				</c:if>
			</td>
		</tr>
	</table>
		
	
		<c:if test="${qna.reply eq '미답변' || qna.reply eq null}"> <!-- 현재 로그인한 사람이 작성자이고, 미답변 상태면 수정btn 보여주기 -->
			<button type="button" class="btn btn-outline-success" name="modify" data-toggle="modal" data-target="#checkPwModal">수정</button>
		</c:if> 
		<button type="button" class="btn btn-outline-danger" name="delete" data-toggle="modal" data-target="#checkPwModal">삭제</button> <!-- 관리자는 삭제못함 -->
		<button type="button" class="btn btn-outline-dark" onclick="history.go(-1);">목록보기</button>
		
	
	<!-- 답변등록Form -->
	<div class="form-group collapse" id="replyForm">
		<form action="replyModify" method="post">
			<input type="hidden" name="num" value="${report.num }">
			<textarea class="form-control" rows="3" name="reply" placeholder="${report.reply }" style="resize: none;"></textarea>
			<br>
			<input class="btn btn-outline-primary" type="submit" value="답변등록하기" style="text-align: right;">
		</form>
	</div>
		
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
		          	비밀번호를 입력하세요 <br><br>
		          	<input type="password" name="password"> <br><br>
		          	<input type="submit" class="btn btn-outline-primary" value="확인">
		          	<button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div>
		  
	</div><!-- container -->
	
<%@ include file="../../layout/bottom.jsp"%>