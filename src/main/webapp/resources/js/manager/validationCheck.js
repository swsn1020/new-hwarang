/**
 * ValidationCheck
 */

//공지사항, REPORT, FAQ, QNA 게시판  form 요소들 유효성 검사
function valCheck(formId){
	//form 요소 선택하기 (form.find("input[name='title'").length && )
	//유효성 검사가 제대로 끝나면 true, 아니면 false 반환
	var form = $("#"+formId);
	if(form.find("input[name='title']").length && form.find("input[name='title']").val().trim()==''){
		alert("제목은 필수입력 값입니다.");
		form.find("input[name='title']").focus(); 
		return false;
	}
	if(form.find("select[name='category']").length && form.find("select[name='category']").val().trim()=='default'){
		alert("게시판을 선택하세요.");
		form.find("input[name='category']").focus(); 
		return false;
	}
	if(form.find("select[name='subCategory']").length && form.find("select[name='subCategory']").val().trim()=='default'){
		alert("분류를 선택하세요.");
		form.find("input[name='subCategory']").focus();
		return false;
	}
	if(form.find("textarea[name='content']").length && form.find("textarea[name='content']").val()==''){
		alert("내용을 입력하세요.");
		form.find("textarea[name='content']").focus(); 
		return false;
	}
	if(form.find("input[name='question']").length && form.find("input[name='question']").val().trim()==''){
		alert("질문을 입력하세요.");
		form.find("input[name='question']").focus(); 
		return false;
	}
	if(form.find("textarea[name='answer']").length && form.find("textarea[name='answer']").val().trim()==''){
		alert("답변을 입력하세요.");
		form.find("textarea[name='answer']").focus(); 
		return false;
	}
	return true;
}