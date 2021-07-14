<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>아이디 찾기</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#findidresult").hide();
	});
	
	function findid() {
		var useremail = $("#useremail").val().trim();
		
		var findVal = {
				"useremail" : useremail
		}
		
		
		if(useremail == null || useremail == "") {
			alert("email을 입력해 주세요");
			
		} else {
			$.ajax({
				type:"post",
				url:"ajaxfindid.do",
				data:JSON.stringify(findVal),
				contentType:"application/json",
				dataType:"json",
				success:function(msg) {
					if(msg.userid != null) {
						$("#findidresult").show();
						$("#findidresult").html(msg.userid);
						$("#cancelBtn").html("login하러가기")
					} else {
						$("#findidresult").show();
						$("#findidresult").html("일치하는 이메일이 존재하지 않습니다.").css("color", "red");
					}
				},
				error:function() {
					alert("통신 실패");
				}
			});
		}
		
	}
	

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
                    <label for="mem_email">이메일 주소</label> <input type="email"
                        class="form-control" id="useremail" name="useremail"
                        placeholder="이메일을 입력해주세요 ex)phoenix@carrot.com" style="margin-top:10px ;">
                    <div id="findidresult"></div>
                    <div class="row" style="padding-top:20px ;">
                        <div class="col-md-6">
                            <button type="button" class="btn btn-warning btn-block" onclick="findid();">찾기</button>
                        </div>
                        <div class="col-md-6">
                            <button type="button" class="btn btn-default btn-block" id="cancelBtn" onclick="history.go(-1)">취소</button>
                        </div>
                    </div>
                </div>
            
      
    
	       
	    </div>
	</div>
	<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>













