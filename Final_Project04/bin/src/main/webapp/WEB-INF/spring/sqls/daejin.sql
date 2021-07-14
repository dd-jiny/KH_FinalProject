DROP SEQUENCE farmSeq;
DROP TABLE weekendFarm;

CREATE SEQUENCE farmSeq;

--위도 경도 추가해야할듯
CREATE TABLE weekendFarm(
	farmSeq NUMBER PRIMARY KEY NOT NULL,
	farmName VARCHAR2(100) NOT NULL,
	farmAddress VARCHAR2(200) NOT NULL,
	farmPhone NUMBER(30) NOT NULL
	
);

INSERT INTO weekendFarm
VALUES (farmSeq.NEXTVAL, '대진이네 농장', '경기도 고양시', '01097954578');

SELECT * FROM WEEKENDFARM;

----------------------boardtable--------------------------------

DROP SEQUENCE entireBoardSeq;
DROP TABLE entireBoard;

CREATE SEQUENCE entireBoardSeq;

CREATE TABLE entireBoard(
	entireBoardSeq NUMBER PRIMARY KEY NOT NULL,
	boardKind NUMBER NOT NULL,
	boardDate DATE NOT NULL,
	boardTitle VARCHAR2(200),
	boardContents VARCHAR2(4000), 
	userId VARCHAR2(30) NOT NULL,
	userSeq NUMBER NOT NULL,
	boardImg VARCHAR2(4000),
	boardThumbImg VARCHAR2(4000),
	likeCount NUMBER
);

ALTER TABLE entireBoard
ADD CONSTRAINT BOARD_USER_FK
FOREIGN KEY (userSeq)
REFERENCES USERS (userSeq)
ON DELETE CASCADE;

---sns:1, knowhow:2, notice:3

INSERT INTO entireBoard
VALUES (entireBoardSeq.NEXTVAL, 1, SYSDATE, '테스트글입니다.', '테스트내용입니다.', 'daejin', 1, NULL, NULL, 0);

INSERT INTO entireBoard
VALUES (entireBoardSeq.NEXTVAL, 1, SYSDATE, '테스트글입니다2.', '테스트내용입니다2.', 'daejin', 1, NULL, NULL, 0);

INSERT INTO entireBoard
VALUES (entireBoardSeq.NEXTVAL, 1, SYSDATE, '테스트글입니다3.', '테스트내용입니다3.', 'daejin', 1, NULL, NULL, 0);

INSERT INTO entireBoard
VALUES (entireBoardSeq.NEXTVAL, 3, SYSDATE, '공지사항제목', '공지사항내용', 'admin', 1, NULL, NULL, 0);

SELECT * FROM entireBoard;
SELECT * FROM USERS;
SELECT *
FROM entireBoard
WHERE boardKind = 1
ORDER BY boardDate ASC;

SELECT *
FROM entireBoard
WHERE boardKind = 1 AND userId = 'daejin'
ORDER BY boardDate DESC

SELECT *
FROM entireBoard
WHERE boardKind = 3
ORDER BY boardDate ASC;


-------------------------상품 --------------------------------------
DROP SEQUENCE productSeq;
DROP TABLE Product;

CREATE SEQUENCE productSeq;

CREATE TABLE Product (
	productSeq NUMBER PRIMARY KEY NOT NULL,
	productName VARCHAR2(100) NOT NULL,
	productPrice NUMBER(30) NOT NULL,
	sellerAddress VARCHAR2(1000),
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
VALUES (productSeq.NEXTVAL, '태린이가 심은 고구마', 8800, '유저판매', SYSDATE, NULL, NULL, NULL, 'N','USER', , 'test', "36.587769", "127.2323808");


INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '1인용 텃밭 세트', 12800, '운영자판매', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '운영자', NULL, NULL);

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '가정용 호미 세트', 9800, '운영자판매', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '운영자', NULL, NULL);

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '친환경 물뿌리개', 6800, '운영자판매', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '운영자', NULL, NULL);


INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '대진이가 심은 상추', 8000, '유저판매', SYSDATE, NULL, NULL, NULL, 'N', 'USER', 1, 'test', NULL, NULL);



DELETE FROM Product
WHERE userRole = 'USER'; 
SELECT * FROM Product;

DELETE FROM PRODUCT WHERE userRole = 'ADMIN';

