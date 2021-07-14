<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 당근 거래/나눔</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	
$(document).ready(function(){	
	
	
	$("#searchBtn").click(function (){
		var selectBox = $("#selectBox option:selected").val();
		var searchVal = document.getElementById("searchVal").value;
		console.log(selectBox);
		
		if(selectBox == "" || selectBox == null) {
				alert("카테고리를 선택해 주세요.!");
				$("#searchVal").focus();
				
		} else if(selectBox === "addr") {
			
			var addrVal = {
					"sellerAddress": searchVal
			}
			
			$.ajax({
				type: "post",
				url: "searchProduct.do",
				data: JSON.stringify(addrVal),
				contentType: "application/json",
				dataType:"json",
				success:function(data) {
				//console.log(data.list.length);
				//console.log(data.list[0].productName);
			
				var html = "<tr>";
					for(var i = 0; i < data.list.length; i++) {
						html += "<td>"+data.list[i].productRegDate+"</td>";
						html += "<td>"+data.list[i].userId+"</td>";
						html += "<td><a href='userproductdetail.do?productSeq="+data.list[i].productSeq+"'>"+data.list[i].productName+"</a></td>";
						html += "<td>"+data.list[i].productPrice+"</td>";
						html += "<td>"+data.list[i].sellerAddress+"</td>";	
					}
					html += "</tr>";
					$("#dynamicTbody").empty();
					$("#dynamicTbody").append(html);
				}
				
			});
		} else if(selectBox === "productName") {
			
			var addrVal = {
					"productName": searchVal
			}
			
			$.ajax({
				type: "post",
				url: "searchProduct.do",
				data: JSON.stringify(addrVal),
				contentType: "application/json",
				dataType:"json",
				success:function(data) {
				//console.log(data.list.length);
				//console.log(data.list[0].productName);
			
				var html = "<tr>";
					for(var i = 0; i < data.list.length; i++) {
						html += "<td>"+data.list[i].productRegDate+"</td>";
						html += "<td>"+data.list[i].userId+"</td>";
						html += "<td><a href='userproductdetail.do?productSeq="+data.list[i].productSeq+"'>"+data.list[i].productName+"</a></td>";
						html += "<td>"+data.list[i].productPrice+"</td>";
						html += "<td>"+data.list[i].sellerAddress+"</td>";	
					}
					html += "</tr><br>";
					$("#dynamicTbody").empty();
					$("#dynamicTbody").append(html);
				}
				
			});
		}
			
		
	
		
	});


});

</script>
<body>
	<h1>당근마켓 상품 리스트</h1>

	<a href="userproductinsert.do">상품등록</a>
	<br>
	<select id="selectBox">
		<option value="">선택</option>
		<option value="addr">지역</option>
		<option value="productName">상품명</option>
	</select>
	<input id="searchVal" type="text"/>
	<button id="searchBtn">검색</button>
	
	
	<table border="1">
	<col width="200">
	<col width="100">
	<col width="200">
	<col width="100">
	<col width="300">
	
	<tr>
		<th>등록날짜</th>
		<th>유저ID</th>
		<th>상품명</th>
		<th>상품가격</th>
		<th>판매자주소</th>
	</tr>
	<tbody id="dynamicTbody">
		<c:choose>
			<c:when test="${empty userProductList }">
				<tr>
					<th colspan="4">------ 작성된 글이 없습니다 ------ </th>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${userProductList }" var="dto">
				
					<tr>
						<td>${dto.productRegDate }</td>
						<td>${dto.userId }</td>
						<td><a href="userproductdetail.do?productSeq=${dto.productSeq }">${dto.productName }</a></td>
						<td>${dto.productPrice }</td>
						<td>${dto.sellerAddress }</td>
					</tr>
				
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
		<tr>
			<td colspan="4" align="right"><input type="button" value="글작성" onclick="location.href='productinsert.do'"></td>
		</tr>
	</table>

</body>
</html>




















