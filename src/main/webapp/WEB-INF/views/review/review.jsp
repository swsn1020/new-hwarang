<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%
	String contextPath = request.getContextPath();
	request.setAttribute("contextPath", contextPath);
%>
<link rel="stylesheet" type="text/css"
	href="${contextPath}/resources/css/style.css">
<meta charset="UTF-8">
<title>reviewForm</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function() {

		ReplyView();
		$("#rbtnWrite").on("click", function() {
			var data = $("#rwriteForm").serialize();
			$.ajax({
				url : "${contextPath}/reply/rwrite",
				data : data,
				type : "post",
				dataType : "json",
				success : function(result) {
					if (result) {
						alert("작성되었습니다.");
					} else {
						alert("다시 시도해주세요.");
					}
					$("#rcontent").val("");
					ReplyView();
				},
				error : function() {
					alert("replyWrtie error");
				}
			});
			return false;
		});

		/* 		$("#rbtnClose").on("click", function() {
		 $("#modalDiv").hide("slow");
		 });
		 $("#rbtnClose2").on("click", function() {
		 $("#modalDiv2").hide("slow");
		 }); */
		/* 		$("#modalForm input[type='button']").on("click", function() {
		 $("#modalDiv").hide("slow");
		 });
		 $("#modalForm2 input[type='button']").on("click", function() {
		 $("#modalDiv2").hide("slow");
		 }); */
	});

	function ReplyView() {
		var table = $("#replyTable");
		$("#replyTable tr:gt(0)").remove();
		var reviewNum = ${review.review_num};
		/* member_id 수정해야됨 */
		$.ajax({
					url : "${contextPath}/reply/replyView?num=" + reviewNum,
					type : "get",
					dataType : "json",
					success : function(data) {
						for ( var i in data) {
							var tr = $("<tr>");
							var modiText = $("<div id='mod"+i+"' class='collapse form-group'><input type='hidden' name='num' value='"+data[i].review_reply_num+"'><input type='hidden' name='id' value='"+data[i].member_id+"'> password <input class='form-control' type='text' name='pw'><br><textarea class='form-control' name='content' rows='3' cols='80'>"
									+ data[i].review_reply_content + "</textarea></div>");
							var remvText = $("<div id='modd"+i+"' class='collapse form-group'><input type='hidden' name='num2' value='"+data[i].review_reply_num+"'><input type='hidden' name='id2' value='"+data[i].member_id+"'> password <input class='form-control' type='text' name='pw2'></div>");
							
							var rbtnModify = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#mod"+i+"'>M</button>");
							var rbtnRemove = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#modd"+i+"'>D</button>");
							var btnReport = $("<button type='button' class='btn btn-link' onclick='loction.href=report'>Report</button>");
							
							var form = $("<form action='#'></form>");
							var form2 = $("<form action='#'></form>");
							var btnSubmit = $("<button type='button' class='btn btn-link'>ok</button>");
							var btnSubmit2 = $("<button type='button' class='btn btn-link'>ok</button>");

							$("<td>").text(data[i].member_id).appendTo(tr);
							$("<td>").text(data[i].review_reply_content)
									.append(form.append(modiText.append(btnSubmit)))
									.appendTo(tr);
							$("<td>").append(form2.append(remvText.append(btnSubmit2)))
									.appendTo(tr);
							$("<td>").text(data[i].review_reply_reg_date)
									.appendTo(tr);
							$("<td>").append(rbtnModify).append(rbtnRemove)
									.appendTo(tr);
							$("<td>").append(btnReport).appendTo(tr);

							tr.appendTo(table);

							rbtnModify.on("click", function() {
								var removeBtn = $(this).next();
								if (removeBtn.attr('disabled') == 'disabled') {
									removeBtn.removeAttr('disabled');
								} else {
									removeBtn.attr('disabled', 'true');
								}
							});

							rbtnRemove.on("click", function() {
								var modifyBtn = $(this).prev();
								if(modifyBtn.attr('disabled') == 'disabled'){
									modifyBtn.removeAttr('disabled');
								}else{
									modifyBtn.attr('disabled','true');
								}
							});

							btnSubmit.on("click", function() {
								var data = $(this).closest("form").serialize();
								/* alert(data); */
								$.ajax({
									url : "${contextPath}/reply/rmodify",
									data : data,
									type : "post",
									dataType : "json",
									success : function(result) {
										if (result) {
											alert("수정되었습니다.");
											ReplyView();
										} else {
											alert("다시 시도해주세요.");
											ReplyView();
										}
									},
									error : function() {
										alert("replyModify error");
									}
								});
								return false;
							});
							btnSubmit2.on("click", function() {
								var data = $(this).closest("form").serialize();
								/* alert(data); */
								$.ajax({
									url : "${contextPath}/reply/rdelete",
									data : data,
									type : "post",
									dataType : "json",
									success : function(result) {
										if (result) {
											alert("삭제되었습니다.");
											ReplyView();
										} else {
											alert("다시 시도해주세요.");
											ReplyView();
										}
									},
									error : function() {
										alert("replyDelete error");
									}
								});
								return false;
							});
						}

					}
				});

	};
