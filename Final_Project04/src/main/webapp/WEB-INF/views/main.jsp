<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모두의 당근</title>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<style>
        body{
            height: 100vh;
        }
        #buttondiv{
            display:inline
        }
        #left_side_bar{
            position: fixed;
            left:0;
        }
        #right_side_bar{
            position: fixed;
            right:0;
        }
        #navbar-style{
            border-bottom: 1px solid rgb(206, 206, 206);
            padding-left:10px;
        }
        #navbar-style a{
            height: 50px;
           padding-top:15px;
        }
        
        #fn{
            font-size: 2rem; 
            border-color: rgb(241, 241, 241); 
            background: linear-gradient(#f1f1f1 0%, #ffffff 2px,  #eeeeee 100%);
        }
        #li-color{
            color:rgb(77, 75, 75);
        }
        
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>
	
<!-- 재희 CSS -->
    <div class="container" style="width: 100%;">
        <div class="row" style="padding-top:70px;">
<!--왼쪽 사이드-->
            <div class="col-sm-2 col-md-2 " id="left_side_bar" style="border-right:1px solid rgb(214, 214, 214); height: 100%;  ">
                <!--로고이미지-->
                <div class="row">
                <img src="resources/image/logo.png" class="img-responsive"  alt="당근팜 로고" style="padding-bottom: 20px;" >
                </div>
                <!--프로필사진,id-->
                <div class="row">
                    <div class="col-md-4"><img src="./resources/image/userdefaultimg.png" class="img-responsive img-circle"  alt="프로필 이미지" style="margin:20px 10px 20px 10px" ></div>
                    <div class="col-md-8" >
                        <button type="button" class="btn btn-link" style="padding-top:15%;">${login.userid }</button>
                        <p>${login.useremail }</p>
                    </div>
                    <button type="button" class="btn btn-warning btn-block" style="margin-bottom: 20px;">로그아웃</button>
                </div>
                <!--네이게이션바-->
                <div class="row">
                    <ul class="nav nav-pills nav-stacked" >
                        <!--홈으로 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="index.jsp" id="li-color"><span class="glyphicon glyphicon-home" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">home</span></a></li>
                        <!--나의 피드보기 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="snsBoardUserFeed.do?userId=${login.userid }" id="li-color"><span class="glyphicon glyphicon-th" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">나의 피드 보기</span></a></li>
                        <!--글작성 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="snsBoardInsertForm.do" id="li-color"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">글작성</span></a></li>
                        <!--마이페이지로 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="mypage.do?userid=${login.userid}" id="li-color"><span class="glyphicon glyphicon-user" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">마이페이지</span></a></li>
                         <!-- 타임라인 -->
                        <li id="navbar-style" role="presentation" ><a href="main.do" id="li-color"><span class="glyphicon glyphicon-time" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">타임라인</span></a></li>
                        <!--채팅-->
                        <li id="navbar-style" role="presentation" ><a href="#" id="li-color"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">채팅</span></a></li>
                        <!--로컬마켓 가기-->
                        <li id="navbar-style" role="presentation" ><a href="usermarketplace.do" id="li-color"><span class="glyphicon glyphicon-gift" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">로컬마켓 가기</span></a></li>
                        
                      </ul>
                        
                        
                </div>
                <div class="row">

                </div>
            </div>
            
