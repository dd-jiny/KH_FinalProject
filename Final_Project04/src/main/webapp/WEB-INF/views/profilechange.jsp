<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- style -->
<style>
	#image_container img{
		width:400px;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/1header.jsp"%>
	<h1>유저프로필사진 변경</h1>
	
	<!-- 사진업로드 박스 -->
			<div>
				<p>사진 업로드</p>
			</div>
			<form action="snsBoardInsertRes.do" method="post" enctype="multipart/form-data">

			<div>유저Seq :<textarea rows="1" cols="20" name="userSeq" readonly="readonly">${login.userseq }</textarea></div>
			<div>유저아이디 :<textarea rows="1" cols="20" name="userId" readonly="readonly">${login.userid }</textarea></div>
			
			<!-- 사진업로드 form -->
				<div class='uploadFileDiv'>
					<input type="file" name="file" accept="image/*1" id="boardImg" onchange="setThumbnail(event);"><br>
				</div>
			
				<!-- 이미지 미리보기 출력 -->	
				<div id="image_container"></div>
											
				<!--  <button id='uploadBtn'>Upload</button> -->
				<%=request.getRealPath("/") %>
				<!-- end -->
				
				<!-- 게시글 + 업로드 버튼 -->
				<div class="upload-form-detail">
					<input type="text" name="boardContents" placeholder="게시글" /><br>
					<button type="submit">등록</button>
				</div>
				
			</form> 							

			
		<script>
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
		</script>
	<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>