<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내정보수정</title>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <style>
        h3{
            text-align: center;
        }
        th{
            text-align: center;
        }
        tr{
            text-align: center;
        }
        .img-circle{
             margin-bottom:50px;
         }
         
         #id{
             font-size: 30px;
             font-weight:lighter; 
         }
         
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>
    <div class="container" style="width: 100%;">
        
        <!--바디 (사이드바 포함 )-->
        <div class="row" style="padding-top:50px;">
            <!--왼쪽 사이드-->
            <div class="col-sm-3 col-md-3" >
            </div>
            <!--본문--> 
            <div class="col-sm-6 col-md-6 ">
                
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <h2 style="text-align: center;">회원정보 수정 </h2>
                        <form action="registPost.do" method="post" role="form" id="usercheck" name="member">
                            <div class="form-group">
                                <label for="id">아이디</label> <input type="text" class="form-control"
                                    id="userid" name="userid" value="${login.userid}" readonly>
                                <div class="eheck_font" id="id_check"></div>
                            </div>
                            <div class="form-group">
                                <label for="pw">새로운 비밀번호</label> <input type="password"
                                    class="form-control" id="password" name="password"
                                    placeholder="PASSWORD">
                                <div class="eheck_font" id="pw_check"></div>
                            </div>
                            <div class="form-group">
                                <label for="pw2">새로운 비밀번호 확인</label> <input type="password"
                                    class="form-control" id="password2" name="password2"
                                    placeholder="Confirm Password">
                                <div class="eheck_font" id="pw2_check"></div>
                            </div>
                            <div class="form-group">
                                <label for="mem_name">이름</label> <input type="text"
                                    class="form-control" id="username" name="username" value="${login.username}"
                                    readonly>
                                <div class="eheck_font" id="name_check"></div>
                            </div>
                            <div class="form-group">
                                <label for="mem_birth">생년월일</label> <input type="tel"
                                    class="form-control" id="userbirthday" name="userbirthday" value="${login.userbirthday}"
                                    readonly>
                                <div class="eheck_font" id="birth_check"></div>
                            </div>
                            <div class="form-group">
                                <label for="mem_email">이메일 주소</label> <input type="email"
                                    class="form-control" id="useremail" name="useremail"
                                    placeholder="E-mail">
                                <div class="eheck_font" id="email_check"></div>
                            </div>
                            <div class="form-group">
                                <label for="mem_phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label> <input
                                    type="tel" class="form-control" id="userphone" name="userphone"
                                    placeholder="Phone Number">
                                <div class="eheck_font" id="phone_check"></div>
                            </div>
                            <div class="form-group">
                                <input class="form-control" style="width: 40%; display: inline;"
                                    placeholder="우편번호" name="useroaddress" id="useroaddress"
                                    type="text" readonly="readonly">
                                <button type="button" class="btn btn-default"
                                    onclick="execPostCode();">
                                    <i class="fa fa-search"></i> 우편번호 찾기
                                </button>
                            </div>
                            <div class="form-group">
                                <input class="form-control" style="top: 5px;" placeholder="도로명 주소"
                                    name="useraddress" id="useraddress" type="text"
                                    readonly="readonly" />
                            </div>
                            <div class="form-group">
                                <input class="form-control" placeholder="상세주소"
                                    name="userdetailaddress" id="userdetailaddress" type="text" />
                            </div>
                            <div class="g-recaptcha" id="recaptcha"
                                data-sitekey="6LfJBFIbAAAAAPyFCgWwMz3xEFvaBdABdZtEdjMD" style="padding:0px 0px 0px 100px" >
                            </div>
                            <div class="form-group text-center">
                                <button type="submit" class="btn btn-primary">수정 완료</button>
                            </div>
                            
                        </form>
                    </div>
                </div>
                 
            </div>
            <!--오른쪽 사이드-->
            <div class="col-sm-3 col-md-3 " >
            </div>
        </div>
    </div>
  <%@include file="/WEB-INF/views/1footer.jsp"%>  
</body>
</html>