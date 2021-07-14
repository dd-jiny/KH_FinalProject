<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 부트스트랩 css 사용 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<!-- daum 도로명주소 찾기 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- 리캡차 api -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<style type="text/css">
td {
	border: 1px solid #000000;
	border-collapse: collapse;
}
</style>




<script type="text/javascript"> 
	
//모든 공백 체크 정규식 
var empJ = /\s/g; 
//아이디 정규식 
var idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/; 
// 비밀번호 정규식 
var pwJ = /^[A-Za-z0-9]{4,12}$/; 
// 이름 정규식 
var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; 
// 이메일 검사 정규식 
var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 
// 휴대폰 번호 정규식 
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/; /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/ 
var birthJ = false; 
var address = $('#userdetailaddress'); 
$(document).ready(function() { 
	

	var address = $('#userdetailaddress'); 
	
	//아이디 중복확인 
	$("#userid").blur(function() { 
		if($('#userid').val()==''){ 
			$('#id_check').text('아이디를 입력하세요.'); 
			$('#id_check').css('color', 'red'); 
		} else if(idJ.test($('#userid').val())!=true){ 
			$('#id_check').text('4~12자의 영문, 숫자만 사용 가능합니다.'); 
			$('#id_check').css('color', 'red'); 
		} else if($('#userid').val()!=''){ 
			var userid=$('#userid').val();
			var data = {
					"userid" : userid
			}
			
			$.ajax({
				type : "post",
				data : JSON.stringify(data), 
				url : "idcheck.do", 
				dateType: 'json', 
				contentType: "application/json", 
				success : function(data) { 
					if(data.res > 0){ 
						$('#id_check').text('중복된 아이디 입니다.'); 
						$('#id_check').css('color', 'red'); 
						$("#usercheck").attr("disabled", true); 
					}else{ 
						if(idJ.test(userid)){ 
							$('#id_check').text('사용가능한 아이디 입니다.'); 
							$('#id_check').css('color', 'blue');
							$("#usercheck").attr("disabled", false); 
						} else if(userid==''){
							$('#id_check').text('아이디를 입력해주세요.'); 
							$('#id_check').css('color', 'red'); 
							$("#usercheck").attr("disabled", true);
						} else{ $('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다.");
						$('#id_check').css('color', 'red'); 
						$("#usercheck").attr("disabled", true); 
						} 
					}
				} 
				
					}); //ajax/// 
				}//else if
		});//blur 
		
		$('form').on('submit',function(){
			
			// 유효성 검사 배열 생성
			var inval_Arr = new Array(8).fill(false);
			
			
			if (idJ.test($('#userid').val())) {
				inval_Arr[0] = true; 
			} else { 
				inval_Arr[0] = false;
				alert('아이디를 확인하세요.'); 
				return false; 
			} 
			// 비밀번호가 같은 경우 && 비밀번호 정규식
			if (($('#password').val() == ($('#password2').val())) && pwJ.test($('#password').val())) {
				inval_Arr[1] = true;
			} else {
				inval_Arr[1] = false;
				alert('비밀번호를 확인하세요.'); 
				return false; 
			} 
			// 이름 정규식 
			if (nameJ.test($('#username').val())) { 
				inval_Arr[2] = true; 
			} else { 
				inval_Arr[2] = false;
				alert('이름을 확인하세요.');
				return false;
			} 
			// 생년월일 정규식
			if (birthJ) { 
				console.log(birthJ);
				inval_Arr[3] = true;
			} else { 
				inval_Arr[3] = false; 
				alert('생년월일을 확인하세요.'); 
				return false; 
			} 
			// 이메일 정규식
			if (mailJ.test($('#useremail').val())){
				console.log(phoneJ.test($('#useremail').val())); 
				inval_Arr[4] = true;
			} else { 
				inval_Arr[4] = false;
				alert('이메일을 확인하세요.');
				return false;
			} 
			// 휴대폰번호 정규식
			if (phoneJ.test($('#userphone').val())) { 
				console.log(phoneJ.test($('#userphone').val())); 
				inval_Arr[5] = true;
			} else {
				inval_Arr[5] = false;
				alert('휴대폰 번호를 확인하세요.'); 
				return false;
			} 
			
			//주소확인 
			if(address.val() == ''){ 
				inval_Arr[6] = false; 
				alert('주소를 확인하세요.'); 
				return false;
			} else {
				inval_Arr[6] = true;
			}
			
			
			// 모달 체크여부 확이하기
			var inlineCheckbox1 = $("#inlineCheckbox1").is(":checked");
			var inlineCheckbox2 = $("#inlineCheckbox2").is(":checked");
			
			if(inlineCheckbox1 === true && inlineCheckbox2 === true) {
				inval_Arr[7] = true
			} else {
				inval_Arr[7] = false;
				alert("필수 선택항목을 체크해 주세요.");
				return false;
			}
			console.log(inlineCheckbox1);
			
			//전체 유효성 검사 
			var validAll = true;
			for(var i = 0; i < inval_Arr.length; i++){ 
				if(inval_Arr[i] == false){ 
					validAll = false;
				}
			} 
			
			
			
			if(validAll == true && grecaptcha.getResponse()!=""){ 
				// 유효성 모두 통과
				alert('당근팜 회원이 되어 주셔서 감사합니다. 아이디로 로그인 해주세요'); 
				location.href="login.jsp";
			} else if(grecaptcha.getResponse() == null) { 
				alert('로봇인지 아닌지 확인해 주세요.');
				return false;
			} else {
				alert("입력하지 않은 정보가 있는지 확인해 주세요.");
				return false;
			}
		});
			
		
		$('#userid').blur(function() {
			if (idJ.test($('#userid').val())) { 
				console.log('true');
				$('#id_check').text(''); 
			} else { 
				console.log('false'); 
				$('#id_check').text('5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.');
				$('#id_check').css('color', 'red');
				}
			}); 
		
		$('#password').blur(function() { 
			if (pwJ.test($('#password').val())) { 
				console.log('true'); 
				$('#pw_check').text(''); 
			} else { 
				console.log('false'); 
				$('#pw_check').text('4~12자의 숫자 , 문자로만 사용 가능합니다.'); 
				$('#pw_check').css('color', 'red'); 
				} 
			});
		
		//1~2 패스워드 일치 확인 
		$('#password2').blur(function() { 
			if ($('#password').val() != $(this).val()) { 
				$('#pw2_check').text('비밀번호가 일치하지 않습니다.'); 
				$('#pw2_check').css('color', 'red'); 
			} else { 
				$('#pw2_check').text('');
				} 
			}); 
		//이름에 특수문자 들어가지 않도록 설정
		$("#username").blur(function() { 
			if (nameJ.test($(this).val())) {
				console.log(nameJ.test($(this).val())); 
				$("#name_check").text(''); 
			} else { 
				$('#name_check').text('한글 2~4자 이내로 입력하세요. (특수기호, 공백 사용 불가)');
				$('#name_check').css('color', 'red'); 
				} 
			});
		
		$("#useremail").blur(function() { 
			if (mailJ.test($(this).val())) {
				$("#email_check").text('');
			} else { 
				$('#email_check').text('이메일 양식을 확인해주세요.'); 
				$('#email_check').css('color', 'red'); 
				} 
			}); 
			
		// 생일 유효성 검사 
		var birthJ = false;
		 
		// 생년월일 birthJ 유효성 검사
		$('#userbirthday').blur(function(){
			var dateStr = $(this).val(); 
			var year = Number(dateStr.substr(0,4)); 
			// 입력한 값의 0~4자리까지 (연) 
			var month = Number(dateStr.substr(4,2)); 
			// 입력한 값의 4번째 자리부터 2자리 숫자 (월)
			var day = Number(dateStr.substr(6,2));
			// 입력한 값 6번째 자리부터 2자리 숫자 (일) 
			var today = new Date(); 
			// 날짜 변수 선언 
			var yearNow = today.getFullYear(); 
			// 올해 연도 가져옴 
			if (dateStr.length <=8) { 
				// 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다. 
				if (year > yearNow || year < 1900 ){ 
					$('#birth_check').text('생년월일을 확인해주세요'); 
					$('#birth_check').css('color', 'red'); 
				} else if (month < 1 || month > 12) { 
					$('#birth_check').text('생년월일을 확인해주세요 '); 
					$('#birth_check').css('color', 'red');
				} else if (day < 1 || day > 31) { 
					$('#birth_check').text('생년월일을 확인해주세요 '); 
					$('#birth_check').css('color', 'red');
				} else if ((month==4 || month==6 || month==9 || month==11) && day==31) {
					$('#birth_check').text('생년월일을 확인해주세요 '); 
					$('#birth_check').css('color', 'red'); 
				} else if (month == 2) { 
					var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
					if (day>29 || (day==29 && !isleap)) {
						$('#birth_check').text('생년월일을 확인해주세요 '); 
						$('#birth_check').css('color', 'red');
					} else{ 
						$('#birth_check').text('');
						birthJ = true; 
					} 
				} else {
					$('#birth_check').text('');
					birthJ = true;
				} //end of if 
			} else { 
				//1.입력된 생년월일이 8자 초과할때 : auth:false
				$('#birth_check').text('생년월일을 확인해주세요 '); 
				$('#birth_check').css('color', 'red'); 
				} 
			}); //End of method /* 
			
		// 휴대전화 
		$('#userphone').blur(function(){ 
			if(phoneJ.test($(this).val())){ 
				console.log(nameJ.test($(this).val())); 
				$("#phone_check").text(''); 
			} else { 
				$('#phone_check').text('휴대폰번호를 확인해주세요 '); 
				$('#phone_check').css('color', 'red'); 
			} 
		}); 
			
	}); 
	
	//우편번호 찾기 버튼 클릭시 발생 이벤트
	function execPostCode() {
		new daum.Postcode({ oncomplete: function(data) { 
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 
			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullRoadAddr = data.roadAddress; 
			// 도로명 주소 변수
			var extraRoadAddr = ''; 
			// 도로명 조합형 주소 변수 
			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다. 
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname; 
			} 
			// 건물명이 있고, 공동주택일 경우 추가한다. 
			if(data.buildingName !== '' && data.apartment === 'Y'){ 
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다. 
			if(extraRoadAddr !== ''){ 
				extraRoadAddr = ' (' + extraRoadAddr + ')'; 
			} 
			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			if(fullRoadAddr !== ''){ 
				fullRoadAddr += extraRoadAddr;
			} 
			// 우편번호와 주소 정보를 해당 필드에 넣는다. 
			console.log(data.zonecode); 
			console.log(fullRoadAddr); 
			
		
			$("[name=useroaddress]").val(data.zonecode); 
			$("[name=useraddress]").val(fullRoadAddr);
			document.getElementById('useroaddress').value = data.zonecode; //5자리 새우편번호 사용 
			document.getElementById('useraddress').value = fullRoadAddr;
			document.getElementById('userdetailaddress').value = data.jibunAddress; 
			}
		}).open();
		} 
	</script>
</head>
<body>
		<!-- 페이지 상단  -->
		<div class="container" style="width: 100%;">
			<div class="row" >
		            <div class="col-md-12" >
		                <nav class="navbar navbar-default navbar-fixed-top">
		                    <div class="container-fluid">
		                      <!-- Brand and toggle get grouped for better mobile display -->
		                      <div class="navbar-header">
		                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
		                          <span class="sr-only">Toggle navigation</span>
		                          <span class="icon-bar"></span>
		                          <span class="icon-bar"></span>
		                          <span class="icon-bar"></span>
		                        </button>
		                        <a class="navbar-brand" href="#" style="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px"><img src="resources/image/당근팜_로고_2.png" alt="logo" style="width: 100px; height:50px; "></a>
		                      </div>
		                  
		                      <!-- Collect the nav links, forms, and other content for toggling -->
		                      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		                       
		                        <ul class="nav navbar-nav navbar-right">
		                            <li><a href="#"title="로그인 페이지 이동"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span></a></li>
		                            <li><a href="#" title="메인 페이지 이동"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a></li>
		                        </ul>
		                      </div><!-- /.navbar-collapse -->
		                    </div><!-- /.container-fluid -->
		                  </nav>
		            </div>
		        </div>
	       	</div>
	      
	       	
	       	
	       	
	       
        <article class="container">
		<div class="page-header">
			<div class="col-md-6 col-md-offset-3">
				<h3>회원가입</h3>
			</div>
		</div>
		<div class="col-sm-6 col-md-offset-3">
		<div class="form-group ">
               <h5 style="margin:0px 0px"><b>이용약관 동의</b>
               <!-- Button trigger modal -->
               <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#myModal">
                   <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
               </button>
               
               <!-- Modal -->
               <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                 <div class="modal-dialog">
                   <div class="modal-content">
                     <div class="modal-header">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                       <h3 class="modal-title" id="myModalLabel">약관 동의</h3>
                       
                     </div>
                     <div class="modal-body">
                       <h4>당근팜 이용약관 동의(필수)</h4>
                       <p>여러분을 환영합니다.당근팜 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 당근팜 서비스의 이용과 관련하여 당근팜 서비스를 제공하는 당근팜 주식회사(이하 ‘당근팜’)와 이를 이용하는 당근팜 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 당근팜 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</p>
                       <hr>
                       <h4>개인정보 수집 및 이용 동의(필수)</h4>
                       <p>개인정보보호법에 따라 당근팜에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.</p>
                       <hr>
                       <h4>위치정보 이용약관 동의(선택)</h4>
                       <p>위치정보 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 당근팜 위치기반 서비스를 이용할 수 있습니다.</p>
                       <hr>
                       <h4>프로모션 정보 수신 동의(선택)</h4>
                       <p>당근팜에서 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화, 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 당근팜 가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.</p>
                       
                     </div>
                     <div class="modal-footer">
                       <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                       <button type="button" class="btn btn-primary">Save changes</button>
                     </div>
                   </div>
                 </div>
               </div>
               </h5>
               
               <label class="checkbox-inline" >
                 <input type="checkbox" id="inlineCheckbox1" value="option1" style="margin:40 0 0 0"> 당근팜 이용 약관 동의(필수)
                    
               </label>
               <label class="checkbox-inline" >
                 <input type="checkbox" id="inlineCheckbox2" value="option2"> 개인정보 수집 및 이용 동의(필수)
               </label>
               <label class="checkbox-inline" style="margin:0px 0px 0px 0px">
                 <input type="checkbox" id="inlineCheckbox3" value="option3"> 위치정보 이용약관 동의(선택)
               </label>
               <label class="checkbox-inline" style="margin:0px 0px 0px 0px">
                 <input type="checkbox" id="inlineCheckbox3" value="option3"> 프로모션 정보 수신 동의(선택)
               </label>
            </div>
			<form action="registPost.do" method="post" role="form" id="usercheck" name="member">
				<div class="form-group">
					<label for="id">아이디</label> <input type="text" class="form-control"
						id="userid" name="userid" placeholder="ID">
					<div class="eheck_font" id="id_check"></div>
				</div>
				<div class="form-group">
					<label for="pw">비밀번호</label> <input type="password"
						class="form-control" id="password" name="password"
						placeholder="PASSWORD">
					<div class="eheck_font" id="pw_check"></div>
				</div>
				<div class="form-group">
					<label for="pw2">비밀번호 확인</label> <input type="password"
						class="form-control" id="password2" name="password2"
						placeholder="Confirm Password">
					<div class="eheck_font" id="pw2_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_name">이름</label> <input type="text"
						class="form-control" id="username" name="username"
						placeholder="Name">
					<div class="eheck_font" id="name_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_birth">생년월일</label> <input type="tel"
						class="form-control" id="userbirthday" name="userbirthday"
						placeholder="ex) 19990101">
					<div class="eheck_font" id="birth_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_email">이메일 주소</label> <input type="email"
						class="form-control" id="useremail" name="useremail"
						placeholder="E-mail">
					<div class="eheck_font" id="email_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label> <input
						type="tel" class="form-control" id="userphone" name="userphone"
						placeholder="Phone Number">
					<div class="eheck_font" id="phone_check"></div>
				</div>
				<div class="form-group">
					<input class="form-control" style="width: 40%; display: inline;"
						placeholder="우편번호" name="useroaddress" id="useroaddress"
						type="text" readonly="readonly">
					<button type="button" class="btn btn-default"
						onclick="execPostCode();">
						<i class="fa fa-search"></i> 우편번호 찾기
					</button>
				</div>
				<div class="form-group">
					<input class="form-control" style="top: 5px;" placeholder="도로명 주소"
						name="useraddress" id="useraddress" type="text"
						readonly="readonly" />
				</div>
				<div class="form-group">
					<input class="form-control" placeholder="상세주소"
						name="userdetailaddress" id="userdetailaddress" type="text" />
				</div>
				<div class="g-recaptcha" id="recaptcha"
					data-sitekey="6LfJBFIbAAAAAPyFCgWwMz3xEFvaBdABdZtEdjMD" style="padding:0px 0px 0px 100px" >
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-primary">회원가입</button>
				</div>
				
			</form>
		</div>
	</div>
	</article>
</body>