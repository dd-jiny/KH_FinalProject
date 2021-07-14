DROP SEQUENCE farmSeq;
DROP TABLE weekendFarm;

CREATE SEQUENCE farmSeq;

--���� �浵 �߰��ؾ��ҵ�
CREATE TABLE weekendFarm(
	farmSeq NUMBER PRIMARY KEY NOT NULL,
	farmName VARCHAR2(100) NOT NULL,
	farmAddress VARCHAR2(200) NOT NULL,
	farmPhone NUMBER(30) NOT NULL
	
);

INSERT INTO weekendFarm
VALUES (farmSeq.NEXTVAL, '�����̳� ����', '��⵵ ����', '01097954578');

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
VALUES (entireBoardSeq.NEXTVAL, 1, SYSDATE, '�׽�Ʈ���Դϴ�.', '�׽�Ʈ�����Դϴ�.', 'daejin', 1, NULL, NULL, 0);

INSERT INTO entireBoard
VALUES (entireBoardSeq.NEXTVAL, 1, SYSDATE, '�׽�Ʈ���Դϴ�2.', '�׽�Ʈ�����Դϴ�2.', 'daejin', 1, NULL, NULL, 0);

INSERT INTO entireBoard
VALUES (entireBoardSeq.NEXTVAL, 1, SYSDATE, '�׽�Ʈ���Դϴ�3.', '�׽�Ʈ�����Դϴ�3.', 'daejin', 1, NULL, NULL, 0);

INSERT INTO entireBoard
VALUES (entireBoardSeq.NEXTVAL, 3, SYSDATE, '������������', '�������׳���', 'admin', 1, NULL, NULL, 0);

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


-------------------------��ǰ --------------------------------------
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
VALUES (productSeq.NEXTVAL, '�¸��̰� ���� ����', 8800, '�����Ǹ�', SYSDATE, NULL, NULL, NULL, 'N','USER', , 'test', "36.587769", "127.2323808");


INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '1�ο� �Թ� ��Ʈ', 12800, '����Ǹ�', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '���', NULL, NULL);

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '������ ȣ�� ��Ʈ', 9800, '����Ǹ�', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '���', NULL, NULL);

INSERT INTO Product 
VALUES (productSeq.NEXTVAL, 'ģȯ�� ���Ѹ���', 6800, '����Ǹ�', NULL, NULL, NULL, NULL, 'Y', 'ADMIN', 1, '���', NULL, NULL);


INSERT INTO Product 
VALUES (productSeq.NEXTVAL, '�����̰� ���� ����', 8000, '�����Ǹ�', SYSDATE, NULL, NULL, NULL, 'N', 'USER', 1, 'test', NULL, NULL);



DELETE FROM Product
WHERE userRole = 'USER'; 
SELECT * FROM Product;

DELETE FROM PRODUCT WHERE userRole = 'ADMIN';

SELECT * FROM Product
WHERE userRole = 'ADMIN';

SELECT * FROM Product
WHERE userRole = 'USER'
ORDER BY productRegDate DESC;

----------------------���/����------------------------
DROP SEQUENCE commentNoSeq;
DROP TABLE commentBoard;

CREATE SEQUENCE commentNoSeq;

CREATE TABLE commentBoard(
	commentNoSeq NUMBER PRIMARY KEY,    --��۹�ȣ
	groupNo NUMBER,   --����̼��ѹ�ȣ
	groupDepth NUMBER,   --����� ���� �����̸� 0, ����̸� 1
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

--1��° ��� 
INSERT INTO commentBoard
VALUES(commentNoSeq.NEXTVAL, 1, 0, 1, 1, 'daejin', '��� 1 �׽�Ʈ�Դϴ�.', SYSDATE);

--2��° ���
INSERT INTO commentBoard
VALUES(commentNoSeq.NEXTVAL, 2, 0, 1, 1, 'daejin', '��� 1 �׽�Ʈ�Դϴ�.', SYSDATE);

INSERT INTO commentBoard
VALUES(commentNoSeq.NEXTVAL, 2, 1, 1, 1, 'daejin', '��� 1 �׽�Ʈ�Դϴ�.', SYSDATE);
---------------------�ȷο�-----------------------------
--SQL ���� �ٶ� 
DROP SEQUENCE followSeq;
DROP TABLE followTable;

CREATE SEQUENCE followSeq;

CREATE TABLE followTable(
	followSeq NUMBER PRIMARY KEY,
	following_ID VARCHAR2(100),
	follower_ID VARCHAR2(100)
);

--------------------���ƿ�------------------------------
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

--------------------�ؽ��±�----------------------------

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

SELECT * FROM USERS;