<!--본문-->
            <c:choose>
            	<c:when test="${empty snsBoardList}">
            		<div>글이 없습니다.</div>
            	</c:when>
            	<c:otherwise>
            		<c:forEach items="${snsBoardList}" var= "dto">
                    <div class="col-sm-8 col-md-8 col-md-offset-2 " style="border:1px solid rgb(228, 228, 228);">
                        <div class="row" style="padding-bottom: 20px;">
                                             
                            <div class="col-md-12" style="padding-top: 10px;">
                                <!--작성자 프로필 이미지-->
                                <img src="./resources/image/userdefaultimg.png" class="img-responsive img-circle"  alt="프로필 이미지"  style="height:40px; width:50px;">
                                 
                                <!--작성자 아이디 -->
                                <a href="snsBoardUserFeed.do?userId=${dto.userId }" style="color: black; padding-left: 10px;"><b>${dto.userId }</b></a>
                                <!--작성일-->
                                <span style="padding-left: 20px;">${dto.boardDate }</span>
                            </div>
                        </div>
                        <div class="row">
                            
                            <div class="col-md-10 col-md-offset-1">
                                <!--글내용 작성 부분-->
                                <span>${dto.boardContents }</span>
                            </div>
                        </div>
                        <div class="row">
                            
                            <div class="col-md-10 col-md-offset-1">
                                <!--해시태그 혹시 몰라서 넣어뒀습니다.. 만약 링크 걸어서이동 하고싶으면 첫번째꺼쓰고 ,링크 필요없으면 나머지 4개 같이 하면 됩니다.-->
                                <span style="color:cornflowerblue; padding-right: 20px;">#냥냥</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#고양이만한 당근</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#당근</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#주말농장</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#당근팜 최고</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#보수</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#예정입니다ㅜㅜ</span>
                            </div>
                        </div>
                        <div class="row" style="padding-top: 20px;">
                        
                            <div class="col-md-10 col-md-offset-1"  >
                                <!--게시물 이미지 센터로 나오는지 확인-->
                                <a href="snsBoardOne.do?entireBoardSeq=${dto.entireBoardSeq }"  >
                                <img src="${pageContext.request.contextPath}/resources${dto.boardImg }" class="img-responsive"  alt="게시물 이미지" style="height: 500px; width: 500px; margin-left:200px; "   > 
                            	</a>
                            </div>
                        </div>
                        <div class="row" style="padding-top:20px;">
                            
                            <!--댓글,좋아요,공유 버튼 다시 -->
                            
                            <div class="col-md-4">
                                <!--댓글 버튼입니다 (span태그는 아이콘입니다.)--><!--버튼 2가지라서 다른종류보고싶으면 부트스트랩에서 보이기/숨기기 확인하자-->
                                  <button class="btn btn-default btn-block" type="button" id="fn" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                                    <span class="glyphicon glyphicon-comment" aria-hidden="true" style="color: black;"></span>
                                  </button>
                                  <div class="collapse" id="collapseExample">
                                      <!--댓글창-->
                                    <div class="well" style="width: 315%;">
                                        <table class="table">
                                            <tr>
                                                <th>작성자</th>
                                                <th>내용</th>
                                                <th>작성일</th>
                                                <th></th>
                                            </tr>
                                            <tr>
                                                <td>앨리스</td>
                                                <td>굳굳 당근이 엄청 크네여 </td>
                                                <td>2020.07.11</td>
                                                <td>
                                                    <button type="button" class="btn btn-warning btn-xs">작성</button>
                                                    <button type="button" class="btn btn-danger btn-xs">삭제</button>
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <table class="table">
                                            <tr>
                                                <th>
                                                    <!--댓글작성 인풋박스 입니다.-->
                                                    <input type="text" class="form-control" placeholder="댓글을 입력해주세요">
                                                </th>
                                                <td style="width: 20%;">
                                                    <button type="button" class="btn btn-warning btn-sm">작성</button>
                                                </td>
                                            </tr>
                                            
                                        </table>
                                    </div>
                                  </div>
                            </div>
                            <div class="col-md-4">
                                <!--좋아요 버튼입니다 (span태그는 아이콘입니다.)-->
                                <button type="button" class="btn btn-default btn-block" id="fn">
                                    <span class="glyphicon glyphicon-heart-empty" aria-hidden="true" style="color: black; margin-right : 10px;"></span><span>${dto.likeCount}</span>
                                    <!--
                                    <span class="glyphicon glyphicon-heart" aria-hidden="true" style="color: black;"></span>    :꽉찬 하트 입니다.
                                    <span >count</span> :혹시몰라서 넣어뒀습니다.
                                     -->
                                </button>
                            </div>
                            <div class="col-md-4">
                                <!--공유 버튼입니다 (span태그는 아이콘입니다.)-->
                                <button type="button" class="btn btn-default btn-block" id="fn"><span class="glyphicon glyphicon-share" aria-hidden="true" style="color: black;"></span></button>
                            </div>
                        </div>
                        
                        <hr style="color:black">
                        
                        
                    </div>
                    </c:forEach>
                    </c:otherwise>
               </c:choose>
<!--오른쪽 사이드-->
            <div class="col-sm-2 col-md-2 "  id="right_side_bar" style=" border-left:1px solid rgb(214, 214, 214); padding:0px 5px; ">
                 <div class="col-md-12">
            	                	<a href="snsUserSearch.do"><button type="button" class="btn btn-warning btn-block" style="margin-bottom:20px;">유저 검색</button></a>
								</div>
                
                <div class="col-md-12" style="padding:0px 0px 0px 0px;">
                    <!--팔로우 추천 리스트-->
                    <div class="list-group" >
                        <a href="#" class="list-group-item disabled" style="text-align: center;">팔로우 추천</a>
                        <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                        <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                        <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                        <a href="#" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >이름 넣으면 됩니다.</a>
                    </div>
                    <!--해시태그 순위-->
                    <div class="list-group" >
                        <a href="#" class="list-group-item disabled" style="text-align: center;">해시태그 순위</a>
                        <a href="#" class="list-group-item"><p>1위</p><p style="color:cornflowerblue">#당근</p></a>
                        <a href="#" class="list-group-item"><p>2위</p><p style="color:cornflowerblue">#씨앗</p></a>
                        <a href="#" class="list-group-item"><p>3위</p><p style="color:cornflowerblue">#꿀팁</p></a>
                        <a href="#" class="list-group-item"><p>4위</p><p style="color:cornflowerblue">#날씨</p></a>
                </div>
                        
                    
               
            </div>
        </div>
    </div>
</body>
</html>