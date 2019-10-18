<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>Insert title here</title>
<%@ include file="../layout/menu.jsp" %>

<script type="text/javascript">
//let
let gBno = '${fboard.num}',
	gBoardWriter = '${fboard.userid}',
	gRno = 0,
	gReplytext = null;
$(function() {	//문서가 로딩되면 실행할 함수
		/*댓글 목록 그리기 */
	replyList(1);
	$("#btnRegister").on("click",function(){
		//replyForm에 작성된 내용을 DB에 쓰기 후, 결과 받아와서 처리
		var data = $("#Replyregister").serialize();
		var replyer = $('#replyer');
		$.ajax({
			url : "${contextPath}/freereply/register",
			data : data,
			type : "post",
			dataType : "json",
			success : function(result){
				if(result){
					//댓글 등록 성공
					alert("등록 완료");
					$("#Replyregister")[0].reset();
					//새로운 댓글 목록 그리기
					location.reload();
					console.debug("reply.js::socket>>",socket)
					if(socket){
						//websocket에 보내기 (reply,댓글작성자,게시글작성자,글번호)
						//let
						
						let socketMsg = "reply," + $('#replyer').val() + "," + gBoardWriter + "," + gBno;
						console.debug("sssssssmsg>>", socketMsg)
						socket.send(socketMsg);
// 						alert(replyer.val());
// 						alert(gBoardWriter);
// 						alert(gBno);
// 						alert("socket 등록 완료");
						
					}else{
						alert("socket 등록 실패")
					}
				}else{
					//댓글 등록 실패
					alert("오류가 발생했습니다.계속 발생한다면 문의하세요.")
				}
			},
			error : function(){
				alert("예외발생")
				//예외 발생
			}
		});//ajax end
		   //boardView 요청을 진행 중.. 진행하지 못하도록 return false;
		return false;
	});//on submit end	
	
	//게시글 신고 메서드
	$("#btn-block").on("click", function(){
		var category = $("#blockForm").find('input[name="category"]');
		category.val("Free_Board");
		var writer = '${fboard.userid}';
		var bMemId = $("#blockForm").find('input[name="blockMemId"]');
		bMemId.val(writer);	//관리자의 경우 아이디 넣기(현재아이디)
		var blockForm = document.blockForm;
		var url = "/block/form";
		window.open("", "Report", "width=400, height=500, top=300, left=300");
		
		blockForm.action = url;
		blockForm.target = "Report";
		blockForm.submit();
	});
});

//댓글 총 수 불러오는 함수
function getReplyCnt(){
	var fboardNum = '${fboard.num}';
	var replyCount;
	$.ajax({
		url: "reply/getReplyCnt",
		data: {"fboardNum" : fboardNum},
		type: "get",
		async: false,
		dataType: "json",
		success: function(result){
			replyCount = result;
			var table = $("#replyTable");
			table.append($("<tr><th colspan='4'>댓글"+replyCount+"</th></tr>"));
		},
		error: function(){
			alert("댓글 수 불러오기 에러")
		}
	});
	return replyCount;
}

