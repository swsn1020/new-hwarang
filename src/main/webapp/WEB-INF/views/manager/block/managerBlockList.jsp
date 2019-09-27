<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-전체 신고 현황</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript">
	$(function(){
		$("#blocks tr td[name='final']").css('color', 'red');
	});


	function replyRegister(modalId){
		var blockNum = $("#"+modalId).find('input').val();
		var reply = $("#"+modalId).find('textarea').val();
	//		alert(reply);
		var d = {"num": blockNum, "reply": reply};
		$.ajax({
			url: "replyModify",
			data: d,
			type: "post",
			dataType: "json",
			success: function(result){
				if(result){
					alert("답변이 등록되었습니다.");
					location.reload();
				}else{
					alert("답변 등록 다시시도!");
				}
			},
			error: function(){
				alert("답변등록 ajax 오류");
			}
		});
	}
</script>
	<div class="container">
		<h3>전체 신고상황</h3>
		<table class="table table-hover" id="blocks">
			<thead>
				<tr>
					<th>번호</th>
					<th>게시판</th>
					<th>게시글번호</th>
					<th>작성자</th>
					<th>신고일</th>
					<th>처리상태</th>
				</tr>
			</thead>
			<c:forEach items="${blockList }" var="block" varStatus="vs">
				<fmt:formatDate value="${block.regDate }" var="regDate"	pattern="yyyy-MM-dd" />
				<tr>
					<td><a href="/block/blockView?num=${block.num}">${block.num }</a></td>
					<td>${block.category }</td>
					<td>${block.boardNum }</td>
					<td>${block.memId }</td>
					<td>${regDate }</td>
					<c:choose>
						<c:when test="${block.reply eq '미확인' }">
							<!-- 	<td>미답변</td>  onclick="show(this);"-->
							<td id="final">
								<button type="button" id="btn-reply" class="btn btn-outline-primary btn-sm"
									data-toggle="modal" data-target="#replyModal${vs.index }">답변하기</button>
							</td>
						</c:when>
						<c:otherwise>
							<td><a id="final" data-toggle="modal" href="#replyModal${vs.index }">답변완료</a></td>
						</c:otherwise>
					</c:choose>
					<td>
						<!-- Reply Modal -->
						<div class="modal" id="replyModal${vs.index }">
							<div class="modal-dialog">
								<div class="modal-content">
									<!-- Modal Header -->
									<div class="modal-header">
										<h1 class="modal-title">답변작성</h1>
										<button type="button" class="close" data-dismiss="modal">×</button>
									</div>
									<!-- Modal body -->
									<div class="modal-body">
										<div style="margin: 10px;">${block.content}<br></div>
										<div>
											<textarea class="form-control" name="reply" id="reply" rows="5" style="resize: none;">${block.reply }</textarea>
										</div>
									</div>
									<!-- Modal footer -->
									<div class="modal-footer">
										<input type="hidden" id="bsNum" value="${block.num }">
										<button type="button" class="btn btn-outline-primary" onclick="replyRegister('replyModal${vs.index }');">답변등록</button>
										<button type="button" class="btn btn-outline-danger" data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
					</td>
			</c:forEach>
		</table>
		
		<!-- Pagination -->
		<div class="container">
			<ul class="pagination justify-content-center">
				<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="blockListForManager?pageNum=${pageMaker.startPage-1 }">&laquo;</a>
				</li>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
					<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
						<a class="page-link" href="blockListForManager?pageNum=${num}">${num}</a>
					</li>
				</c:forEach>
				<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="blockListForManager?pageNum=${pageMaker.endPage+1 }">&raquo;</a>
				</li>
			</ul>
		</div>
	</div>
<%@ include file="../../layout/bottom.jsp"%>