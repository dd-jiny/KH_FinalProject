<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>씨앗마켓 결제 페이지</title>
 <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>

<body>



<!-- !!!주문 정보!!! -->
<!-- Adminproductcontroller에서 보내준 값을 el태그에 받아서 input태그에 넣어준다. -->
<form name="orderinfo" id = "orderinfo">
	<!-- userseq: -->
	<input type="hidden" id="userseq" value="${login.userseq }">
	<br>
	<!-- 상품번호: -->
	<input type="hidden" id="productSeq" value="${dto.productSeq }">
	<br>
	<!-- 상품명: -->
	<input type="hidden" id="productName" value="${dto.productName }">
	<br>
	<!-- 상품가격: -->
	<input type="hidden" id="productPrice" value="${dto.productPrice }">
	<br>
	<!-- 수량: -->
	<input type="hidden" id="quantity" value="${quantity }">
	<br>
	<!-- 총가격: -->
	<input type="hidden" id="orderAmount" value="${orderAmount }">
	<br>
	<!-- 결제수단: -->
	<input type="hidden" id="paymethod" value="${paymethod }">
	<br>
	<!-- 주문자id: -->
	<input type="hidden" id="userid" value="${login.userid }">
	<br>
	<!-- 주문자 이름: -->
	<input type="hidden" id="receiveName" value="${receiveName }">
	<br>
	<!-- 주문자 연락처: -->
	<input type="hidden" id="receiverPhone" value="${receiverPhone }">
	<br>
	<!-- 주문자 우편번호: -->
	<input type="hidden" id="receiverOaddress" value="${receiverOaddress }">
	<br>
	<!-- 주문자 주소: -->
	<input type="hidden" id="receiverRaddress" value="${receiverRaddress }">
	<br>
	<!-- 상세주소: -->
	<input type="hidden" id="receiverDetailaddress" value="${receiverDetailaddress }">
</form>


	<script>
		
	
		//id를 이용하여 받아온 값을 변수에 넣어준다.
		var userSeq = $("#userseq").val();
		var productSeq = $("#productSeq").val();
		var productName = $("#productName").val();
		var quantity = $("#quantity").val();
		var orderAmount = $("#orderAmount").val();
		var paymethod = $("#paymethod").val();
		var userId = $("#userid").val();
		var receiveName = $("#receiveName").val();
		var receiverPhone = $("#receiverPhone").val();
		var receiverOaddress = $("#receiverOaddress").val();
		var receiverRaddress = $("#receiverRaddress").val();
		var receiverDetailaddress = $("#receiverDetailaddress").val();
		var paymethod = $("#paymethod").val();
		var productPrice = $("#productPrice").val();
		
		/* 넘길데이터 */
		var params = $("#orderinfo").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.

/* 		var params ={'userSeq':userSeq, 'productPrice': productPrice, 'productSeq':productSeq,'productName':productName, 'quantity':quantity, 
				'orderAmount':orderAmount, 'paymethod': paymethod, 'userId': userId,'receiveName':receiveName,
				'receiverPhone':receiverPhone,'receiverOaddress': receiverOaddress,  'receiverOaddress':receiverOaddress, 
				'receiverRaddress': receiverRaddress, 'receiverDetailaddress': receiverDetailaddress,'paymethod':paymethod };
	 */	console.log(params);

		
		$(function() {
			
			
			var IMP = window.IMP; // 생략가능
			IMP.init('imp98397380'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			var msg;

			IMP.request_pay({
				pg : 'kakaopay',
				paymethod : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : productName,
				buyer_name : receiveName,
				buyer_tel : receiverPhone,
				pay_type : paymethod,
				amount : orderAmount
			//m_redirect_url : 'http://www.naver.com'
			}, function(rsp) {
				if (rsp.success) {
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
					jQuery.ajax({
						//
						url : "${path}/adminproductorderPayRes.do", //cross-domain error가 발생하지 않도록 주의해주세요
						type : 'POST',
						dataType : 'text',
						contentType: 'application/json',
						data :JSON.stringify(params)
		
						/*  {
							
							$("#orderinfo").serialize();		
							
							imp_uid : rsp.imp_uid,
							buyer_name : name,
							buyer_email : email,
							buyer_tel : phone,
							pay_type : type,
							amount : orderAmount
							//기타 필요한 데이터가 있으면 추가 전달
						} */
					}).done(function(data) {
						//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						if (everythings_fine) {
							msg = '결제가 완료되었습니다.';
							msg += '\n고유ID : ' + rsp.imp_uid;
							msg += '\n상점 거래ID : ' + rsp.merchant_uid;
							msg += '\결제 금액 : ' + rsp.paid_amount;
							msg += '카드 승인번호 : ' + rsp.apply_num;

							alert(msg);

						} else {
							//[3] 아직 제대로 결제가 되지 않았습니다.
							//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
							msg = "done err";
							alert(msg);
						}
					});
					//성공시 이동할 페이지
					alert("결제 성공!")
            		
				} else {
					msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					//실패시 이동할 페이지
					alert(msg);

				}
			});

		});
	</script>
</body>
</html>