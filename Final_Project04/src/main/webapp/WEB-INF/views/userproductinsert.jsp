<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓 상품 등록</title>

<!-- 썸머노트 경로 
<script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">
-->
<!--  include libraries(jQuery, bootstrap) --> 
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> 
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<!-- style -->
<style>
	#image_container img{
			height:400px;
			width:400px;
		}
</style>

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

	<form action="userproductinsertres.do" method="post" enctype="multipart/form-data">
		<input type="hidden" id="userLatitude" name="userLatitude">
		<input type="hidden" id="userLongitude" name="userLongitude">
		<input type="hidden" id="userLongitude" name="userSeq" readonly value="${login.userseq}">
					<!-- 이미지 업로드 -->
		    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2" >
                <h1 style="margin-top:50px;">유저 상품정보 등록</h1>
                <table class="table table-bordered" style="margin-top:50px;">
                    <tr>
                        <th>작성자</th>
                        <td><input type="text" name="userId" class="form-control" readonly value="${login.userid}"></td>
                    </tr>
                    <tr>
                     	<th style="vertical-align: middle;">상품이미지</th>
                        	<td><img src="https://via.placeholder.com/300x300" class="img-responsive" alt="Responsive image" id="preview-image" style="height:400px; width:400px;">
                            	<input type="file" name="file" accept="image/*1" id="boardImg" onchange="setThumbnail(event);" class="form-control custom-file-input" id="customFile" />
                        	</td>
                    </tr>
                    <tr>
                        <th>상품명</th>
                        <td><input type="text" name="productName" class="form-control" placeholder="상품명을 입력해주세요"></td>
                    </tr>
                    <tr>
                        <th>판매금액</th>
                        <td><input type="text" name="productPrice" class="form-control" placeholder="금액을 입력해주세요"></td>
                    </tr>
                    <tr>
                        <th style="vertical-align: middle;">주소</th>
                        <td>
                            <div class="col-md-10">
                                <input type="text" class="form-control" id="sellerAddress" name="sellerAddress" placeholder="주소 검색" style="margin-bottom: 10px;">
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-warning btn-block" onClick="goPopup();"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                            </div>
                            
                            <input type="text" class="form-control" placeholder="자세한 주소를 입력해주세요 ">
                        </td>
                    </tr>
                    <tr>
                        <th style="vertical-align: middle;">내용</th>
                        <td>
                       	 	<textarea placeholder="상품정보를 입력해주세요" id="summernote" name="productInfo" rows="10"></textarea>
                        </td>
                    </tr>
                  </table>
                  <div class="row">
                      <div class="col-md-6"><button type="submit" class="btn btn-warning btn-block">글작성</button></div>
                      <div class="col-md-6"><button type="button" class="btn btn-default btn-block" onclick="location.href='marketplace.do'">취소</button></div>
                  </div>
            </div>
        </div>
    </div>
	</form>
	<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>

<script type="text/javascript">

	function readImage(input) {
    	// 인풋 태그에 파일이 있는 경우
    	if(input.files && input.files[0]) {
        	// 이미지 파일인지 검사 (생략)
        	// FileReader 인스턴스 생성
        	const reader = new FileReader()
        	// 이미지가 로드가 된 경우
        	reader.onload = e => {
            	const previewImage = document.getElementById("preview-image")
            	previewImage.src = e.target.result
        	}
        	// reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    	}
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("boardImg")
	inputImage.addEventListener("change", e => {
    	readImage(e.target)
	})

</script>
</html>