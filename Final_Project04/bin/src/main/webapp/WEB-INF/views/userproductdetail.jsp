<%@page import="com.phoenix.carrot.product.dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</head>

<script type="text/javascript">
	window.onloaed = function() {
	
		
	}
</script>
<body>



	<h1>상품정보</h1>

	<table border="1">
		<tr>
			<td>userSeq</td>
			<td>${dto.userSeq }</td>
		</tr>
		<tr>
			<td>userId</td>
			<td>${dto.userId }</td>
		</tr>
		<tr>
			<td>등록날짜</td>
			<td>${dto.productRegDate }</td>
		</tr>
		<tr>
			<td>상품명</td>
			<td>${dto.productName }</td>
		</tr>
		<tr>
			<td>판매금액</td>
			<td>${dto.productPrice }</td>
		</tr>
		<tr>
			<td>판매가능여부</td>
			<td>${dto.saleStatus }</td>
		</tr>
		<tr>
			<td>상품정보</td>
			<td>${dto.productInfo }</td>
		</tr>
		<tr>
			<td>거래가능지역</td>
			<td>${dto.sellerAddress }</td>
		</tr>
		<tr>
			<td>지도</td>
			<td>
				<!-- 지도를 표시할 div 입니다 -->
				<div id="map" style="width: 100%; height: 350px;"></div>
			</td>
		</tr>
	</table>

	<!-- 카카오 map 사용 -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4b7e72eca108f2115775c1000b513249&libraries=services,clusterer,drawing"></script>

	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨 
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		var clusterer = new kakao.maps.MarkerClusterer({
			map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
			averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
			minLevel : 10, // 클러스터 할 최소 지도 레벨
			disableClickZoom : true
		// 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
		});
		
		var data = JSON.parse('${data}');
		
		
		 var markers = $(data.positions).map(function(i, position) {
	            return new kakao.maps.Marker({
	                position : new kakao.maps.LatLng(position.lat, position.lng)
	            });
	        });

	        // 클러스터러에 마커들을 추가합니다
	   clusterer.addMarkers(markers);



		 // 마커 클러스터러에 클릭이벤트를 등록합니다
	    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
	    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
	    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

	        // 현재 지도 레벨에서 1레벨 확대한 레벨
	        var level = map.getLevel()-1;

	        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
	        map.setLevel(level, {anchor: cluster.getCenter()});
	    });
		
		
		 
		 

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // 위도
				lon = position.coords.longitude; // 경도

				var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div style="padding:5px;">나의 위치</div>'; // 인포윈도우에 표시될 내용입니다

				// 마커와 인포윈도우를 표시합니다
				displayMarker(locPosition, message);

			});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

			displayMarker(locPosition, message);
		}

		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition, message) {

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				map : map,
				position : locPosition
			});

			var iwContent = message, // 인포윈도우에 표시할 내용
			iwRemoveable = true;

			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				content : iwContent,
				removable : iwRemoveable
			});

			// 인포윈도우를 마커위에 표시합니다 
			infowindow.open(map, marker);

			// 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(locPosition);
		}
	</script>







	<button type="button"
		onclick="location.href='chat.do?selleruserId=${dto.userId }&productName=${dto.productName }'">채팅하기</button>

</body>


</html>