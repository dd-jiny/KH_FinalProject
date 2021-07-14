<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>씨앗 마켓 상품 상세 페이지</title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

        <!-- style -->
        <style>
            #preview-image img {
                height: 300px;
                width: 300px;
                
            }
        </style>

        <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- 썸머노트 경로 -->
        <script src="${pageContext.request.contextPath}/resources/js/summernote/summernote-lite.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/summernote/lang/summernote-ko-KR.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote/summernote-lite.css">

        <script type="text/javascript">
            //썸머노트
            $(document).ready(function () {

                var toolbar = [
                    // 글꼴 설정
                    ['fontname', ['fontname']],
                    // 글자 크기 설정
                    ['fontsize', ['fontsize']],
                    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
                    ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
                    // 글자색
                    ['color', ['forecolor', 'color']],
                    // 표만들기
                    ['table', ['table']],
                    // 글머리 기호, 번호매기기, 문단정렬
                    ['para', ['ul', 'ol', 'paragraph']],
                    // 줄간격
                    ['height', ['height']],
                    // 그림첨부, 링크만들기, 동영상첨부
                    ['insert', ['picture', 'link', 'video']],
                    // 코드보기, 확대해서보기, 도움말
                    ['view', ['codeview', 'fullscreen', 'help']]
                ];

                var setting = {
                    height: 300,
                    minHeight: null,
                    maxHeight: null,
                    focus: true,
                    lang: 'ko-KR',
                    toolbar: toolbar,
                    callbacks: { //여기 부분이 이미지를 첨부하는 부분
                        onImageUpload: function (files, editor,
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
                    data: data,
                    type: "POST",
                    url: "uploadSummernoteImageFile.do",
                    contentType: false,
                    enctype: 'multipart/form-data',
                    processData: false,
                    success: function (data) {

                        $(el).summernote('editor.insertImage', data.url);
                    }
                });
            }
        </script>
    </head>
    </head>

    <body>
       


            <form action="adminproductinsertres.do" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="userSeq" value="${login.userseq }">
                <input type="hidden" name="userId" value="${login.userid }">


                <!-- 이미지 업로드 -->
                <div class="container" style="width: 100%; padding-top:100px">
				<div style="text-align: center;">
					<h1>씨앗마켓 상품 주문 페이지</h1>
				</div>
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <table class="table table-bordered" style="margin-top:50px;">
                                <tr>
                                    <th>작성자</th>
                                    <td><input type="text" name="userId" class="form-control" readonly
                                            value="${login.userid}"></td>
                                </tr>
                                <tr>
                                    <th style="vertical-align: middle;">상품이미지</th>
                                    <td><img src="https://via.placeholder.com/300x300" class="img-responsive"
                                            alt="Responsive image" id="preview-image" style="height:400px; width:400px;">
                                        <input type="file" name="file" accept="image/*1" id="boardImg"
                                            onchange="setThumbnail(event);" class="form-control custom-file-input"
                                            id="customFile">
                                    </td>
                                </tr>
                                <tr>
                                    <th>상품명</th>
                                    <td><input type="text" name="productName" class="form-control"
                                            placeholder="상품명을 입력해주세요"></td>
                                </tr>
                                <tr>
                                    <th>판매금액</th>
                                    <td><input type="text" name="productPrice" class="form-control"
                                            placeholder="금액을 입력해주세요"></td>
                                </tr>
                                
                                <tr>
                                    <th style="vertical-align: middle;">내용</th>
                                    <td>
                                        <textarea placeholder="상품정보를 입력해주세요" id="summernote" name="productInfo"
                                            cols="50" rows="10"></textarea>
                                    </td>
                                </tr>
                            </table>
                            <div class="row">
                                <div class="col-md-6"><button type="submit"
                                        class="btn btn-warning btn-block">글작성</button></div>
                                <div class="col-md-6"><button type="button" class="btn btn-default btn-block"
                                        onclick="location.href='adminproduct.do'">취소</button></div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <script type="text/javascript">

                function readImage(input) {
                    // 인풋 태그에 파일이 있는 경우
                    if (input.files && input.files[0]) {
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
            <%@include file="/WEB-INF/views/1footer.jsp" %>
    </body>

    </html>