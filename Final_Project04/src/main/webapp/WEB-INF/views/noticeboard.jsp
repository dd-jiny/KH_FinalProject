<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항</title>
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
	text-align: center;
}
</style>
</head>
<body>

<%@include file="/WEB-INF/views/1header.jsp"%>

	<!-- 
    <table border="1">
	<col width="200">
	<col width="100">
	<col width="200">
	<col width="100">
	<col width="300">
	
	<tr>
		<th>상품썸네일</th>
		<th>등록날짜</th>
		<th>유저ID</th>
		<th>상품명</th>
		<th>상품가격</th>
		<th>판매자주소</th>
	</tr>
	<tbody id="dynamicTbody">
		<c:choose>
			<c:when test="${empty userProductList }">
				<tr>
					<th colspan="4">------ 작성된 글이 없습니다 ------ </th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${userProductList }" var="dto">
				
					<tr>
						<td><img src="${pageContext.request.contextPath}/resources${dto.productThumb }"></td>
						<td>${dto.productRegDate }</td>
						<td>${dto.userId }</td>
						<td><a href="userproductdetail.do?productSeq=${dto.productSeq }">${dto.productName }</a></td>
						<td>${dto.productPrice }</td>
						<td>${dto.sellerAddress }</td>
					</tr>
				
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
		<tr>
			<td colspan="4" align="right"><input type="button" value="글작성" onclick="location.href='productinsert.do'"></td>
		</tr>
	</table>
    
    <span class="label label-danger" style="margin-left: 10px;">공지사항</span>
    
     -->
	<div class="container" style="width: 100%;">

		<!--바디 (사이드바 포함 )-->
		<div class="row" style="padding-top: 50px;">
			<!--왼쪽 사이드-->
			<div class="col-sm-3 col-md-3"></div>
			<!--본문-->
			<div class="col-sm-6 col-md-6 ">
				<table class="table table-hover">
					<tr>
						<th style="text-align:center;">글번호</th>
						<th style="text-align:center;">등록일자</th>
						<th style="text-align:center;">제목</th>
						<th style="text-align:center;">유저아이디</th>
					</tr>
					<tbody id="dynamicTbody">
						<c:choose>
							<c:when test="${empty noticeBoardList }">
								<tr>
									<th colspan="4">------ 작성된 글이 없습니다 ------</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${noticeBoardList }" var="dto">
									<tr>
										<td>${dto.entireBoardSeq }</td>
										<td>${dto.boardDate }</td>
										<td><a href="noticeboarddetail.do?entireBoardSeq=${dto.entireBoardSeq }">${dto.boardTitle }
											<span class="label label-danger" style="margin-left: 10px;">공지사항</span>
										</a></td>
										<td>${dto.userId }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	 <div class="row" style="text-align: center;">
                        <nav>
                            <ul class="pagination">
                                <li>
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <li><a href="#">1</a></li>
                                <li><a href="#">2</a></li>
                                <li>
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>

<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>