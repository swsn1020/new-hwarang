<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../layout/menu.jsp"%>
<%@include file="../layout/rightUser.jsp"%>
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
    
    ajaxForm : function (id, func){
        $('#'+id).ajaxForm({
            contentType : false,
            processData: false,
            enctype: "multipart/form-data",
            dataType : "POST",
            dataType : 'json',
            beforeSubmit: function(data, form, option) {
                console.log('beforeSubmit');
                console.log(data);
                console.log(form);
                console.log(option);
            },
            success: function(returnData) {
                func(returnData);
            },
            error: function(x,e){
                console.log("[aljjabaegi]ajax status : "+x.status);
                console.log(e);
            },
        });
    },


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
                        <label>펀딩 이미지</label>
                        <input type="text" class="form-control" name="funding_image">
                    </div>    
                    
                    <div class="form-group">
                        <label>내용</label>
                        <textarea name="funding_content" rows="3" class="form-control"></textarea>
                    </div>
                     <div class="form-group">
                        <label>홍보영상주소(url)</label>
                        <input type="text" class="form-control" name="funding_video">
                    </div>   
                    <div class="form-group">
                        <label>해시태그 (#)</label>
                        <input type="text" class="form-control" name="funding_hashtag">
                    </div> 
                     <div class="form-group">
                        <label>새소식</label>
                        <input type="text" class="form-control" name="funding_news">
                    </div> 
                     <div class="form-group">
                        <label>메이커 이름</label>
                        <input type="text" class="form-control" name="maker_name">
                    </div> 
                     <div class="form-group">
                        <label>메이커 로고</label>
                        <input type="text" class="form-control" name="maker_logo">
                    </div> 
                     <div class="form-group">
                        <label>메이커 홈페이지</label>
                        <input type="text" class="form-control" name="maker_homepage">
                    </div> 
                     <div class="form-group">
                        <label>메이커 페이스북</label>
                        <input type="text" class="form-control" name="maker_facebook">
                    </div> 
                    <div class="form-group">
                        <label>메이커 인스타</label>
                        <input type="text" class="form-control" name="maker_insta">
                    </div> 
                     <div class="form-group">
                        <label>리워드 제목</label>
                        <input type="text" class="form-control" name="reward_title">
                    </div> 
                     <div class="form-group">
                        <label>리워드 부제목</label>
                        <input type="text" class="form-control" name="reward_title2">
                    </div> 
                     <div class="form-group">
                        <label>리워드 배송비</label>
                        <input type="text" class="form-control" name="reward_shippingCost">
                    </div> 
                     <div class="form-group">
                        <label>리워드 발송시작일</label>
                        <input type="text" class="form-control" name="reward_startDay">
                    </div> 
                     <div class="form-group">
                        <label>리워드 총 수량</label>
                        <input type="text" class="form-control" name="reward_Total">
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

<!-- 이미지  -->
  
<form id="frm" name="frm" action="${ctx}/content/uploadContent.do" enctype="multipart/form-data" method="post">
    <label for="file">이미지 파일 </label><input multiple="multiple" name="files[]" id="files" type="file" style="width:500px"/>
</form>


<%@include file="../layout/bottom.jsp"%>