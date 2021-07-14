<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <style>
        .container{
            width:100%;
        }
        nav .container-fluid .navbar-header .navbar-brand img{
            height: 25px ;
            width: 100px;
        }
    </style>
</head>
<body>

    <!--navbar-->
    <div class="container" >
        <div class="row">
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                  <!-- Brand and toggle get grouped for better mobile display -->
                  <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                      <span class="sr-only">Toggle navigation</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#"><img src="resources/image/logo-banner.png" alt="logo"  ></a>
                  </div>
              
                  <!-- Collect the nav links, forms, and other content for toggling -->
                  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                      <li><a href="#">로컷마켓</a></li>
                      <li><a href="#">씨앗,도구 구매</a></li>
                      <li><a href="#">주말농장</a></li>
                      <li><a href="#">꿀팁</a></li>
                      <li><a href="#">날씨/미세먼지</a></li>
                      <li><a href="#">게시판</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"title="로그인 페이지 이동" style="color:rgb(116, 116, 116)"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span></span></a></li>
                        <li><a href="#" title="메인 페이지 이동" style="color:rgb(116,116,116)"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a></li>
                    </ul>
                  </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->
              </nav>
        </div>
    </div>
    <!--body-->
    <div class="container">
        <div class="row">
            <div class="col-md-2 bg-success" id="left">f</div>
            <div class="col-md-8 bg-info " id="body" >f</div>
            <div class="col-md-2 bg-warning" id="right">ffff</div> 
        </div>
    </div>

    <!--footer-->
    <footer class="footer text-center secondary">
        <div class="container" style="width:100%" >
            <div class="row">
                <hr>
                <div class="col-md-12  text-center"  >
                    <div class="col-md-4 mb-5 mb-lg-0">
                        <h4 class="text-uppercase mb-4">Project</h4>
                        <p>
                            kh정보교육원<br>
                            오픈소스 기반 머신러닝 플랫폼을 활용한 응용소프트웨어 개발자 양성과정<br>
                            당근팜 프로젝트 - 불사조
                        </p>
                    </div>
                    <div class="col-md-4 mb-5 mb-lg-0">
                        <h4 class="text-uppercase mb-4">git</h4>
                        <a href="https://github.com/DOHAN25/Final_Project.git"><img src="resources/image/git_logo.png" alt="git logo" class="img-rounded"></a>
                    </div>
                    <div class=" col-md-4">
                        <h4 class=" mb-4"> DEVELOPER</h4>
                        <div class="dropdown d-inline-block">
                            <button class="btn mb-2 mr-2 dropdown-toggle btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton1"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                Developer
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                <li><a class="dropdown-item" href="https://github.com/DOHAN25">김도한</a></li>
                                <li><a class="dropdown-item" href="https://github.com/dd-jiny">김대진</a></li>
                                <li><a class="dropdown-item" href="https://github.com/Taerin-Kim">김태린</a></li>
                                <li><a class="dropdown-item" href="#">박찬종</a></li>
                                <li><a class="dropdown-item" href="https://github.com/jaehee-9638">이재희</a></li>
                                <li><a class="dropdown-item" href="https://github.com/1251024">장보옥</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="copyright py-4 text-center text-light bg-success">
                    <div class="container">
                        <small>Copyright &copy;
                            Phoenix
                            <a href="https://github.com/DOHAN25/Final_Project.git">@github</a>
                        </small>
                    </div>
                    <p>
                        <a href="#">Back to top</a>
                    </p>
            
                </div>
            
            
            
                <!-- Optional tstrap Bundle with Popper -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
                    crossorigin="anonymous"></script>
            </div>
        </div>
    </footer>
    
    
</body>
</html>