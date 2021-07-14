
-------------------------상품 --------------------------------------
DROP SEQUENCE productSeq;
DROP TABLE Product;

CREATE SEQUENCE productSeq;

CREATE TABLE Product (
	productSeq NUMBER PRIMARY KEY NOT NULL,
	productName VARCHAR2(100) NOT NULL,
	productPrice NUMBER(30) NOT NULL,
	sellerAddress VARCHAR2(30),
	productRegDate DATE,
	productInfo VARCHAR2(4000),
	productImg VARCHAR2(4000),
	productThumb VARCHAR2(4000),
	saleStatus VARCHAR2(20),
	userRole VARCHAR2(10) NOT NULL,
	userSeq NUMBER NOT NULL,
	userId VARCHAR2(30),
	userLatitude VARCHAR2(1000),
	userLongitude VARCHAR2(1000) 
);



-------userRole = > ADMIN, USER
ALTER TABLE Product ADD CONSTRAINT FK_Product
FOREIGN KEY (userSeq) REFERENCES Users (userSeq)
ON DELETE CASCADE;

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '1인용 텃밭 세트', 12800, '운영자판매', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '운영자', NULL, NULL);

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '가정용 호미 세트', 9800, '운영자판매', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '운영자', NULL, NULL);

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '친환경 물뿌리개', 6800, '운영자판매', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '운영자', NULL, NULL);


INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '대진이가 심은 상추', 8000, '유저판매', SYSDATE, NULL, NULL, NULL, 'N', 'USER', 1, 'test', NULL, NULL);

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '태린이가 심은 고구마', 8800, '유저판매', SYSDATE, NULL, NULL, NULL, 'N','USER', 1, 'test', NULL, NULL);


SELECT * FROM Product;

SELECT * FROM Product
WHERE userRole = 'ADMIN'
ORDER BY productPrice DESC;

SELECT * FROM Product
WHERE userRole = 'USER'
ORDER BY productRegDate DESC;