<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>화랑-신고게시판</title>
<%@ include file="../../layout/menu.jsp" %>
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
		<h3>신고게시판</h3>
		<div class="form-group">
			<form id="reportForm" action="reportWrite" method="post" enctype="multipart/form-data">
				<input type="hidden" name="memId" value="<sec:authentication property="principal.Username"/>">
				<div class="table-responsive">
					<table class="table">
						<tr>
							<th style="width: 17%;">게시판 분류</th>
							<td>
								<select id="category" name="category" class="form-control col-md-3" onchange="doChange(this, 'subCategory')" style="display: inline-block;">
									<option value="default">--게시판 선택--</option>
									<option value="Notice">공지게시판</option>
									<option value="Free">자유게시판</option>
									<option value="Review">후기게시판</option>
									<option value="Exhibition">전시게시판</option>
									<option value="Funding">펀딩게시판</option>
								</select>
								<select id="subCategory" name="subCategory" class="form-control col-md-3" style="display: inline-block;">
									<option value="default">--분류--</option>
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
								<pre><textarea class="form-control" rows="15" name="content" style="resize: none;" placeholder="*신고 내용 작성은 2000자까지 가능합니다. "></textarea></pre>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<input type="file" name="file" multiple="multiple" class="form-control">
							</td>
						</tr>
					</table>
				</div>
				<div class="btnGroup" style="text-align: center;">
					<input type="submit" value="글 작성" class="btn btn-outline-primary btn-sm">
					<input type="reset" value="초기화" class="btn btn-outline-dark btn-sm">
					<input type="button" value="목록" onclick="location.href='reportList" class="btn btn-outline-info btn-sm">
				</div>
			</form>
		</div>
	</div>
