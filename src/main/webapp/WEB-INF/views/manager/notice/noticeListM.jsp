<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-공지사항</title>
<%@ include file="../../layout/managerSidebar.jsp" %>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	th {
		text-align: center;
	}
	
	.form-control:focus {
		border-color: #9C869C;
		-webkit-box-shadow: 0 0 0 0.2rem rgba(156, 134, 156, 0.25);
  		box-shadow: 0 0 0 0.2rem rgba(156, 134, 156, 0.25);
	}
</style>
<script type="text/javascript">
</script>
	<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1><strong>공지사항</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
          	<div class="card-body" style="padding: 20px;">
          		<div class="buttondiv" style="text-align: center; float: right; margin-bottom: 10px;">
					<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='noticeWrite'">공지작성</button>
				</div>
          		<div class="table-responsive">
					<table class="table table-hover" style="margin: auto;">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>등록일</th>
								<th>조회수</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${noticeList }" var="notice" varStatus="vs">
								<fmt:formatDate value="${notice.regDate }" var="regDate" pattern="yyyy-MM-dd" />
								<tr>
									<td style="text-align: center; width: 10%;">${notice.num }</td>
									<td><a href="noticeView?num=${notice.num }">${notice.title }</a>
										<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${notice.replyCnt }</span>
									</td>
									<td style="text-align: center; width: 20%;">${regDate }</td>
									<td style="text-align: center; width: 10%;">${notice.readCnt }</td>
									<td style="text-align: center; width: 20%;">
										<button class="btn btn-outline-primary btn-sm" onclick="location.href='noticeModify?num=${notice.num}'">수정</button> 
										<button class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target="#checkPwModal${vs.index }">삭제</button>
										<!-- checkPw Modal -->
									  	<div class="modal fade" id="checkPwModal${vs.index }" style="text-align: center;">
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
										          	<input type="hidden" name="num" value="${notice.num }">
										          	<input type="hidden" name="type" value="delete">
										          	<p>비밀번호를 입력하세요</p>
										          	<input type="password" name="password"> <br><br>
										          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
										          	<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">닫기</button>
										          </form>
										        </div>
									      	</div>
									    </div>
									  </div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div style="text-align: center; margin: 10px;">
					<div class="text">
						<form id="searchForm" action="noticeListForManager" method="get">
							<select name="type" class="form-control-sm">
								<option value="" <c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}"/>>검색
								</option>
								<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected' : ''}"/>>제목
								</option>
								<option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected': ''}"/>>카테고리
								</option>
								<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected': ''}"/>>내용
								</option>
								<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected': ''}"/>>제목+내용
								</option>
								<option value="TA" <c:out value="${pageMaker.cri.type eq 'TA' ? 'selected': ''}"/>>제목+카테고리
								</option>
								<option value="TAC" <c:out value="${pageMaker.cri.type eq 'TAC' ? 'selected': ''}"/>>제목+카테고리+내용
								</option>
							</select>
							<input type="text" class="form-control-sm" name="keyword" placeholder="검색어를 입력하세요." value="<c:out value="${pageMaker.cri.keyword }"/>">
							<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
							<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
							<button class="btn btn-outline-primary btn-sm">검색</button>
						</form>
					</div>
				</div>
			<!-- Pagination -->
				<ul class="pagination justify-content-center">
					<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="noticeListForManager?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
					</li>
					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
						<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
							<a class="page-link" href="noticeListForManager?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">${num}</a>
						</li>
					</c:forEach>
					<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
						<a class="page-link" href="noticeListForManager?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</section>
</div>
