<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var status = false; // 수정과 대댓글을 동시에 적용 못하도록
		
		//댓글 저장 
		$("#reply_save").click(function(){
			//널검사 // 띄어쓰기 되는지 보기 
			if($("#replyContent").val().trim() ==  ""){
			alert("내용을 입력하세요");
			$("#replyContent").focus();
			return false;
		}
		
		
		var replyContent = $("#replyContent").val().replace("\n", "<br>"); //개행 처리

		console.log("replyContent : ", replyContent)
		//값 세팅
		var objParams = {
				groupNo			: 0,
				groupDepth		: 0,
				entireBoardSeq  : ${dto.entireBoardSeq},
				userSeq			: ${login.userseq},
				userId			: '${login.userid}',
				replyContent	: replyContent
		};
		
		console.log(objParams);
		
		var commentNoSeq;

		
		//ajax호출
		$.ajax({
			url			: "boardreplysave.do",
			dataType	: "json",
			contentType	: "application/x-www-form-urlencoded; charset=UTF-8",
			type		: "POST",
			async		: true, //동기 : false, 비동기 : true
			data		: objParams,
			success		: function(retVal) {
				
				if(retVal.code != "OK") {
					alert(retVal.message);
					return false;
				} else {
					commentNoSeq = retVal.commentNoSeq;
				}
				
			},
			error		: function(request, status, error) {
				console.log("AJAX_ERROR");
			}
		});
		
		var reply_area = $("#reply_area");
		
		var reply =
            '<tr reply_type="main">'+
            '    <td width="820px">'+
            replyContent+
            '    </td>'+
            '    <td width="100px">'+
            $("#userId").val()+   //${login.userid}
            '    </td>'+
            '    <td align="center">'+
            '       <button name="reply_reply" reply_id = "'+commentNoSeq+'">댓글</button>'+
            '       <button name="reply_modify" r_type = "main" parent_id = "0" reply_id = "'+commentNoSeq+'">수정</button>      '+
            '       <button name="reply_del" r_type = "main" reply_id = "'+commentNoSeq+'">삭제</button>      '+
            '    </td>'+
            '</tr>';
 
            console.log("reply : ", reply)
            
            if($('#reply_area').contents().length == 0){
            	$('#reply_area').append(reply);
            } else {
            	$('#reply_area tr:last').after(reply);
            }
            
            //댓글 초기화
            $("#userId").val("");
            $("#replyContent").val("");
            
		});
		
		//댓글 삭제 
		$(document).on("click", "button[name='reply_del']", function(){
			var check = false;
			var commentNoSeq = $(this).attr("reply_id");
			var r_type = $(this).attr("r_type");
			console.log("commentNoSeq : ", commentNoSeq)
			console.log(r_type)
			//아이디와 코멘트 번호 넘겨 삭제
			//값세팅
			var objParams = {
					commentNoSeq	: commentNoSeq,
					userId 			: '${login.userid}',
					r_type			: r_type
			};
			
			//ajax호출
			$.ajax({
				url			:	"boardreplydel.do",
				dataType	:	"json",
				contentType :	"application/x-www-form-urlencoded; charset=UTF-8",
				type		:	"POST",
				async		:	false,
				data		:	objParams,
				success		:	function(retVal) {
					
					if(retVal.code != "OK") {
						alert(retVal.message);
					} else {
						check = true;
					}
				},
				error	:	function(request, status, error) {
					console.log("AJAX_ERROR");
				}
			});
			
			if(check) {
				
				if(r_type=="main"){ //depth가 0이면 하위 댓글 다 지움
					//삭제하면서 하위 댓글도 삭제
					var prevTr = $(this).parent().parent().next(); //댓글의 다음
					
					while(prevTr.attr("reply_type")=="sub"){ //댓글의 다음이 sub이면 계속 넘어감
						prevTr.remove();
						prevTr = $(this).parent().parent().next();
					}
					
					$(this).parent().parent().remove();
				} else {
					//아니면 자기만 지움
					$(this).parent().parent().remove();
				}
			}
		});
		
		//댓글 수정
		//댓글수정 취소
		//댓글수정 저장
        //대댓글 입력창
        	$(document).on("click","button[name='reply_reply']",function(){ //동적 이벤트
            		
            	if(status){
                     alert("수정과 대댓글은 동시에 불가합니다.");
                     return false;
                   }
                    
                     status = true;
            		
            	$("#reply_add").remove();
            		
            	var commentNoSeq = $(this).attr("reply_id");
            	console.log("commentNoSeq : ", commentNoSeq)
            	var last_check = false;//마지막 tr 체크
            		
            	//입력받는 창 등록
            	var replyEditor = 
            		'<tr id="reply_add" class="reply_reply">'+
	            	'	<td width="820px">'+
	            	'		<textarea name="reply_reply_content" rows="3" cols="50"></textarea>'+
	            	'	</td>'+
	            	'	<td width="100px">'+
	            	'		<textarea name="userId" style="width:100%;" maxlength="10" readonly="readonly">'+'${login.userid}'+'</textarea>'+
	            	'	</td>'+
	            	'	<td align="center">'+
	            	'		<button name="reply_reply_save" parent_id='+commentNoSeq+'>등록</button>'+
	            	'		<button name="reply_reply_cancel">취소</button>'+
	            	'	</td>'+
	            	'</tr>';
	            		
				var prevTr = $(this).parent().parent().next();
	            	
	            //부모의 부모 다음이 sub이면 마지막 sub 뒤에 붙인다.
            	//마지막 리플 처리
            	if(prevTr.attr("reply_type") == undefined){
            		prevTr = $(this).parent().parent();
            	}else{
            		while(prevTr.attr("reply_type")=="sub"){//댓글의 다음이 sub면 계속 넘어감
                          prevTr = prevTr.next();
                   }
            			
            		if(prevTr.attr("reply_type") == undefined){//next뒤에 tr이 없다면 마지막이라는 표시를 해주자
            			last_check = true;
            		}else{
            			prevTr = prevTr.prev();
            		}
            			
            	}
	            	
	            if(last_check){//마지막이라면 제일 마지막 tr 뒤에 댓글 입력을 붙인다.
	            	$('#reply_area tr:last').after(replyEditor);	
	            }else{
	            	prevTr.after(replyEditor);
	            }
            		
            });
        	//대댓글 등록
        	$(document).on("click","button[name='reply_reply_save']",function(){
        		
        		var userId = $("textarea[name='userId']");
        		var reply_reply_content = $("textarea[name='reply_reply_content']");
        		var replyContent = reply_reply_content.val().replace("\n", "<br>"); //개행처리
        		console.log("userId : ", userId)
        		//널검사 
        		if(reply_reply_content.val().trim() == ""){
        			alert("내용을 입력하세요");
        			reply_reply_content.focus();
        			return false;
        		}
        		
        		//값세팅
        		var objParams = {
        				groupNo			: $(this).attr("parent_id"),
        				groupDepth		: 1,
        				entireBoardSeq  : ${dto.entireBoardSeq},
        				userSeq			: ${login.userseq},
        				userId			: '${login.userid}',
        				replyContent	: replyContent
        		};
        		
        		var commentNoSeq;
        		var groupNo;
        		console.log("objParams : ",objParams)
        		//ajax호출
        		$.ajax({
        			url			: "boardreplysave.do",
        			dataType	: "json",
        			contentType	: "application/x-www-form-urlencoded; charset=UTF-8",
        			type		: "POST",
        			async		: false,
        			data		: objParams,
        			success		: function(retVal) {
        				
        				if(retVal.code != "OK") {
        					alert(retVal.message);
        				}else {
        					commentNoSeq = retVal.commentNoSeq;
        					groupNo = retVal.groupNo;
        				}
        			},
        			error		: function(request, status, error){
        				console.log("AJAX_ERROR");
        			}
        		});
        		var reply =
                    '<tr reply_type="sub">'+
                    '    <td width="820px"> → '+
                    replyContent+
                    '    </td>'+
                    '    <td width="100px">'+
                    userId.val()+
                    '    </td>'+
                    '    <td align="center">'+
                    '       <button name="reply_modify" r_type = "sub" parent_id = "'+groupNo+'" reply_id = "'+commentNoSeq+'">수정</button>'+
                    '       <button name="reply_del" r_type = "sub" reply_id = "'+commentNoSeq+'">삭제</button>'+
                    '    </td>'+
                    '</tr>';
                    
                    var prevTr = $(this).parent().parent().prev();
                    
                    prevTr.after(reply);
                    $("#reply_add").remove();
                    
                    status = false;
        	});
        	//대댓글입력창취소
        	$(document).on("click", "button[name='reply_reply_cancel']", function(){
        		$("#reply_add").remove();
        		
        		status = false;
        	});
        	
  
	});
		
		
		//대댓글?수정

		
