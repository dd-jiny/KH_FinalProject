<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>채팅</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
<!--<script type="text/javascript" src="https://cdn.jsdeliver.net/sockjs/1/sockjs.min.js"></script> -->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Tinos:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&amp;display=swap"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<style>


.inbox_people {
	background: #f8f8f8 none repeat scroll 0 0;
	float: left;
	overflow: hidden;
	width: 40%;
	border-right: 1px solid #c4c4c4;
}

.inbox_msg {
	border: 1px solid #c4c4c4;
	clear: both;
	overflow: hidden;
}

.received_msg {
	display: inline-block;
	padding: 0 0 0 10px;
	vertical-align: top;
	width: 90%;
}

.received_withd_msg p {
	background: #fad7a9 none repeat scroll 0 0;
	border-radius: 3px;
	color: #646464;
	font-size: 14px;
	margin: 0;
	padding: 5px 10px 5px 12px;
	width: 100%;
}

.time_date {
	color: #747474;
	display: block;
	font-size: 12px;
	margin: 8px 0 0;
}

.received_withd_msg {
	width: 57%;
}

.mesgs {
	float: left;
	padding: 30px 15px 0 25px;
	width: 97%;
	height: 95%;
}

.sent_msg p {
	background: #f7a65b none repeat scroll 0 0;
	border-radius: 3px;
	font-size: 14px;
	margin: 0;
	color: #fff;
	padding: 5px 10px 5px 12px;
	width: 100%;
}

.outgoing_msg {
	overflow: hidden;
	margin: 26px 0 26px;
}

.sent_msg {
	float: right;
	width: 46%;
}

.input_msg_write input {
	background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
	border: medium none;
	color: #4c4c4c;
	font-size: 15px;
	min-height: 48px;
	width: 100%;
}

.type_msg {
	border-top: 1px solid #c4c4c4;
	position: relative;
}

.msg_send_btn {
	background: #05728f none repeat scroll 0 0;
	border: medium none;
	border-radius: 50%;
	color: #fff;
	cursor: pointer;
	font-size: 17px;
	height: 33px;
	position: absolute;
	right: 0;
	top: 11px;
	width: 33px;
}

.messaging {
	padding: 0 0 50px 0;
	height: 95%;
}

.msg_history {
	height: 516px;
	width: 100%;
	overflow-y: auto;
}

#title {
	margin-bottom: 0px;
}

#title-id {
	margin-top: 0px;
	margin-bottom: 5px;
}

#ididid {
	padding: 0px 0px 0px 20px;
	margin-bottom: 5px;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>
	<div class="container" style="padding-top:60px;">
		<h3 class=" text-center" id="title">제품명:${productName }</h3>
		<p id="title-id">
			<small>상대방 아이디:${sellerId }</small>
		</p>
		<div class="messaging">
			<div class="inbox_msg">
				<div class="mesgs">
			<c:choose>
				<c:when test="${empty messageList }">
					<div class="msg_history">
						<div class="incoming_msg">
							<p id="ididid">
								<small>운영자</small>
							</p>
							<div class="received_msg">
								<div class="received_withd_msg">
									<p>
										채팅방에 입장하였습니다. 대화를 시작해 보세요.
										욕설과 비속어 사용은 금지입니다.
									</p>
									<!--  <span class="time_date"></span>-->
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${messageList }" var="messageDto">
						<div class="msg_history">
						<c:if test="${messageDto.message_sender != login.userid  }">
						<div class="incoming_msg">
							<p id="ididid">
								<small>${messageDto.message_sender }</small>
							</p>
							<div class="received_msg">
								<div class="received_withd_msg">
									
									<!--  <span class="time_date">${messageDto.message_regdate }</span>-->
								</div>
							</div>
						</div>
						</c:if>
						<c:if test="${messageDto.message_sender == login.userid }">
						<div class="outgoing_msg">
							<div class="sent_msg" id="addMessage">
								<p>${messageDto.message_content }</p>
								<!--<span class="time_date">${messageDto.message_regdate }</span>-->
							</div>
						</div>
						</c:if>		
					</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>	
					<div class="type_msg">
						<div class="input_msg_write">
							<input type="text" class="write_msg" placeholder="Type a message" id="getMessage"/>

							<button class="msg_send_btn" type="button" onclick="sendMessage();">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
                            <path
										d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
                            <path
										d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z" />
                          </svg>
							</button>

						</div>
					</div>
				</div>
			</div>
			<button class="btn btn-warning" onclick="closeChatRoom();">채팅방 나가기</button>
			<!--https://bootsnipp.com/snippets/1ea0N : bootstrap template원본 -->
			<!-- 웹소켓 연결 하는 부분 -->
		</div>
		
	</div>
	

	
