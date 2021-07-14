--상품주문 결제 테이블

/*주문번호
 * 운영자 판매상품 등록번호(product seq -product 테이블 참조)
 * 운영자판매 상품명(product name)
 * 운영자 판매 상품 가격(product price)
 * 수량
 * 배송비
 * 총가격
 * 결제 수단
 * 
 * 유저 등록번호(user seq)
 * 유저 아이디(user id)
 * 
 * 받는사람 이름
 * 받는사람 연락처
 * 받는사람 우편번호
 * 받는사람 주소
 * 받는사람 상세주소
 * 주문날짜
 */
DROP TABLE productorder;

DROP SEQUENCE orderSeq;

CREATE SEQUENCE orderSeq;

CREATE TABLE productorder (
	orderSeq NUMBER PRIMARY KEY,
	productSeq NUMBER(30),
	productName VARCHAR2(100) NOT NULL,
	productPrice NUMBER(30) NOT NULL,
	quantity NUMBER(30) NOT NULL,
	deliveryfee NUMBER(30) NOT NULL,
	orderAmount NUMBER NOT NULL,
	paymethod VARCHAR2(100) NOT NULL,
	userSeq NUMBER(30) NOT NULL,
	userId VARCHAR2(200) NOT NULL,
	receiveName VARCHAR2(100) NOT NULL,
	receiverPhone VARCHAR2(200) NOT NULL,
	receiverOaddress VARCHAR2(4000) NOT NULL,
	receiverRaddress VARCHAR2(4000) NOT NULL,
	receiverDetailaddress VARCHAR2(4000) NOT NULL,
	orderDate DATE NOT NULL,
	CONSTRAINT FK_userSeq FOREIGN KEY(userSeq) REFERENCES USERS(USERSEQ)
);

SELECT * FROM productorder;

INSERT INTO productorder
VALUES(orderSeq.NEXTVAL, 44, '가지씨앗 500립',  1000, 2, 2500, 4500, 'CREDIT', 39, 'boock00', 
'receiveName', 'receiverPhone', 'receiverOaddress', 'receiverRaddress', 'receiverDetailaddress',SYSDATE );



