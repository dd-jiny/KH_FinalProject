<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로컬마켓</title>
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
table {
	vertical-align: middle;
}

th {
	text-align: center;
}

td {
	text-align: center;
	height: 100px;
	padding: 50px 0px 50px 0px;
	vertical-align: bottom;
}

#styled-select {
	width: 100px;
	height: 34px;
	overflow: hidden;
	background: url("../img/downarrow_blue.png") no-repeat right #fff;
	border: 1px solid #ccc;
	margin: auto;
	border-radius: 6px;
}

#styled-select select {
	background: transparent;
	width: 100px;
	padding: 5px;
	font-size: 15px;
	line-height: 1;
	border: 0;
	border-radius: 0;
	height: 34px;
	-webkit-appearance: none;
	font-family: helvetica-roman;
	color: #9C9C9C;
}
</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#searchBtn")
								.click(
										function() {
											var selectBox = $(
													"#selectBox option:selected")
													.val();
											var searchVal = document
													.getElementById("searchVal").value;
											console.log(selectBox);
											if (selectBox == ""
													|| selectBox == null) {
												alert("카테고리를 선택해 주세요.!");
												$("#searchVal").focus();
											} else if (selectBox === "addr") {
												var addrVal = {
													"sellerAddress" : searchVal
												}
												$
														.ajax({
															type : "post",
															url : "searchProduct.do",
															data : JSON
																	.stringify(addrVal),
															contentType : "application/json",
															dataType : "json",
															success : function(
																	data) {
																//console.log(data.list.length);
																//console.log(data.list[0].productName);
																
		
										var html = "<tr>";
									    for (var i = 0; i < data.list.length; i++) {
											html += "<td>" + data.list[i].productRegDate+"</td>";
											html += "<td><img stlye='width: 200px; height: 200px;' src='${pageContext.request.contextPath}/resources"+data.list[i].productImg+"'></td>";
										  	html += "<td>"+ data.list[i].userId+"</td>";
											html += "<td><a href='userproductdetail.do?productSeq="+ data.list[i].productSeq+ "'>"+ data.list[i].productName+ "</a></td>";
											html += "<td>"+ data.list[i].productPrice
																			+ "</td>";
																	html += "<td>"
																			+ data.list[i].sellerAddress
																			+ "</td>";
																	html += "</tr><br>";
																}
																$(
																		"#dynamicTbody")
																		.empty();
																$(
																		"#dynamicTbody")
																		.append(
																				html);
															}
														});
											} else if (selectBox === "productName") {
												var addrVal = {
													"productName" : searchVal
												}
												$
														.ajax({
															type : "post",
															url : "searchProduct.do",
															data : JSON
																	.stringify(addrVal),
															contentType : "application/json",
															dataType : "json",
															success : function(
																	data) {
																//console.log(data.list.length);
																//console.log(data.list[0].productName);

																var html = "<tr>";
																for (var i = 0; i < data.list.length; i++) {
																	html += "<td>"
																			+ data.list[i].productRegDate
																			+ "</td>";
																	html += "<td><img stlye='width: 200px; height: 200px;' src='${pageContext.request.contextPath}/resources"+data.list[i].productImg+"'></td>";
																	html += "<td>"
																			+ data.list[i].userId
																			+ "</td>";
																	html += "<td><a href='userproductdetail.do?productSeq="
																			+ data.list[i].productSeq
																			+ "'>"
																			+ data.list[i].productName
																			+ "</a></td>";
																	html += "<td>"
																			+ data.list[i].productPrice
																			+ "</td>";
																	html += "<td>"
																			+ data.list[i].sellerAddress
																			+ "</td>";
																}
																html += "</tr><br>";
																$(
																		"#dynamicTbody")
																		.empty();
																$(
																		"#dynamicTbody")
																		.append(
																				html);
															}
														});
											}
										});
					});

	function productInsert() {
		location.href = "userproductinsert.do";
	}
</script>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>
	<div class="container" style="width: 100%;">

		<!--바디 (사이드바 포함 )-->
		<div class="row" style="padding-top: 50px;">
			<!--왼쪽 사이드-->
			<div class="col-sm-2 col-md-2"></div>
			<!--본문-->
			<!--tr,th,td사용하자-->
			<div class="col-sm-8 col-md-8 ">
				<h2 style="text-align: center;">당근마켓 상품 리스트</h2>
				<!--버튼-->
				<div class="row">
					<div class="col-md-4 col-md-offset-6" style="padding-bottom: 10px;">
						<div class="input-group">
							<div class="input-group-btn">
							<!-- 
								<button type="button" class="btn btn-warning dropdown-toggle"
								
									data-toggle="dropdown" aria-expanded="false">
									선택 <span class="caret"></span>
								</button>
							 -->
								<div id="styled-select">
									<select name="group" id="selectBox">
										<option value="">선택</option>
										<option value="addr">지역</option>
										<option value="productName">상품명</option>
									</select>
								</div>

								<!-- 
								<ul class="dropdown-menu" role="menu">
									<select id="selectBox">
										<option value="">선택</option>
										<option value="addr">지역</option>
										<option value="productName">상품명</option>
									</select>
								</ul>
								 -->
							</div>
							<!-- /btn-group -->
							<input type="text" class="form-control" aria-label="..."
								id="searchVal" style="margin-left:15px;">
						</div>
						<!-- /input-group -->
					</div>
					<!-- /.col-md-4 -->
					<div class="col-md-1">
						<button id="searchBtn" type="button" class="btn btn-warning">검색</button>
					</div>
				</div>
				<!-- /.row -->


				<table class="table table-hover">
					<tr>
						<th style="text-align: center;">등록날짜</th>
						<th style="text-align: center;">상품 이미지</th>
						<!--혹시몰라서 넣어둡니다 나중에 빼도됩니다-->
						<th style="text-align: center;">유저ID</th>
						<th style="text-align: center;">상품명</th>
						<th style="text-align: center; width:100px;">상품가격</th>
						<th style="text-align: center;">판매자 주소</th>
					</tr>
					<tbody id="dynamicTbody">
						<c:choose>
							<c:when test="${empty userProductList }">
								<tr>
									<th colspan="4">------ 작성된 글이 없습니다 ------</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${userProductList }" var="dto">

									<tr>
										<td style="vertical-align: middle;">${dto.productRegDate }</td>
										<td><img style="width: 200px; height: 200px;"
											src="${pageContext.request.contextPath}/resources${dto.productImg }"></td>
										<td style="vertical-align: middle;">${dto.userId }</td>
										<td style="vertical-align: middle;"><a
											href="userproductdetail.do?productSeq=${dto.productSeq }">${dto.productName }</a></td>
										<td style="vertical-align: middle;">${dto.productPrice }</td>
										<td style="vertical-align: middle;">${dto.sellerAddress }</td>
									</tr>

								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div class="col-md-1 col-md-offset-11">
					<button type="button" class="btn btn-warning btn-sm"
						onclick="productInsert();">상품등록</button>
				</div>

				<!--페이지네이션 구간 -->
				<div class="row">

					<div class="col-md-4 col-md-offset-5">
						<nav>
							<ul class="pagination" style="text-align: center;">
								<li><a href="#" aria-label="Previous"> <span
										aria-hidden="true">&laquo;</span>
								</a></li>
								<li><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#" aria-label="Next"> <span
										aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
				<!--페이지네이션 끝-->
			</div>
			<!--오른쪽 사이드-->
			<div class="col-sm-2 col-md-2 "></div>
		</div>
	</div>
<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>