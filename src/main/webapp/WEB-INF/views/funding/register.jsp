<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../layout/left.jsp"%>

<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
    <script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
    <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
    <script src="/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
 <script type='text/javascript'>
    $(function(){
        $('.input-group.date').datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy/mm/dd",
            language: "kr"
        });
    });
 </script>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">펀딩등록</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
        
            <div class="panel-heading">Crowdfunding Register</div>
            <!-- /.panel-heading -->
            <div class="panel-body">
            
                <form action="/funding/register" method="post" role="form">
                    <div class="form-group">
                        <label>제목</label> <input type="text" class="form-control" name="funding_subject">
                    </div>
                    <div class="form-group">
                        <label>작성자</label>
                        <input type="text" class="form-control" name="funding_writer">
                    </div>
                    
					<div class="form-group">
                        <label>펀딩가격</label>
                        <input type="text" class="form-control" name="funding_price">
                    </div>
                    
                    <div class="form-group">
			        <label>펀딩 시작일</label>
			        <div class="input-group date">
			            <input type="text" class="form-control" name="funding_created_date">
			            <span class="input-group-addon">
			            <i class="glyphicon glyphicon-calendar"></i></span>
			        </div>
			        </div>
			        
			        <div class="form-group">
					 <label>펀딩 종료일 </label>
			        <div class="input-group date">
			            <input type="text" class="form-control" name="funding_target_date">
			            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
			        </div>
			        </div>
			    	          
                    <div class="form-group">
                        <label>펀딩목표액</label>
                        <input type="text" class="form-control" name="funding_target_amount">
                    </div>     
                    
                    <div class="form-group">
                        <label>내용</label>
                        <textarea name="funding_content" rows="3" class="form-control"></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-default">Submit Button</button>
                    <button type="reset" class="btn btn-default">Reset Button</button>
                </form>
            </div>
            <!-- end panel-body -->
            
        </div>
        <!-- end panel-body -->
    </div>
    <!-- end panel -->
</div>
<!-- /.row -->

  

<%@include file="../layout/bottom.jsp"%>