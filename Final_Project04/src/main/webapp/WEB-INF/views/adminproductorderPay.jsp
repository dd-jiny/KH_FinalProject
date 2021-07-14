<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<c:set var="path" value="${pageContext.request.contextPath }" />
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>씨앗마켓 결제 페이지</title>
			<!-- jQuery -->
			<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
			<!-- iamport.payment.js -->
			<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		</head>

		<body>
			<%@include file="/WEB-INF/views/1header.jsp" %>

				결과 창
				<%@include file="/WEB-INF/views/1footer.jsp" %>

		</body>

		</html>