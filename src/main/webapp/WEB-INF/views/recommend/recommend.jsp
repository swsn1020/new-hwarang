<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../layout/left.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/resources/css/style.css">
<meta charset="UTF-8">
<title>recommForm</title>
<script type="text/javascript">
</script>
<script type="text/javascript">
	$(function() {

		ReplyView();
		$("#rbtnWrite").on("click", function() {
			var data = $("#rwriteForm").serialize();
			$.ajax({
				url : "/rreply/rwrite",
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
	var memberid = ${id};
	function ReplyView() {
		var table = $("#replyTable");
		$("#replyTable tr:gt(0)").remove();
		var recommNum = ${recomm.recomm_num};

		/* member_id 수정해야됨 */
		$.ajax({
					url : "/rreply/replyView?num=" + recommNum,
					type : "get",
					dataType : "json",
					success : function(data) {
						for ( var i in data) {
							var tr = $("<tr>");
							var modiText = $("<div id='mod"+i+"' class='collapse form-group'> <input type='hidden' name='num' value='"+data[i].recomm_reply_num+"'><input type='hidden' name='id' value='"+data[i].member_id+"'><br><textarea class='form-control' name='content' rows='3' cols='80'>"+data[i].recomm_reply_content+"</textarea></div>");
							var remvText = $("<div id='modd"+i+"' class='collapse form-group'> <input type='hidden' name='num2' value='"+data[i].recomm_reply_num+"'><input type='hidden' name='id2' value='"+data[i].member_id+"'></div>");
							
							var rbtnModify = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#mod"+i+"'>M</button>");
							var rbtnRemove = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#modd"+i+"'>D</button>");
							var btnReport = $("<button type='button' class='btn btn-link' onclick='loction.href=report'>Report</button>");
							
							var form = $("<form action='#'></form>");
							var form2 = $("<form action='#'></form>");

							var btnSubmit = $("<button type='button' class='btn btn-link'>ok</button>");
							var btnSubmit2 = $("<button type='button' class='btn btn-link'>ok</button>");

							$("<td>").text(data[i].member_id).appendTo(tr);
							$("<td>").text(data[i].recomm_reply_content)
									.append(form.append(modiText.append(btnSubmit)))
									.appendTo(tr);
							$("<td>").append(form2.append(remvText.append(btnSubmit2)))
									.appendTo(tr);
							$("<td>").text(data[i].recomm_reply_reg_date)
									.appendTo(tr);
							
							if(memberid.equals(data[i].member_id)){		
								$("<td>").append(rbtnModify).append(rbtnRemove).appendTo(tr);
							}
							
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
									url : "/rreply/rmodify",
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
									url : "/rreply/rdelete",
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

		<div align="center">
			<h1>추천 게시판</h1>
		</div>
		<div style='text-align: center;'>
			<input type="hidden" name="num" value="${recomm.recomm_num}">
			<table class="table">
				<tr>
					<th>Title</th>
					<td>${recomm.recomm_title}</td>
				</tr>
				<tr>
					<th>Writer</th>
					<td>${recomm.member_id}</td>
				</tr>
				<tr>
					<th>Date</th>
					<td><fmt:formatDate value="${recomm.recomm_reg_date}"
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
								<img onerror="this.style.display='none'" alt='' style='max-width: 100%; height: auto;' src="downloadThumb?uuid=${img.recomm_uuid}">
								<a href="download?uuid=${img.recomm_uuid}">${img.recomm_filename }</a>
					            <br><br>
							</div>
						    </c:forEach>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>					
					<td colspan="5">${recomm.recomm_content}</td>
				</tr>
				<tr align="right">
					<td colspan="4">
					<input type="button" onclick="location.href='/recommend/recommendboard'" value="List" class="btn btn-link"> 
					<input type="text" value="<sec:authentication property="principal.Username" var="id"/>">
					<c:if test="${id eq recomm.member_id}">
						<input type="button" onclick="location.href='/recommend/modify?num=${recomm.recomm_num}'" value="Modify" class="btn btn-link"> 
						<input type="button" onclick="location.href='/recommend/remove?num=${recomm.recomm_num}'" value="Remove" class="btn btn-link">					
					</c:if>
					<input type="button" onclick="location.href='report'" value="Report" class="btn btn-link">
					</td>
				</tr>
			</table>
		</div>
		<!-- 리뷰댓글등록 -->
		<div class="form-group">
			<form id="rwriteForm">
				<input type="hidden" name="member_id" value="${id}"> 
				<input type="hidden" name="recomm_num" value="${recomm.recomm_num}">
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
<%@ include file="../layout/bottom.jsp"%>
</body>
</html>