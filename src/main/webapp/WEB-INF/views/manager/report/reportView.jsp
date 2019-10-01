<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고게시판-상세보기</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript">
$(function(){
	$(".btn").click(function(){
		 $("#btnCheck").attr("value",$(this).attr("name"));
	});
	
	var originCategory = '${report.category}';
	var category = originCategory.substring(0, originCategory.indexOf("_"));
	var subCategory = originCategory.substring(originCategory.indexOf("_")+1);
	$("#category option[value='"+category+"']").attr("selected", "selected");
	$("#subCategory option[value='"+subCategory+"']").attr("selected", "selected");
	
	$("#blockForm").on("submit", function(){
		var txt = $("#txt-content").val();
		$("#radio4").attr("value", txt);
		var params = $(this).serialize();
		$.ajax({
			url: "../block/blockRegister",
			data: params,
			type: "post",
			success: function(result){
				if(result){
					alert("신고등록성공");
					$("#blockModal").modal('hide');
				}else {
					alert("신고 등록 실패");
					$("#blockModal").modal('hide');
				}
			},
			error: function(){
				alert("이미 신고처리된 게시글입니다.");
				$("#blockModal").modal('hide');
			}
		});
	});
	
});

function getOriginFileName(fullName){
	if(!fullName){
		return;
	}
	var idx = fullName.lastIndexOf(indexOf("_"))+1;
	return fullName.substring(idx);
}

function hide(id){
	document.getElementById(id).style.display='none';
}
function show(id){
	document.getElementById(id).style.display='';
}

