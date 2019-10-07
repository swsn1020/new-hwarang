<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화랑-신고</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/resources/css/contents.css">
<link rel="stylesheet" type="text/css" href="/resources/css/respond.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#blockForm").on("submit", function(e){
		e.preventDefault();
		var txt = $("#txt-content").val();
		$("#radio4").attr("value", txt);
		var d = $(this).serialize();
// 		alert(data);
		$.ajax({
			url: "blockRegister",
			data: d,
			type: "post",
			success: function(result){
				if(result){
					alert("신고 접수 성공");
					window.close();
				}else{
					alert("신고 접수 실패");
				}
			},
			error: function(){
				alert("이미 신고처리된 글입니다.");
				window.close();
			}
		});
	});
// 	return false;
});

	function hide(id){
		document.getElementById(id).style.display='none';
	}
	function show(id){
		document.getElementById(id).style.display='';
	}


</script>
</head>
<body>
	<div class="container" style="width: 400px; height: 500px;">
		<h3>신고하기</h3>
		<div class="form-group" style="padding: 5px;">
			<form id="blockForm" name="blockForm" method="post">
				<input type="hidden" name="category" value="${category }">
				<input type="hidden" name="boardNum" value="${boardNum }"> 
				<input type="hidden" name="blockMemId" value="${blockMemId }">
				<input type="text" name="boardTitle" value="${boardTitle }">
				<p style="font-weight: bold;">신고자ID 
					<input type="text" name="memId" class="form-control" value="<sec:authentication property="principal.Username"/>" readonly="readonly">
				</p>
				<fieldset>
					<legend style="font-weight: bold; font-size: medium;">신고 내용</legend>
					<div class="form-check">
				      <label class="form-check-label" for="radio1">
				        <input type="radio" class="form-check-input" id="radio1" name="content" value="부적절한 홍보 게시물" onclick="hide('div-content')">부적절한 홍보 게시물
				      </label>
				    </div>
				    <div class="form-check">
				      <label class="form-check-label" for="radio2">
				        <input type="radio" class="form-check-input" id="radio2" name="content" value="음란성 또는 청소년에게 부적합한 내용" onclick="hide('div-content')">음란성 또는 청소년에게 부적합한 내용
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
				        	<textarea id="txt-content" class="form-control" rows="5" style="resize: none;"></textarea>
				        </div>
				    </div>
				</fieldset><br>
			    <div style="text-align: center;">
		    		<p style="color: red;">*한번 신고한 글은 수정할 수 없습니다.</p>
					<input type="submit" class="btn btn-outline-danger btn-sm" value="신고등록">
					<input type="button" class="btn btn-outline-dark btn-sm" value="닫기" onclick="self.close();">
				</div>
			</form>
			</div>
		</div>
</body>
</html>