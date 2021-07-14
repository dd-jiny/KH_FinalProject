<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
 <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>

<%@include file="/WEB-INF/views/1header.jsp"%>
	 <div class="container">
        <div class="row">
            <div class="col-md-12" style="height: 100px;"></div>
            <div class="col-md-10 col-md-offset-1" style="border:1px solid rgb(197, 197, 197)">
                
                <table class="table table-bordered">
                    <tr>
                        <th>작성자</th>
                        <td><input type="text" class="form-control" style="cursor:default" onfocus="javascript:blur();" value="${dto.entireBoardSeq }"></td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td><input type="text" class="form-control" style="cursor:default" onfocus="javascript:blur();" value="${dto.boardDate }"></td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" class="form-control" style="cursor:default" onfocus="javascript:blur();" value="${dto.boardTitle }"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><textarea class="form-control" rows="25" style="cursor:default" onfocus="javascript:blur();">${dto.boardContents }</textarea></td>
                    </tr>

                </table>

            </div>
            
        </div>
    </div>




<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>