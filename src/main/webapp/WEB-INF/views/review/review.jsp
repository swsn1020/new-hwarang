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
<title>reviewForm</title>
<script type="text/javascript">

</script>
<script type="text/javascript">
	$(function() {

		ReplyView();
		var num = ${review.review_num};
		$("#rbtnWrite").on("click", function() {
			var data = $("#rwriteForm").serialize();
			$.ajax({
				url : "/reviewreply/rwrite?num="+num,
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
					alert("reivewreplyWrtie error");
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
		var seqid = $("#seqid").val();
		/* member_id 수정해야됨 */
		$.ajax({
					url : "/reviewreply/replyView?num=" + reviewNum,
					type : "get",
					dataType : "json",
					success : function(data) {
						for ( var i in data) {
							var tr = $("<tr>");
							var modiText = $("<div id='mod"+i+"' class='collapse form-group'><input type='hidden' name='num' value='"+data[i].review_reply_num+"'><input type='hidden' name='id' value='"+data[i].member_id+"'><textarea class='form-control' name='content' rows='3' cols='80'>"+data[i].review_reply_content+"</textarea></div>");
							var remvText = $("<div id='modd"+i+"' class='collapse form-group'><input type='hidden' id='replynum' name='num' value='"+data[i].review_reply_num+"'></div>");
							
							var rbtnModify = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#mod"+i+"'>M</button>");
							var rbtnRemove = $("<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#modd"+i+"'>D</button>");
							var btnReport = $("<button type='button' class='btn btn-link' onclick='loction.href=report'>Report</button>");
							
							var form = $("<form action='#'></form>");
							var form2 = $("<form action='#'></form>");
							var btnSubmit = $("<button type='button' class='btn btn-link'>ok</button>");

							$("<td>").text(data[i].member_id).appendTo(tr);
							$("<td>").text(data[i].review_reply_content)
									.append(form.append(modiText.append(btnSubmit)))
									.appendTo(tr);
							$("<td>").append(form2.append(remvText)).appendTo(tr);
							$("<td>").text(data[i].review_reply_reg_date)
									.appendTo(tr);
							
							if(seqid == data[i].member_id){
								$("<td>").append(rbtnModify).append(rbtnRemove).appendTo(tr);								
							}
						
							$("<td colspan='2'>").append(btnReport).appendTo(tr);

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
								
								var data = $(this).closest("form").serialize();
								var replynum = $("#replynum").val();
								/* alert(data); */
								$.ajax({
									url : "/reviewreply/rdelete?num="+replynum,
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
										alert("reviewreplyDelete error");
									}
								});
								return false;
							});

							btnSubmit.on("click", function() {
								var data = $(this).closest("form").serialize();
								/* alert(data); */
								$.ajax({
									url : "/reviewreply/rmodify",
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
										alert("reviewreplyModify error");
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
			<h1>관람 후기</h1>
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
				<tr align="right">
					<td colspan="4">
					<input type="button" onclick="location.href='/review/reviewboard'" value="List" class="btn btn-link"> 
					<input type="hidden" id="seqid" value="${id}"> 
					<c:if test="${id eq review.member_id}">
						<input type="button" onclick="location.href='/review/modify?num=${review.review_num}'" value="Modify" class="btn btn-link"> 
						<input type="button" onclick="location.href='/review/remove?num=${review.review_num}'" value="Remove" class="btn btn-link">
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
<%@ include file="../layout/bottom.jsp"%>
</body>
</html>