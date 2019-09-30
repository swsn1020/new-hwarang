<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ include file="../layout/left.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

</script>
</head>
<body>
		<div align="center">
			<h1>나의 페이지</h1>
		</div>
		<div id="containers" style="width: 720px; margin: 0 auto;">
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
								<button type="button" onclick="location.href='/member/modifyForm?id=${param.id}'">개인정보 수정</button>
							<!-- 회원 탈퇴 -->
								<button type="button" onclick="location.href='/member/deleteForm?id=${param.id}'">회원탈퇴</button>						
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 포인트 내역 -->
			<div>
				<h3>포인트 내역</h3>
				<table class="table" >
					<tbody>
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
					<tbody align="center">
						<tr> 
							<th>구분</th>
							<th>제목</th>
							<th colspan="3">등록일</th>
						</tr>
						<c:forEach items="${review}" var="r">
						<tr>
							<td>후기</td>
							<td><a href="/review/view?num=${r.review_num}">${r.review_title}</a></td>
							<td><fmt:formatDate value="${r.review_reg_date}" pattern="yyyy-MM-dd"/></td>
						</tr>
						</c:forEach>
						<c:forEach items="${recommend}" var="rc">
						<tr>
							<td>추천</td>
							<td><a href="/recommend/view?num=${rc.recomm_num}">${rc.recomm_title}</a></td>
							<td><fmt:formatDate value="${rc.recomm_reg_date}" pattern="yyyy-MM-dd"/></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 예매내역 -->
			<div>
				<h3>예매 내역</h3>
				<table class="table">
					<tbody>
					
					</tbody>
				</table>
			</div>
			<!-- 신고내역 -->
			<div>
				<h3>신고 내역</h3>
				<table class="table">
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
<%@ include file="../layout/bottom.jsp"%>
</body>
</html>