function replyList(num){
		var table = $("#replyTable");
		$("#replyTable tr").remove();
		getReplyCnt();
		$.ajax({
			url : "${contextPath}/freereply/all",
			data : {"fboardNum" : '${fboard.num}',"curPage":num},
			type : "get",
			dataType : "json",
			success : function(data){
				//data는 list
				var rnum = (Number(num) * 10) -9;
				var rPager = data.rPager;
				console.log(rPager);
				console.log(rPager.curPage);
				console.log(rPager.totalPage);
				if(rPager.curPage != 1){
					$("#left").attr("class", "page-item");
				}
				if(rPager.curPage == rPager.totalPage){
					$("#right").attr("class", "page-item disabled");
				}

				for(var i in data.replyTable){
				//등록일자 얻어오기
				var upDateDate = new Date(data.replyTable[i].upDateDate);
				var year = upDateDate.getFullYear();
				var month = upDateDate.getMonth()+1;
				month = month >= 10 ? month: '0'+month;
				var date = upDateDate.getDate();
				date = date >= 10 ? date: '0'+ date;
				var hour = upDateDate.getHours()+9;
				hour = hour >= 10 ? hour : '0'+hour;
				var minute = upDateDate.getMinutes();
				minute = minute >= 10 ? minute : '0'+minute;
				var finalDate = year+"-"+month+"-"+date+" "+hour+":"+minute;
				
				var blockStatus = data.replyTable[i].block;
				if(blockStatus == 'true'){
					var content = '관리자에 의해 삭제처리 된 댓글입니다.';
				}else{
					var content = data.replyTable[i].content;
				}
				
				
				var tr = $("<tr>");
// 				var num = data.replyTable[i].free_reply_num;
// 				var userid = data.replyTable[i].userid;
// 				var content = data.replyTable[i].content;
			
				//수정폼
				var modiForm = $("<form></form");
				var modiText = $("<div id='modi"+i+"'class='collapse'><input type='hidden' name='num' value='"+data.replyTable[i].num+"'><input type='hidden' name='userid' value='"+data.replyTable[i].userid+"'><br><textarea class='form-control' name='content' rows='5'>"+ content + "</textarea></div>");
				
				//삭제폼
				var delForm = $("<form></form>");
				var delText = $("<div id='del"+i+"' class='collapse'><input type='hidden' name='num' value='"+data.replyTable[i].num+"'></div>");
				
				
				//수정 확인버튼
				var rbtnModify = $("<button type='button' class='btn btn-link'>수정</button>");
				modiText.append(rbtnModify);
				modiForm.append(modiText);
				
				//삭제 확인버튼				
				var rbtnRemove = $("<button type='button' class='btn btn-link'>ok</button>");
				delText.append(rbtnRemove);
				delForm.append(delText);
				
				var tr = $("<tr>");
				
				tr.append($("<td>" +rnum+ "</td>"));
				rnum++;
				tr.append($("<td><a href='#'>"+data.replyTable[i].userid+"</a><br>"+finalDate+"</td>"));
				tr.append($("<td>").text(content).append(modiForm));
				tr.append($("<td>").append(delForm));
				
				var modiBtn = $("<button type='button' class='btn btn-link btn-sm' data-toggle='collapse' data-target='#modi"+i+"'> 수정 </a>");
				var delBtn = $("<button type='button' class='btn btn-link btn-sm' data-toggle='collapse' data-target='#del"+i+"'> 삭제 </a>");
				//신고버튼
				var blockBtn = $("<button type='button' class='btn btn-link btn-sm' style='color: red;'> 신고 </button>");
				
				tr.append($("<td style='width: 200px;''>").append(modiBtn).append(delBtn).append(blockBtn));
				//disabled 설정하기
				
				if(blockStatus == 'true'){
					modiBtn.attr("disabled", "disabled");
				}
				
				var currId = table.closest("div").find("input[name='currId']").val();
//					alert(currId);
				if(currId != data.replyTable[i].userid){
					console.log("아이디 일치하지 않음");
					modiBtn.css("display", "none");
					delBtn.css("display", "none");
				}else{
					console.log("아이디 일치");
					modiBtn.css("display", "true");
					delBtn.css("display", "true");
				}

				
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
			rbtnModify.on("click",function(){
				var d = $(this).closest("form").serialize();			
				$.ajax({
						url : "${contextPath}/freereply/modifyReply",
						type: "post",
						data : d,
						dataType:"json",
						success:function(result){
							if(result){
								alert("수정완료");
								replyList();
							}else{
								alert("수정실패");
							}	
						}			
				});
				return false;
			});
			//삭제확인
			rbtnRemove.on("click",function(){
				var d = $(this).closest("form").serialize();
				$.ajax({
					url : "${contextPath}/freereply/removeReply",
					type : "post",
					data : d,
					dataType:"json",
					success: function(result){
						if(result){
							alert("삭제완료");
							replyList();
						}else{
							alert("삭제실패");
						}
					}
				});
				return false;
			});
			
			//신고 댓글처리 메서드
			(function(m) {
				blockBtn.on("click", function(){
				var category = $("#blockForm").find('input[name="category"]');
				category.val("Free_Reply");
				var replyMemId = data.replyTable[m].userid;
				var blockMemId = $("#blockForm").find('input[name="blockMemId"]');
				blockMemId.val(replyMemId);
				var replyNum = data.replyTable[m].num;
				var rInput = $("#blockForm").find('input[name="replyNum"]');
				rInput.val(replyNum);
//					alert(rInput.val());
				var blockForm = document.blockForm;
				var url = "../block/form";
				window.open("", "Report", "width=400, height=500, top=300, left=300");
				
				blockForm.action = url;
				blockForm.target = "Report";
				blockForm.submit();
				});
			})(i)	// 댓글 해당 인덱스 보내기(클로저 방지)
			
			
			table.append(tr);
		}
	},
	error: function(){
		alert("list 오류");
	}		
	});
}
</script>

<script>
// function connect(){
	
// 	var ws = new WebSocket("ws://localhost:8081/replyEcho?bno=1234");
	
// 	ws.onopen = function(){
// 		console.log('Info.connection opened');
// 		setTimeout(function(){connect(); },1000);
		
// 	};
	
// 	ws.onmessage = function(event){
// 		console.log(event.data+'\n');
// 	};
	
