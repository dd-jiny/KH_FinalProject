<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
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
<script>
// 이메일 정규식
var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 아이디 정규식
var idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/; 

	$(document).ready(function(){
		
		$("#emailresult").hide();
		$("#idresult").hide();
		
		$("#findemailBtn").click(function(){
			
			var useremail = $("#useremail").val().trim();
			
			var userid = $("#userid").val().trim();
			
			var findpwVal = {
					"useremail" : useremail,
					"userid" : userid
			}
			
			if(mailJ.test(useremail) && idJ.test(userid) && useremail != null && useremail != '' && userid != null && userid != '') {
				
				$.ajax({
					type:"post",
					url:"findpw.do",
					data: JSON.stringify(findpwVal),
					contentType: "application/json",
					dataType:"json",
					success:function(result) {
						switch (result) {
						case 1:
							alert("가입된 아이디가 없습니다. 아이디를 확인해 주세요.");
							return false;
							break;
						case 2:
							alert("가입된 이메일이 없습니다. 이메일을 확인해 주세요.")
							return false;
							break;
						default:
							alert("가입된 이메일로 임시 비밀번호를 전송하였습니다. 메일을 확인해주세요.");
							break;
						}
					},
					error:function() {
						alert("이메일 전송에 실패하였습니다.");
						return false;
					}
					
					
				});
				
				
			} else if(idJ.test(userid) == false || userid == null || userid == '') {
				alert("아이디를 확인해 주세요.");
				$("#idresult").show();
				$("#userid").focus();
				$("#idresult").html("아이디 입력을 확인해 주세요.").css("color", "red");
				return false;
		
			} else if(mailJ.test(useremail) == false || useremail == null || useremail == '') {
				alert("이메일 입력을 확인해 주세요.");
				$("#useremail").focus();
				$("#emailresult").show();
				$("#emailresult").html("이메일 입력을 확인해 주세요.").css("color", "red");
				return false;
			} 
		});
		
	});
	

	
	

</script>
<body>
    <%@include file="/WEB-INF/views/1header.jsp"%>
    <!-- 페이지 상단  -->
	<div class="container" style="width: 100%;">
		<div class="row" >
            
                
            </div>
            <div class="col-sm-4 col-md-offset-4">
                <h3 style="padding-top:200px ;">아이디 찾기</h3>
                <div class="form-group">
                    <label for="mem_email">ID</label> 
                    <input type="text" class="form-control" id="userid" name="userid" placeholder="아이디를 입력해주세요" style="margin-top:10px; margin-bottom:10px;">
                    <div id="idresult"></div>
                    <label for="mem_email">이메일 주소</label> 
                    <input type="email" class="form-control" id="useremail" name="useremail" placeholder="이메일을 입력해주세요 ex)phoenix@carrot.com" style="margin-top:10px; margin-bottom:10px ;">
                    <div id="emailresult"></div>
                    <div class="row" style="padding-top:20px ;">
                        <div class="col-md-6">
                            <button id="findemailBtn" type="button" class="btn btn-warning btn-block">이메일로 전송</button>
                        </div>
                        <div class="col-md-6">
                            <button type="button" class="btn btn-default btn-block">취소</button>
                        </div>
                    </div>
                </div>
            
      
    
	       
	    </div>
	</div>

   
       

    <%@include file="/WEB-INF/views/1footer.jsp"%>
            
</body>
</html>