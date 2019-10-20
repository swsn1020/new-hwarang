<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../layout/menu.jsp"%>
<%@ include file="../layout/rightUser.jsp"%>
<title>펀딩 게시판</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="//code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
<script type="text/javascript">
//프로그레스바 
	$(document).ready(function() {
	  $('.progress-bar').each(function() {
	    var bar_value = $(this).attr('aria-valuenow') + '%';                
	    $(this).animate({ width: bar_value }, { duration: 2000, easing: 'easeOutCirc' });
	  });
	});
	
    $(document).ready(function () {
        var result = '<c:out value="${result}" />';
        checkModal(result);
        history.replaceState({}, null, null);
        function checkModal(result) {
            if(result === '' || history.state) return;
            if(parseInt(result) > 0) {
                $(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
            }
            $("#myModal").modal("show");
        }
        $('#regBtn').on("click", function () {
            self.location = "fundingWrite";
        });
        var actionForm = $("#actionform");
        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();
            console.log('click');
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });
       		  $(".move").on("click", function (e) {
         	 e.preventDefault();
             actionForm.append("<input type='hidden' name='funding_num' value='"
              + $(this).attr("href") + "'>");
             actionForm.attr("action", "/funding/get");
             actionForm.submit();
         });  
        var searchForm = $("#searchForm");
        $("#searchForm button").on("click", function (e) {
            e.preventDefault();
            console.log('click search form');
            if(!searchForm.find("option:selected").val()) {
                alert("검색 종류를 선택해 주세요");
                return false;
            }
            if(!searchForm.find("input[name='keyword']").val()) {
                console.log('hihi');
                alert("키워드를 입력하세요");
                return false;
            }
            searchForm.find("input[name='pageNum']").val("1");
            searchForm.submit();
        });
    });
</script>

<!-- Search-Bar -->
<div class="row" style="text-align: center">
	<div class="col-lg-12">
	<!-- <h1 class="reward-header">펀딩 게시판</h1> -->
		<form action="fundingList" method="get" id="searchForm">
			<select name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>--</option>
				<option value="T"
					<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>>제목</option>
				<option value="C"
					<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>내용</option>
				<option value="W"
					<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
				<option value="TC"
					<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}"/>>제목
					or 내용</option>
				<option value="TW"
					<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}"/>>제목
					or 작성자</option>
				<option value="TWC"
					<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}"/>>모두
					검색</option>
			</select> <input type="text" name="keyword"
				value="<c:out value='${pageMaker.cri.keyword}'/>" /> <input
				type="hidden" name="pageNum"
				value="<c:out value='${pageMaker.cri.pageNum}'/>" /> <input
				type="hidden" name="amount"
				value="<c:out value='${pageMaker.cri.amount}'/>" />
			<button class="btn btn-default">Search</button>
		</form>
	</div>
</div>
<!-- /. Search-Bar -->
<div class="row" style="padding-right: 15%; padding-left: 15%;">
       
            <div class="col-lg-12">
                <div class="panel panel-default">
                   <div class="exh-list album py-5 bg-light">
	<div class="row" >
		<c:forEach items="${fundingList}" var="funding">
			<div class="col-sm-3" style="height: 600px; margin: 0 0 20px 0;">
				<div class="card mb-3 shadow-sm">
					<a href="/funding/fundingView?funding_num=${funding.funding_num}"><img
						class="card-img-top" style="width: 100%; height: 400px;"
						alt="item image" role="img" src="${funding.funding_image}"></a>
				</div>
				<div class="card-body">
					<p class="card-title" style="font-weight: bold; font-size: 18px">
						<a href="/funding/fundingView?funding_num=${funding.funding_num}">${funding.funding_subject}</a>
						</p>
						<p>
						<div class="progress" style="height: 20px">
							<div class="progress-bar bg-info" 
							aria-valuenow="${(funding.funding_price/funding.funding_target_amount)*100}" aria-valuemin="0" aria-valuemax="100">
								<strong><fmt:formatNumber pattern=".0">${(funding.funding_price/funding.funding_target_amount)*100}</fmt:formatNumber>%</strong>
							</div>
						</div>
						<br>
						<span style="font-weight: bold" >by ${funding.maker_name}</span>&nbsp;
						
					
				</div>
			</div></c:forEach>
                         
                        <!-- Pagination -->
				<div class="container">
					<ul class="pagination justify-content-center">
						<li
							class='${ pageMaker.prev == true ? "page-item" : "page-item disabled" }'>
							<a class="page-link"
							href="fundingList?pageNum=${pageMaker.startPage-1 }&type=${param.type}&keyword=${param.keyword}">&laquo;</a>
						</li>
						<c:forEach var="num" begin="${pageMaker.startPage }"
							end="${pageMaker.endPage}">
							<li
								class='${pageMaker.cri.pageNum == num ? "active" : "page-item"}'>
								<a class="page-link"
								href="fundingList?pageNum=${num}&type=${param.type}&keyword=${param.keyword}">[${num}]</a>
							</li>
						</c:forEach>
						<li
							class='${pageMaker.next == true ? "page-item" : "page-item disabled" }'>
							<a class="page-link"
							href="noticeList?pageNum=${pageMaker.endPage+1 }&type=${param.type}&keyword=${param.keyword}">&raquo;</a>
						</li>
					</ul>
				</div>
                        <!-- /. Pagination -->
                         <div style="float: right; position:relative; bottom: 100px; " >
                 	<a ><button id="regBtn" type="button" class="btn btn-primary text-right" >펀딩등록</button></a>
                 </div>
				
			</div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-6 -->
        </div>
        <!-- /.row -->
        
		 <form action="/funding/fundinglist" method="get" id="actionform">
	    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	    <input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}'/>">
	    <input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"> 
		</form>
</div>


	<%@include file="../layout/bottom.jsp"%>