<script type="text/javascript">

$(document).ready(function(){
	openSocket();
});




	var ws;
	var message = document.getElementById("getMessage").value;
	var loginuserId = '${login.userid}';
	var title = '${productName}'
	function openSocket() {
		if(ws !== undefined && ws.readyState !== WebSocket.CLOSED) {
			alert("이미 채팅이 진행중인 사이트가 존재합니다.!");
			return;
		}
		
		ws = new WebSocket("ws://localhost:8787/carrot/echo.do");
		
		ws.onopen = function(event) {
			
			console.log(event);
			if(event.data === undefined) {
				return;
			} else {
				$(".msg_history").append(event.data);
			}
			
			/*
			var strArray = data.split(':');

			sessionId = strArray[0];
			message  = strArray[1];
			
			if(loginuserId == sessionId) {
				
				var printHTML = "<div class='outgoing_msg'>";
				printHTML += "<div class='sent_msg'>";
				printHTML += "<p>"+message+"</p>";
				//printHTML += "<span class='time_date'>"+date+"</span>";
				printHTML += "</div>";
				printHTML += "</div>";
				
				$(".msg_history").append(printHTML);
			} else {
			
				
				var printHTML = "<dic class='incoming_msg'>";
				printHTML += "<p id='ididid'>";
				printHTML += "<small>"+sessionId+"</small>";
				printHTML += "</p>";
				printHTML += "<div vlass='received_withd_msg'>";
				printHTML += "<p>"+message+"</p>";
				//printHTML += "<span class='time_date'>"+date+"</span>";
				printHTML += "</div>";
				printHTML += "</div>";
				printHTML += "</div>";
				
				
				$(".msg_history").append(printHTML);
			
			}
			*/	
		};
		
		ws.onmessage = function(event) {

			var data = event.data;
			console.log(data);
			//var sessionId = data["sender"];
			//var message = data["message"];
			
			//console.log(sessionId);
			//console.log(message);
			
			var strArray = data.split(':');

			var sessionId = strArray[0];
			var message  = strArray[1];
			
			if(loginuserId == sessionId) {
				outgoing_msg(event);
			} else {
				 incoming_msg(event);	
			}
		};
		/*
		ws.onclose = function(event) {
			printHTML = "대화가 종료되었습니다.";
			$('.msg_history').append(printHTML);
		}
		*/
	}
	
	
	
	
	function sendMessage() {
		var message = document.getElementById("getMessage").value;
		var text = loginuserId + "," + message;
		var receiver = '${sellerId}';
		ws.send(text);
		text = "";
		
		var MessageVal = {
				"message_sender" : loginuserId,
				"message_receiver" : receiver,
				"message_content" : message,
				"chatroom_title" : title
		}
		
		$('#getMessage').val('');
		
		
		$.ajax({
			type: "post",
			url: "messageinput.do",
			data: MessageVal,
			contentType:"application/json",
			success: function(msg) {
				console.log(msg.result);
			},
			error:function(msg) {
				console.log(msg.result);
			}
			
		});
		
	}
	
	function closeChatRoom(event) {
		ws.close();
		history.go(-1);
	}
	
	function incoming_msg(event) {
		var data = event.data;
		//var sessionId = data["sender"];
		//var message = data["message"];
		var strArray = data.split(':');
		var sessionId = strArray[0];
		var inputmessage  = strArray[1];
		var printHTML = "<dic class='incoming_msg'>";
		printHTML += "<p id='ididid'>";
		printHTML += "<small>"+sessionId+"</small>";
		printHTML += "</p>";
		printHTML += "<div class='received_msg'>";
		printHTML += "<div class='received_withd_msg'>";
		printHTML += "<p>"+inputmessage+"</p>";
		//printHTML += "<span class='time_date'>"+date+"</span>";
		printHTML += "</div>";
		printHTML += "</div>";
		printHTML += "</div><br>";
		$(".msg_history").append(printHTML);
	}
	
	function outgoing_msg(event) {
		var data = event.data;
		//var sessionId = data["sender"];
		//var message = data["message"];
		var strArray = data.split(':');
		var sessionId = strArray[0];
		var inputmessage  = strArray[1];
		var printHTML = "<div class='outgoing_msg'>";
		printHTML += "<div class='sent_msg'>";
		printHTML += "<p>"+inputmessage+"</p>";
		//printHTML += "<span class='time_date'>"+date+"</span>";
		printHTML += "</div>";
		printHTML += "</div><br>";
		
		$(".msg_history").append(printHTML);
		
	}
</script>
	<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>