<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고게시판</title>
<%@ include file="../../layout/left.jsp" %>
<script type="text/javascript" src="/resources/js/manager/validationCheck.js"></script>
<script>
$(function(){
	$("#reportForm").on("submit", function(){
		var validation = valCheck("reportForm");
		if(!validation){
			return false;
		}
	});
});

 function doChange(srcE, targetId){
    var val = srcE.options[srcE.selectedIndex].value;
    var targetE = document.getElementById(targetId);
//     alert(val);
    removeAll(targetE);

    if(val == 'Notice'){
//         addOption('댓글', 'Reply', targetE);
		var newOption = new Option('댓글', 'Reply', true, true);
		$("#subCategory").append(newOption);
        
    } else if(val == ''){
    	
    }
    else {
//     	 addOption('게시글', 'Board', targetE);
//          addOption('댓글', 'Reply', targetE);
    	var newOption1 = new Option('게시글', 'Board', true, true);
		$("#subCategory").append(newOption1);
		var newOption2 = new Option('댓글', 'Reply');
		$("#subCategory").append(newOption2);
    }
}

 /*
function addOption(str, value, e, bool){
	if(vo)
    var o = new Option(str, value);
    try{
        e.add(o);
    }catch(ee){
        e.add(o, null);
    }
}
*/

function removeAll(e){
    for(var i = 0, limit = e.options.length; i < limit - 1; ++i){
        e.remove(1);
    }
}
</script>
	<div class="container">
		<h4>신고하기</h4>
		<div class="form-group">
		<!-- 이미지 넣기 -->
		<form id="reportForm" action="reportWrite" method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="hidden" name="memId" value="haddie">
			<table class="table">
				<tr>
					<th>게시판 종류</th>
					<td>
						<select id="category" name="category" class="form-control col-sm-3" onchange="doChange(this, 'subCategory')" style="display: inline-block;">
							<option value="default">--게시판 선택--</option>
							<option value="Notice">공지게시판</option>
							<option value="Free">자유게시판</option>
							<option value="Review">후기게시판</option>
							<option value="Exhibition">전시게시판</option>
							<option value="Ticket">티켓나눔게시판</option>
							<option value="Funding">펀딩게시판</option>
							<option value="Party">파티원게시판</option>
						</select>
						<select id="subCategory" name="subCategory" class="form-control col-sm-3" style="display: inline-block;">
							<option value="default">--분류--</option>
<!-- 							<option value="Board">게시글</option> -->
<!-- 							<option value="Reply">댓글</option> -->
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input class="form-control col-md-6" type="text" name="title">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea class="form-control" rows="20" name="content" style="resize: none;"></textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<input type="file" name="file" multiple="multiple" class="form-control">
					</td>
				</tr>
			</table>
			<div>
				<input type="submit" value="글 작성" class="btn btn-outline-success">
				<input type="reset" value="초기화" class="btn btn-outline-danger">
				<input type="button" value="목록보기" onclick="location.href='reportList'" class="btn btn-outline-dark">
			</div>
		</form>
		</div>
	</div>
<%@ include file="../../layout/bottom.jsp"%>