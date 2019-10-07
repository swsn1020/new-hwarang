<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고하기수정</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript">
$(function(){

});
	function hide(id){
		document.getElementById(id).style.display='none';
	}
	function show(id){
		document.getElementById(id).style.display='';
	}
	
</script>
	<div class="container">
	<h3>화랑-신고수정하기</h3>
	<div class="form-group"></div>
	<form action="blockModify" method="post">
		<input type="text" name="num" value="${block.num }">
		<input type="text" name="category" value="${block.category }">
		<input type="text" name="boardNum" value="${block.boardNum }"> 
		<input type="text" name="blockMemId" value="${block.bMemId }">
		<!-- 작성자 아이디 (받아오기) -->
		<input type="text" name="memId" value="haddie" readonly="readonly">
	
		<div class="form-check">
	      <label class="form-check-label" for="radio1">
	        <input type="radio" class="form-check-input" id="radio1" name="content" value="영리/홍보" onclick="hide('div-content')">부적절한 홍보 게시물
	      </label>
	    </div>
	    <div class="form-check">
	      <label class="form-check-label" for="radio2">
	        <input type="radio" class="form-check-input" id="radio2" name="content" value="음란성" onclick="hide('div-content')">음란성 또는 청소년에게 부적합한 내용
	      </label>
	    </div>
	    <div class="form-check">
	      <label class="form-check-label" for="radio3">
	        <input type="radio" class="form-check-input" id="radio3" name="content" value="장난성" onclick="hide('div-content')">장난성 또는 질문에 맞지 않는 무의미글
	      </label>
	    </div>
	    <div class="form-check">
	      <label class="form-check-label" for="radio4">
	        <input type="radio" class="form-check-input" id="radio4" name="content" onclick="show('div-content')">기타 <br>
	      </label>
	        <div id="div-content" style="display:none">
	        	<textarea id="txt-content" name="txt-content" rows="5" cols="30"></textarea>
	        </div>
	    </div>
	    <br>
		<input type="submit" value="신고하기">
		<input type="reset" value="다시작성">
	</form>
	</div>
<%@ include file="../../layout/bottom.jsp"%>