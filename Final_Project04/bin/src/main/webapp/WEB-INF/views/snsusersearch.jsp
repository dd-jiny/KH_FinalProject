<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#searchBtn").click(function(){
		var selectBox = $("#selectBox option:selected").val();
		var searchVal = document.getElementById("searchVal").value;
		
		if(selectBox == "" || selectBox == null) {
			alert("카테고리를 선택해 주세요!");
			$("#searchVal").focus();
			
		} else if(selectBox === "userid") {
			
			var useridVal = {
					"userid" : searchVal
			}
			
			$.ajax({
				type: "post",
				url: "searchUser.do",
				data: JSON.stringify(useridVal),
				contentType: "application/json",
				dataType:"json",
				success: function(data) {
					console.log(data)
					//console.log(data.list.length);
					//console.log(data.list[0].userid);
					var html = "<tr>";
					for(var i = 0; i < data.userList.length; i++) {
						html += "<td><a href='snsBoardUserFeed.do?userId="+data.userList[i].userid+"'>"+data.userList[i].userid+"</a></td>";
						html += "<td>"+data.userList[i].username+"</td>";
					}
					html += "</td>";
					$("#dynamicTbody").empty();
					$("#dynamicTbody").append(html);
				}
			});
		} else if(selectBox === "username") {
			
			var usernameVal = {
					"username" : searchVal
			}
			
			$.ajax({
				type: "post",
				url: "searchUser.do",
				data: JSON.stringify(usernameVal),
				contentType: "application/json",
				dataType:"json",
				success: function(data) {
					
					var html = "<tr>";
					for(var i = 0; i < data.userList.length; i++) {
						html += "<td><a href='snsBoardUserFeed.do?userId="+data.userList[i].userid+"'>"+data.userList[i].userid+"</a></td>";
						html += "<td>"+data.userList[i].username+"</td>";
					}
				}
			});
		}
	});
});
	
</script>
<body>

	<h1>유저검색창</h1>
	
	<select id="selectBox">
		<option value="">선택</option>
		<option value="userid">유저아이디</option>
		<option value="username">유저이름</option>
	</select>
	<input id="searchVal" type="text"/>
	<button id="searchBtn">검색</button>
	
	<table border="1">
	<col width="200">
	<col width="100">
	
	<tr>
		<!-- 유저프로필 넣어야함 -->
		<th>유저id</th>
		<th>유저이름</th>
	</tr>
	
	<tbody id="dynamicTbody">
		<c:choose>
			<c:when test="${empty userList }">
				<tr>
					<th colspan="4">-------검색된 값이 없습니다.-----</th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${userList }" var="userdto">
					<tr>
						<td><a href="snsBoardUserFeed.do?userId=${userdto.userid }">${userdto.userid }</a></td>
						<td>${userdto.username }</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>

	</table>

</body>
</html>