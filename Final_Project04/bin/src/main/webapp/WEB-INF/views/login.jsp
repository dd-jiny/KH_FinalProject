<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 네이버 로그인 -->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>

<!-- 구글 로그인 api-->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id"
	content="526188882166-3g6n3ua4795hsb0p3889lhg7f90hcfta.apps.googleusercontent.com">

<!-- 카카오 로그인 api -->
<script type="text/javascript"
	src="https://developers.kakao.com/sdk/js/kakao.js"></script>


<title>로그인 페이지</title>

<style type="text/css">
* {
	padding: 1px;
	margin: 1px;
	width: auto;
	align-content: center;
}

header {
	height: 30%
}

#body {
	margin-top: 150px;
	height: 600px;
	background-color: #E9E9E9;
	border: 1px solid #CFCECE;
}
</style>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script type="text/javascript">
$(function() {
	$("#loginChk").hide();
});

function login() {
	var userid = $("#inputEmail3").val().trim();
	var password = $("#inputPassword3").val().trim();

	// 자바스크립트 오브젝트 리터럴 형태 뭔지 찾아보자.
	var loginVal = {
		"userid" : userid,
		"password" : password
	}
	if (userid == null || userid == "" || password == null
			|| password == "") {
		alert("ID 및 PW를 다시 확인해 주세요!");
	} else {
		$.ajax({
			type : "post",
			url : "ajaxlogin.do",
			data : JSON.stringify(loginVal), 
			contentType : "application/json",
			dataType : "json",
			success : function(msg) {
				if (msg.check == true) {
					alert("반갑습니다.");
					location.href="index.jsp";
					redirect:"header.jsp";
				} else {
					$("#loginChk").show();
					$("#loginChk").html("ID 혹은 PW가 잘못되었습니다.");
				}
			},
			error : function() {
				alert("통신 실패");
			}
		});
	}

}
function kakaoLogin() {
	Kakao.Auth.login({
		success : function(response) {
			Kakao.API.request({
				url : '/v2/user/me',
				success : function(response) {
					kakaoLoginPro(response)
				},
				fail : function(error) {
					console.log(error)
				},
			})
		},
		fail : function(error) {
			console.log(error)
		},
	})
}

function onSignIn(googleUser) {
	var profile = googleUser.getBasicProfile();
	console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	console.log('Name: ' + profile.getName());
	console.log('Image URL: ' + profile.getImageUrl());
	console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
	var userid = profile.getId();
	var username = profile.getName();
	var useremail = profile.getEmail();

	var googleVal = {
		"userid" : userid,
		"username" : username,
		"useremail" : useremail
	}

	$.ajax({
		type : "post",
		url : "googlelogin.do",
		data : JSON.stringify(googleVal),
		contentType : "application/json",
		dataType : "json",
		success : function(msg) {
			alert(msg.username + "님 환영합니다.");
		},
		error : function() {
			alert("통신 실패");
		}
	});

}

function logOut() {
	var auth2 = gapi.auth2.getAuthInstance();
	if (auth2 != null) {
		auth2.signOut().then(function() {
			console.log('로그아웃 되었습니다.');
			alert("로그아웃 되었습니다.");
			location.href = "logOut.do";
		});
	}
	
	if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        	alert("로그아웃 되었습니다.");
	        	location.href = "logOut.do";
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
}



Kakao.init('1e4c72d72b9614055f4d89bb5623539d');
Kakao.isInitialized();

//카카오 로그인 부분
function kakaoLogin() {
	Kakao.Auth.login({
	      success: function (response) {
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function (response) {
	        	  console.log(response);
	        	  var userid = response.id;
	        	  var useremail = response.kakao_account.email;
	        	  var username = response.properties.nickname;
	        	  
	        	  var kakaologinVal = {
	        			"userid" : userid,
	        			"useremail" : useremail,
	        			"username" : username
	        	  };
	        	  
	        	  if(userid == null || userid == "") {
	        		  alert("아이디 비밀번호를 확인해 주세요.");
	        	  } else {
	        	  $.ajax({
	        		type:"post",
	        		url:"kakaologincallback.do",
	        		data:JSON.stringify(kakaologinVal),
	        		contentType:"application/json",
	        		dataType:"json",
	        		success:function(msg) {
	        			if(msg.username != null) {
	        				alert(msg.username+"님 환영합니다.");
	        				location.href="index.jsp";
	        			} else {
	        				alert("로그인에 실패하였습니다.");
	        				return false;
	        			}
	        		},
	        		error : function() {
	        			alert("통신 실패");
	        			return false;
	        		}
	        	  });
	        	 }
	        	  
	          },
	          fail: function (error) {
	            console.log(error)
	          },
	        })
	      },
	      fail: function (error) {
	        console.log(error)
	      },
	    })
}

</script>
</head>
<body>


	<div class="container ">
	<div class="row">

		<div class="col-md-5 col-md-offset-7 text-center" id="body">
			<div class="row">
				<div class="col-md-8 col-md-offset-2 ">
					<img src="resources/image/logo-banner.png" class="img-responsive"
						alt="Responsive image">


					<div class="form-group">

						<div class="col-sm-12">
							<input type="text" class="form-control" id="inputEmail3"
								placeholder="아이디를 입력하세요">
						</div>
						<div align="center" id="loginChk" style="color: red;"></div>
					</div>
					<div class="form-group">

						<div class="col-sm-12">
							<input type="password" class="form-control" id="inputPassword3"
								placeholder="비밀번호를 입력하세요">
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-12">
							<br />
							<button onclick="login();" type="button"
								class="btn btn-info btn-block">로그인</button>
						</div>
						<br /> <br /> <br /> <br />
						<p>
							계정이 없으신가요?
							<button onclick="location.href='registform.do'" type="button"
								class="btn btn-link">회원가입</button>
						</p>
						<a href="findidform.do"><button type="button"
								class="btn btn-link">아이디 찾기</button></a> <a href="findpwform.do"><button
								type="button" class="btn btn-link">비밀번호 찾기</button></a> <br> <br>
						<div class="loginform" style="align-content: center;">
							<a href="javascript:kakaoLogin();"><img
								src="resources/image/kakaolog.png" alt="Kakao image"
								style="height: inherit; width: inherit; margin-right: 10px;"></a>
							<br>
							<form class="form-horizontal" action="naverlogin.do">
								<a href="${naverUrl }"><img
									src="resources/image/naverlog.png" alt="Naver image"
									style="height: 35%; width: 30%; margin-right: 10px;"></a>
							</form>
							<div id="googleBtn" class="g-signin2" data-onsuccess="onSignIn"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

</div>

</body>
</html>