</script>
<!-- 서머노트를 위해 추가해야할 부분 -->
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
<!--  -->
</head>
<body>

	<h1>SnsBoardDetail</h1>

	<table border="1">
		<tr>
			<td>userId</td>
			<td>${dto.userId }</td>
		</tr>
		<tr>
			<td>boardDate</td>
			<td>${dto.boardDate }</td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><img src="${pageContext.request.contextPath}/resources${dto.boardImg }"/></td>
		</tr>
		<tr>
			<td>썸네일 이미지</td>
			<td><img src="${pageContext.request.contextPath}/resources${dto.boardThumbImg }"/></td>
			
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="60" readonly="readonly">${dto.boardContents }</textarea></td>
		</tr>
		<tr>
			<td>좋아요</td>
			<td>
			<c:choose>
				<c:when test="${likeCheck == 1}">
					<!-- 꽉찬하트일때 -->
    				<span> 
        				<a idx="${dto.entireBoardSeq }" href="javascript:" class="heart-click heart_icon${dto.entireBoardSeq }">
            				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
            				<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" /> </svg>
        				</a>
    				</span>
    			</c:when>
    			<c:otherwise>
    				<!-- 빈하트일때 -->
    				    <span> 
        				<a idx="${dto.entireBoardSeq }" href="javascript:" class="heart-click heart_icon${dto.entireBoardSeq }">
            				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
            				<path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
        				</a>
    				</span>
    			</c:otherwise>
    		</c:choose>
			</td>
		</tr>
		<tr>
			<td>좋아요 수</td>
			<td><span id="heart${dto.entireBoardSeq }">${dto.likeCount }</span></td>
		</tr>
	</table>
	<!-- 댓글 -->
	
    <table border="1" width="1200px" id="reply_area">
         <tr reply_type="all"  style="display:none"><!-- 뒤에 댓글 붙이기 쉽게 선언 -->
              <td colspan="4"></td>
         </tr>
              <!-- 댓글이 들어갈 공간 -->
              <c:forEach var="replyList" items="${replyList}" varStatus="status">
                  <tr reply_type="<c:if test="${replyList.groupDepth == 0}">main</c:if><c:if test="${replyList.groupDepth == 1}">sub</c:if>"><!-- 댓글의 depth 표시 -->
                      <td width="820px">
                          <c:if test="${replyList.groupDepth == 1}"> → </c:if>${replyList.replyContent}
                      </td>
                      <td width="100px">
                          ${replyList.userId}
                      </td>
                      <td align="center">
                            <c:if test="${replyList.groupDepth != 1 }">
                                <button name="reply_reply" parent_id = "${replyList.userId}" reply_id = "${replyList.commentNoSeq}">댓글</button><!-- 첫 댓글에만 댓글이 추가 대댓글 불가 -->
                            </c:if>
                            	<button name="reply_modify" parent_id = "${replyList.groupNo}" r_type = "<c:if test="${replyList.groupDepth == 0}">main</c:if><c:if test="${replyList.groupDepth == 1}">sub</c:if>" reply_id = "${replyList.commentNoSeq}">수정</button>
                            	<button name="reply_del" r_type = "<c:if test="${replyList.groupDepth == 0}">main</c:if><c:if test="${replyList.groupDepth == 1}">sub</c:if>" reply_id = "${replyList.commentNoSeq}">삭제</button>
                       </td>
                    </tr>
                </c:forEach>
      </table>
      
      <table border="1" width="1200px" bordercolor="#46AA46">
          			<tr>
                       <td width="500px">
                        	유저 아이디: <textarea id="userId" name="userId" readonly="readonly" rows="1" cols="50">${login.userid}</textarea>
                        	<button id="reply_save" name="reply_save">댓글 등록</button>
                    	</td>
                   </tr>
                   <tr>
                       <td>
                           <textarea id="replyContent" name="replyContent" rows="4" cols="50" placeholder="댓글을 입력하세요."></textarea>
                       </td>
                   </tr>
       </table>

	<!-- 내 게시물만 삭제,수정버튼 나오게하기  -->
	
	<c:if test="${dto.userId==login.userid}">	
	<table border="1">
		<tr>
			<td colspan="2" align="right">
										
				<input type="button" value="공유하기" onclick="location.href"/>
				<input type="button" value="삭제" onclick="location.href='snsBoardDelete.do?entireBoardSeq=${dto.entireBoardSeq}'"/>
				<input type="button" value="목록" onclick="location.href='snsBoardList.do'"/>
			</td>
		</tr>
	</table>
	</c:if>




