<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-FAQ</title>
<%@include file="../../layout/managerSidebar.jsp"%>
<style>
	.container{
		margin: 10px 0px;
		padding: 3px 0px;
	}
	table {
		text-align: center;
	}
</style>
<div class="content-inner" style="padding-bottom: 59px;">
	<section class="projects no-padding-top">
		<div class="contianer-fluid">
			<div style="width: 100%; padding-top: 50px; margin-bottom: 10px; text-align: center;">
				<h1 style="color: #80425A"><strong>FAQ</strong></h1>
			</div>
		</div>
		<div class="project" id="project3">
          <div class="row bg-white has-shadow">
           <div class="card-body" style="padding: 20px;">
           	<div class="buttondiv" style="text-align: center; float: right; margin-bottom: 10px;">
				<button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='faqWrite'">질문작성</button>
			</div>
           	<div class="table-responsive">
				<table class="table table-hover">
					<thead>
						<tr>
							<th style="width: 10%;">번호</th>
							<th style="width: 10%;">카테고리</th> 
							<th style="width: 50%">질문</th>
							<th style="width: 15%;">등록일</th>
							<!-- 관리자 권한 -->
							<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
								<th>편집</th>
							</sec:authorize>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${faqList }" var="faq" varStatus="vs">
							<fmt:formatDate value="${faq.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
							<tr>
								<td>${faq.num }</td>
								<td>${faq.category }</td>
								<td>
									<div id="accordion">
										<div><a data-toggle="collapse" href="#content${vs.index }">${faq.question }</a></div>
										<div id="content${vs.index }" class="collapse"  data-parent="#accordion">${faq.answer }</div>
									</div>
								</td>
								<td>${regDate}</td>
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
									          	<input type="hidden" name="num" value="${faq.num }">
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
					<form id="searchForm" action="faqListForManager" method="get">
						<select name="type">
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
						<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="<c:out value="${pageMaker.cri.keyword }"/>">
						<input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>">
						<input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>">
						<button class="btn btn-outline-primary btn-sm">검색</button>
					</form>
				</div>
			</div>		
           	<!-- Pagination -->
			<ul class="pagination justify-content-center">
				<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="faqListForManager?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
				</li>
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
					<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
						<a class="page-link" href="faqListForManager?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">${num}</a>
					</li>
				</c:forEach>
				<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
					<a class="page-link" href="faqListForManager?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
				</li>
			</ul>
           </div>
          </div>
         </div>
        </section>
       </div>
