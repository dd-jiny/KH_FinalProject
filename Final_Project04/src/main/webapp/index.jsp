<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>당근팜</title>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
body {
	padding-top: 70px;
	position: relative;
}

.navbar-brand img {
	width: 100px;
}

.container-fluid .row p {
	font-size: 2em;
}

#ad {
	padding-bottom: 500px;
}

.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:focus,
	.navbar-default .navbar-nav>.active>a:hover {
	color: #166FA0;
	background-color: lightblue;
}

#text .text {
	position: absolute;
	top: 100px;
	right: 80px;
}

#img_title {
	font-size: 50px;
	color: blanchedalmond;
}

#img_content {
	font-size: 20px;
	color: white;
}
</style>
</head>
<body>

	<nav class="navbar navbar-default navbar-fixed-top ">
		<div class="container-fluid" >
			<div class="navbar-header" >
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#myNavbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp"  style="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px; padding-top:0px;"> <img src="resources/image/logo-banner.png"
					alt="당근팜" >
				</a>
				<p class="navbar-text">
					내가 키운 채소, <a href="index.jsp" class="navbar-link">당근팜</a>에서 거래하세요!
				</p>
			</div>

		
			<div class="collapse navbar-collapse navbar-scrollspy" id="myNavbar" >
				<ul class="nav navbar-nav">
					<c:if test="${login == null }">
						<li><a href="#section1">로컬마켓</a></li>
						<li><a href="#section2">씨앗마켓</a></li>
						<li><a href="#section4">꿀팁</a></li>
						<li><a href="#section6">공지사항</a></li>
						
						
					</c:if>
					<c:if test="${login != null }">
						<li><a href="#section1">로컬마켓</a></li>
						<li><a href="#section2">씨앗마켓</a></li>
						<li><a href="#section3">모두의 당근</a></li>
						<li><a href="#section4">꿀팁</a></li>
						<li><a href="#section6">공지사항</a></li>
						
					</c:if>

				</ul>

			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>

	<c:if test="${login != null }">
		<div class="container-fluid" id="section1">
			<a href="usermarketplace.do"><div class="col-md-12" id="text">
					<img src="resources/image/로컬마켓_main.jpg" alt="당근팜"
						style="width: 100%; height: 100%;">
					<div class="text">
						<p id="img_title">로컬마켓으로 이동</p>
						<p id="img_content">내가 키운 채소, 당근팜에서 거래/나눔하기</p>
					</div>
				</div></a>
		</div>


		<div class="container-fluid" id="section2">
			<a href="adminproduct.do"><div class="col-md-12" id="text">
					<img src="resources/image/씨앗도구구매_main2.jpg" alt="당근팜"
						style="width: 100%; height: 100%;">
					<div class="text">
						<p id="img_title">씨앗마켓</p>
						<p id="img_content">당근팜에서 우리집 텃밭가꾸기 상품을 준비해보세요.</p>
					</div>
				</div></a>
		</div>
		
		<div class="container-fluid" id="section3">
			<a href="main.do"><div class="col-md-12" id="text">
					<img src="resources/image/모두의당근.jpg" alt="당근팜"
						style="width: 100%; height: 100%;">
					<div class="text">
						<p id="img_title">모두의 당근</p>
						<p id="img_content">내가 키운 작물을 자랑하고 공유해보세요!</p>
					</div>
				</div></a>
		</div>
		
		

		<div class="container-fluid" id="section4">
			<a href="honeytip.do"><div class="col-md-12" id="text">
					<img src="resources/image/꿀팁얻기_main1.jpg" alt="당근팜"
						style="width: 100%;">
					<div class="text">
						<p id="img_title">꿀팁얻기</p>
						<p id="img_content">처음에 힘드실까봐 저희가 알찬 정보들만 모아놨습니다.</p>
					</div>
				</div></a>
		</div>


		<div class="container-fluid" id="section6">
			<a href="noticeboardlist.do"><div class="col-md-12" id="text">
					<img src="resources/image/게시판_main1.jpg" alt="당근팜"
						style="width: 100%;">
					<div class="text">
						<p id="img_title">공지사항</p>
						<p id="img_content">공지사항을 확인해 보세요.</p>
					</div>
				</div></a>
		</div>


	</c:if>

	<c:if test="${login == null }">
		<div class="container-fluid" id="section1">
			<a href="loginform.do"><div class="col-md-12" id="text">
					<img src="resources/image/로컬마켓_main.jpg" alt="당근팜"
						style="width: 100%; height: 100%;">
					<div class="text">
						<p id="img_title">로컬마켓으로 이동</p>
						<p id="img_content">내가 키운 채소, 당근팜에서 거래/나눔하기</p>
					</div>
				</div></a>
		</div>


		<div class="container-fluid" id="section2">
			<a href="loginform.do"><div class="col-md-12" id="text">
					<img src="resources/image/씨앗도구구매_main2.jpg" alt="당근팜"
						style="width: 100%; height: 100%;">
					<div class="text">
						<p id="img_title">씨앗,도구 구매</p>
						<p id="img_content">모든 분들이 손쉽게 나만의 텃밭을 가꿀 수 있도록 저희가 준비했습니다.</p>
					</div>
				</div></a>
		</div>

		<div class="container-fluid" id="section4">
			<a href="loginform.do"><div class="col-md-12" id="text">
					<img src="resources/image/꿀팁얻기_main1.jpg" alt="당근팜"
						style="width: 100%;">
					<div class="text">
						<p id="img_title">꿀팁얻기</p>
						<p id="img_content">처음에 힘드실까봐 저희가 알찬 정보들만 모아놨습니다.</p>
					</div>
				</div></a>
		</div>


		<div class="container-fluid" id="section6">
			<a href="loginform.do"><div class="col-md-12" id="text">
					<img src="resources/image/게시판_main1.jpg" alt="당근팜"
						style="width: 100%;">
					<div class="text">
						<p id="img_title">공지사항</p>
						<p id="img_content">공지사항을 확인해 보세요.</p>
					</div>
				</div></a>
		</div>


	</c:if>


	<script>
		$(document).ready(function() {
			// Add scrollspy to <body>
			$('body').scrollspy({
				target : ".navbar",
				offset : 50
			});

			// Add smooth scrolling on all links inside the navbar
			$("#myNavbar a").on('click', function(event) {

				// Prevent default anchor click behavior
				event.preventDefault();

				// Store hash
				var hash = this.hash;

				// Using jQuery's animate() method to add smooth page scroll
				// The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
				$('html, body').animate({
					scrollTop : $(hash).offset().top
				}, 800, function() {

					// Add hash (#) to URL when done scrolling (default click behavior)
					window.location.hash = hash;
				});
			});
		});
	</script>

	


	
	
	


	<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>