</body>
<script type="text/javascript">
	//페이지가 뒤로가기 하면 하트버튼과 하트수 갱신이 안된다. 이때 하트를 누르면 디비에 중복으로 값이 들어가진다.
	//방지하기 위해 페이지가 뒤로가기 할때마다 css로 클릭을 막고 새로고침을 통해 갱신된 하트버튼과 하트수가 나오도록 한다.
	$(window).bind("pageshow", function (event) {
   	//파이어폭스와 사파리에서는 persisted를 통해서 뒤로가기 감지가 가능하지만 익스와 크롬에서는 불가  ||뒤의 코드를 추가한다. 
   		if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
      	console.log('BFCahe로부터 복원됨');
      	$(".heart-click").css("pointer-events","none");
      	location.reload();//새로고침 
   	}
   		else {
      		console.log('새로 열린 페이지');
   		}
	});
	
	//로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
	$(".heart-click").click(function(){
		
		//게시물 번호(entireBoardSeq)를 idx로 전달 받아 저장
		let entireBoardSeq = $(this).attr('idx');
		var userId = '<%=(String)session.getAttribute("userid")%>';
		console.log("userId :", userId);
		console.log("entireBoardSeq : ", entireBoardSeq);
		console.log("heart-click");
		
		//빈하트를 눌렀을때 
		if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
			console.log("빈하트 클릭" + entireBoardSeq);
			
			$.ajax({
				url : 'saveHeart.do',
				type : 'get',
				data : {
					entireBoardSeq : entireBoardSeq,

				},
				success : function(dto) {
					//페이지새로고침
					//document.location.reload(true);
					
					let heart = dto.likeCount;
					
					//페이지, 모달창에 하트수 갱신;
					$('#m_heart'+entireBoardSeq).text(heart);
					$('#heart'+entireBoardSeq).text(heart);
					
					console.log("하트추가 성공");
				},
				error : function() {
					alert('서버에러');
				}
			});
			console.log("꽉찬하트로 바껴라!");
			
			//꽉찬하트로 바꾸기!
			$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
	        $('.heart_icon'+entireBoardSeq).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
		
		//꽉찬 하트를 눌렀을 때 
		} else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill") {
			console.log("꽉찬하트 클릭" + entireBoardSeq);
			
			$.ajax({
				url : 'removeHeart.do',
				type : 'get',
				data : {
					entireBoardSeq : entireBoardSeq
				},
				success : function(dto) {
					//페이지 새로고침
					//document.location.reload(true);
					
					let heart = dto.likeCount;
					//페이지, 하트수 갱신
					$('#m_heart'+entireBoardSeq).text(heart);
					$('#heart'+entireBoardSeq).text(heart);
					
					console.log("하트삭제 성공");
				},
				error : function() {
					alert('서버 에러');
				}
			});
			console.log("빈하트로 바껴라!");
			
			//빈하트로 바꾸기
			$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

	        $('.heart_icon'+entireBoardSeq).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
		}
		
	});
	
	
	
</script>
</html>