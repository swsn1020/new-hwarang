<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-공지사항</title>
<%@ include file="../../layout/left.jsp" %>
<script>
	$(function(){
		replyList();
		$("#replyForm").on("submit", function(){
			var params = $(this).serialize();
			console.log(params);
			$.ajax({
				url: "reply/write",
				data: params,
				type: "post",
				dataType: "json",
				success: function(result){
					if(result){
						alert("댓글 등록완료");
						$("#replyForm")[0].reset();
						//새로운 댓글목록 그리기
						replyList();
					}else{
						//댓글등록 실패
						alert("댓글 등록실패");
					}
				},
				error: function(){
					alert("댓글등록 ajax()오류!");
				}
			});
			return false;
		});
		
		//신고 글 메서드
		$("#btn-block").on("click", function(){
			var category = $("#blockForm").find('input[name="category"]');
			category.val("Notice_Board");
			var blockMemId = $("#blockForm").find('input[name="blockMemId"]');
			blockMemId.val('haddie');	//관리자의 경우 아이디 넣기(현재아이디)
			var blockForm = document.blockForm;
			var url = "../block/form";
			window.open("", "Report", "width=400, height=500, top=300, left=300");
			
			blockForm.action = url;
			blockForm.target = "Report";
			blockForm.submit();
		});
	});
	
	//댓글 총 수 불러오는 함수 따로 만들기
	function getReplyCnt(){
		var boardNum = '${notice.num}';
		var replyCnt;
		$.ajax({
			url: "reply/getReplyCnt",
			data: {"boardNum" : boardNum},
			type: "get",
			async: false,
			dataType: "json",
			success: function(result){
				replyCnt = result;
				var replyTable = $("#replies");
				replyTable.append($("<tr><th colspan='4'>총 댓글"+replyCnt+"</th></tr>"));
			},
			error: function(){
				alert("댓글 수 불러오기 에러")
			}
		});
		return replyCnt;
	}
	
	
	function replyList(){
		var replyTable = $("#replies");
		$("#replies tr").remove();
		getReplyCnt();
// 		alert("replyCnt : "+replyCnt);
		$.ajax({
			url: "reply/all/${notice.num}",
			type: "get",
			dataType: "json",
			success: function(data){
				
				//data는 list
				for(var i in data){
					//등록일자 얻어오기
					var modiDate = new Date(data[i].modiDate);
					var year = modiDate.getFullYear();
					var month = modiDate.getMonth()+1;
					month = month >= 10 ? month: '0'+month;
					var date = modiDate.getDate();
					date = date >= 10 ? date: '0'+ date;
					var hour = modiDate.getHours()+9;
					hour = hour >= 10 ? hour : '0'+hour;
					var minute = modiDate.getMinutes();
					minute = minute >= 10 ? minute : '0'+minute;
					var finalDate = year+"-"+month+"-"+date+" "+hour+":"+minute;
					
					//멤버 아이디
					var memId = data[i].memId;
					//내용(Block처리 함께)
					var blockStatus = data[i].block;
					if(blockStatus == 'true'){
						var content = '관리자에 의해 삭제처리 된 댓글입니다.';
					}else{
						var content = data[i].content;
					}
					
					
					
					//수정폼 (수정, 삭제는 본인이 작성한 글만)
					var modiForm = $("<form></form>");
					var modiTxt = $("<div id='modi"+i+"' class='collapse'>"+
							"<input type='hidden' name='num' value='"+data[i].num+"'>"+
							"<label for='pw'>password</label><br><input type='password' name='pw' class='form-control'><br>"+
							"<textarea class='form-control' rows='5' name='content'>"+data[i].content+"</textarea></div>");
					//삭제폼 (수정, 삭제는 본인이 작성한 글만)
					var delForm = $("<form></form>");
					var delTxt = $("<div id='del"+i+"' class='collapse'>"+
							"<input type='hidden' name='num' value='"+data[i].num+"'>"+
							"<label for='pw'>password</label><br><input type='password' name='pw' class='form-control'></div>");
					
					//'수정'안  확인버튼
					var modiSubmit = $("<button type='button' class='btn btn-link'>수정</button>");
					modiTxt.append(modiSubmit);
					modiForm.append(modiTxt);
					
					//'삭제'안 확인버튼
					var delSubmit = $("<button type='button' class='btn btn-link'>삭제</button>");
					delTxt.append(delSubmit);
					delForm.append(delTxt);
					
					
					var tr = $("<tr>");
					tr.append($("<td><a href='#'>"+memId+"</a><br>"+finalDate+"</td>"));
					tr.append($("<td>").text(content).append(modiForm));
					tr.append($("<td>").append(delForm));
					var modiBtn = $("<button type='button' class='btn btn-link btn-sm' data-toggle='collapse' data-target='#modi"+i+"'> 수정 </a>");
					var delBtn = $("<button type='button' class='btn btn-link btn-sm' data-toggle='collapse' data-target='#del"+i+"'> 삭제 </a>");
					//내가 쓴 글일 경우 신고 버튼 없음
					var blockBtn = $("<button type='button' class='btn btn-link btn-sm' style='color: red;'> 신고 </button>");
					tr.append($("<td>").append(modiBtn).append(delBtn).append(blockBtn));
					
					
					//disabled 설정하기
					modiBtn.on("click", function(){
						var delBtn = $(this).next();
						if (delBtn.attr('disabled') == 'disabled') {
							delBtn.removeAttr('disabled');
						} else {
							delBtn.attr('disabled', 'true');
						}
					});
					delBtn.on("click", function(){
						var modiBtn = $(this).prev();
						if (modiBtn.attr('disabled') == 'disabled') {
							modiBtn.removeAttr('disabled');
						} else {
							modiBtn.attr('disabled', 'true');
						}
					});
					
					//수정확인
					modiSubmit.on("click", function() {
						var data = $(this).closest("form").serialize();
						$.ajax({
							url : "reply/modify",
							data : data,
							type : "post",
							dataType : "json",
							success : function(result) {
								if (result) {
									alert("수정되었습니다.");
									replyList();
								} else {
									alert("다시 시도해주세요.");
									replyList();
								}
							},
							error : function() {
								alert("replyModify error");
							}
						});
						return false; //form action 동작 안함
					});
					
					//삭제확인
					delSubmit.on("click", function() {
						var data = $(this).closest("form").serialize();
// 						alert(data);
						$.ajax({
							url : "reply/delete",
							data : data,
							type : "post",
							dataType : "json",
							success : function(result) {
								if (result) {
									alert("삭제되었습니다.");
									replyList();
								} else {
									alert("다시 시도해주세요.");
									replyList();
								}
							},
							error : function() {
								alert("replyDelete error");
							}
						});
						return false; //form action 동작 안함
					});
					
					//신고 댓글처리 메서드
					(function(m) {
						blockBtn.on("click", function(){
						var category = $("#blockForm").find('input[name="category"]');
						category.val("Notice_Reply");
						var replyMemId = data[m].memId;
						var blockMemId = $("#blockForm").find('input[name="blockMemId"]');
						blockMemId.val(replyMemId);
						var replyNum = data[m].num;
						var rInput = $("#blockForm").find('input[name="replyNum"]');
						rInput.val(replyNum);
// 						alert(rInput.val());
						var blockForm = document.blockForm;
						var url = "../block/form";
						window.open("", "Report", "width=400, height=500, top=300, left=300");
						
						blockForm.action = url;
						blockForm.target = "Report";
						blockForm.submit();
						});
					})(i)	// 댓글 해당 인덱스 보내기(클로저 방지)
					replyTable.append(tr);
				} //for문
			},
			error: function(){
				alert("replyList 오류");
			}
		});
	}