SELECT * FROM Product
WHERE userRole = 'ADMIN'
ORDER BY productPrice DESC;

SELECT * FROM Product
WHERE userRole = 'USER'
ORDER BY productRegDate DESC;

----------------------댓글/대댓글------------------------
DROP SEQUENCE commentNoSeq;
DROP TABLE commentBoard;

CREATE SEQUENCE commentNoSeq;

CREATE TABLE commentBoard(
	commentNoSeq NUMBER PRIMARY KEY,    --댓글번호
	groupNo NUMBER,   --댓글이속한번호
	groupDepth NUMBER,   --댓글의 깊이 모댓글이면 0, 답글이면 1
	entireBoardSeq NUMBER NOT NULL,
	userSeq NUMBER NOT NULL,
	userId VARCHAR2(30) NOT NULL,
	replyContent VARCHAR2(2000),
	replyRegDate DATE 
	
);

ALTER TABLE commentBoard ADD CONSTRAINT FK_CommentBoard_ID
FOREIGN KEY (userSeq) REFERENCES Users (userSeq)
ON DELETE CASCADE;

ALTER TABLE commentBoard ADD CONSTRAINT FK_commentBoard_Ogigin
FOREIGN KEY (entireBoardSeq) REFERENCES entireBoard (entireBoardSeq)
ON DELETE CASCADE;

SELECT * 
FROM commentBoard
WHERE entireBoardSeq = 1;

--1번째 댓글 
INSERT INTO commentBoard
VALUES(commentNoSeq.NEXTVAL, 1, 0, 1, 1, 'daejin', '댓글 1 테스트입니다.', SYSDATE);

--2번째 댓글
INSERT INTO commentBoard
VALUES(commentNoSeq.NEXTVAL, 2, 0, 1, 1, 'daejin', '댓글 1 테스트입니다.', SYSDATE);

INSERT INTO commentBoard
VALUES(commentNoSeq.NEXTVAL, 2, 1, 1, 1, 'daejin', '댓글 1 테스트입니다.', SYSDATE);
---------------------팔로우-----------------------------
--SQL 수정 바람 
DROP SEQUENCE followSeq;
DROP TABLE followTable;

CREATE SEQUENCE followSeq;

CREATE TABLE followTable(
	followSeq NUMBER PRIMARY KEY,
	followingId VARCHAR2(100) NOT NULL,
	followerId VARCHAR2(100) NOT NULL
);

--------------------좋아요------------------------------
DROP SEQUENCE likeSeq;
DROP TABLE likeTable;

CREATE SEQUENCE likeSeq;

CREATE TABLE likeTable(
	likeSeq NUMBER PRIMARY KEY,
	userSeq NUMBER,
	userId VARCHAR2(100),
	entireBoardSeq NUMBER,
	likeCheck NUMBER DEFAULT 0
);

ALTER TABLE likeTable ADD CONSTRAINT FK_likeTable_Id
FOREIGN KEY (userSeq) REFERENCES Users (userSeq)
ON DELETE CASCADE;

ALTER TABLE likeTable ADD CONSTRAINT FK_likeTable_Board
FOREIGN KEY (entireBoardSeq) REFERENCES entireBoard (entireBoardSeq)
ON DELETE CASCADE;

SELECT * FROM likeTable;

--------------------해시태그----------------------------

DROP SEQUENCE hashTagSeq;
DROP TABLE hashTag;

CREATE SEQUENCE hashtagSeq;

CREATE TABLE hashTag(
	hashTagSeq NUMBER PRIMARY KEY,
	hashTagName VARCHAR2(30)
);

DROP SEQUENCE boardHashTagSeq;
DROP TABLE boardHashTag;

CREATE SEQUENCE boardHashTagSeq;

CREATE TABLE boardHashTag(
	boardHashTagSeq NUMBER PRIMARY KEY,
	hashTagSeq NUMBER NOT NULL,
	entireBoardSeq NUMBER NOT NULL
);

ALTER TABLE boardHashTag ADD CONSTRAINT FK_Hash_hash
FOREIGN KEY (hashTagSeq) REFERENCES hashTag (hashTagSeq)
ON DELETE CASCADE;

ALTER TABLE boardHashTag ADD CONSTRAINT FK_Hash_board
FOREIGN KEY (entireBoardSeq) REFERENCES entireBoard (entireBoardSeq)
ON DELETE CASCADE;

























