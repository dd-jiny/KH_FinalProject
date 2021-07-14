<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>씨앗 마켓</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
   <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!--jquery (부트스트랩의 자바스트립트 플러그인을 위해 필요합니다.)-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
</head>
<body>
<%@include file="/WEB-INF/views/1header.jsp"%>

  <div class="container" style="width: 100%; padding-top:100px">
	<div style="text-align: center;">
		<h1>씨앗마켓 상품 상세 페이지</h1></div>
    <div class="col-md-8 col-md-offset-2 ">
      <div class="col-md-5">
	    <img id="productImg" src="${pageContext.request.contextPath}/resources${dto.productImg }" alt="상품이미지"
          class="img-responsive"  style="border :1px solid rgb(226, 226, 226);">
          
      </div>

      <div class="col-md-6 col-md-offset-1">
        <h4><!-- 상품명: -->${dto.productName }</h4>
        <h4><!-- 가격 -->${dto.productPrice }</h4>
        <hr>
        <p><!-- 상품정보 -->${dto.productInfo }</p>
        <span><b>구매혜택 </b></span><span>당근씨앗 드립니다</span><br>
        <span><b>배송 방법 </b></span><span>택배</span><br>
        <span><b>배송비 </b></span><span> 3,000</span>
        <div class="row" style="padding-top:20px;">
          <div class="col-md-12 " style="background-color: rgb(252, 244, 239);">
            <p style="padding-top: 15px;">수량</p>
            <hr style="border-top: dashed 1px rgb(255, 237, 214);">
            <div class="row">
              <div class="col-md-4">
                <!--수량선택 옵션-->
                <select class="form-control" style="margin-bottom: 20px;">
                  <option>1</option>
                  <option>2</option>
                  <option>3</option>
                  <option>4</option>
                  <option>5</option>
                  <option>6</option>
                  <option>7</option>
                  <option>8</option>
                  <option>9</option>
                  <option>10</option>
                </select>
              </div>
              <div class="col-md-4 col-md-offset-4">
              <!-- 추후 [option x productPrice]금액으로 수정하기  -->
               <div id=orderAmount> ${dto.productPrice }</div>
               <input type="hidden" id="orderAmount" value=" ${dto.productPrice }">
              </div>
            </div>
          </div>



        </div>
        <div class="row" style="padding-top:20px;">
          <div class="col-md-4"><b>총상품금액</b></div>
          <div class="col-md-4 col-md-offset-4">${dto.productPrice }</div>
        </div>
        <div class="row" style="padding-top:20px;">
          <div class="col-md-6">
          	<button type="button" class="btn btn-warning btn-block" onclick="location.href='adminproductorder.do?productSeq=${dto.productSeq }'">구매</button>
          </div>
          <div class="col-md-6">
          	<button type="button" class="btn btn-default btn-block" onclick="location.href='adminproduct.do'">상품목록</button>
          </div>

        </div>

      </div>
      <!--네비게이션-->
      <div class="col-md-12">
        <!-- 페이지 중앙에있는 선택 탭입니다.-->
        <ul class="nav nav-tabs nav-justified" style="margin-top:50px;">
          <li role="presentation" class="active"><a data-toggle="tab" href="#detail">상세정보</a></li>
          <li role="presentation"><a data-toggle="tab" href="#review">구매평</a></li>
          <li role="presentation"><a data-toggle="tab" href="#qna">Q&A</a></li>
          <li role="presentation"><a data-toggle="tab" href="#information">배송/반품/교환</a></li>
        </ul>
        <!--탭 안에있는 내용 입니다.-->
        <div class="tab-content">
          <!--상세정보 탭 내용입니다.-->
          <div id="detail" class="tab-pane fade in active">
            <h3>상세정보</h3>

            <h5><b>설명</b></h5>
			<p>${dto.productInfo }</p>			
            <p>헤어핀레그로 제작한 화분 스탠드는 화분을 세워둘 수 있는 철제 스탠드입니다.<br> 철제를 두껍게 제작하여 내구성이 튼튼하며 동 도금이 되어 있습니다.<br> 베란다뿐만 아니라 실내에서
              공기 정화 식물을 받쳐 사용해도 좋습니다. <br>화분 스탠드로 멋진 인테리어 포인트를 조성해보세요.<br>
              ※ 화분은 포함되어 있지 않습니다.<br>
              ※ 원형 스탠드에 맞는 화분사이즈는 아래와 같습니다.<br>
              - 국산 토분 3호 이상<br>
              - 독일 토분R 3호 이상<br>
              - 독일 토분L 4호 이상<br>
              - 독일 벨분 4호 이상<br>
              - 독일 더블링 토분 1호 이상<br></p>
            <h5><b>상품 필수 정보</b></h5>
            <div class="row">
              <div class="col-md-2">
                <p>규격(S)<br><br>규격(M)<br><br>재질<br><br>원산지</p>
              </div>
              <div class="col-md-10">
                <p>14.5 X (h) 40 cm<br><br>14.5 X (h) 60 cm<br><br>스틸(동 도금)<br><br>대한민국</p>
              </div>
            </div>

            





          </div>
          <!--구매평 탭 내용입니다.-->
          <div id="review" class="tab-pane fade">
            <h3>구매평</h3>
            <p>상품의 사용후기를 적어주세요.</p>
            <!--상품 후기 테이블-->
            <table class="table">
              <tr>
                <th>작성일</th>
                <th style="text-align: center;">상품평</th>
                <th>작성자</th>
              </tr>
              <tr>
                <td>2020.07.10</td>
                <td>바닥에 다 늘어두니까 너무 서로 겹치는거 같아서 화분 스탠드를 사봤는데 생각보다 들어가는 화분 사이즈도 좀 작고 높이도 그리 높진 않네요.</td>
                <td>앨리스</td>

              </tr>
            </table>
          </div>

          <!--qna탭 내용입니다.-->
          <div id="qna" class="tab-pane fade">
            <h1>Q&A</h1>
            <p>자주 묻는 질문입니다.</p>
            <!--qna아코디온(펼쳐지는 메뉴) 총 5개 입니다. -->
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
              <!--1-->
              <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                  <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true"
                      aria-controls="collapseOne">
                      1. 배송은 얼마나 걸리나요?
                    </a>
                  </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                  <div class="panel-body">
                    당근팜은 오후 2시 이전 입금에 한해서 택배를 통하여 당일배송을 해드리고 있습니다.<br>
                    토, 일요일, 공휴일의 경우 택배 영업소의 휴무로 택배업무를 하지 않습니다.<br> 또한 금요일 배송의 경우 지역마다 차이가 있어 주말에 배송이 이루어 지는 경우가 있고, 그렇지
                    않고 월요일에 배송이 이루어지는 경우가 있습니다.<br>
                  </div>
                </div>
              </div>
              <!--2-->
              <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingTwo">
                  <h4 class="panel-title">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"
                      aria-expanded="false" aria-controls="collapseTwo">
                      2. 주문 변경 및 취소를 하고 싶어요.
                    </a>
                  </h4>
                </div>
                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                  <div class="panel-body">
                    주문 후 주문 변경 혹은 취소가 필요하신가요?<br>
                    고객센터로 연락 부탁드립니다.<br>
                    ※ 고객센터 02-123-4567<br>
                  </div>
                </div>
              </div>
              <!--3-->
              <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingThree">
                  <h4 class="panel-title">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree"
                      aria-expanded="false" aria-controls="collapseThree">
                      3. 물건을 받으시고 한달 이내에 환불/교환/반품이 가능합니다.
                    </a>
                  </h4>
                </div>
                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                  <div class="panel-body">
                    환불/교환/반품을 원하시는 경우 고객센터에 전화를 주시면 안내를 해드립니다.<br>
                    고객센터와 연락없이 상품을 반품하는 경우 반송될 수 있으니 주의부탁드립니다.<br>
                  </div>
                </div>
              </div>
              <!--4-->
              <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingFour">
                  <h4 class="panel-title">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour"
                      aria-expanded="false" aria-controls="collapseFour">
                      4. 구성품 변경을 원합니다.
                    </a>
                  </h4>
                </div>
                <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                  <div class="panel-body">
                    배송메세지에 써주셔도 누락되는 경우가 있기 때문에, 주문 전 반드시 게시글 혹은 고객센터로 문의바랍니다.<br>
                    그 후 배송메세지에 써주시면 감사하겠습니다.<br>
                  </div>
                </div>
              </div>
              <!--5-->
              <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingFive">
                  <h4 class="panel-title">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive"
                      aria-expanded="false" aria-controls="collapseFive">
                      5. 무통장 입금시의 계좌번호 입니다.
                    </a>
                  </h4>
                </div>
                <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                  <div class="panel-body">
                    하나은행 : 000 - 123 - 123456<br>예금주 : 당근팜<br>
                  </div>
                </div>
              </div>
            </div>
            <!--아코디온 끝-->
          </div>

          <!--배송/반품/교환 탭 내용입니다.-->
          <div id="information" class="tab-pane fade">
            <div class="row" style="padding-top: 20px;">
              <div class="col-md-3">
                <h3><b>배송/반품/교환</b></h3>
              </div>
              <div class="col-md-9" style="padding-top: 15px;">
                <p><b>배송 방법</b>: 택배</p>
                <p><b>배송 지역</b>: 전국지역</p>
                <p><b>배송 비용</b>: 3,000원</p>
                <p><b>배송 기간</b>: 1일 ~ 5일</p>
                <p><b>배송 안내 :</b><br>
                  배송기간은 주문일(무통장입금은 결제완료일)로부터 영업일기준 1일~5일정도 걸립니다.<br>
                  구매 순 순차 출고이며, 배송 준비 시작 전까지만 취소가 가능합니다. * 취소는 반드시 고객센터로 유선연락바랍니다.<br>
                  오후 2시 이전 입금에 한해서 당일배송을 해드리고 있습니다.<br>
                  단, 금요일 오후 2시 이후 결제완료건은 다음주 영업일에 발송되며,<br>
                  주말과 공휴일을 지난 다음주 영업일의 경우 출고량이 많아 배송이 늦어질 수 있습니다.<br>
                  일반배송상품은 5만원 이상 주문시 무료배송되며, 5만원 미만시 3,000원의 배송비가 발생합니다.<br>
                  텃밭상품의 경우 파손 위험이 커 한박스에 여러개를 겹쳐 배송하는데 어려움이 있으니<br>
                  여러개 주문시에는 배송료를 문의해주시기 바랍니다.<br>
                  제작기간이 별도로 소요되는 상품의 경우에는 상품설명에 있는 제작기간과 배송시기를 숙지해 주시기 바랍니다.<br>
                  일부 상품의 경우에는 지역에 따라 별도의 추가 배송비용이 발생할 수 있습니다.</p>
                <p style="color: red;">※ 제주, 도서, 산간, 오지 지역 운송 시 배송비는 추가요금이 발생합니다.( 3,000원 + α )</p>
              </div>
            </div>
            <div class="row" style="padding-top: 20px;">
              <div class="col-md-3">
                <h3><b>반품 교환</b></h3>
              </div>
              <div class="col-md-9" style="padding-top: 15px;">
                <p>
                  <b>교환 및 반품시 고객이 왕복배송비를 부담해야 하는 경우</b><br>
                  1. 고객의 단순변심 및 판단착오 또는 상세페이지 미확인<br>
                  2. 사이즈 변경 및 컬러변경 또는 기타 사유로 반품을 원하는 경우<br>
                  3. 촬영 환경 및 모니터 해상도에 따른 상품의 컬러차이로 반품 및 교환을 원하는 경우<br><br>

                  <b>교환 및 반품이 절대 불가한 경우</b><br>
                  1. 상품을 이미 사용하거나 사용 하시려고 씻은 경우<br>
                  2. 상품 구매 후 한달이 경과한 경우 <br>
                  3. 고객의 과실로 제품 또는 포장이 훼손되거나 분실한 경우(택이나 스티커를 제거했을 경우 포함)<br>
                  4. 되돌려 보내주신 제품이 배송 중 파손된 경우<br>
                  5. 타쇼핑몰 또는 동일 쇼핑몰에서 더 저렴한 상품 확인 후 차액 환불 요청의 경우<br><br>

                  <b>무상 교환 및 반품이 가능한 경우</b><br>
                  1. 제품 하자 또는 택배사의 실수로 상품이 훼손 또는 분실된 경우<br>
                  2. 기타 판매자가 무상 교환 및 반품을 승인한 경우<br><br><br><br>
                </p>
              </div>
            </div>


          </div>

        </div>
        <hr>
      </div>
    </div>
  </div>

<%@include file="/WEB-INF/views/1footer.jsp"%>
</body>
</html>