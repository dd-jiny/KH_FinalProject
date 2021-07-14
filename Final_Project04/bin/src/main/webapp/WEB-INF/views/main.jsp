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
</head>
<body>
	<c:if test="${empty login }">
		<div>로그인해주세요</div>
	</c:if>
	<!-- 로그인이 되었을때 -->
	<c:if test="${not empty login }">	
		<div>${login.userid}님의 피드입니다.</div>
	</c:if>
	<h1>대진이 메인 작업창</h1>
	<h2>대진이 두번째 작업창 :<a href="weekendfarmmap.do"> 지도 </a></h2>
	<h2>대진이 세번째 작업창 : <a href="snsBoardInsertForm.do">글 작성</a></h2>
	<h2>유저개인피드 : <a href="snsBoardUserFeed.do?userId=${login.userid }">유저개인피드</a></h2>
	<h2>유저 검색 : <a href="snsUserSearch.do">유저검색</a></h2>
	<div id="page-content-wrapper">
		<div class="search-window">
			<input type="search" placeholder="유저 아이디/이름을 검색하세요."/>
			<input type="submit" value="검색" />	
		</div>

        <!-- 글작성 -->
        
		<div class="content-container">
			<div class="timeline-insert-head">타임라인 글작성</div>
                <div class="timeline-insert-body">
                    <div class="insert-userId-form">
                    	유저아이디:<textarea type="text" class="user-id-form" name="userId" cols="30" rows="1"></textarea>
                    </div>
                    <div class="insert-content-form">
                        글내용:<br/><textarea type="text" class="sns-contents-form" name="boardContents" cols="30" rows="10"></textarea>
                    </div>
                    <div class="insert-btn-group" role="group">
                        <button type="button" class="insert-btn">미디어</button>
                        <button type="submit" class="insert-fin">등록</button>
                    </div>         
            </div>
		</div>
		
        <!-- 뉴스피드 -->
        <div class="newsfeed">
            <div class="newsfeed-one">
                <div class="newsfeen-one-contents">
                    <button type="button" class="btn btn-light float-right">...</button>
                    <img src="" class="rounded-circle profile photo" width="50">
                    <a class="feed-information">아이디</a>
                    <a class="feed-information" id="insert-time">작성시간</a><br>
                    <img src="" class="user-insert-image">회원이 올린 이미지<br/>
                    <a href="#" class="feed-content" style="margin-top: 10px;">글내용<br/>
                        블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창
                        블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창
                        블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창
                        블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창 블라블라피드에팔로우한사람글내용나오는창
                           
                    </a>
                </div>
                <div align="center">
                    <div class="btn-group-comment" role="group" aria-label="Button group with nested dropdown">
                        <button type="button" class="comment-btn-secondary" data-toggle="tooltip" data-placement="top" title="좋아요">
                            <img src="">좋아요
                        </button>
                        <button type="button" class="comment-btn-secondary" data-toggle="tooltip" data-placement="top" title="답글">답글</button>
                        <button type="button" class="comment-btn-secondary" data-toggle="tooltip" data-placement="top" title="공유하기">공유하기</button>
                    </div>

                </div>
            </div>

            </div>
        </div>
	</div>

  
	<table border="1">
	<col width="20">
	<col width="100">
	<col width="100">
	<col width="200">


	<tr>
		<th>번호</th>
		<th>작성자</th>
		<th>제목</th>
		<th>작성일</th>
	</tr>
	
	<c:choose>
		<c:when test="${empty snsBoardList }">
			<tr>
				<th colspan="4">------ 작성된 글이 없습니다-----</th>
			</tr>
		
		</c:when>
		<c:otherwise>
			<c:forEach items="${snsBoardList }" var= "dto">
				<tr>
					<td>${dto.entireBoardSeq }</td>
					<td>${dto.userId }</td>
					<td><a href="snsBoardOne.do?entireBoardSeq=${dto.entireBoardSeq }">${dto.boardTitle }</a></td>
					<td>${dto.boardDate }</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<tr>
		<td colspan="4" align="right"><input type="button" value="글작성" onclick="location.href='snsBoardInsertForm.do'"></td>
	</tr>
	
	
</table>
<!-- 재희 CSS -->
<div class="container" style="width: 100%;">
        
        <!--바디 (사이드바 포함 )-->
        <div class="row" style="padding-top:50px;">
            <!--왼쪽 사이드-->
            <div class="col-sm-3 col-md-3" style="padding:80px 0px 10px 200px; text-align: right; ">
                
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default" >
                      <div class="panel-heading" role="tab" id="headingOne" >
                        <h4 class="panel-title">
                          <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
                          </a>
                        </h4>
                      </div>
                      <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                        <a href="#" class="list-group-item">내피드</a>
                        <a href="#" class="list-group-item">글작성</a>
                        <a href="#" class="list-group-item">Porta ac consectetur ac</a>
                        <a href="#" class="list-group-item">Vestibulum at eros</a>
                      </div>
                    </div>
                </div>
            </div>
            <!--본문-->
            <div class="col-sm-6 col-md-6 ">
                <div class="row" style="padding-bottom: 20px;">
                    <div class="col-md-12 col-md-offset-1" style="padding-top: 10px;"><img src="https://via.placeholder.com/50" class="img-circle"  alt=""  > <button type="button" class="btn btn-link" style=" color:black; padding-left:0px;">아이디 입력</button></div>
                </div>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <img src="https://via.placeholder.com/700x450" class="img-responsive"  alt=""  > 
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <div class="btn-group" role="group" aria-label="..." >
                            <button type="button" class="btn btn-link"><span class="glyphicon glyphicon-heart-empty" aria-hidden="true" style="color: black;"></span></button>
                            <button type="button" class="btn btn-link"><span class="glyphicon glyphicon-comment" aria-hidden="true" style="color: black;"></span></button>
                            <button type="button" class="btn btn-link"><span class="glyphicon glyphicon-share" aria-hidden="true" style="color: black;"></span></button>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <button type="button" class="btn btn-link" style=" color:black; padding-left:0px;">아이디 입력</button>
                        <span>Lorem ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eveniet et, deserunt quas reprehenderit ad voluptate dolores placeat sed! Sint sed libero repudiandae nesciunt explicabo ad voluptates, a beatae dolorum.</span>
                    </div>
                </div>
                <hr style="color:black">
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        
                        <span>#######</span>
                    </div>
                </div>
            </div>
            <!--오른쪽 사이드-->
            <div class="col-sm-3 col-md-3 " style="padding:80px 100px 10px 0px;">
                <div class="list-group" >
                    <a href="#" class="list-group-item disabled" style="text-align: center;">
                      <b>친구목록</b>
                    </a>
                    <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                    <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                    <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                    <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>