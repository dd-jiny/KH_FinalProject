<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<link href="css/styles.css" rel="stylesheet" />
<!-- Google jQuery file -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/bootstrap/js/bootstrap.js"></script>

<title>당근팜</title>
</head>
<body>


    <!-- header -->
    <nav class="py-2 bg-light border-bottom">
        <div class="container d-flex flex-wrap">

            <ul class="nav">
            <c:if test="${login == null}">
                <li class="nav-item"><a href="loginform.do" class="nav-link link-dark px-2">Login</a></li>
            </c:if>
            <c:if test="${login != null }">
                 <li class="nav-item"><a href="logOut.do" class="nav-link link-dark px-2">LogOut</a></li>
            </c:if>
           	<c:if test="${login == null }">
                <li class="nav-item"><a href="registform.do" class="nav-link link-dark px-2">Sign up</a></li>
            </c:if>
            <c:if test="${login != null }">
                <li class="nav-item"><a href="mypage.do" class="nav-link link-dark px-2">MyPage</a></li>
            </c:if>
            </ul>
        </div>
    </nav>
    <nav class="navbar navbar-expand-lg navbar-light" style="background-color:white;">
        <a class="navbar-brand d-lg-none" href="#"><img src="${pageContext.request.contextPath}/resources/image/당근팜_로고_2.png"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#myNavbarToggler7"
            aria-controls="myNavbarToggler7" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="myNavbarToggler7">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="usermarketplace.do">로컬마켓</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminproduct.do">씨앗도구구매</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">주말농장</a>
                </li>
                <li>
	                <a class="d-none d-lg-block" href="#"><img src="${pageContext.request.contextPath}/resources/image/당근팜_로고_2.png"></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">꿀팁</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">날씨</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">자유게시판</a>
                </li>
            </ul>
        </div>
    </nav>
    <hr>
   
</body>
</html>