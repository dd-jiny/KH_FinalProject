<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>
	<h1>snsboardupdate</h1>
	<form action="snsBoardUpdateRes.do" method="post">
	<input type="hidden" name="entireBoardSeq" value="${dto.entireBoardSeq }">
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
			<td><textarea rows="10" cols="60" name="boardContents">${dto.boardContents }</textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="글수정" />
				<input type="button" value="취소" onclick="location.href='snsBoardDetail.do'"/>
			</td>
		</tr>
		</table>
		
	</form>
<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>