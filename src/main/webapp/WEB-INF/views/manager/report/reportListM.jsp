${mem }<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고게시판</title>
<%@ include file="../../layout/managerSidebar.jsp" %>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	th {
		text-align: center;
	}
</style>
<script>
	$(function(){
		$("#replyModal").on('show.bs.modal', function(e){
			var link = $(e.relatedTarget);
			var reportNum = link.data('whatever');
			var reportContent = link.data('content');
			var modal = $(this);
			modal.find("input[name='num']").val(reportNum);
			modal.find("td[id='content']").text(reportContent);
		});
		
		
		$("#blockModal").on('show.bs.modal', function(e){
			var link = $(e.relatedTarget);
			var bCategory = link.data('category');
			var modal = $(this);
			modal.find("input[name='category']").val(bCategory);
		});
		
		
		//신고 모달
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
	
	function hide(id){
		document.getElementById(id).style.display='none';
	}
	function show(id){
		document.getElementById(id).style.display='';
	}
</script>
<style>
	
</style>
<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1><strong>신고게시판</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
          	<div class="card-body" style="padding: 20px;">
          		<div class="table-responsive">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>처리상태</th>
							<th>관리</th>
						</tr>
					</thead>
					<c:forEach items="${reportList }" var="report">
						<fmt:formatDate value="${report.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
						<tr>
							<td style="text-align: center;">${report.num }</td>
							<td>
								<a href="reportView?num=${report.num }">${report.title }</a>
							</td>
							<td style="text-align: center;">${report.memId }</td>
							<td style="text-align: center;">${regDate }</td>
							<c:choose>
								<c:when test="${report.reply eq '미해결' || report.reply eq null }">
									<td style="text-align: center;"><a data-toggle="modal" href="#replyModal" data-whatever="${report.num }" data-content="${report.content }" style="color: #57859D">처리 중</a></td>
								</c:when>
								<c:otherwise>
									<td style="text-align: center;">처리 완료</td>
								</c:otherwise>
							</c:choose>
							<td style="text-align: center;">
								<span><a href="#blockModal" data-toggle="modal" data-category="${report.category }" style="color: red;"><i class="fas fa-ban fa-lg"></i></a></span>
							</td>
						</tr>
					</c:forEach>
				</table>
				</div>
				<ul class="pagination justify-content-center">
					<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="reportListForManager?pageNum=${pageMaker.startPage-1 }">&laquo;</a>
					</li>
					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
						<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
							<a class="page-link" href="reportListForManager?pageNum=${num}">${num}</a>
						</li>
					</c:forEach>
					<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="reportListForManager?pageNum=${pageMaker.endPage+1 }">&raquo;</a>
					</li>
				</ul>
          	</div>
          </div>
         </div>
        </section>
       </div>
       
       <!-- reply Modal -->
	  <div class="modal" id="replyModal">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h1 class="modal-title">답변등록</h1>
	          <button type="button" class="close" data-dismiss="modal">×</button>
	        </div>
	        <!-- Modal body -->
	       	<form action="replyModify" method="post">
	        	<div class="modal-body">
	        		<div class="form-group">
		        		<input type="hidden" name="num" value="">
		        		<table class="table">
		        			<tr>
		        				<th style="width: 20%">작성내용</th>
		        				<td id="content"></td>
		        			</tr>
		        			<tr>
		        				<td colspan="2">
					        		<textarea class="form-control" rows="5" name="reply" style="resize: none;"></textarea><br>
		        				</td>
		        			</tr>
		        		</table>
	        		</div>
	        	</div>
	        <!-- Modal footer -->
	        	<div class="modal-footer">
	         	 	<input type="submit" class="btn btn-outline-primary btn-sm" value="답변등록">
	         	 	<button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">닫기</button>
	       	 	</div>
	       	</form>
	      </div>
	    </div>
	  </div>
	  
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
	          		<td><input class="form-control" type="text" name="category" value="" readonly="readonly">
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
