<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layout/left.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>화랑 - 공연전시 - ${exh.exh_title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
#popup { width:450px; }
.header h1 { height:45px; padding:0 0 0 20px; color:#fff; font-size:14px; line-height:45px; background-color:#495164; }
.content { padding:20px; min-height:250px; }
.btnArea { position:fixed; bottom:0; left:0; width:100%; padding:10px 0; border-top:1px solid #d7d5d5; text-align:center; background-color:#fbfafa; }
.xans-link-bookmark .info { padding:153px 0 20px 0; text-align:center; font-size:12px; line-height:1.8em; background:url("http://img.echosting.cafe24.com/skin/base_ko_KR/link/bg_bookmark.gif") center 33px no-repeat; }
</style>
<!-- <script type="text/javascript"src=" //dapi.kakao.com/v2/maps/sdk.js?appkey=f2ce3ae8264eed849df9ea6f9ad313b9&libraries=services,clusterer,drawing"></script> -->
<!-- <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> -->
<script type="text/javascript">
	$(function() {
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
		
		var iwContent = '<div style="padding:5px;"><div>${exh.exh_title}<div><table class="table"><tbody><tr><td>홈페이지</td><td><a href="${exh.exh_url}"><i class="fas fa-home"></i></a></td></tr><tr><td>주소</td><td><a href="${exh.exh_placeurl}">${exh.exh_place}</a></td></tr><tr><td>전화번호</td><td>${exh.exh_phone}</td></tr></tbody></table></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
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
						replyUL.html("");
						return;
					}
					for (var i = 0, len = list.length || 0; i < len; i++) {
						str += "<li class='list-group-item' data-rno='"+list[i].reply_num+"'><div class='col-sm-10'><strong style='color : #337ab7;'><i class='fas fa-user'>&nbsp&nbsp"+list[i].replyer+"..${pinfo.username}</i></strong></div>";
						str += "<div col-sm-2  style='text-align: center;'>"+ replyService.displayTime(list[i].reply_reg_date)+"&nbsp&nbsp<a data-toggle='collapse' data-target='#modifyCol"+i+"'><i class='fas fa-tools replyModify'>&nbsp&nbsp</i></a><a href='#'><i class='fas fa-trash-alt replyDelete'></i></a></div>";
						str += "<div col-sm-2></div><div col-sm-10><p class='text-uppercase'>&nbsp&nbsp"+ list[i].reply_content +"</p></div> <div id='modifyCol"+i+"' class='collapse'><textarea rows='4' cols='108' id='replyMod' name='replyMod' placeholder='수정할 댓글을 입력해주세요''></textarea><button type='button' class='btn btn-primary replyModifyBtn'>Reply Modify</button></div></li>";					
					}
					replyUL.html(str);
				});
			}
			
	});
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
				$("#modal-close").click();
			}else{
				alert("관심 등록이 실패 되었습니다.");	
			}
		})
	};

	function addFavGroup(seq) {
		var basicGroup = $("#basic-group");
		var addGroupVal = $("#addFavGroup").val();
		basicGroup.attr("value",addGroupVal);
		basicGroup.text("새로운 그룹 - "+addGroupVal);
		alert(addGroupVal+" 이 입력 되었습니다.");
	};
</script>

<div class="table-responsive">
	<div class="container">
		<h3>${exh.exh_title}
			<span class="badge badge-primary">${exh.exh_realmName}</span>
		</h3>
		<img class="card-img-top" style="width: 20%; height: 280px;"
			alt="item image" role="img" src="${exh.exh_imgurl}"> 
			<a class="btn btn-primary" data-toggle="modal" data-target="#favModal">관심목록 추가</a> 
			<a class="btn btn-primary" data-toggle="modal" data-target="#buyModal" onclick="">공연 예매</a>
		<table class="table table-hover">
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
							<a class="btn btn-secondary" onclick="addFavGroup()">그룹추가</a>
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
						<a onclick="addFavorite()"><img src="http://img.echosting.cafe24.com/skin/base_ko_KR/link/btn_add.gif" alt="추가하기"></a>
	            		<a data-dismiss="modal" id ="modal-close"><img src="http://img.echosting.cafe24.com/skin/base_ko_KR/link/btn_cancel.gif" alt="취소하기"></a>
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
						<a class="btn btn-primary">장바구니 이동</a>
	            		<a class="btn btn-primary" data-dismiss="modal" id ="modal-close">쇼핑 계속하기</a>
					</div>

				</div>
			</div>
		</div>
		<!--  탭 구현 부분 -->
		<div class="container">
			<ul class="nav nav-tabs" role="tablist">
			    <li class="nav-item">
			      <a class="nav-link active" data-toggle="tab" href="#home">지도</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" data-toggle="tab" href="#menu1">리뷰</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" data-toggle="tab" href="#menu2">Menu 2</a>
			    </li>
			</ul>
		
		  <!-- Tab panes -->
		  <div class="tab-content">
		    <div id="home" class="container tab-pane active"><br>
					<h3>지도</h3>
					<div id="map" style="width: 100%; height: 450px;"></div>
		    </div>
		    <div id="menu1" class="container tab-pane fade"><br>
		      <h3>Menu 1</h3>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		    </div>
		    <div id="menu2" class="container tab-pane fade"><br>
		      <h3>Menu 2</h3>
		      <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
		    </div>
		  </div>
		</div>
		<!-- 댓글 구현 부분 -->
		<div class="container">
			<form action="#" id="replyForm" method="get">
				<input type="hidden" class="alert alert-secondary" id="replyer"
					name="member_id" value="id"> <input type="hidden"
					class="alert alert-secondary" id="seq" name="exh_seq"
					value="${exh.exh_seq}">
				<div class="form-group">
					<label for="comment">Comment:</label>
					<textarea class="form-control" rows="5" id="reply_content"
						name="reply_content" placeholder="게시판이 더 훈훈해지는 댓글 부탁드립니다."></textarea>
				</div>
				<button type="submit" id="addReply" class="btn btn-primary">입력</button>
			</form>
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw" style='color: #337ab7;'></i> Reply
				List
			</div>
			<ul class="list-group list-group-flush col-sm-10" id="chat"></ul>
		</div>


	</div>
</div>
<%@include file="../layout/bottom.jsp"%>
</body>
</html>