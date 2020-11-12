-- create table SURVEY(
-- 	ID INTEGER PRIMARY KEY,
-- 	TITLE TEXT not null,
-- 	DESCRIPTION TEXT
-- );

create table QUESTION(
	Q_ID INTEGER PRIMARY KEY,
	TITLE TEXT not null,
	QUESTION TEXT not null
	);

create table CHOICES(
	Q_ID INTEGER not null,
	C_NUMBER INTEGER not null,
	TEXT TEXT not null,
    POINT INTEGER,
	CONSTRAINT CHOICES_FK FOREIGN KEY(Q_ID)
	REFERENCES QUESTION(Q_ID)
	PRIMARY KEY(Q_ID, C_NUMBER)
	);

create table RESULT(
	-- S_ID INTEGER not null,
	R_ID INTEGER not null,
	NAME TEXT not NULL,
	-- CONSTRAINT RESULT_FK FOREIGN KEY(S_ID)
	-- REFERENCES SURVEY(ID)
	PRIMARY KEY(R_ID)

);

create table COMPLETE_SURVEY(
	ID INTEGER not null,
	Q_ID INTEGER not null,
	C_ID INTEGER not null,
	CONSTRAINT COMPLETE_FK FOREIGN KEY(Q_ID)
	REFERENCES QUESTION(Q_ID)
	CONSTRAINT COMPLETE_FK2 FOREIGN KEY(C_ID)
	REFERENCES CHOICES(C_NUMBER)
	PRIMARY KEY(ID, Q_ID)
);

create table STATISTIC(
	ID INTEGER PRIMARY KEY AUTOINCREMENT,
	Q_ID INTEGER not null,
	CNT INTEGER DEFAULT 0,
	CONSTRAINT STATISTIC_FK FOREIGN KEY(Q_ID)
	REFERENCES RESULT(Q_ID)
);

--답변
insert into QUESTION(Q_ID, TITLE, QUESTION) values(1, '성별', '고객님의 성별은?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(2, '연령', '고객님의 연령대는? ');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(3, '목적', '방문목적은 무엇입니까?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(4, '경험', '귀하께서는 경륜, 경정 휴장기간 동안 불법도박을 이용하신 경험이 있으십니까?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(5, '도박형태', '귀하께서는 경륜, 경정 휴장기간 동안 불법도박을 이용하셨다면, 어떤 행태의 불법도박입니까?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(6, '도박이유', '귀하께서 경륜, 경정 휴장기간 동안 불법도박을 이용하신 이유는 무엇입니까?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(7, '휴장기간이용여부', '귀하께서는 경륜, 경정 휴장기간 이전에도 불법도박을 이용하셨습니까?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(8, '온라인구매이용', '귀하께서는 경륜, 경정에서도 온라인 구매가 가능하다면 온라인 구매를 이용하시겠습니까?');

--문항
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (1,1,'남성', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (1,2,'여성', 2);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,1,'20대', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,2,'30대', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,3,'40대', 3);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,4,'50대', 4);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,1,'나들이 또는 데이트', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,2,'베팅참여', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,3,'스포츠(경주)관람', 3);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,4,'내부시설이용', 4);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,5,'기타', 5);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (4,1,'있습니다.', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (4,2,'없습니다.', 2);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,1,'온라인 불법사이트', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,2,'집 근처 불법도박시설', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,3,'기타', 3);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,4,'해당없음', 4);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,1,'경륜, 경정 등 합법사업이 휴장해서', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,2,'불법도박이 접근하기 쉬워서', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,3,'불법도박이 배당률이 높아서', 3);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,4,'단순 호기심', 4);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,5,'신속하게 환전이 가능해서', 5);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,6,'기타', 6);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (7,1,'이용했습니다.', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (7,2,'이용하지 않았습니다.', 2);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (8,1,'이용하겠습니다.', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (8,2,'이용하지 않겠습니다.', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (8,3,'모르겠습니다.', 3);


-- 결과
insert into RESULT(R_ID, NAME) values(1, '감사합니다');
insert into RESULT(R_ID, NAME) values(2, '감사합니다');
insert into RESULT(R_ID, NAME) values(3, '감사합니다');
insert into RESULT(R_ID, NAME) values(4, '감사합니다');

-- 통계정보
insert into STATISTIC(Q_ID, CNT) values(0, 0);
insert into STATISTIC(Q_ID, CNT) values(1, 0);
insert into STATISTIC(Q_ID, CNT) values(2, 0);
insert into STATISTIC(Q_ID, CNT) values(3, 0);
insert into STATISTIC(Q_ID, CNT) values(4, 0);
insert into STATISTIC(Q_ID, CNT) values(5, 0);
insert into STATISTIC(Q_ID, CNT) values(6, 0);
insert into STATISTIC(Q_ID, CNT) values(7, 0);
insert into STATISTIC(Q_ID, CNT) values(8, 0);