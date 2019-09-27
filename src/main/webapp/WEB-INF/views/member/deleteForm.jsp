<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
* {
    padding: 0;
	margin: 0 auto;
    box-sizing: border-box;
}
form {
    margin-top: 0em;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		var id = '${param.id}';
		if(id.match(".*(naver).*")){
			$("input[name='member_id']").val("네이버 간편 로그인");
			$("input[name='snsId']").val(id);
		}else if(id.match(".*(kakao).*")){
			$("input[name='member_id']").val("카카오톡 간편 로그인");
			$("input[name='snsId']").val(id);
		}else{
			$("input[name='member_id']").val(id);
		}
		
		$("input[type='checkbox']").ionCheckRadio();
	});
	function doSubmit(frm){
		if($("textarea[name='content']").val() == ""){
			alert("탈퇴사유를 입력하세요.");
			$("textares[name='content']").focus();
			return;
		}
		if($("input[name='agree']:checked").val() != "Y"){
			alert("안내사항 동의를 체크해주세요.");
			return;
		}
		frm.submit;
	}
</script>
</head>
<body>
	<div class="container">
			<div class="jumbotron text-center">
				<h1>HWARANG</h1>
				<p>Your own exhibition</p>
			</div>
			<div id="containers" style="width: 720px; margin: 0 auto;" align="center">
				<h3>회원 탈퇴</h3>
				<form action="/member/delete" onsubmit="doSubmit(this);return false;">
					<input type="hidden" name="snsId" id="snsId">
					<table class="table"> 
						<tbody>
							<tr>
								<th>아이디</th>
								<td>
									<input type="text" class="form-control" style="width: 40%;" readonly="readonly" name="member_id" id="member_id">
								</td>
							</tr>
							<tr>
								<th>탈퇴 사유</th>
								<td><textarea name="content" class="form-control" placeholder="탈퇴사유에 대해 적어주시기 바랍니다." style="width: 80%;" rows="5" cols="50"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input type="checkbox" name="agree" value="Y">
									탈퇴 시 아이디의 재사용 및 데이터 복구가 불가함에 동의합니다.
								</td>
							</tr>
							<tr>
								<td colspan="2" align="center">
								<div>
									<button type="submit" >회원탈퇴</button>
									<button type="button" onclick="history.back()">취소</button>
								</div>
								</td>
								
							</tr>
						</tbody>
					</table>
				</form>
				
			</div>
	</div>
</body>
</html>