</script>
	<fmt:formatDate value="${report.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
	<fmt:formatDate value="${report.modiDate }" var="modiDate" pattern="yyyy-MM-dd"/>
	<div class="container">
		<h3>신고 글</h3>
		<table class="table">
			<tr>
				<th style="width: 15%;">게시판 종류</th>
				<td colspan="5">
					<select class="form-control col-sm-3" id="category" name="category" disabled="disabled" style="display: inline-block;">
						<option value="Free">자유게시판</option>
						<option value="Review">후기게시판</option>
						<option value="Exhibition">전시게시판</option>
						<option value="Ticket">티켓나눔게시판</option>
						<option value="Funding">펀딩게시판</option>
						<option value="Party">파티원게시판</option>
					</select>
					<select class="form-control col-sm-3" id="subCategory" name="subCategory" disabled="disabled" style="display: inline-block;">
						<option value="Board">게시글</option>
						<option value="Reply">댓글</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="2">${report.title }</td>
			</tr>
			<tr>
				<td colspan="3" style="width: 75%;">
					<div style="display: inline-block;">작성자&nbsp; ${report.memId } </div>&nbsp;
					<div style="display: inline-block;">작성일&nbsp; ${regDate } </div>
				</td>
				<td>
					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
						<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#blockModal">신고등록</button>
						<button class="btn btn-info btn-sm" data-toggle="collapse" data-target="#replyForm">답변등록</button>
					</sec:authorize>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;">${report.content}<br><br><br><br><br></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<div class="fileDiv">
						<c:choose>
							<c:when test="${empty reportImgList }">
								<p>첨부된 파일이 없습니다.</p>
							</c:when>
							<c:otherwise>
								<c:forEach items="${reportImgList }" var="reportImg" varStatus="vs">
								<div>
									<img src="downloadThumb?uuid=${reportImg.uuid }">&nbsp;&nbsp;<a href="download?uuid=${reportImg.uuid }">${reportImg.originName }</a>
									<br><br>
								</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</td>
			</tr>
		</table>
		
		<div class="btnGroup" style="text-align: center; margin: 5px; padding: 10px;">
			<sec:authorize access="!hasRole('ROLE_ADMIN') && !hasRole('ROLE_MANAGER')">
				<c:if test="${report.reply eq '미해결' || report.reply eq null }">
					<button type="button" class="btn btn-outline-success btn-sm" name="modify" data-toggle="modal" data-target="#checkPwModal">수정</button>
				</c:if>
				<button type="button" class="btn btn-outline-danger btn-sm" name="delete" data-toggle="modal" data-target="#checkPwModal">삭제</button>
			</sec:authorize>
			<button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='reportList'">목록</button>
		</div>	
		
		<div class="container" style="text-align: center;">
			<table class="table">
				<tr>
					<th style="width: 17%">답변 내용</th>
					<td colspan="3">${report.reply }</td>
				</tr>
				<tr>
					<td colspan="4">
						<div class="form-group collapse" id="replyForm" style="text-align: center;">
							<form action="replyModify" method="post">
								<input type="hidden" name="num" value="${report.num }">
								<textarea class="form-control" rows="3" name="reply" placeholder="${report.reply }" style="resize: none;"></textarea><br>
								<input class="btn btn-outline-primary btn-sm" type="submit" value="답변등록하기">
							</form>
						</div>
					</td>
				</tr>
			</table>
		</div>
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
	          	<input type="hidden" name="num" value="${report.num }"> 
	          	<p>비밀번호를 입력하세요 </p>
	          	<input type="password" name="password"> <br><br>
	          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
	          	<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">닫기</button>
	          </form>
	        </div>
	      </div>
	    </div>
	  </div>
	
	<!-- 신고pop에 보낼 내용 (관리자 글 읽고 신고 처리)-->
	<!-- Block The Modal -->
	  <div class="modal fade" id="blockModal" style="text-align: center;">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">신고 등록하기</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- Modal body -->
	        <div class="modal-body form-group">
	          <form id="blockForm" method="post">
	          <!-- Only for admin -->
	          <input type="hidden" name="memId" value="${report.memId }">
	          <table class="table">
	          	<tr>
	          		<th style="width: 30%">카테고리</th>
	          		<td><input class="form-control" type="text" name="category" value="${report.category }" readonly="readonly">
	          	</tr>
	          	<tr>
	          		<th>게시글번호</th>
	          		<td><input class="form-control" type="text" name="boardNum"></td>
	          	</tr>
	          	<tr>
	          		<th>신고대상ID</th>
	          		<td><input class="form-control" type="text" name="blockMemId"></td>
	          	</tr>
	          	<tr>
	          		<th>신고내용</th>
	          		<td>
	          			<div class="form-check">
					      <label class="form-check-label" for="radio1">
					        <input type="radio" class="form-check-input" id="radio1" name="content" value="부적절한 홍보 게시물" onclick="hide('div-content')">부적절한 홍보 게시물
					      </label>
					    </div>
					    <div class="form-check">
					      <label class="form-check-label" for="radio2">
					        <input type="radio" class="form-check-input" id="radio2" name="content" value="음란성, 욕설 또는  청소년에게 부적합한 내용" onclick="hide('div-content')">음란성, 욕설 또는  청소년에게 부적합한 내용
					      </label>
					    </div>
					    <div class="form-check">
					      <label class="form-check-label" for="radio3">
					        <input type="radio" class="form-check-input" id="radio3" name="content" value="장난성 또는 질문에 맞지 않는 무의미글" onclick="hide('div-content')">장난성 또는 질문에 맞지 않는 무의미글
					      </label>
					    </div>
					    <div class="form-check">
					      <label class="form-check-label" for="radio4">
					        <input type="radio" class="form-check-input" id="radio4" name="content" onclick="show('div-content')" value="">기타 <br>
					      </label>
				      	<div id="div-content" style="display:none">
				        	<textarea class="form-control" id="txt-content" rows="3" style="resize: none;"></textarea>
				        </div>
	    				</div>			
	          		</td>
	          	</tr>
	          </table>
			  <input type="submit" class="btn btn-outline-danger btn-sm" value="신고등록">
          	  <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">닫기</button>
	          </form>
	        </div>
	      </div>
	    </div>
	  </div><!-- 신고Form End -->
	  
<%@ include file="../../layout/bottom.jsp"%>