<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
       
        
        #fn{
            font-size: 2rem; 
            border-color: rgb(241, 241, 241); 
            background: linear-gradient(#f1f1f1 0%, #ffffff 2px,  #eeeeee 100%);
        }
        #li-color{
            color:rgb(77, 75, 75);
        }
        
    </style>
    
    <style>
        #insert-form-group{
        margin-bottom: 30px;
  		  }
   		 #customFile{
        margin-bottom: 30px;
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
    </style>

<!-- style -->
	<style>
	#image_container img{
		height: 500px;
		width: 500px;
		
	}
	</style>
	
</head>
<body>
	<%@include file="/WEB-INF/views/1header.jsp"%>
	
	
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
                    <div class="col-md-4"><img src="./resources/image/userdefaultimg.png" class="img-responsive img-circle"  alt="프로필 이미지" style="margin:20px 10px 20px 10px; " ></div>
                    
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
                        <li id="navbar-style" role="presentation" ><a href="#" id="li-color"><span class="glyphicon glyphicon-user" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">마이페이지</span></a></li>
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
<!-- 본문-->
            <div class="col-sm-8 col-md-8 col-sm-offset-2 col-md-offset-2" style="border:1px solid rgb(228, 228, 228);">

                <!--폼태그 시작~-->
                <form action="snsBoardInsertRes.do" method="post" enctype="multipart/form-data">
                    <!--id-->
                    <div class="form-group">
                        <label for="text" class="col-sm-2 control-label">ID</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" name="userId" readonly value="${login.userid }" id="insert-form-group">
                          <input type="hidden" name="userSeq" readonly value="${login.userseq }"/>	
                        </div>
                      </div>
                      <!--사진업로드-->
                      <div class="form-group">
                        <div class="custom-file">
                            <label for="image" class="col-sm-2 control-label custom-file-label" for="customFile">사진 업로드</label>
                            <div class="col-sm-10">
                            <input type="file" name="file" accept="image/*1" id="boardImg" onchange="setThumbnail(event);" class="form-control custom-file-input" id="customFile" >
                            </div>
                        </div>
                      </div>
                      <!--이미지 미리보기 -->
                      <div class="form-group" >
                            <label for="image" class="col-sm-2 control-label">이미지 미리보기</label>
                            <div class="col-sm-10" id="image_container" style="text-align:center;">
                            	<img style="width: 500px; height:500px;  " id="preview-image" src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image">
                            </div>
                      </div>

                      <!--게시글-->
                      <div class="form-group">
                          <label for="text" class="col-sm-2 control-label" >게시글</label>
                          <div class="col-sm-10">
                              <textarea class="form-control" rows="10" id="insert-form-group" name="boardContents"  placeholder="n자 이내로 입력 가능합니다. "></textarea>
                          </div>
                        </div>
                        <!--#해시태그-->
                        <div class="form-group">
                          <label for="text" class="col-sm-2 control-label">hashtag#</label>
                          <div class="col-sm-2">
                              <input type="text" class="form-control" placeholder="#">
                          </div>
                          <div class="col-sm-2">
                              <input type="text" class="form-control" placeholder="#">
                            </div>
                            <div class="col-sm-2">
                              <input type="text" class="form-control" placeholder="#">
                            </div>
                            <div class="col-sm-2">
                              <input type="text" class="form-control" placeholder="#">
                            </div>
                            <div class="col-sm-2">
                              <input type="text" class="form-control" placeholder="#" id="insert-form-group">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="button" class="col-sm-2 control-label"></label>
                            <div class="col-sm-2 col-sm-offset-8">
                                <button type="submit" class="btn btn-warning btn-block" style="margin-bottom:100px;"  >글작성 </button>
                            </div>
                            
                          </div>
                        
                  </form>
            </div>
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
    </div>    
    
		
	<script>
	
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        const reader = new FileReader()
	        // 이미지가 로드가 된 경우
	        reader.onload = e => {
	            const previewImage = document.getElementById("preview-image")
	            previewImage.src = e.target.result
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0])
	    }
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("boardImg")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	})

	/*
	//이미지 미리보기 함수 
		function setThumbnail(event) {
			var reader = new FileReader();
			
			//onload됐을시에 발생할 이벤트 작성 
			reader.onload = function(event) {
				//FileReader가 로드 됐을 때 img 엘리먼트 생성하고 src 속성을 설정 
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				//이미지가 들어갈 div에 넣어주기 
				document.querySelector("div#image_container").appendChild(img);
			};
			
			//리더에서 input 태그에서 선택한 파일을 읽어오도록 설정 
			reader.readAsDataURL(event.target.files[0]);
		} 
	
	
		//end setTumbnail 
		/*
		//첨부파일 영역 선택자 
		var uploadFileDiv = $(".uploadFileDiv").clone();
		
		//첨부파일 이벤트 처리 : 파일 업로드 처리 -> 파일 출력
		$("#uploadBtn").on("click", function(e){
			var formData = new FormData();
			var inputFile = $("input[name=uploadFile]");
			var files = inputFile[0].files;
			
			formData.append("uploadFile", files);
			
			ajaxUploadFile(formData);			
		});
		*/
		/* 
		//첨부파일 이벤트 처리 : 파일 업로드 처리 -> 파일 출력	
		uploadDiv.on("drop", function (event){
			//click 이벤트 발생시 전달된 파일 데이터 
			var files = event.originalEvent.dataTransfer.files;
			console.log("files : " , files);
			//단일 파일 데이터만을 처리하기 때문에 첫번째 파일만 저장
			var file = files[0];
			console.log("file : " , file);
			//formData 객체 생성 , 파일 데이터 저장 
			var formData = new FormData();
			formData.append("file", file);
			//파일 업로드 AJAX 통신 메서드 호출 
			uploadFile(formData);
		});
		*/
		
		/*
		function ajaxUploadFile(formData) {
			$.ajax({
				url:"upload",
				data: formData,
				dataType: "text",
		        // processData : 데이터를 일반적인 query string으로 변환처리할 것인지 결정
		        // 기본값은 true, application/x-www-form-urlencoded 타입
		        // 자동변환 처리하지 않기 위해 false
		        processData: false,
		     	// contentType : 기본값은 true, application/x-www-form-urlencoded 타입
		        // multipart/form-data 방식으로 전송하기 위해 false
		        contentType: false,
		        type: "POST",
		        success: function (data) {
		        	printFiles(data); //첨부파일 출력 메서드 호출
		        	$(".noAttach").remove();
		        }
				
			});
		}
		*/
		
	</script>
	


</body>

</html>


















