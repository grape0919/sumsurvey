-- 질문 테이블
create table QUESTION(
	ID INT not null AUTO_INCREMENT PRIMARY KEY,
	TITLE TEXT not null,
	QUESION TEXT not null
	);

-- 선택지 테이블
create table CHOICES(
	Q_ID INT not null,
	C_NUMBER INT not null,
	TEXT TEXT not null,
    POINT INT,
	FOREIGN KEY(Q_ID) REFERENCES QUESTION(ID),
	PRIMARY KEY(Q_ID, C_NUMBER)
	);

-- 
create table SURV_RESULT(
    E_MAIL TEXT NOT NULL,
    Q_ID INT NOT NULL,
    C_NUMBER INT NOT null
    PRIMARY KEY(E_MAIL, Q_ID)
)

create table SURV_USER(
    ID INT NOT NULL,
    NAME VARCHAR(32) NOT NULL
    PRIMARY KEY(ID)
)