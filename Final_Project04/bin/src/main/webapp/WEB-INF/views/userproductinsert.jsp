<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 썸머노트 경로 -->
<script
	src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">


<script type="text/javascript">
	//주소팝업
	function goPopup() {
		//주소 검색을 수행할 팝업 페이지를 호출
		//호출된 페이지 (jusopopup.jsp) 에서 실제 주소검색 URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("jusoPopup.do", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}
	//원하는 페이지 영역에 주소값을 입력해줌 
	var jusoCallBack = function(roadFullAddr, roadAddrPart1, addrDetail,
			roadAddrPart2, engAddr, jibunAddr, zipNo) {
		document.getElementById("sellerAddress").value = roadFullAddr;
		self.close();
	}
	
	//썸머노트
	$(document).ready(function() {

		var toolbar = [
			    // 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 표만들기
			    ['table', ['table']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기, 동영상첨부
			    ['insert',['picture','link','video']],
			    // 코드보기, 확대해서보기, 도움말
			    ['view', ['codeview','fullscreen', 'help']]
			  ];

		var setting = {
	            height : 300,
	            minHeight : null,
	            maxHeight : null,
	            focus : true,
	            lang : 'ko-KR',
	            toolbar : toolbar,
	            callbacks : { //여기 부분이 이미지를 첨부하는 부분
	            onImageUpload : function(files, editor,
	            welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            uploadSummernoteImageFile(files[i],
	            this);
	            		}
	            	}
	            }
	         };

	        $('#summernote').summernote(setting);
	        });
	
    		function uploadSummernoteImageFile(file, el) {
				data = new FormData();
				data.append("file", file);
				$.ajax({
					data : data,
					type : "POST",
					url : "uploadSummernoteImageFile.do",
					contentType : false,
					enctype : 'multipart/form-data',
					processData : false,
					success : function(data) {
						
				$(el).summernote('editor.insertImage', data.url);
			}
		});
	}

	// 현재 위치의 위도, 경도 가져오기 geolocation사용

	$(function() {
		// Geolocation API에 액세스할 수 있는지를 확인
		if (navigator.geolocation) {
			//위치 정보를 얻기
			navigator.geolocation.getCurrentPosition(function(pos) {
				$('#userLatitude').attr('value',pos.coords.latitude); // 위도
				$('#userLongitude').attr('value',pos.coords.longitude); // 경도
			});
		} else {
			alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
		}
	});
</script>
</head>
<body>

	<h1>당근마켓등록</h1>

	<form action="userproductinsertres.do" method="post">
		<input type="hidden" id="userLatitude" name="userLatitude">
		<input type="hidden" id="userLongitude" name="userLongitude">
		<table border="1">
			<tr>
				<td>유저Seq</td>
				<td><textarea rows="1" cols="20" name="userSeq"
						readonly="readonly">${login.userseq }</textarea></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><textarea rows="1" cols="20" name="userId"
						readonly="readonly">${login.userid }</textarea></td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="productName" /></td>
				<td>상품가격</td>
				<td><input type="text" name="productPrice" /></td>
			</tr>
			<tr>
				<td>거래가능지역</td>
				<td><input type="text" id="sellerAddress" name="sellerAddress" /></td>
				<td><button type="button" class="btnjuso" onClick="goPopup();">검색</button></td>
			</tr>
				
			<tr>
				<!-- div에 에디터를 사용하는경우 -->
				<!-- <div id="summernote">Hello Summernote</div> -->
				<!-- summernote : form 안에 에디터를 사용하는 경우 -->
				<td>상품정보</td>
				<td><textarea id="summernote" name="productInfo"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="submit" value="상품등록" />
					<input type="button" value="취소"
					onclick="location.href='marketplace.do'" /></td>
			</tr>
		</table>
	</form>
</body>

<script type="text/javascript">


</script>
</html>