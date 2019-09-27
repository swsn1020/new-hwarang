<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-FAQ</title>
<%@ include file="../../layout/left.jsp" %>
<div class="container">
	<h3>자주하는 질문</h3><br>
	<div id="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>카테고리</th> 
					<th>질문</th>
					<th>등록일</th>
					<!-- 관리자 권한인 경우 -->
					<th>편집</th>
				</tr>
				</thead>
				<tbody>
					<c:set var="rnum" value="${pageMaker.total - ((pageMaker.cri.pageNum-1)*12)}"/>
					<c:forEach items="${faqList }" var="faq" varStatus="vs">
					<fmt:formatDate value="${faq.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
					<tr>
						<td>${rnum }</td>
						<td>${faq.category }</td>
						<td>
							<div id="accordion">
								<div><a data-toggle="collapse" href="#content${vs.index }">${faq.question }</a></div>
								<div id="content${vs.index }" class="collapse"  data-parent="#accordion">${faq.answer }</div>
							</div>
						</td>
						<td>${regDate}</td>
						<!-- 관리자 권한 -->
						<td>
							<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='faqModify?num=${faq.num}'">수정</button>
							
							<button type="button" class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target="#checkPwModal${vs.index }">삭제</button>
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
							          	<input type="hidden" name="type" value="delete">
							          	<input type="hidden" name="num" value="${faq.num }">
							          	비밀번호를 입력하세요 <br>
							          	<input type="password" name="password"> <br>
							          	<input type="submit" class="btn btn-outline-primary" value="확인">
							          	<button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
							          </form>
							        </div>
						      </div>
						    </div>
						  </div>
						  
						</td>
					</tr>
					<c:set var="rnum" value="${rnum-1 }"></c:set>
			</c:forEach>
			</tbody>
		</table>
		</div>
		<div class="container">
			<form id="searchForm" action="faqList" method="get">
				<select name="type" class="form-control col-sm-2" style="display: inline-block;">
				<option value="" <c:out value="${pageMaker.cri.type eq null ? 'selected' : ''}"/>>검색
				</option>
				<option value="Q" <c:out value="${pageMaker.cri.type eq 'Q'? 'selected' : ''}"/>>질문
				</option>
				<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected': ''}"/>>카테고리
				</option>
				<option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected': ''}"/>>답변
				</option>
				<option value="QA" <c:out value="${pageMaker.cri.type eq 'QA' ? 'selected': ''}"/>>질문+답변
				</option>
				<option value="QC" <c:out value="${pageMaker.cri.type eq 'QC' ? 'selected': ''}"/>>질문+카테고리
				</option>
				<option value="QAC" <c:out value="${pageMaker.cri.type eq 'QAC' ? 'selected': ''}"/>>질문+카테고리+답변
				</option>
				</select>
				<input class="form-control col-sm-5" type="text" name="keyword" placeholder="검색어를 입력하세요." value="<c:out value="${pageMaker.cri.keyword }"/>" style="display: inline-block;">
				<input class="form-control" type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
				<input class="form-control" type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
				<button class="btn btn-outline-primary">검색</button>
			</form>
		</div>		
	</div>
	
	
	<!-- 관리자 권한 가진 사람만 글쓰기 가능 -->
	<div class="buttondiv" align="center" style="margin-top: 10px; margin-bottonm: 10px;">
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='faqWrite'">글 쓰기</button>
	</div>
	<!-- Pagination -->
	<div class="container" style="margin-top: 10px; margin-bottonm: 10px;">
		<ul class="pagination justify-content-center">
			<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="faqList?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
					<a class="page-link" href="faqList?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">[${num}]</a>
				</li>
			</c:forEach>
			<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="faqList?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
			</li>
		</ul>
	</div>
<%@ include file="../../layout/bottom.jsp"%>