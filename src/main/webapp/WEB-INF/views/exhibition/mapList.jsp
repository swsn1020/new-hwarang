<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/left.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화랑 - 공연전시 지도</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
	$(function() {
		var xList = <c:out value="${xList}"/>;
		var yList = <c:out value="${yList}"/>;
	  	var sList = <c:out value="${sList}"/>;
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng(yList[0], xList[0]),
				level: 3
		//지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();
		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		function mapMarker(i,seq){					
			getExh(seq, function(exh){
				var y = exh.exh_gpsy;
				var x = exh.exh_gpsx;
				var favi= 'star fas';
				var favm= '#fav-RemoveModal';
				if(exh.favorite_status == 0){
					favi = 'far';
					favm = '#fav-AddModal';
				}
				
				var position = new kakao.maps.LatLng(y, x);
	            var marker = new daum.maps.Marker({
	                map : map,
	                position : position
	            });
	    		var iwContent = '<div style="padding:5px;"><div><p><a href="/exhibition/view?seq='+seq+'">'+exh.exh_title+'</a> <i id="favStatus${e.exh_seq}"class="'+favi+' fa-star" data-toggle="modal" data-target="'+favm+'"></i></p><div><table class="table"><tbody><tr><td>길찾기</td><td><a href="https://map.kakao.com/link/to/'+exh.exh_place+','+y+','+x+'" target="_blank"><i class="fas fa-map-marked-alt"></i></a></td></tr><tr><td>주소</td><td><a href="'+exh.exh_placeurl+'">'+exh.exh_place+'</a></td></tr><tr><td>전화번호</td><td>'+exh.exh_phone+'</td></tr></tbody></table></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
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
			});

		};
		
		var size = ${fn:length(xList)};
		for(var i=0; i<size; i++){
			mapMarker(i,sList[i]);
		};
	});
	function getExh(seq, callback, error) {
		$.getJSON("/exhibition/"+seq+".json", function(data) {
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	
	function addFavorite(seq) {
		var id = 'id';
		var groupValue = $("#favGroup"+seq).val();
		var fav = {
			exh_seq	: seq,
			member_id : id,
			favorite_group : groupValue
		};
		
		favService.add(fav, function(result) {
			if(result){
				alert("관심 등록 완료 되었습니다.");
				$("#favStatus"+seq).attr("class","star fas fa-star");
				+$("#favStatus"+seq).attr("data-target","#fav-RemoveModal"+seq);
				$(".close").click();
			}else{
				alert("관심 등록이 실패 되었습니다.");	
			}
			return false;
		})
	};
	
	function removeFavorite(seq) {
		var id = 'id';
		var fav = {
			exh_seq	: seq,
			member_id : id,
		};

		favService.remove(fav, function(result) {
			if(result){
				alert("관심 삭제가 완료 되었습니다.");
				$("#favStatus"+seq).attr("class","far fa-star");
				$("#favStatus"+seq).attr("data-target","#fav-AddModal"+seq);
				$(".close").click();
			}else{
				alert("관심 삭제가 실패 되었습니다.");	
			}
			return false;
		})
	};
	
	function addFavGroup() {
		var basicGroup = $("#basic-group");
		var addGroupVal = $("#addFavGroup").val();
		basicGroup.attr("value",addGroupVal);
		basicGroup.text("새로운 그룹 - "+addGroupVal);
		alert(addGroupVal+" 이 입력 되었습니다.");
	};
</script>
</head>
<body>
	<div class="container">
		<form action="#">
			<select name="area">
				<option value="" <c:out value="${param.area == null ?'selected':''}"/>>서울</option>
				<c:forEach items="${area}" var="a">
					<option value="${a}" <c:out value="${param.area  eq a ?'selected':''}"/>>${a}</option>			
				</c:forEach>
			</select>
			<button type="submit" class="btn btn-primary">검색</button>
		</form>
		<div id="map" style="width: 1200px; height: 650px;"></div>
			<!-- 관심추가  Modal -->
			<div class="modal" id="fav-AddModal">
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
								<input id="addFavGroup" type="text"
									placeholder="새로운 그룹 이름  추가"> <a
									class="btn btn-secondary" onclick="addFavGroup()">그룹추가</a>
							</div>
							<select name="group" id="favGroup">
								<option selected value="찜 목록" id="basic-group">기본
									- 찜 목록</option>
								<c:forEach items="${group}" var="g">
									<option value="${g}">${g}</option>
								</c:forEach>
							</select>
							<p class="info">
								<strong>${e.exh_title}</strong> (가)이 추가됩니다. <br />추가하시겠습니까?
							</p>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<a onclick="addFavorite()"><img
								src="http://img.echosting.cafe24.com/skin/base_ko_KR/link/btn_add.gif"
								alt="추가하기"></a> <a data-dismiss="modal"><img
								src="http://img.echosting.cafe24.com/skin/base_ko_KR/link/btn_cancel.gif"
								alt="취소하기"></a>
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
						<div class="content">
							<p class="info">
								<strong>${e.exh_title}</strong> (가)이 삭제됩니다. <br />정말로 삭제 하시겠습니까?
							</p>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<a class="btn btn-primary" onclick="removeFavorite()">삭제하기</a>
							<a data-dismiss="modal"><img
								src="http://img.echosting.cafe24.com/skin/base_ko_KR/link/btn_cancel.gif"
								alt="취소하기"></a>
						</div>
					</div>
				</div>
			</div>
	</div>
<%@include file="../layout/bottom.jsp"%>
</body>
</html>