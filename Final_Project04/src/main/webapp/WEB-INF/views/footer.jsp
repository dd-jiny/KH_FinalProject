<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<link href="css/styles.css" rel="stylesheet" />
<!-- Google jQuery file -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/bootstrap/js/bootstrap.js"></script>
<title>당근팜</title>
</head>
<body>
    
    <!-- Footer -->

    <footer class="footer text-center secondary">
        <div class="container">
            <div class="row">
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
                    <a href="https://github.com/DOHAN25/Final_Project.git">
                        <svg id="i-github" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="32"
                            height="32">
                            <path stroke-width="0" fill="currentColor"
                                d="M32 0 C14 0 0 14 0 32 0 53 19 62 22 62 24 62 24 61 24 60 L24 55 C17 57 14 53 13 50 13 50 13 49 11 47 10 46 6 44 10 44 13 44 15 48 15 48 18 52 22 51 24 50 24 48 26 46 26 46 18 45 12 42 12 31 12 27 13 24 15 22 15 22 13 18 15 13 15 13 20 13 24 17 27 15 37 15 40 17 44 13 49 13 49 13 51 20 49 22 49 22 51 24 52 27 52 31 52 42 45 45 38 46 39 47 40 49 40 52 L40 60 C40 61 40 62 42 62 45 62 64 53 64 32 64 14 50 0 32 0 Z" />
                        </svg>
                    </a>

                </div>
                <div class=" col-md-4">
                    <h4 class="text-uppercase mb-4">Developer</h4>
                    <div class="dropdown d-inline-block">
                        <button class="btn mb-2 mr-2 dropdown-toggle btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton1"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            Developer
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li><a class="dropdown-item" href="https://github.com/DOHAN25">김도한</a></li>
                            <li><a class="dropdown-item" href="https://github.com/dd-jiny">김대진</a></li>
                            <li><a class="dropdown-item" href="https://github.com/Taerin-Kim">김태린</a></li>
                            <li><a class="dropdown-item" href="https://github.com/jaehee-9638">이재희</a></li>
                            <li><a class="dropdown-item" href="https://github.com/1251024">장보옥</a></li>
                        </ul>
                    </div>
            	</div>
            </div>
        </div>



    </footer>

    <div class="copyright py-4 text-center text-light bg-dark">
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

</body>
</html>