</script>
</head>
<body>
	<!--리뷰내용-->

	<div class="container">
		<div class="jumbotron text-center">
			<h1>HWARANG</h1>
			<p>Your own exhibition</p>
		</div>
		<div style='text-align: center;'>
			<input type="hidden" name="num" value="${review.review_num}">
			<table class="table">
				<tr>
					<th>Program name</th>
					<td>${review.review_exh_name}</td>
				</tr>
				<tr>
					<th>Title</th>
					<td>${review.review_title}</td>
				</tr>
				<tr>
					<th>Writer</th>
					<td>${review.member_id}</td>
				</tr>
				<tr>
					<th>Date</th>
					<td><fmt:formatDate value="${review.review_reg_date}"
							pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<td colspan="5">
					<c:choose>
						<c:when test="${empty imgs }">
							<p>첨부된 파일이 없습니다.</p>
						</c:when>
						<c:otherwise> 
							<c:forEach items="${imgs }" var="img" varStatus="vs">
							<div>
								<img onerror="this.style.display='none'" alt='' style='max-width: 100%; height: auto;' src="downloadThumb?uuid=${img.review_uuid}">
								<a href="download?uuid=${img.review_uuid}">${img.review_filename }</a>
					            <br><br>
							</div>
						    </c:forEach>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>					
					<td colspan="5">${review.review_content}</td>
				</tr>
				<%-- 
			<tr>
				<th>File</th>
				<td><a href="download?num=${review.review_num}" id="attach_file">${img.review_filename}</a></td>
			</tr> 
			--%>
				<tr align="right">
					<td colspan="4">
					<input type="button" onclick="location.href='reviewboard'" value="List" class="btn btn-link"> 
					<input type="button" onclick="location.href='checkPw?id=${review.member_id}&num=${review.review_num}&button=modify'" value="Modify" class="btn btn-link"> 
					<input type="button" onclick="location.href='checkPw?id=${review.member_id}&num=${review.review_num}&button=remove'" value="Remove" class="btn btn-link">
					<input type="button" onclick="location.href='report'" value="Report" class="btn btn-link">
					</td>
				</tr>
			</table>
		</div>
		<!-- 리뷰댓글등록 -->
		<div class="form-group">
			<form id="rwriteForm">
				<!-- member_id 고치기 -->
				<input type="hidden" name="member_id" value="test1"> 
				<input type="hidden" name="review_num" value="${review.review_num}">
				<table>
					<tr>
						<td><textarea class="form-control" id="rcontent" name="rcontent" rows="3"
								cols="100"></textarea></td>
						<td>
							<button class="btn btn-link" id="rbtnWrite">Write</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 리뷰댓글목록(AJax) -->
		<div class="table">
			<table id="replyTable" class="table table-hover">
				<tr></tr>
			</table>
		</div>
	</div>
	<!-- 모달창:Modify 
	<div class="modalDiv" id="modalDiv">
		<form class="modalForm" id="modalForm">
			member_id
			<input type="hidden" name="modalId" id="modalId"> <input
				type="hidden" name="modalNum" id="modalNum">
			<table class="modalTable" id="modalTable">
				<tr>
					<td>Password <input type="password" id="modalPw"
						name="modalPw">
					</td>
				</tr>
				<tr>
					<td>Content <input type="text" id="modalContent"
						name="modalContent">
					</td>
				</tr>
				<tr>
					<td><input type="submit" id="rbtnOk" value="Ok"> <input
						type="button" id="rbtnClose" value="Close"></td>
				</tr>
			</table>
		</form>
	</div>
	모달창:Delete
	<div class="modalDiv2" id="modalDiv2">
		<form class="modalForm2" id="modalForm2">
			member_id
			<input type="hidden" name="modalId2" id="modalId2"> <input
				type="hidden" name="modalNum2" id="modalNum2">
			<table class="modalTable2" id="modalTable2">
				<tr>
					<td>Password <input type="password" id="modalPw2"
						name="modalPw2">
					</td>
				</tr>
				<tr>
					<td><input type="submit" id="rbtnOk2" value="Ok"> <input
						type="button" id="rbtnClose2" value="Close"></td>
				</tr>
			</table>
		</form>
	</div> 
-->
</body>
</html>