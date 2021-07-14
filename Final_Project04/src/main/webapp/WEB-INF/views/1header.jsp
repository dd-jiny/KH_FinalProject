<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <style>
    .container{
    z-index : 3;
    
    </style>
</head>
<body>
<!--navbar-->
<header >
    <div class="container" style="width:100%;  position: fixed; " >
        <div class="row">
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                  <!-- Brand and toggle get grouped for better mobile display -->
                  <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                      <span class="sr-only">Toggle navigation</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp" style="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px; padding-top:0px;"><img src="resources/image/당근팜_로고_2.png" alt="배너"  style=" height: 50px; width: 100px;"></a>
                  </div>
              
                  <!-- Collect the nav links, forms, and other content for toggling -->
                  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                    <c:if test="${login == null }">
                      <li><a href="loginform.do">로컬마켓</a></li>
                      <li><a href="loginform.do">씨앗마켓</a></li>
                      <li><a href="loginform.do">모두의 당근</a></li>
                      <li><a href="loginform.do">꿀팁</a></li>
                      <li><a href="loginform.do">공지사항</a></li>
                     </c:if>
                     
                     <c:if test="${login != null }">
                      <li><a href="usermarketplace.do">로컬마켓</a></li>
                      <li><a href="adminproduct.do">씨앗마켓</a></li>
                      <li><a href="main.do">모두의 당근</a></li>
                      <li><a href="honeytip.do">꿀팁</a></li>
                      <li><a href="noticeboardlist.do">공지사항</a></li>
                     </c:if>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                    	<c:if test="${login != null }">
                        <li><a href="logOut.do" title="로그아웃" style="color:rgb(116,116,116)"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span></a></li>
                        <li><a href="mypage.do" title="마이페이지" style="color:rgb(116,116,116)"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></a></li>
                        </c:if>
                        <c:if test="${login == null }">
                        <li><a href="loginform.do"title="로그인" style="color:rgb(116, 116, 116)"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span></span></a></li>
                        <li><a href="registform.do"title="회원가입" style="color:rgb(116, 116, 116)"><span class="glyphicon glyphicon-registration-mark" aria-hidden="true"></span></span></a></li>
                        </c:if>
                    </ul>
                  </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->
              </nav>
        </div>
    </div>
</header>
</body>
</html>