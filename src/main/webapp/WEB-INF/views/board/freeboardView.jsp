<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<%
	String contextPath = request.getContextPath();
	request.setAttribute("contextPath", contextPath);
%>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript">
$(function() {	//문서가 로딩되면 실행할 함수
		/*댓글 목록 그리기 */
	replyList();
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
					//새로운 댓글 목록 그리기
					replyList();
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


function replyList(){
		var table = $("#replyTable");
		$("#replyTable tr:gt(0)").remove();
		$.ajax({
			url : "${contextPath}/reply/all/"+${fboard.num},
			type : "get",
			dataType : "json",
			success : function(data){
			for(var i in data){
				var tr = $("<tr>");
				var num = data[i].free_reply_num;
				var userid = data[i].userid;
				var content = data[i].content;
				
				var modiText = $("<div id='mod"+i+"' class='collapse form-group'><input type='hidden' name='num' value='"+data[i].num+"'><input type='hidden' name='userid' value='"+data[i].userid+"'><br><textarea class='form-control' name='content' rows='3' cols='80'>"+ data[i].content + "</textarea></div>");
				
				var remvText = $("<div id='modd"+i+"' class='collapse form-group'><input type='hidden' name='num' value='"+data[i].num+"'><input type='hidden' name='userid2' value='"+data[i].userid+"'></div>");
				
				var rbtnModify = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#mod"+i+"'>M</button>");
				
				var rbtnRemove = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#modd"+i+"'>D</button>");

				var form = $("<form action='#' id='modify'></form>");
				var form2 = $("<form action='#' id='remove'></form>");
				var btnSubmit = $("<button type='button' class='btn btn-link' id='btnModify'>ok</button>");
				var btnSubmit2 = $("<button type='button' class='btn btn-link' id='btnRemove'>ok</button>");
				// btnSubmit을 on.click 했을때 url로 요청을 보내서 컨트롤러와 연결.
				
				//신고버튼
				var blockBtn = $("<button type='button' class='btn btn-link btn-sm' style='color: red;'> 신고 </button>");
				
				$("<td>").text(data[i].userid).appendTo(tr);
				$("<td>").text(data[i].content)
					.append(form.append(modiText.append(btnSubmit)))
					.appendTo(tr);
				$("<td>").append(form2.append(remvText.append(btnSubmit2)))
					.appendTo(tr);
				$("<td>").text(data[i].regDate)
				.appendTo(tr);
				$("<td>").append(rbtnModify).append(rbtnRemove)
				.appendTo(tr);
				//신고버튼 붙이기 확인 필요!
				tr.append(blockBtn);
				tr.appendTo(table);
			}(i);
			
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
				var d = $("#remove").serialize();
// 				var d = $(this).closest("form2").serialize();
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
			
			//신고 댓글처리 메서드
			/*
			(function(m) {
				blockBtn.on("click", function(){
				var category = $("#blockForm").find('input[name="category"]');
				category.val("Notice_Reply");
				var replyMemId = data[m].memId;
				var bMemId = $("#blockForm").find('input[name="bMemId"]');
				bMemId.val(replyMemId);
				var replyNum = data[m].num;
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
			*/
		}
	});
}
</script>
</head>
<body>
	<div>
		<h1>게시글 상세보기</h1>
		<table>
			<tr>
				<th>작성자</th>
				<td>${fboard.userid}</td>
				<th>조회수</th>
				<td>${fboard.readCount}</td>
				<th>추천</th>
				<td>${fboard.recommCount}</td>
				<th>비추천</th>
				<td>${fboard.disrecommCount}</td>
				<th>작성일</th>
				<td>${fboard.regDate}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${fboard.content}</td>
			</tr>
		<tr>
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
			<tr>
				<td>
				<input type="button" class="btn btn-primary" value="수정" onclick="location.href='modify?num=${fboard.num }'"> 
				<input type="button" class="btn btn-primary" value="삭제" onclick="location.href='remove?num=${fboard.num }'"> 
				<input type="button" class="btn btn-primary" value="목록" onclick="location.href='freeboard'">
				<button id="btn-block" class="btn btn-outline-danger btn-sm">신고</button>
				<input type="button" class="btn btn-primary" value="새글쓰기" onclick="location.href='register'">
				</td>
			</tr>
		</table>
	</div>
	<div>
		<table id="replyTable">
			<tr>
				<th>아이디</th>
				<th>내용</th>
				<th>작성일</th>
			</tr>
		</table>
	</div>
	<div>
	<!-- 댓글등록 -->
	</div>
		<form id="Replyregister">
			<input type="hidden" name="boardNum" value="${fboard.num}">
			<table>
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
		
	<!-- 신고pop에 보낼 내용 -->
	<form id="blockForm" name="blockForm" method="post">
<%-- 		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> --%>
		<input type="hidden" name="bMemId" value="${fboard.userid}">
		<input type="hidden" name="category" value="">
		<input type="hidden" name="boardNum" value="${fboard.num }">
		<input type="hidden" name="replyNum" value="">
	</form>
		
		
</body>
</html>