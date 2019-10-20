<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ include file="../layout/menu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<script>
	src="https://code.jquery.com/jquery-3.3.1.min.js"
    integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
    crossorigin="anonymous"></script><!-- jQuery CDN --->
    
  <script>
    function cancelPay() {
      jQuery.ajax({
        "url": "http://www.myservice.com/payments/cancel",
        "type": "POST",
        "contentType": "application/json",
        "data": JSON.stringify({
          "merchant_uid": "mid_" + new Date().getTime(), // 주문번호
          "cancel_request_amount": 2000, // 환불금액
          "reason": "테스트 결제 환불" // 환불사유
          "refund_holder": "홍길동", // [가상계좌 환불시 필수입력] 환불 가상계좌 예금주
          "refund_bank": "88" // [가상계좌 환불시 필수입력] 환불 가상계좌 은행코드(ex. KG이니시스의 경우 신한은행은 88번)
          "refund_account": "56211105948400" // [가상계좌 환불시 필수입력] 환불 가상계좌 번호
        }),
        "dataType": "json"
      });
    }
</script>
</head>
<body>
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
								<button type="button" onclick="location.href='/member/modifyForm?id=${id}'">개인정보 수정</button>
							<!-- 회원 탈퇴 -->
								<button type="button" onclick="location.href='/member/deleteForm?id=${id}'">회원탈퇴</button>						
							</td>
						</tr>
						<tr align="right">
							<!-- 신고 -->
							<td>
								<button type="button" onclick="location.href='/block/blockListForUser?memId=${id}'">신고내역</button>
							<!-- 1:1 -->
								<button type="button" onclick="location.href='/qna/qnaListForUser?memId=${id}'">1:1 문의</button>
								  <button onclick="cancelPay()">환불하기</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 예매내역 -->
			<div>
				<h3>예매 내역</h3>
				<table class="table" style="table-layout: fixed" align="center">
					<tbody>
					<tr> 
						<th>주문번호</th>
						<th>상품 </th> 
						<th>상품명 </th>
						<th>수량</th>
						<th>총 금액</th>
					</tr>
					<tr>
						<th>주문번호:${order.order_seq_num}</th>
						<th><img width="200" alt="" src="${order.order_image}"></th>
						<th>${order.order_title}</th>
						<th>${order.order_qty}</th>
						<th>${order.order_price}</th>
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
</body>
</html>
<%@ include file="../layout/bottom.jsp"%>