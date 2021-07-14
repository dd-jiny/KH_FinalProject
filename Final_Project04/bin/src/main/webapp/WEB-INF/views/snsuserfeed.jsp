<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${empty login }">
		<div>로그인해주세요</div>
	</c:if>
	<!-- 로그인이 되었을때 -->
	<c:if test="${not empty login }">

		<div>${login.userid}님 안녕하세요.</div>
		
		
		<table border="1">
			<col width="20">
			<col width="100">
			<col width="300">
			<col width="200">
			
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
		
		<c:choose>

			<c:when test="${empty snsUserFeedList }">
				<tr>
					<th colspan="4">------ 작성된 글이 없습니다-----</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${snsUserFeedList }" var= "dto">

					<tr>
						<td>${dto.entireBoardSeq }</td>
						<td>${dto.userId }</td>
						<td>
							<button type="button" onclick="location.href='snsBoardOne.do?entireBoardSeq=${dto.entireBoardSeq }'">
								<img src="${pageContext.request.contextPath}/resources${dto.boardThumbImg }">
							</button>
						</td>
						<td>${dto.boardDate }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
			<tr>
				<td colspan="4" align="right"><input type="button" value="글작성" onclick="location.href='snsBoardInsertForm.do'"></td>
			</tr>
		</table>
		
	</c:if>


</body>
</html>