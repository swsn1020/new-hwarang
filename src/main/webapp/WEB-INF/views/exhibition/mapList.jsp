<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../layout/menu.jsp"%>
<%@include file="../layout/rightUser.jsp"%>
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
	  	var pList = <c:out value="${pList}"/>;
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

		function mapMarker(i,y,x,p){				
				var position = new kakao.maps.LatLng(y, x);
	            var marker = new daum.maps.Marker({
	                map : map,
	                position : position
	            });
			
				getPlaceInfo(p, function(exh){
		    		var iwContent = '<div style="padding:5px; font-weight: bold;"><p><a href="'+exh.exh_placeurl+'">'+exh.exh_place+'</a></p><div><table class="table"><tbody><tr><td>'+exh.exh_placeaddr+'</td><td><a href="https://map.kakao.com/link/to/'+exh.exh_placeaddr+','+y+','+x+'" target="_blank"><i class="fas fa-map-marked-alt"></i></a></td></tr><tr><td><a class="btn btn-outline-dark" onclick="getList('+p+')">해당 장소의 공연보기</a></td></tr></tbody></table></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
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
		
		var size = ${fn:length(yList)};
		for(var i=0; i<size; i++){
			mapMarker(i,yList[i],xList[i],pList[i]);
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
	function getPlaceInfo(p, callback, error) {
		$.getJSON("/exhibition/getPlaceInfo/"+p+".json", function(data) {
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	function getPlaceList(p, callback, error) {
		$.getJSON("/exhibition/placeList/"+p+".json", function(data) {
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	
	function getList(p){
		getPlaceList(p, function(eList){
			var str = "";
			var exhibition = $("#exhibition");			
			for(var i=0; i<eList.length; i++){
				console.log(eList[i]);
				str += "<tr><td>"+eList[i].exh_title+"</td><td>"+eList[i].exh_startDate.substring(0,10)+" ~ "+eList[i].exh_endDate.substring(0,10)+"</td><td><a class='btn btn-outline-dark' href='/exhibition/view?seq="+eList[i].exh_seq+"'>공연 페이지</a></td></tr>"
			};
			exhibition.html(str);
		});	
	}
	

</script>
</head>
<body>
	<div class="container">
		<form action="#" style="margin: 10px;">
			<select name="area">
				<option value="" <c:out value="${param.area == null ?'selected':''}"/>>--기본--</option>
				<c:forEach items="${area}" var="a">
					<option value="${a}" <c:out value="${param.area  eq a ?'selected':''}"/>>${a}</option>			
				</c:forEach>
			</select>
			<button type="submit" class="btn btn-outline-dark">검색</button>
		</form>
		<div style="border-top: 2px solid black; padding: 10px;"></div>
		<!-- 카카오 지도 부분 -->
		<div id="map" style="width: 1100px; height: 500px;"></div>
		
		<!-- 공연정보 부분  -->
		<br>
		<div style="border-top: 2px solid black; padding: 10px;"></div>
		<div>
			<table class="table table-hover">
			    <thead  style="text-align: center;">
			      <tr>
			        <th>공연명</th>
			        <th>기간</th>
			        <th>상세페이지</th>
			      </tr>
			    </thead>
			    <tbody id="exhibition"  style="text-align: center;">
	
			    </tbody>
			</table>
		</div>
		<!-- 공연장 부분 -->
<!-- 		<div> -->
<!-- 			<table class="table table-hover"> -->
<!-- 			    <thead  style="text-align: center;"> -->
<!-- 			      <tr> -->
<!-- 			        <th>공연장명</th> -->
<!-- 			        <th>바로가기</th> -->
<!-- 			      </tr> -->
<!-- 			    </thead> -->
<!-- 			    <tbody style="text-align: center;"> -->
<%-- 					<c:forEach items="${pcList}" var="p"> --%>
<!-- 						<tr> -->
<%-- 							<td>${p}</td> --%>
<!-- 							<td><a class="btn btn-outline-dark"></a></td> -->
<!-- 						</tr> -->
<%-- 					</c:forEach> --%>
<!-- 			    </tbody> -->
<!-- 			</table> -->
		</div>
	</div>
<%@include file="../layout/bottom.jsp"%>
</body>
</html>