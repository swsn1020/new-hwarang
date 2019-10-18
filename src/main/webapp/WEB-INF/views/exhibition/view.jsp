<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript" src="/resources/js/mention.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/movie.all.css">
<%@ include file="../layout/menu.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>화랑 - 공연전시 - ${exh.exh_title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
#popup { width:450px; }
/* .header h1 { height:45px; padding:0 0 0 20px; color:#fff; font-size:14px; line-height:45px; background-color:#495164; } */
.content { padding:20px; min-height:250px; }
.btnArea { position:fixed; bottom:0; left:0; width:100%; padding:10px 0; border-top:1px solid #d7d5d5; text-align:center; background-color:#fbfafa; }
.xans-link-bookmark .info { padding:153px 0 20px 0; text-align:center; font-size:12px; line-height:1.8em; background:url("http://img.echosting.cafe24.com/skin/base_ko_KR/link/bg_bookmark.gif") center 33px no-repeat; }
</style>
<!-- <script type="text/javascript"src=" //dapi.kakao.com/v2/maps/sdk.js?appkey=f2ce3ae8264eed849df9ea6f9ad313b9&libraries=services,clusterer,drawing"></script> -->
<!-- <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> -->
<script type="text/javascript">
	$(function() {
		//추천,비추천
		$('.like').click(function(e) {
			e.preventDefault();
			if("${exh.exh_like_status}"==0){
				alert("등록요청");
				location.replace('/exhibition/like/add?seq=${exh.exh_seq}'); 
			}
			if("${exh.exh_like_status}"==1){
				alert("추천 삭제");
				location.replace('/exhibition/like/modify?seq=${exh.exh_seq}&status=3'); 
			}
			if("${exh.exh_like_status}"==2){
				alert("이미 비추천을 누르셨습니다.");
				return false;
			}
			if("${exh.exh_like_status}"==3){
				alert("등록요청");
				location.replace('/exhibition/like/modify?seq=${exh.exh_seq}&status=1'); 
			}
		});
		
		$('.unlike').click(function(e) {
			e.preventDefault();
			if("${exh.exh_like_status}"==0){
				alert("등록요청");
				location.replace('/exhibition/unlike/add?seq=${exh.exh_seq}'); 
			}
			if("${exh.exh_like_status}"==1){
				alert("이미 추천을 누르셨습니다.");
				return false;
			}
			if("${exh.exh_like_status}"==2){
				alert("비추천 삭제");
				location.replace('/exhibition/unlike/modify?seq=${exh.exh_seq}&status=3'); 
			}
			if("${exh.exh_like_status}"==3){
				alert("등록요청");
				location.replace('/exhibition/unlike/modify?seq=${exh.exh_seq}&status=2'); 
			}
			
		});

		//지도
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng(${exh.exh_gpsy}, ${exh.exh_gpsx}),
				level: 3
		//지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		var markerPosition  = new kakao.maps.LatLng(${exh.exh_gpsy}, ${exh.exh_gpsx}); 
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition,
		    clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
		});
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);	
		var title = "${exh.exh_title}".replace(/'/gi,'"');
		var iwContent = '<div style="padding:5px; width: 105%;"><div>'+title+'<div><table class="table"><tbody><tr><td>홈페이지</td><td><a href="${exh.exh_url}"><i class="fas fa-home"></i></a></td></tr><tr><td>주소</td><td><a href="${exh.exh_placeurl}">${exh.exh_place}</a></td></tr><tr><td>전화번호</td><td>${exh.exh_phone}</td></tr></tbody></table></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    content : iwContent,
		    removable : iwRemoveable
		});
	
		// 마커에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'click', function() {
		      // 마커 위에 인포윈도우를 표시합니다
		      infowindow.open(map, marker);  
		});
		
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();
		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		//=======댓글 부분=======
		var seqValue = '<c:out value="${param.seq}"/>';
		var replyUL = $("#chat");
		var replyForm = $("#replyForm");
		var replyer = $('#replyer');
		showList(1);

		$("#addReply").on("click", function(e) {
			if (!$('#reply_content').val()) {
				alert("댓글내용을 입력해 주세요");
				return false;
			};
			var reply = {
				reply_content : $('#reply_content').val(),
				member_id : replyer.val(),
				exh_seq : seqValue
			};
			e.preventDefault();

			replyService.add(reply, function(result) {	
				if(result){
					alert("댓글 입력이 완료되었습니다.");					
				}else{
					alert("댓글 입력에 실패하였습니다.");	
				}
				replyForm.find("textarea").val("");
				showList(1);
			})
		});	
		
	
		$("#chat").on("click", ".replyDelete", function(e) {
			var reply_num = $(this).closest("li").data("rno");
 			replyService.remove(reply_num, function(result) {
				alert(result);
				showList(1);
			}); 
			e.preventDefault();
		});
		
		$("#chat").on("click", ".replyModifyBtn", function(e) {
			if (!$(this).prev().val()) {
				alert("댓글내용을 입력해 주세요");
				return false;
			};
			var reply_num = $(this).closest("li").data("rno");
			var reply ={reply_num : reply_num, reply_content : $(this).prev().val()};
			replyService.update(reply, function(result) {
				alert(result);
				showList(1);
			})
			e.preventDefault();
		});
		
		function showList(page) {
			replyService.getList({seq : seqValue, page: page||1},function(list) {
				var str = "";
				if (list == null || list.length == 0) {
					replyUL.html("<li class='list-group-item'><div class='col-sm-10'>댓글없음</div></li>");
					return;
				}
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='list-group-item' data-rno='"+list[i].reply_num+"'><div class='col-sm-10'><strong style='color : #337ab7;'><i class='fas fa-user'>&nbsp&nbsp"+list[i].member_id+"</i></strong></div><div col-sm-2  style='text-align: center;'>"+ replyService.displayTime(list[i].reply_reg_date);
					
					if("${pinfo.username}"==list[i].member_id){
						str += "&nbsp&nbsp<a data-toggle='collapse' data-target='#modifyCol"+i+"'><i class='fas fa-tools replyModify'>&nbsp&nbsp</i></a><a href='#'><i class='fas fa-trash-alt replyDelete'></i></a>";	
					}
					str += "</div><div col-sm-10><p class='text-uppercase'>&nbsp&nbsp댓글내용 : "+ list[i].reply_content +"</p></div> <div id='modifyCol"+i+"' class='collapse'><textarea rows='4' cols='108' id='replyMod' name='replyMod' placeholder='수정할 댓글을 입력해주세요''></textarea><button type='button' class='btn btn-primary replyModifyBtn'>Reply Modify</button></div></li>";					
				}
				replyUL.html(str);
			});
		}
		
		//구매평 부분
		var mentionUL = $("#mention");
		var mentionForm = $("#mentionForm");
		showMentionList(1);
		//구매평 추가로직
		$("#addMention").on("click", function(e) {

// 			mentionService.getMentionStatus(seqValue,function(status) {
// 				alert(status);
// 			})		
			if (!$('#mention_content').val()) {
				alert("구매평 내용을 입력해 주세요");
				return false;
			};

			var mention = {
				mention_content : $('#mention_content').val(),
				mention_score : $('#mention_score').val(),
				member_id : replyer.val(),
				exh_seq : seqValue
			};
			e.preventDefault();

			mentionService.add(mention, function(result) {	
				if(result){	
					alert("구매평 입력이 완료되었습니다.");					
				}else{
					alert("구매평 입력에 실패하였습니다.");	
				}
				mentionForm.find("textarea").val("");
				showMentionList(1);
			})
		});	
		
		//구매평 삭제로직
		$("#mention").on("click", ".mentionDelete", function(e) {
			var mention_no = $(this).closest("li").data("mno");
			mentionService.remove(mention_no, function(result) {
				alert(result);
				showMentionList(1);
			}); 
			e.preventDefault();
		});
		//구매평 수정로직
		$("#mention").on("click", ".mentionModifyBtn", function(e) {
			if (!$(this).prev().val()) {
				alert("수정할 내용을 입력해 주세요");
				return false;
			};
			var mention_no = $(this).closest("li").data("mno");
			var mention ={mention_no : mention_no, mention_content : $(this).prev().val()};
			mentionService.update(mention, function(result) {
				alert(result);
				showMentionList(1);
			})
			e.preventDefault();
		});
		//구매평 리스트불러오기
		function showMentionList(page) {
			mentionService.getList({seq : seqValue, page: page||1},function(mentionCnt,list) {
				var str = "";
				if (list == null || list.length == 0) {
					mentionUL.html("<li class='list-group-item'>구매평없음</li>");
					return;
				}
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='list-group-item' data-mno='"+list[i].mention_no+"'><div class='star_score'><span class='st_off'><span class='st_on' style='width:"+list[i].mention_score*10+"%'></span></span><em>"+list[i].mention_score+"</em></div>";
					str += "<div class='score_reple'><p><span>"+list[i].mention_content+"</span></p></div>";
					str += "<dl><dt><em>"+list[i].member_id+"</em>&nbsp|&nbsp<em>"+replyService.displayTime(list[i].mention_regdate)+"</em>";					
					if("${pinfo.username}"==list[i].member_id){
						str += "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<em><a data-toggle='collapse' data-target='#mentionModi"+i+"'>수정하기</a></em>&nbsp&nbsp<em><a href='#' class='mentionDelete'>삭제하기</a></em>";	
						str += "<div id='mentionModi"+i+"' class='collapse'><textarea rows='4' cols='108' id='mentionMod' name='mentionMod' placeholder='수정할 구매평을 입력해주세요. 평점은 수정되지 않습니다.'></textarea><button type='button' class='btn btn-primary mentionModifyBtn'>구매평 수정</button></div>";					
					}
					str += "</dt></dl></li>";
				}
				mentionUL.html(str);
				showMentionPage(mentionCnt);
			});
		}		
		//구매평 페이징 처리
	    var pageNum = 1;
	    var mentionPageFooter = $(".mention-footer");
	    
	    function showMentionPage(mentionCnt){
	      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= mentionCnt){
	        endNum = Math.ceil(mentionCnt/10.0);
	      }
	      
	      if(endNum * 10 < mentionCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	       
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
	        var active = pageNum == i? "active":"";
	        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul></div>";
	      console.log(str);
	      mentionPageFooter.html(str);
	    }
	    mentionPageFooter.on("click","li a", function(e){
	        e.preventDefault();
	        console.log("page click");        
	        var targetPageNum = $(this).attr("href");
	        console.log("targetPageNum: " + targetPageNum);    
	        pageNum = targetPageNum;	        
	        showMentionList(pageNum);
	      });   
		
	});
