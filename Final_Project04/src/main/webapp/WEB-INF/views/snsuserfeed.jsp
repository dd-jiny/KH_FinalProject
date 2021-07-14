<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        
        
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>
	<c:if test="${empty login }">
		<div>로그인해주세요</div>
	</c:if>
	<!-- 로그인이 되었을때 -->
	<c:if test="${not empty login }">

		<div class="container" style="width: 100%;">
        <div class="row" style="padding-top:50px;">
<!--왼쪽 사이드-->
            <div class="col-sm-2 col-md-2 " id="left_side_bar" style="border-right:1px solid rgb(214, 214, 214); height: 100%;  ">
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
                        <li id="navbar-style" role="presentation" ><a href="index.jsp" id="li-color" style="color: black;"><span class="glyphicon glyphicon-home" aria-hidden="true"></span><span style="margin-left:20px" >home</span></a></li>
                        <!--나의 피드보기 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="snsBoardUserFeed.do?userId=${login.userid }" id="li-color" style="color: black;"><span class="glyphicon glyphicon-th" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">나의 피드 보기</span></a></li>
                        <!--글작성 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="snsBoardInsertForm.do" id="li-color" style="color: black;"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">글작성</span></a></li>
                        <!--마이페이지로 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="mypage.do?userid=${login.userid}" id="li-color" style="color: black;"><span class="glyphicon glyphicon-user" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">마이페이지</span></a></li>
                         <!-- 타임라인 -->
                        <li id="navbar-style" role="presentation" ><a href="main.do" id="li-color" style="color: black;"><span class="glyphicon glyphicon-time" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">타임라인</span></a></li>
                        <!--채팅-->
                        <li id="navbar-style" role="presentation" ><a href="#" id="li-color" style="color: black;"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">채팅</span></a></li>
                        <!--로컬마켓 가기-->
                        <li id="navbar-style" role="presentation" ><a href="usermarketplace.do" id="li-color" style="color: black;"><span class="glyphicon glyphicon-gift" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">로컬마켓 가기</span></a></li>
                        
                      </ul>
                        
                        
                </div>
                <div class="row">

                </div>
            </div>
            
            
<!--본문-->
            
                    <div class="col-sm-8 col-md-8 col-md-offset-2 " style="border:1px solid rgb(228, 228, 228);">
                        <div class="row" style="padding-bottom: 20px;">
                            <div class="col-md-12">
                                

                            </div>
                            <div class="col-md-8 col-md-offset-1" style="padding-top: 10px;">
                                <!--작성자 프로필 이미지-->
                                <img src="https://via.placeholder.com/50" class="img-circle"  alt="프로필 이미지"  > 
                                <!--프로필 수정 -->
                                <a href="#">${snsUserSelectOne.userid} </a>

                            </div>
                            
                            <c:if test="${snsUserSelectOne.userid == login.userid }">
                            <div class="col-md-3" >
                                <!-- 글쓰기 버튼 클릭시 글작성 화면으로 이동  -->
                        <button type="button" class="btn btn-warning btn-sm btn-block"  style="margin-top: 20px;" onclick="location.href='snsBoardInsertForm.do'">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><span style="padding-left:10px;">글작성 </span>
                        </button>
                            </div>
                            </c:if>
                        </div>
                        <div class="row">
                            
                            <div class="col-md-10 col-md-offset-1">
                                <!--글내용 작성 부분-->
                                <span>오늘도 힘차게 당근키우기,  
                                    초보 농부의 농부일지</span>
                            </div>
                        </div>
                        <br><br>
                        <div class="row">
                            
                            <div class="col-md-10 col-md-offset-1">
                                <!--해시태그 혹시 몰라서 넣어뒀습니다.. 만약 링크 걸어서이동 하고싶으면 첫번째꺼쓰고 ,링크 필요없으면 나머지 4개 같이 하면 됩니다.-->
                                <a href="#"><span style=" padding-right: 20px;">#냥냥</span></a>
                                <span style="color:cornflowerblue; padding-right: 20px;">#초보농부</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#농부일지</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#당근팜</span>
                                <span style="color:cornflowerblue; padding-right: 20px;">#텃밭가꾸기</span>
                            </div>
                        </div>
                         <div class="row">
                         <c:set var="i" value="0" />
                         <c:set var="j" value="4" />
                         <table>
                         	<c:choose>
                         		<c:when test="${empty snsUserFeedList }">
                         			<div>
                         				<h1>작성된 글이 없습니다.</h1>
                         			</div>
                         		</c:when>
                         		<c:otherwise>
                         			<c:forEach items="${snsUserFeedList }" var="dto">
                         				<c:if test="{i%j == 0}">
											<tr>
                         				</c:if>
											<td>
												<div class="col-sm-12 col-md-12 img-responsive" >
      												<a type="button" href="snsBoardOne.do?entireBoardSeq=${dto.entireBoardSeq }"> 	
      													<img src="${pageContext.request.contextPath}/resources${dto.boardThumbImg }" alt="내가 올린 이미지" id="img" style="padding:10px 10px 10px 10px; width:250px; height:250px;">
      												</a>
												</div>
											</td>
										<c:if test="${i%j == j-1 }">
											<tr>
										</c:if>
										<c:set var="i" value="${i+ 1}"/>
                               		</c:forEach>
                                </c:otherwise>
                            </c:choose>
                            
                            </table>
                            </div>
                    </div>
                    
               
<!--오른쪽 사이드-->
            <div class="col-sm-2 col-md-2 "  id="right_side_bar" style=" border-left:1px solid rgb(214, 214, 214); padding:0px 5px; ">
                <div class="col-md-12" style="margin-top:20px;">
            	       <a href="snsUserSearch.do"><button type="button" class="btn btn-warning btn-block" style="margin-bottom:20px;">유저 검색</button></a>
				</div>
                <div class="col-md-12" style="padding:0px 0px 0px 0px; ">
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
    
    
	</c:if>
	


</body>
</html>