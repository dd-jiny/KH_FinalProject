<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<link rel="shortcut icon" type="image/x-icon" href="img/carrot.png">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
#insert-form-group{
	margin-bottom: 30px;
    }
#customFile{
	margin-bottom: 30px;
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

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#searchBtn").click(function(){
		var selectBox = $("#selectBox option:selected").val();
		var searchVal = document.getElementById("searchVal").value;
		
		if(selectBox == "" || selectBox == null) {
			alert("카테고리를 선택해 주세요!");
			$("#searchVal").focus();
			
		} else if(selectBox === "userid") {
			
			var useridVal = {
					"userid" : searchVal
			}
			
			$.ajax({
				type: "post",
				url: "searchUser.do",
				data: JSON.stringify(useridVal),
				contentType: "application/json",
				dataType:"json",
				success: function(data) {
					console.log(data)
					//console.log(data.list.length);
					//console.log(data.list[0].userid);
					var html = "<div class='list-group'>";
					for(var i = 0; i < data.userList.length; i++) {
						html += "<div><a class='list-group-item' href='snsBoardUserFeed.do?userId="+data.userList[i].userid+"'>"+"<img src='https://via.placeholder.com/40' class='img-circle'  alt='' style='margin-right:10px;'>"+data.userList[i].userid+"</a></div>";
						html += "</div><br>";
					}
					
					$("#dynamicTbody").empty();
					$("#dynamicTbody").append(html);
				}
			});
			
		} else if(selectBox === "username") {
			
			var usernameVal = {
					"username" : searchVal
			}
			
			$.ajax({
				type: "post",
				url: "searchUser.do",
				data: JSON.stringify(usernameVal),
				contentType: "application/json",
				dataType:"json",
				success: function(data) {
					
					var html = "<div class='list-group'>";
					for(var i = 0; i < data.userList.length; i++) {
						html += "<div><a class='list-group-item' href='snsBoardUserFeed.do?userId="+data.userList[i].userid+"'>"+"<img src='https://via.placeholder.com/40' class='img-circle'  alt='' style='margin-right:10px;'>"+data.userList[i].username+"</a></div>";
						html += "</div><br>";
					}
					
					html += "</tr><br>";
					$("#dynamicTbody").empty();
					$("#dynamicTbody").append(html);
				}
			});
		}
	});
});
	
</script>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>

    <div class="container" style="width: 100%;">
        <div class="row" style="padding-top:80px;">
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
                        <li id="navbar-style" role="presentation" ><a href="index.jsp" id="li-color" style="color: black;"><span class="glyphicon glyphicon-home" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">home</span></a></li>
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
<!-- 본문-->
            <div class="col-sm-8 col-md-8 " style="border:1px solid rgb(228, 228, 228);">

               <div class="row">
                
                <div class="col-md-8 col-md-offset-2" style="padding-right:0px; padding-bottom:20px;">
						<div id="styled-select">
                             <select name="group" id="selectBox">
                                   <option value="">선택</option>
                                   <option value="userid">아이디</option>
                                   <option value="username">이름</option>
                              </select>
                        </div>
                    <!--검색창-->
                    <input type="text" class="form-control" id="searchVal" placeholder="ID를 입력하세요" >
                </div>
                <div class="col-md-2" style="padding-left:0px;">
                    <!--검색버튼-->
                    <button type="button" id="searchBtn" class="btn btn-default" ><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                </div>
               </div>
         <a href="#" class="list-group-item disabled" style="text-align: center;">유저 검색 목록 </a> 
         <c:forEach items="${userList}" var="userdto">
            <div id="dynamicTbody">
               <div class="row">
                   <div class="col-md-12">
                        <div class="list-group" >
                            
                            <a href="snsBoardUserFeed.do?userId=${userdto.userid }" class="list-group-item"><img src="https://via.placeholder.com/40" class="img-circle"  alt="" style="margin-right:10px;" >${userdto.userid }</a>
                        	<a href="snsBoardUserFeed.do?userId=${userdto.userid }" class="list-group-item">${userdto.username }</a>
                        </div>
                   </div>
               </div>
             </div>
            </c:forEach>
        
            </div>
            
<!--오른쪽 사이드-->
            <div class="col-sm-2 col-md-2 "  id="right_side_bar" style=" border-left:1px solid rgb(214, 214, 214); padding:0px 5px; ">
            	                
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
    </div>    

</body>
</html>