// 	ws.onclose = function(event){
// 		console.log('Info:connection closed.');
// 		//setTimeout(function(){connect(); },1000);
// 	};
// 	ws.onerror = function(err) {console.log('Errror:, err');};
	
// }


$('#btnSend').on('click',function(evt){
	evt.preventDefault();
	if(socket.readyState!==1) return;
	//let
		let msg = $('input#msg').val();
		socket.send(msg);
	
});
</script>
	<fmt:formatDate value="${fboard.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
		<div class="container">
				<input type="button" class="btn btn-outline-secondary" value="목록" onclick="location.href='freeboard'">
				<input type="hidden" value="<sec:authentication property="principal.Username" var="id"/>">
				<c:if test="${id eq fboard.userid}">			
					<input type="button"class="btn btn-outline-secondary" value="수정" onclick="location.href='modify?num=${fboard.num }'"> 
					<input type="button" class="btn btn-outline-secondary" value="삭제" onclick="location.href='remove?num=${fboard.num }'"> 
					<input type="button" class="btn btn-outline-secondary" value="새글쓰기" onclick="location.href='register'">
				</c:if>
				<button id="btn-block" class="btn btn-outline-danger btn-sm">신고</button>
	<div class="table-responsive">
		<table class="table">
			<tr>
				<th>제목</th>
				<td>${fboard.title}</td>
			</tr>
			<tr>
				<td colspan="2">		
				<div class="article_writer">
				${fboard.userid} <span class="bar2">|</span>
				<div id="readCnt" style="display: inline-block;">조회 ${fboard.readCount }</div>
				<span class="bar2">|</span>
				&nbsp; ${regDate}
				</div>
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<c:choose>
						<c:when test="${fboard.block eq true}">
							<p>관리자에 의해 삭제처리된 게시글입니다.</p>
						</c:when>
						<c:otherwise>
							<p>${fboard.content }</p>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		<tr>
			<th>첨부파일</th>
				<td>
					<div>
						<c:choose>
							<c:when test="${empty freeImgList}">
								<p>첨부된 파일이 없습니다.</p>
							</c:when>
								<c:otherwise> 
									<c:forEach items="${freeImgList}" var="freeImg" varStatus="vs">
										<div>
											<img src="downloadThumb?uuid=${freeImg.uuid }"><a href="download?uuid=${freeImg.uuid}">${freeImg.originName}</a>
											<br><br>
										</div>
	        						</c:forEach>
								</c:otherwise>
						</c:choose>
					</div>	
			</td>
		</tr>
		</table>
		</div>
	</div>
	
	<!-- 댓글 목록 div -->
	<div class="container">
		<sec:authorize access="isAnonymous()">
			<input type="hidden" name="currId" value="anonymous"/>
		</sec:authorize>	
		<sec:authorize access="isAuthenticated()">
			<input type="hidden" name="currId" value="<sec:authentication property="principal.username"/>">
		</sec:authorize>
		<table  class="table table-hover" id="replyTable">
			<thead></thead>
		</table>
	</div>
	<!-- 페이징 -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<li id="left" class="page-item disabled">
				<a class="page-link" href="javascript:replyList(1))">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${rPager.blockBegin }" end="${rPager.totalPage}">
				<li class='${rPager.curPage == num ? "page-item active" : "page-item"}'>
					<a class="page-link" href="javascript:replyList(${num})">[${num}]</a>
				</li>
			</c:forEach>
			<li id="right" class="page-item">
				<a class="page-link" href="javascript:replyList(${rPager.totalPage })">&raquo;</a>
			</li>
		</ul>
	</div>
	
	
	<div>
	<!-- 댓글등록 -->
	</div>
	<div class="container">
		<form id="Replyregister">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="hidden" name="boardNum" value="${fboard.num}">
			<table class="table">
				<tr>
					<td>
						<input type="hidden" id="replyer" name="userid" value='<sec:authentication property="principal.Username"/>'>
					</td>
					<th>내용</th>
					<td><textarea rows="3" cols="30" name="content"></textarea></td>
					<td>
						<button class="btn btn-outline-secondary" id="btnRegister" >등록</button>
					</td>
				</tr>
			</table>
		</form>
	</div>	
	<!-- 신고pop에 보낼 내용 -->
	<form id="blockForm" name="blockForm" method="post">
		<input type="hidden" name="blockMemId" value="">
		<input type="hidden" name="category" value="">
		<input type="hidden" name="boardNum" value="${fboard.num }">
		<input type="hidden" name="replyNum" value="">
		<input type="hidden" name="boardTitle" value="${fboard.title }">
	</form>
<%@include file="../layout/bottom.jsp"%>		