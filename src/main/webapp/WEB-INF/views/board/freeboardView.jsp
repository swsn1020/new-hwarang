<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>Insert title here</title>
<%@ include file="../layout/left.jsp"%>
<script type="text/javascript">
$(function() {	//문서가 로딩되면 실행할 함수
		/*댓글 목록 그리기 */
	replyList(1);
	$("#btnRegister").on("click",function(){
		//replyForm에 작성된 내용을 DB에 쓰기 후, 결과 받아와서 처리
		var data = $("#Replyregister").serialize();
		$.ajax({
			url : "${contextPath}/reply/register",
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
// 		var bMemId = $("#blockForm").find('input[name="bMemId"]');
// 		bMemId.val('haddie');	//관리자의 경우 아이디 넣기(현재아이디)
		var blockForm = document.blockForm;
		var url = "/block/form";
		window.open("", "Report", "width=1000, height=1000, top=300, left=1000");
		
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
			url : "${contextPath}/reply/all",
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
				console.log(data);
				
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
				
				
				var tr = $("<tr>");
				var num = data.replyTable[i].free_reply_num;
				var userid = data.replyTable[i].userid;
				var content = data.replyTable[i].content;
				
				var modiText = $("<div id='mod"+i+"' class='collapse form-group'><input type='hidden' name='num' value='"+num+"'><input type='hidden' name='userid' value='"+userid+"'><br><textarea class='form-control' name='content' rows='3' cols='80'>"+content + "</textarea></div>");
				
				var remvText = $("<div id='modd"+i+"' class='collapse form-group'><input type='hidden' name='num' value='"+num+"'><input type='hidden' name='userid2' value='"+userid+"'></div>");
				
				var rbtnModify = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#mod"+i+"'>M</button>");
				
				var rbtnRemove = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#modd"+i+"'>D</button>");

				var form = $("<form action='#' id='modify'></form>");
				var form2 = $("<form action='#' id='remove'></form>");
				var btnSubmit = $("<button type='button' class='btn btn-link' id='btnModify'>ok</button>");
				var btnSubmit2 = $("<button type='button' class='btn btn-link' id='btnRemove'>ok</button>");
				// btnSubmit을 on.click 했을때 url로 요청을 보내서 컨트롤러와 연결.
				
				//신고버튼
				var blockBtn = $("<button type='button' class='btn btn-link btn-sm' style='color: red;'> 신고 </button>");
				
				$("<td>").text(data.replyTable[i].userid).appendTo(tr);
				$("<td>").text(data.replyTable[i].content)
					.append(form.append(modiText.append(btnSubmit)))
					.appendTo(tr);
				$("<td>").append(form2.append(remvText.append(btnSubmit2)))
					.appendTo(tr);
				$("<td>").text(finalDate)
				.appendTo(tr);
				$("<td>").append(rbtnModify).append(rbtnRemove)
				.appendTo(tr);
				//신고버튼 붙이기 확인 필요!
				tr.append(blockBtn);
// 				tr.appendTo(table);
			$("#btnModify").on("click",function(){
				var d = $(this).closest("form").serialize();			
				$.ajax({
						url : "${contextPath}/reply/modifyReply",
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
			
			$("#btnRemove").on("click",function(){
// 				var d = $("#remove").serialize();
				var d = $(this).closest("form2").serialize();
				alert("test");
				$.ajax({
					url : "${contextPath}/reply/removeReply",
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
			table.append(tr);
		}
	},
	error: function(){
		alert("list 오류");
	}
			
	});
}
</script>
	<fmt:formatDate value="${fboard.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
<div class="container">
			<tr>
				<td>
				<input type="button" class="btn btn-primary" value="수정" onclick="location.href='modify?num=${fboard.num }'"> 
				<input type="button" class="btn btn-primary" value="삭제" onclick="location.href='remove?num=${fboard.num }'"> 
				<input type="button" class="btn btn-primary" value="목록" onclick="location.href='freeboard'">
				<input type="button" class="btn btn-primary" value="새글쓰기" onclick="location.href='register'">
				<button id="btn-block" class="btn btn-outline-danger btn-sm">신고</button>
				</td>
			</tr>
	<div class="table-responsive">
		<table class="table">
			<tr>
				<th>제목</th>
				<td>${fboard.title}</td>
			</tr>
			<tr>
				<th>작성자</th>	
				<td>${fboard.userid}</td>
			</tr>
			<tr>
				<td colspan="2">
				<div style="display: inline-block;">작성일&nbsp; ${regDate } </div>&nbsp;
						<div id="readCnt" style="display: inline-block;">조회수&nbsp; ${fboard.readCount }</div>
				</td>
			</tr>
			<tr>
				<th></th>
				<td>${fboard.content}</td>
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
		<table  class="table table-hover" id="replyTable">
			<thead></thead>
		</table>
	</div>
	<!-- 페이징 -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<li id="left" class="page-item disabled">
				<a class="page-link" href="javascript:replyList(1)">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${rPager.blockBegin }" end="${rPager.totalPage}">
				<li class='${rPager.curPage == num ? "active" : "page-item"}'>
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
					<th>아이디</th>
					<td><input type="text" name="userid"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="3" cols="30" name="content"></textarea></td>
					<td>
						<button class="btn btn-primary" id="btnRegister" >등록</button>
					</td>
				</tr>
			</table>
		</form>
	</div>	
	<!-- 신고pop에 보낼 내용 -->
	<form id="blockForm" name="blockForm" method="post">
<%-- 		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> --%>
		<input type="hidden" name="bMemId" value="${fboard.userid}">
		<input type="hidden" name="category" value="">
		<input type="hidden" name="boardNum" value="${fboard.num }">
		<input type="hidden" name="replyNum" value="">
	</form>
<%@include file="../layout/bottom.jsp"%>		