<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layout/left.jsp"%>
<%@ include file="../layout/rightUser.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">펀딩 수정창 </h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                크라우드펀딩 수정페이지
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <form action="/funding/modify" method="post" role="form">
                    <div class="form-group">
                        <label>펀딩번호</label>
                        <input class="form-control" name="funding_num" value="<c:out value='${funding.funding_num}' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>조회수</label>
                        <input class="form-control" name="funding_hit" value="<c:out value='${funding.funding_hit}' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input class="form-control" name="funding_subject" value="<c:out value='${funding.funding_subject}' />">
                    </div>
                    <div class="form-group">
                        <label>작성자</label>
                        <input class="form-control" name="funding_writer" value="<c:out value='${funding.funding_writer}' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>가격</label>
                        <input class="form-control" name="funding_price" value="<c:out value='${funding.funding_price}' />">
                    </div>
                    <div class="form-group">
                        <label>펀딩 시작일</label>
                        <input class="form-control" name="funding_created_date" value="<fmt:formatDate value='${funding.funding_created_date}' pattern="yyyy/MM/dd" />" readonly>
                    </div>
                    <div class="form-group">
                        <label>펀딩 종료일</label>
                        <input class="form-control" name="funding_target_date" value="<fmt:formatDate value='${funding.funding_target_date}' pattern="yyyy/MM/dd" />" readonly>
                    </div>
                    <div class="form-group">
                        <label>목표가격</label>
                        <input class="form-control" name="funding_target_amount" value="<c:out value='${funding.funding_target_amount }' />">
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="3" name="funding_content"><c:out value='${funding.funding_content}' /></textarea>
                    </div>
                    <div class="form-group">
                        <label>펀딩 현재달성액</label>
                        <input class="form-control" name="funding_target_amount" value="<c:out value='${funding.funding_target_amount }' />" readonly="readonly">
                    </div>
                    <button data-oper="modify" class="btn btn-default" type="submit">수정</button>
                    <button data-oper="remove" class="btn btn-danger" type="submit">삭제</button>
                    <button data-oper="list" class="btn btn-info" type="submit">목록</button>

                    <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                    <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                    <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
                    <input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var formObj = $("form");
        $('button').on("click", function (e) {
            e.preventDefault();
            var operation = $(this).data("oper");
            console.log(operation);
            if(operation === 'remove') {
                formObj.attr("action", "/funding/remove");
            }else if(operation === 'list') {
                formObj.attr("action", "/funding/list").attr("method", "get");
                var pageNumTag = $("input[name='pageNum']").clone();
                var amountTag = $("input[name='amount']").clone();
                var keywordTag = $("input[name='keyword']").clone();
                var typeTag = $("input[name='type']").clone();
                formObj.empty();
                formObj.append(pageNumTag);
                formObj.append(amountTag);
                formObj.append(keywordTag);
                formObj.append(typeTag);
            }
            formObj.submit();
        });
    });
</script>
<%@include file="../layout/bottom.jsp"%>