//관심추가로직
function addFavorite() {
	var seqValue = '<c:out value="${param.seq}"/>';
	var replyer = $('#replyer');
	var groupValue = $("#favGroup").val();
	var fav = {
		exh_seq	: seqValue,
		member_id : replyer.val(),
		favorite_group : groupValue
	};
	
	favService.add(fav, function(result) {
		if(result){
			alert("관심 등록 완료 되었습니다.");
			$("#favStatus").text("관심목록 삭제");
			$("#favStatus").attr("data-target","#fav-RemoveModal");
			$(".close").click();
		}else{
			alert("관심 등록이 실패 되었습니다.");	
		}
	})
};
//관심삭제로직
function removeFavorite() {
	var seqValue = '<c:out value="${param.seq}"/>';
	var replyer = $('#replyer');
	var fav = {
		exh_seq	: seqValue,
		member_id : replyer.val()
	};

	favService.remove(fav, function(result) {
		if(result){
			alert("관심 삭제가 완료 되었습니다.");
			$("#favStatus").text("관심목록 추가");
			$("#favStatus").attr("data-target","#favModal");
			$(".close").click();
		}else{
			alert("관심 삭제가 실패 되었습니다.");	
		}
		return false;
	})
};

//관심그룹추가로직
function addFavGroup(seq) {
	var basicGroup = $("#basic-group");
	var addGroupVal = $("#addFavGroup").val();
	basicGroup.attr("value",addGroupVal);
	basicGroup.text("새로운 그룹 - "+addGroupVal);
	alert(addGroupVal+" 이 입력 되었습니다.");
};
</script>
<style type="text/css">
.exh-title{
	margin: 20px;
	text-align: center;
}
.exh-div{
	margin-top: 30px;
}
.exh-img{
	border-top: 2px solid black;
	text-align: center;
}
.exh-img2{
	margin-top: 20px;
}
.exh-table{
	margin-top: 30px;
}
.exh-tabs{
	border-top: 2px solid black;
	margin: 20px 0 30px 0;
}
.exh-tab{
	margin-top: 20px;
}
.exh-reply{
	border-top: 2px solid black;
}
</style>
</head>
<div class="table-responsive">
	<div class="container" >
		<div class="exh-title">
			<h3 style="font-weight: bold;">${exh.exh_title}
				<span class="badge badge-primary">${exh.exh_realmName}</span>
			</h3>	
		</div>
		<div class="exh-div">
			<div class="exh-img">
				<img class="exh-img2 card-img-top" style="width: 400px; height: 500px;" alt="item image" role="img" src="${exh.exh_imgurl}"> 
			</div>
			<br>
			<div style="text-align: center;">
				<a class="btn btn-outline-dark like" style="color: blue; ${exh.exh_like_status eq 1 ?'background-color: gray;':''}">&nbsp;추천(${exh.exh_like})&nbsp;</a>
				<a class="btn btn-outline-dark unlike" style="color: black; ${exh.exh_like_status eq 2 ?'background-color: gray;':''}">비추천(${exh.exh_unlike})</a>
			</div>
			<table class="exh-table table table-hover">
				<tbody>
					<tr>
						<th>공연기간</th>
						<td>${fn:substring(exh.exh_startDate, 0, 10)} ~ ${fn:substring(exh.exh_endDate, 0, 10)}</td>
					</tr>
					<tr>
						<th>공연장소</th>
						<td>${exh.exh_area}|<a href="${exh.exh_placeurl}" target="_blank">${exh.exh_place}</a></td>
					</tr>
					<tr>
						<th>가격정보</th>
						<td>${exh.exh_price}</td>
					</tr>
					<tr>
						<th>상세주소</th>
						<td><a href="${exh.exh_placeurl}" target="_blank">${exh.exh_placeaddr}</a></td>
					</tr>
					<tr>
						<th>사이트주소</th>
						<td><a href="${exh.exh_url}" target="_blank">${exh.exh_url}</a></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${exh.exh_phone}</td>
					</tr>
	
				</tbody>
			</table>
			<a class="btn btn-outline-dark" id="favStatus" data-toggle="modal" data-target=${exh.favorite_status==0 ? '"#favModal"' : '"#fav-RemoveModal"'}> ${exh.favorite_status==0 ?'관심목록 추가' : '관심목록 삭제'}</a>
			
			<a class="btn btn-outline-dark" data-toggle="modal" data-target="#buyModal" onclick="">공연 예매</a>
		</div>
		<!-- 관심추가  Modal -->
		<div class="modal" id="favModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<p class="modal-title">관심목록 추가</p>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					
					<div class="content">
						<div>
							<input id="addFavGroup" type="text" placeholder="새로운 그룹 이름  추가">
							<a class="btn btn-outline-dark" onclick="addFavGroup()">그룹추가</a>
						</div>
						<select name="group" id="favGroup">
							<option selected value="찜 목록" id="basic-group">기본 - 찜 목록</option>
								<c:forEach items="${group}" var="g">
								<option value="${g}">${g}</option>			
								</c:forEach>
						</select>
				        <p class="info"> <strong>${exh.exh_title}</strong> (가)이 추가됩니다. <br />추가하시겠습니까?</p>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<a onclick="addFavorite()" class="btn btn-outline-dark">추가하기</a>
	            		<a data-dismiss="modal" id="modal-close" class="btn btn-outline-dark">취소하기</a>
					</div>

				</div>
			</div>
		</div>
		<!-- 관심삭제  Modal -->
		<div class="modal" id="fav-RemoveModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<p class="modal-title">관심목록 삭제</p>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="content" >
						<p class="info" style="margin: 10px;">
							<strong>${exh.exh_title}</strong> (가)이 삭제됩니다. 
							<br />정말로 삭제 하시겠습니까?
						</p>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<a class="btn btn-outline-dark" onclick="removeFavorite()">삭제하기</a>
						<a data-dismiss="modal" class="btn btn-outline-dark">취소하기</a>
					</div>
				</div>
			</div>
		</div>
		<!-- 장바구니추가  Modal -->
		<div class="modal" id="buyModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<p class="modal-title">구매하기</p>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					
					<div class="content">
				        <p class="info"> <strong>${exh.exh_title}</strong> (가)이 장바구니에 담겼습니다.</p>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<a class="btn btn-outline-dark">장바구니 이동</a>
	            		<a class="btn btn-outline-dark" data-dismiss="modal" id ="modal-close">쇼핑 계속하기</a>
					</div>

				</div>
			</div>
		</div>
		<!--  탭 구현 부분 -->
		<div class="exh-tabs container">
			<ul class="exh-tab nav nav-tabs" role="tablist">
			    <li class="nav-item">
			      <a class="nav-link active" data-toggle="tab" href="#home">지도</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" data-toggle="tab" href="#menu1">리뷰</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" data-toggle="tab" href="#menu2">구매자 한줄평</a>
			    </li>
			</ul>
		
		  <!-- Tab panes -->
		  <div class="tab-content">
		    <div id="home" class="container tab-pane active"><br>
					<h3>지도</h3>
					<div id="map" style="width: 100%; height: 450px;"></div>
		    </div>
		    <div id="menu1" class="container tab-pane fade"><br>
		      <h3>블로그 리뷰</h3>
		      <div>
		      	<table class="table">
					<c:forEach items="${blogReview}" var="blog">
					<tr>
						<td><h5 style="font-weight: bold;"><a href="${blog.link}" >${blog.title}</a></h5>
						${blog.description}				
						</td>
					</tr>
					</c:forEach>
				</table>
		      </div>
		    </div>
		    <div id="menu2" class="container tab-pane fade"><br>
		      <!-- 한줄평 구현 부분 -->
		      <h3>구매평</h3>
		      <a href="#mentionEnter" class="btn btn-outline-dark" data-toggle="collapse">내 구매평 등록</a>
				 <div id="mentionEnter" class="collapse">
					<form action="#" id="mentionForm" method="get">
						<select id="mention_score" name="mention_score">
							<option selected value="0">0점</option>
							<option value="1">1점</option>
							<option value="2">2점</option>
							<option value="3">3점</option>
							<option value="4">4점</option>
							<option value="5">5점</option>
							<option value="6">6점</option>
							<option value="7">7점</option>
							<option value="8">8점</option>
							<option value="9">9점</option>
							<option value="10">10점</option>
						</select>
						<textarea class="form-control" rows="5" id="mention_content" name="mention_content" placeholder="자신의 관람후기를 자유롭게 써주세요."></textarea>
						<button type="submit" id="addMention" class="btn btn-outline-dark">입력</button>
					</form>
				 </div>				 
			  <ul class="list-group list-group-flush col-sm-10" id="mention"></ul>	 
			  <div class="mention-footer">d</div>     
		    </div>
		  </div>
		</div>
		<!-- 댓글 구현 부분 -->
		<div class="exh-reply container">
			<form action="#" id="replyForm" method="get">
				<input type="hidden" id="replyer" name="member_id" value="<sec:authentication property="principal.Username"/>">
					 <input type="hidden"
					class="alert alert-secondary" id="seq" name="exh_seq" value="${exh.exh_seq}">
				<div class="form-group">
					<label for="comment"></label>
					<textarea class="form-control" rows="5" id="reply_content" name="reply_content" placeholder="훈훈해지는 댓글 부탁드립니다."></textarea>
				</div>
				<button type="submit" id="addReply" class="btn btn-outline-dark">입력</button>
			</form>
			<div class="panel-heading">
				<!-- <i class="fa fa-comments fa-fw" style='color: #337ab7;'></i> Reply
				List -->
			</div>
			<ul class="list-group list-group-flush col-sm-10" id="chat"></ul>
		</div>


	</div>
</div>
<%@include file="../layout/bottom.jsp"%>
</body>
</html>
