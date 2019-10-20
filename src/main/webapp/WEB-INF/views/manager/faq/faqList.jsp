<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-FAQ</title>
<%@ include file="../../layout/menu.jsp" %>
<%@include file="../../layout/rightUser.jsp"%>
<style>
	.faq-div{
		margin: 0 20% 0 20%;
		padding-left: 50px; 
		padding-right: 50px;
	}
	h3{
		font-weight: bold;
	}
	table {
		text-align: center;
	}
</style>
<br><br><br>
<div class="faq-div container" style="padding-left: 50px; padding-right: 50px;">
	<h3>FAQ</h3>
	<div style="border-top: 2px solid black;"></div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th style="width: 10%;">번호</th>
				<th style="width: 10%;">카테고리</th> 
				<th style="width: 50%">질문</th>
				<th style="width: 15%;">등록일</th>
			</tr>
			</thead>
			<tbody>
				<c:set var="rnum" value="${pageMaker.total - ((pageMaker.cri.pageNum-1)*10)}"/>
				<c:forEach items="${faqList }" var="faq" varStatus="vs">
				<fmt:formatDate value="${faq.regDate }" var="regDate" pattern="yyyy-MM-dd"/>
				<tr>
					<td>${rnum }</td>
					<td>${faq.category }</td>
					<td>
						<div id="accordion">
							<div><a data-toggle="collapse" href="#content${vs.index }">Q.&nbsp;${faq.question }</a></div><br>
							<div id="content${vs.index }" class="collapse"  data-parent="#accordion">A.&nbsp;&nbsp;${faq.answer }</div>
						</div>
					</td>
					<td>${regDate}</td>
				</tr>
				<c:set var="rnum" value="${rnum-1 }"></c:set>
			</c:forEach>
		</tbody>
	</table>
	<div style="border-top: 2px solid black;"></div>
	
	<div class="container" style="margin: 10px;">
		<form id="searchForm" action="faqList" method="get"  style="text-align: center;">
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
			<button class="btn btn-outline-dark btn-sm">검색</button>
		</form>
	</div>		
	
	<!-- Pagination -->
	<div class="container" style="margin-top: 10px;">
		<ul class="pagination justify-content-center">
			<li class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="faqList?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
			</li>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
					<a class="page-link" href="faqList?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">${num}</a>
				</li>
			</c:forEach>
			<li class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
				<a class="page-link" href="faqList?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
			</li>
		</ul>
	</div>
	</div>
