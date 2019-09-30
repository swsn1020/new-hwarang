<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   	<%@ include file="../layout/left.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.div{
    padding: 0;
	margin: 0 auto;
    box-sizing: border-box;
}
form {
    margin-top: 0em;
}
</style>
<meta charset="UTF-8">
<title>joinForm</title>
<script type="text/javascript">

</script>
<script type="text/javascript">
	$(function(){
		$("#inputId").on("blur",function() {
			var inputId = $(this).val();
			$.ajax({
				url:"/member/checkId?id="+inputId,
				data:inputId,
				type:"post",
				dataType:"json",
				success:function(data){
					console.log(data);
					if(data==true){
						$("#msgId").text("사용가능한 아이디입니다.");
						//다시 재입력시
					}else if(data==false){
						$("#msgId").text("이미 사용중인 아이디입니다.");		
						$("#inputId").focus();
						$("#inputId").val("");
					}else if(data==no){
						$("#msgId").text("");							
					}
				},
				error:function(request, error){
					$("#msgId").text("");
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			return false;
		});
		$("#selectEmail").on("blur",function(){
			var optEmail = $("#selectEmail option:selected").val();
			if(optEmail=="naver.com"){
				$("#inputEmail").val(optEmail);
				$("#inputEmail").focus();
			}
			if(optEmail=="hanmail.net"){
				$("#inputEmail").val(optEmail);	
				$("#inputEmail").focus();
			}
			if(optEmail=="gmail.com"){
				$("#inputEmail").val(optEmail);
				$("#inputEmail").focus();
			}
			if(optEmail==""){
				$("#inputEmail").val("");
				$("#inputEmail").focus();
			}
		});
	});
	
function goPopup(){
	window.open("jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn , detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo){ 
	document.form.roadAddrPart1.value = roadAddrPart1;
	document.form.addrDetail.value = addrDetail;
	document.form.zipNo.value = zipNo;
}
function joinSubmit(){
	if(document.form.id.value == ""){
		alert("아이디을 입력해주세요.");
		document.form.id.focus();
		return;
	}
	if(document.form.password.value == ""){
		alert("비밀번호을 입력해주세요.");
		document.form.password.focus();
		return;
	}
	if(document.form.name.value == ""){
		alert("이름을 입력해주세요.");
		document.form.name.focus();
		return;
	}
	if(document.form.tel1.value == ""){
		alert("전화번호을 입력해주세요.");
		document.form.tel1.focus();
		return;
	}
	if(document.form.tel2.value == ""){
		alert("전화번호을 입력해주세요.");
		document.form.tel2.focus();
		return;
	}
	if(document.form.tel3.value == ""){
		alert("전화번호을 입력해주세요.");
		document.form.tel3.focus();
		return;
	}
	if(document.form.email1.value == ""){
		alert("이메일을 입력해주세요.");
		document.form.email1.focus();
		return;
	}
	if(document.form.email2.value == ""){
		alert("이메일을 입력해주세요.");
		document.form.email2.focus();
		return;
	}
	if(document.form.roadAddrPart1.value == ""){
		alert("주소을 입력해주세요.");
		return;
	}
	document.form.method = "get";
	document.form.action = "/member/join";
	document.form.submit();
}

</script>
</head>
<body>

		<div align="center">
			<h1>회원가입</h1>
		</div>

		<div class="div" id="containers" style="width: 720px; margin: 0 auto;">
			<form id="form" name="form" method="post" action="/member/join">
				<table class="table">
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<div class="form-inline" id="dataId">
								<input type="text" id="inputId" class="form-control" name="id" style="width: 40%;">
								<!-- 아이디 중복 확인 -->
							</div>
							<small><span id="msgId"></span></small>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" id="inputPw" class="form-control" name="password" style="width: 40%;">
							<!-- 비밀번호 확인 -->
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text"  class="form-control"  name="name" style="width: 40%;">
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<input type="radio" name="gender" checked="checked" value="0">남자
							&nbsp;&nbsp;
							<input type="radio" name="gender" value="1">여자
						</td>
					</tr>
					<tr>
						<th>휴대전화번호</th>
						<td>
						<div class="form-inline">
							<select class="form-control" name="tel1" title="010" style="width: 20%;">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							&nbsp;-&nbsp;
							<input  class="form-control" type="number" name="tel2" style="width: 20%;">
							&nbsp;-&nbsp;
							<input  class="form-control" type="number" name="tel3" style="width: 20%;">
						</div>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
						<div class="form-inline">
							<input  class="form-control"  type="text" name="email1" style="width: 20%;">
							&nbsp;@&nbsp;
							<input  class="form-control" id="inputEmail" type="text" name="email2" style="width: 20%;">
							<select class="form-control" id="selectEmail" name="email3" title="직접입력" style="width: 20%;">
								<option value="">직접입력</option>
								<option value="naver.com">네이버</option>
								<option value="hanmail.net">다음</option>
								<option value="gmail.com">구글</option>
							</select>
						</div>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
						<div class="form-inline">
							<input class="form-control" type="text" readonly="readonly" name="zipNo" id="zipNo" style="width: 15%;">
							<input  class="form-control" id="roadAddrPart1" type="text" readonly="readonly"  id="roadAddrPart1" name="roadAddrPart1" style="width: 60%;">
							<button type="button" class="btn btn-link" id="buttonAdr" onclick="goPopup()">주소찾기</button>
							<br><br>							
							<input  class="form-control" id="addrDetail" type="text" name="addrDetail" style="width: 70%;">
						</div>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="form-inline" align="center"> 
					<button type="button" onclick="javascript:joinSubmit();" class="form-control">확인</button>
					<button type="button" onclick="location.href='/member/loginForm'" class="form-control">취소</button>
				</div>
			</form>
		</div>
<%@ include file="../layout/bottom.jsp"%>
</body>
</html>