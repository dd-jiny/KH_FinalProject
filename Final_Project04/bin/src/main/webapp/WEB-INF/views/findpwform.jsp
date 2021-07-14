<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
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

	<h3>비밀번호 찾기</h3>
	
	<label>아이디</label>
	<input id="userid" type="text" placeholder="아이디를 입력해 주세요.">
	
	<div id="idresult"></div>
	
	<label>이메일</label>
	<input id="useremail" type="text" placeholder="이메일을 입력해 주세요." name="useremail">
	
	<div id="emailresult"></div>
	
	<button id="findemailBtn" type="button">이메일전송</button>
	
</body>
</html>