</script>
	<fmt:formatDate value="${notice.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
	<h3>공지사항</h3>
	<div class="container">
		<div class="table-responsive">
			<table class="table">
				<tr>
					<th>제목</th>
					<td>[공지]&nbsp;${notice.title }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td></td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="display: inline-block;">작성일&nbsp; ${regDate } </div>&nbsp;
						<div id="readCnt" style="display: inline-block;">조회수&nbsp; ${notice.readCnt }</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="text-align: center;">
						<c:choose>
							<c:when test="${notice.block eq 'true'}">
								<p>관리자에 의해 삭제처리된 게시글입니다.</p>
							</c:when>
							<c:otherwise>
								<p>${notice.content }</p>
							</c:otherwise>
						</c:choose>
						</div>
					</td>
				</tr>
				<tr>
					
				</tr>
			</table>
		</div>
		<hr>
		
	</div>
	<!-- 이전글, 다음글  -->
	<div class="container">
		
	</div>
	
	<!-- 로그인한 id의 권한이 관리자인 경우만 수정할수 있는 버튼 보여주기 -->
	<div class="btnGroup" style="text-align: center;">
<%-- 	<c:if test="${id.auth eq 'admin'}"> --%>
		<button onclick="location.href='noticeModify?num=${notice.num}'" class="btn btn-outline-success">수정</button>
<%-- 		<button onclick="location.href='checkPw?type=delete&num=${notice.num}'">삭제</button> --%>
<%-- 	</c:if> --%>
		<button type="button" data-toggle="modal" data-target="#delModal" class="btn btn-outline-info">삭제</button>
		
		<!-- The Modal -->
		  <div class="modal fade" id="delModal" style="text-align: center;">
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
		          	<input type="hidden" name="type" value="delete">
		          	<input type="hidden" name="num" value="${notice.num }">
		          	비밀번호를 입력하세요 <br>
		          	<input type="password" name="password"> <br>
		          	<input type="submit" class="btn btn-outline-primary" value="확인">
		          	<button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div><!-- Modal End -->
		  
		<button onclick="location.href='noticeList'" class="btn btn-outline-dark">목록</button>
		<button id="btn-block" class="btn btn-outline-danger">신고</button>
	</div>
	<br>
	
	<!-- 댓글 목록 div -->
	<div class="container">
		<table class="table table-hover" id="replies">
			<thead></thead>
		</table>
	</div>
	
	<!-- 댓글입력div -->
	<div class="form-group col-md-9" style="margin-left: 150px;">
		<form id="replyForm">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="hidden" name="boardNum" value="${notice.num}">
			<input type="hidden" name="memId" value="haddie">
			<table class="table">
				<tr>
					<th>댓글쓰기</th>
					<td><textarea class="form-control" name="content" rows="3" placeholder="댓글을 입력하세요" style="resize: none;"></textarea><td>
					<td><input type="submit" class="btn btn-outline-primary" value="작성">
				</td>
			</table>
		</form>
	</div>
	
	<!-- 신고pop에 보낼 내용 -->
	<form id="blockForm" name="blockForm" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="hidden" name="blockMemId" value="">
		<input type="hidden" name="category" value="">
		<input type="hidden" name="boardNum" value="${notice.num }">
		<input type="hidden" name="replyNum" value="">
	</form>
<%@ include file="../../layout/bottom.jsp"%>