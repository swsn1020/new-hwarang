<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layout/menu.jsp"%>
<%
	String order_qty = request.getParameter("order_qty");
	String order_price = request.getParameter("order_price");
	String order_title = request.getParameter("order_title");
	String order_image = request.getParameter("order_image");
	int total_price =Integer.parseInt(order_price);
	int total_qty =Integer.parseInt(order_qty);
	int total = total_price * total_qty;
	
%>
%>
	<div align="center" style="padding-left: 15%;padding-right: 15%;table-layout: fixed;">
		<h3>구매 내역</h3>
		<table class="table">
			<tbody>
				<tr>
					<th>상품 이미지</th>
					<th>상품명</th>
					<th>구매수량</th>
					<th>결제금액</th>
					<th>상태</th>
				</tr>
				<tr>
					<th><img width="100" alt="" src="<%=order_image%>"></th>
					<th><%=order_title%></th>
					<th><%=order_qty%></th>
					<th><%=total %></th>
					<th>결제완료</th>
				</tr>
			</tbody>
	
	
	
		</table>
	</div>
		
<%@include file="../layout/bottom.jsp"%>
			
			