<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ include file="../layout/menu.jsp" %>
	<%@include file="../layout/rightUser.jsp"%>
<title>화랑 - 나의 페이지</title>
<style type="text/css">
h1,h2,h3,h4,h5{
	font-weight: bold;
}
</style>
		<div align="center" style="margin-top: 10px;">
			<h3 style="font-weight: bold;">나의 페이지</h3>
		</div>
		<div id="containers" style="width: 70%; margin: 0 auto;">
			<div style="border-top: 2px solid black;"></div>
			<!-- 회원의 기본정보 -->
			<div>
				<table class="table">
					<tbody>
						<tr>
							<td>${member.member_name} 님 <br>
							 나의 포인트 : ${member.member_point}</td>
						</tr>
						<tr align="right">
							<!-- 개인정보 수정 -->
							<td>
								<button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='/member/modifyForm'">개인정보 수정</button>
							<!-- 회원 탈퇴 -->
								<button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='/member/deleteForm'">회원탈퇴</button>						
							</td>
						</tr>
						<tr align="right">
							<!-- 신고 -->
							<td>
								<button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='/block/blockListForUser?memId=<sec:authentication property="principal.username"/>'">신고내역</button>
							<!-- 1:1 -->
								<button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='/qna/qnaListForUser?memId=<sec:authentication property="principal.username"/>'">1:1 문의</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 예매내역 -->
			<div>
				<h3>예매 내역</h3>
				<table class="table">
					<tbody style="border-top: 2px solid black;">
					<tr align="center"> 
						<th>전시명</th>
						<th>날짜</th>
						<th>상태</th>
					</tr>
					</tbody>
				</table>
			</div>
			<!-- 포인트 내역 -->
			<div>
				<h3>포인트 내역</h3>
				<table class="table" >
					<tbody style="border-top: 2px solid black;">
					<tr align="center"> 
						<th>번호</th>
						<th>날짜</th>
						<th colspan="3">내용</th>
						<th>포인트</th>
					</tr>
					<c:forEach items="${points}" var="point">
					<tr align="center">
						<td>${point.point_num}</td>
						<td>
						<c:if test="${point.point_use_date eq null}">
							<fmt:formatDate value="${point.point_get_date}" pattern="yyyy-MM-dd kk:mm:ss"/>							
						</c:if>
						<c:if test="${point.point_get_date eq null}">
							<fmt:formatDate value="${point.point_use_date}" pattern="yyyy-MM-dd kk:mm:ss"/>						
						</c:if>
						</td>
						<td colspan="3">${point.point_memo}</td>
						<c:if test="${point.point_use_date eq null}">
							<td>${point.point_get_amount}</td>						
						</c:if>
						<c:if test="${point.point_get_date eq null}">
							<td>${point.point_use_amount}</td>
						</c:if>
					</tr>
					</c:forEach>			
					</tbody>
				</table>
			</div>
			<!-- 나의 게시글 -->
			<div>
				<h3>나의 게시글</h3>
				<table class="table">
					<tbody align="center" style="border-top: 2px solid black;">
						<tr> 
							<th>구분</th>
							<th>제목</th>
							<th colspan="3">등록일</th>
						</tr>
						<c:forEach items="${free}" var="f">
						<tr>
							<td>자유</td>
							<td><a href="/board/freeboardView?num=${f.num}">${f.title}</a></td>
							<td><fmt:formatDate value="${f.regDate}" pattern="yyyy-MM-dd"/></td>
						</tr>
						</c:forEach>
						<c:forEach items="${review}" var="r">
						<tr>
							<td>후기</td>
							<td><a href="/review/view?num=${r.review_num}">${r.review_title}</a></td>
							<td><fmt:formatDate value="${r.review_reg_date}" pattern="yyyy-MM-dd"/></td>
						</tr>
						</c:forEach>
						<c:forEach items="${recommend}" var="rc">
						<tr>
							<td>홍보</td>
							<td><a href="/recommend/view?num=${rc.recomm_num}">${rc.recomm_title}</a></td>
							<td><fmt:formatDate value="${rc.recomm_reg_date}" pattern="yyyy-MM-dd"/></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div style="border-top: 2px solid black;"></div>
		</div>
		
		  <!-- checkPw Modal -->
		  <div class="modal fade" id="delModal" style="text-align: center;">
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
		          	<p>비밀번호를 입력하세요 </p>
		          	<input type="password" name="password"> <br><br>
		          	<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
		          	<button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">닫기</button>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div>
		  <!-- Modal End -->
<%@ include file="../layout/bottom.jsp"%>