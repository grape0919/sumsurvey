-- 질문 테이블
create table QUESTION(
	Q_ID INT not null autoincrement PRIMARY KEY,
	TITLE string not null,
	QUESION string not null
	);

-- 선택지 테이블
create table CHOICES(
	Q_ID INT not null,
	C_NUMBER INT not null,
	TEXT string not null,
    POINT INT,
	FOREIGN KEY(Q_ID) REFERENCES QUESTION(ID),
	PRIMARY KEY(Q_ID, C_NUMBER)
	);

-- 
create table SURV_RESULT(
    E_MAIL string NOT NULL,
    Q_ID INT NOT NULL,
    C_NUMBER INT NOT null,
    PRIMARY KEY(E_MAIL, Q_ID)
)

create table SURV_USER(
    E_MAIL string NOT NULL,
	AGE int not null,
	FOREIGN KEY(Q_ID) REFERENCES QUESTION(ID),
    PRIMARY KEY(ID)
)