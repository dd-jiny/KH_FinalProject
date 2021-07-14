<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>오늘의 날씨</title>

<style type="text/css">

</style>

</head>

<body>
	<script type="text/javascript"></script>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>

	<script>
		$.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=eee038bcc405e706ccb79c12e89fbd81&units=metric',
			function(result) {

		$('.ctemp').append(result.main.temp);
		$('.lowtemp').append(result.main.temp_min);
		$('.hightemp').append(result.main.temp_max);
			var wiconUrl = '<img src="http://openweathermap.org/img/wn/'+result.weather[0].icon+ 
         '.png" alt="' + result.weather[0].description + '">'
		$('.icon').html(wiconUrl);

			var ct = result.dt;

			function convertTime(t) {
				var date = new Date(t * 1000);
                //Tue Apr 06 2021 15:28:58 GMT+0900 (대한민국 표준시)
                var year = date.getFullYear();
                var month = "0" + (date.getUTCMonth() + 1);
                var day = "0" + date.getDate();
                var hour = "0" + date.getHours();
                var minute = "0" + date.getMinutes();
                var second = "0" + date.getSeconds();


                return year + '/' + month.substr(-2) + '/' + day.substr(-2) + ' ' + hour.substr(-2) + ':' +
                    minute.substr(-2) + ':' + second.substr(-2);
            }
            var currentTime = convertTime(ct); //커런트타임은 컨버트타임으로 바꿔준다.파라미터는 웨더데이트
            $('.time').append(currentTime); //thistime을 convertTime으로 형변환한 weatherdate을 붙여준다.



        });
		//년 월 일 시 로 바꾸기 
		
	/*
	
	  function Unix_timestamp(t) {
                    var date = new Date(t * 1000);
                    //Tue Apr 06 2021 15:28:58 GMT+0900 (대한민국 표준시)
                    var year = date.getFullYear();
                    var month = "0" + (date.getUTCMonth() + 1);
                    var day = "0" + date.getDate();
                    var hour = "0" + date.getHours();
                    var minute = "0" + date.getMinutes();
                    var second = "0" + date.getSeconds();


                    return year + '/' + month.substr(-2) + '/' + day.substr(-2) + ' ' + hour.substr(-2) + ':' +
                        minute.substr(-2) + ':' + second.substr(-2);
                }
                var currentTime = Unix_timestamp(ct); //커런트타임은 컨버트타임으로 바꿔준다.파라미터는 웨더데이트
                $('.thistime').append(currentTime); //thistime을 convertTime으로 형변환한 weatherdate을 붙여준다.



            });
	
	*/
		
	</script>
	<%@include file ="/WEB-INF/views/1header.jsp" %>
	<h2>날씨 미세먼지</h2>

	<h5>오늘의 날씨</h5>
	<h5 class="icon">
		<img alt="" src="http://openweathermap.org/img/wn/10d.png">
	</h5>

	<h5 class="time">현재 시간 :</h5>
	<h5 class="ctemp">현재 온도 (℃):</h5>
	<h5 class="lowtemp">최저 온도 (℃):</h5>
	<h5 class="hightemp">최고 온도 (℃):</h5>

	<h2>미세먼지</h2>
	<h4 class="grade">[ 미세먼지 수치 등급 : 1- 좋음, 2- 보통, 3-나쁨, 4-매우나쁨 ]</h4>
	<c:forEach items="${list }" var="dto">

		<h5 class="dTime">실시간 : ${dto.dataTime }</h5>
		<h5 class="sdName">지역 : ${dto.sidoName } ${dto.stationName }</h5>
		<h5 class="khaiGrade">통합 대기 환경 지수 : ${dto.khaiGrade }</h5>
		<h5 class="pm10Grade">미세먼지 수치 : ${dto.pm10Grade } (1시간 이내)</h5>
		<h5 class="pm25Grade">초미세먼지 수치 : ${dto.pm25Grade } (1시간 이내)</h5>
		<h5>--------------------------------------------------</h5>
	</c:forEach>

	<div id="scene">
		<div id="left-zone">
			<ul class="list">
				<li class="item"><input type="radio"
					id="radio_The garden strawberry (or simply strawberry /ˈstrɔːbᵊri/; Fragaria × ananassa) is a widely grown hybrid species of the genus Fragaria (collectively known as the strawberries)"
					name="basic_carousel"
					value="The garden strawberry (or simply strawberry /ˈstrɔːbᵊri/; Fragaria × ananassa) is a widely grown hybrid species of the genus Fragaria (collectively known as the strawberries)"
					checked="checked" /> <label class="label_strawberry"
					for="radio_The garden strawberry (or simply strawberry /ˈstrɔːbᵊri/; Fragaria × ananassa) is a widely grown hybrid species of the genus Fragaria (collectively known as the strawberries)">strawberry</label>
					<div class="content content_strawberry">
						<span class="picto"></span>
						<h1>strawberry</h1>
						<p>The garden strawberry (or simply strawberry /ˈstrɔːbᵊri/;
							Fragaria × ananassa) is a widely grown hybrid species of the
							genus Fragaria (collectively known as the strawberries)</p>
					</div></li>
				<li class="item"><input type="radio"
					id="radio_A banana is an edible fruit, botanically a berry, produced by several kinds of large herbaceous flowering plants in the genus Musa."
					name="basic_carousel"
					value="A banana is an edible fruit, botanically a berry, produced by several kinds of large herbaceous flowering plants in the genus Musa." />
					<label class="label_banana"
					for="radio_A banana is an edible fruit, botanically a berry, produced by several kinds of large herbaceous flowering plants in the genus Musa.">banana</label>
					<div class="content content_banana">
						<span class="picto"></span>
						<h1>banana</h1>
						<p>A banana is an edible fruit, botanically a berry, produced
							by several kinds of large herbaceous flowering plants in the
							genus Musa.</p>
					</div></li>
				<li class="item"><input type="radio"
					id="radio_The apple tree (Malus domestica) is a deciduous tree in the rose family best known for its sweet, pomaceous fruit, the apple. It is cultivated worldwide as a fruit tree, and is the most widely grown species in the genus Malus."
					name="basic_carousel"
					value="The apple tree (Malus domestica) is a deciduous tree in the rose family best known for its sweet, pomaceous fruit, the apple. It is cultivated worldwide as a fruit tree, and is the most widely grown species in the genus Malus." />
					<label class="label_apple"
					for="radio_The apple tree (Malus domestica) is a deciduous tree in the rose family best known for its sweet, pomaceous fruit, the apple. It is cultivated worldwide as a fruit tree, and is the most widely grown species in the genus Malus.">apple</label>
					<div class="content content_apple">
						<span class="picto"></span>
						<h1>apple</h1>
						<p>The apple tree (Malus domestica) is a deciduous tree in the
							rose family best known for its sweet, pomaceous fruit, the apple.
							It is cultivated worldwide as a fruit tree, and is the most
							widely grown species in the genus Malus.</p>
					</div></li>
				<li class="item"><input type="radio"
					id="radio_The orange (specifically, the sweet orange) is the fruit of the citrus species Citrus × sinensis in the family Rutaceae."
					name="basic_carousel"
					value="The orange (specifically, the sweet orange) is the fruit of the citrus species Citrus × sinensis in the family Rutaceae." />
					<label class="label_orange"
					for="radio_The orange (specifically, the sweet orange) is the fruit of the citrus species Citrus × sinensis in the family Rutaceae.">orange</label>
					<div class="content content_orange">
						<span class="picto"></span>
						<h1>orange</h1>
						<p>The orange (specifically, the sweet orange) is the fruit of
							the citrus species Citrus × sinensis in the family Rutaceae.</p>
					</div></li>
			</ul>
		</div>
		<div id="middle-border"></div>
		<div id="right-zone"></div>
	</div>
 <%@include file ="/WEB-INF/views/1footer.jsp" %>
</body>
</html>