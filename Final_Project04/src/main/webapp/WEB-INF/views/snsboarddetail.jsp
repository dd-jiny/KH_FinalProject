<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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
        #li-color{
            color:rgb(77, 75, 75);
        }
        #td{
            padding-right:10px;
        }
        
</style>
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
            '	 <td id="td">'+
            '	 <img src="https://via.placeholder.com/30" class="img-circle"  alt="게시글 이미지" style="margin-right: 0px;"  >'+
            '	 <a href="snsBoardUserFeed.do?userId='+$("#userId").val()+'" style="color: black; padding-left: 10px;">'+
            $("#userId").val()+
            '	 </a>'+
            '	 </td>'+
            '    <td id="td">'+
            '<span>'+replyContent+'</span>'+
            '    </td>'+
            '    <td align="center">'+
            '	 	<button name="reply_reply" parent_id = "'+userId+'" reply_id = "'+commentNoSeq+'" type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>'+
            '		<button type="button" class="btn btn-danger btn-xs" name="reply_del" r_type = "main" reply_id = "'+commentNoSeq+'"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>'+
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
	            	'	<td>'+
	            	'		<input type="hidden" name="userId" readonly value="'+'${login.userid }'+'">'+
	            	'	</td>'+
	            	'	<td >'+
					'		<input type="text" class="form-control" name="reply_reply_content" placeholder="Text input">'+
	            	'	</td>'+
	            	'	<td align="center">'+
	            	'		<button type="button" class="btn btn-warning btn-xs" name="reply_reply_save" parent_id='+commentNoSeq+'>등록</button>'+
	            	'		<button type="button" class="btn btn-warning btn-xs" name="reply_reply_cancel">취소</button>'+
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
        		
        		var userId = $("input[name='userId']");
        		var reply_reply_content = $("input[name='reply_reply_content']");
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
                    '<tr id="td reply_type="sub" style="padding-left: 40px;">'+
                    '    <td id="td">  →'+
                    '	 <img src="https://via.placeholder.com/30" class="img-circle"  alt="게시글 이미지" style="margin-right: 0px;"  > '+
                    '	 <a href="snsBoardUserFeed.do?userId='+$("#userId").val()+'" style="color: black; padding-left: 10px;">'+
                    userId.val()+
                    '	 </a>'+
                    '    </td>'+
                    '    <td id="td"> '+
                    '	 <span>'+
                    replyContent+
                    '	 </span>'+
                    '    </td>'+
                    '    <td id="td">'+
                    '       <button name="reply_del" r_type = "sub" reply_id = "'+commentNoSeq+'" type="button" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>'+
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
<%@include file="/WEB-INF/views/1header.jsp"%>
    <div class="container" style="width: 100%;">
        <div class="row" style="padding-top:50px;">
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
                        <li id="navbar-style" role="presentation" ><a href="index.jsp" id="li-color"><span class="glyphicon glyphicon-home" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">home</span></a></li>
                        <!--나의 피드보기 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="snsBoardUserFeed.do?userId=${login.userid }" id="li-color"><span class="glyphicon glyphicon-th" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">나의 피드 보기</span></a></li>
                        <!--글작성 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="snsBoardInsertForm.do" id="li-color"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">글작성</span></a></li>
                        <!--마이페이지로 이동 버튼 -->
                        <li id="navbar-style" role="presentation" ><a href="mypage.do?userid=${login.userid}" id="li-color"><span class="glyphicon glyphicon-user" aria-hidden="true"></span><span style="margin-left:20px" style="color: black;">마이페이지</span></a></li>
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
<!--본문-->
            
                    <div class="col-sm-8 col-md-8 col-md-offset-2 " style="border:1px solid rgb(228, 228, 228);">
                        <div class="row">
                        <div class="col-md-8 col-md-offset-3">
                            <img src="${pageContext.request.contextPath}/resources${dto.boardImg }" alt="상품이미지" style="height: 500px; width: 500px;">
                        </div>
                        </div>
                        <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12" style="margin-top: 20px;"  >
                                    <!--작성자 프로필 이미지-->
                                    <img src="https://via.placeholder.com/50" class="img-circle"  alt="게시글 이미지"  > 
                                    <!--작성자 아이디 -->
                                    <a href="snsBoardUserFeed.do?userId=${dto.userId }" style="color: black; padding-left: 10px; padding-right:20px;"><b>${dto.userId }</b></a>
                                	<span>${dto.boardDate }</span>
                                </div>
                                <!--게시글 -->
                                <div class="col-md-12"  style="padding-top:20px; padding-bottom:20px;">
                                    <p>
                                    	${dto.boardContents }   
                                    </p>
                                    <p>
                                        <a href="#" style="padding-right:10px;"><span>#냥냥펀치</span></a>
                                        <a href="#" style="padding-right:10px;"><span>#고양이</span></a>
                                        <a href="#"><span>#귀여운</span></a>
                                    </p>
                                </div>
                                <div class="col-md-12" style="height: 50px;">
                                   
                                    <!--여기에 하트 넣어주세요~~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
                           		<c:choose>
									<c:when test="${likeCheck == 1}">
								<!-- 꽉찬하트일때 -->
    							<span> 
        							<a idx="${dto.entireBoardSeq }" href="javascript:" class="heart-click heart_icon${dto.entireBoardSeq }" style="color:red;">
            							<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16"> -->
            							<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" /> </svg> 
        							</a>
    							</span>
    								</c:when>
    								<c:otherwise>
    							<!-- 빈하트일때 -->
    				    		<span> 
        							<a idx="${dto.entireBoardSeq }" href="javascript:" class="heart-click heart_icon${dto.entireBoardSeq }" style="color:red;">
            							<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16" > 
            			    			<path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /> 
        							</a>
    							</span>
    								</c:otherwise>
    							</c:choose>
    								<span style="font-size:30px;" id="heart${dto.entireBoardSeq }">${dto.likeCount }</span>
                                </div>
                                
                                <!--댓글 대댓글 여기에 들어있습니다. -->
                                <div class="col-md-12">
                                    <table class="table" id="reply_area">
                                    	<tr></tr>  <!-- 댓글이 깔끔하게 들어가기위한 테이블 행 생성 (댓글을 아래로 붙히기위한 행) -->
                                        <!--댓글-->
                                  <c:forEach var="replyList" items="${replyList}" varStatus="status">      
                                    <tr reply_type="<c:if test="${replyList.groupDepth == 0}">main</c:if><c:if test="${replyList.groupDepth == 1}">sub</c:if>"><!-- 댓글의 depth 표시 -->
                                        <td id="td">
                          					<c:if test="${replyList.groupDepth == 1}"> → </c:if>
                      					</td>
                                        <td id="td">
                                            <!--작성자 프로필 이미지-->
                                            <img src="https://via.placeholder.com/30" class="img-circle"  alt="게시글 이미지" style="margin-right: 0px;"  > 
                                            <!--작성자 아이디 -->
                                            <a href="snsBoardUserFeed.do?userId=${replyList.userId }" style="color: black; padding-left: 10px;">${replyList.userId}</a>
                                        </td>
										
                                        <td id="td">
                                        	<span>${replyList.replyContent}</span>
                                        </td>
                                        
                                        <td id="td">
                                        	
                                            <!--대댓글 모달 입니다 답글달기 모달나오는 버튼-->
                                         
                                            <c:if test="${replyList.groupDepth != 1 }">
                                            	<button name="reply_reply" parent_id = "${replyList.userId}" reply_id = "${replyList.commentNoSeq}" type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
                                            </c:if>
                                            
                                            <button type="button" class="btn btn-danger btn-xs"name="reply_del" r_type = "<c:if test="${replyList.groupDepth == 0}">main</c:if><c:if test="${replyList.groupDepth == 1}">sub</c:if>" reply_id = "${replyList.commentNoSeq}"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>

                                        </td>
                                    </tr>
                                   </c:forEach>
                                   
                                </table>
                                </div>
                                
                                <!--댓글 입력창 -->
                                
                                <div class="col-md-10" >
                                	<input type="hidden" id="userId" name="userId" readonly value="${login.userid}">
                                    <input type="text" class="form-control" placeholder="댓글을 입력해주세요" id="replyContent" name="replyContent">
                                </div>
                                <div class="col-md-2"><button type="button" class="btn btn-warning" id="reply_save" name="reply_save"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button></div>

                                
                            </div>
                        </div>
                        <div class="col-md-2 col-md-offset-10">
                        <c:if test="${dto.userId==login.userid}">	
                            <button type="button" class="btn btn-danger btn-sm" style="margin-right: 10px; margin-left: 15px; margin-top:10px" onclick="location.href='snsBoardDelete.do?entireBoardSeq=${dto.entireBoardSeq}'"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
                        </c:if>
                            <button type="button" class="btn btn-default btn-sm" style="margin-top:10px" onclick="location.href='main.do'">목록으로</button>
                        </div>
                        </div>
                    </div>
                    
                    
               
<!--오른쪽 사이드-->
            <div class="col-sm-2 col-md-2 "  id="right_side_bar" style=" border-left:1px solid rgb(214, 214, 214); padding:0px 5px; ">
                <div class="col-md-12" style="padding-top:10px;">
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
			$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
	        $('.heart_icon'+entireBoardSeq).html("<svg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
		
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
			$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

	        $('.heart_icon'+entireBoardSeq).html('<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
		}
		
	});
	
	
	
</script>
</html>