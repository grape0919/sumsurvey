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

--답변
insert into QUESTION(Q_ID, TITLE, QUESTION) values(1, '여행_짐', '1박2일 짧은 여행을 떠날 때에 나는...');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(2, '여행_식사', '나는 여행지에서 식사를 주로,,,');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(3, '여행_인원', '나는 충전이 필요할 때');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(4, '여행_자연', '여행지에서 자연이 갖는 의미는?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(5, '무인도_집', '무인도에서 일주일동안 지낼 집을 지어야 한다. 내 집은...');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(6, '무인도_화장실', '그렇다면 무인도에서 지낼 화장실은...?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(7, '성향_형용사', '나와 어울리는 단어는?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(8, '성향_음악', '내가 좋아하는 음악은?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(9, '취미_종류', '나의 취미는?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(10, '취미_비용', '나는 취미생활에 이정도 투자한다!');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(11, '개인_차량', '나는 차량이 있다/없다.');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(12, '개인_성별', '나의 성별은?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(13, '개인_나이', '나의 나이는?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(14, '캠핑_경험', '나의 캠핑경험은?');
insert into QUESTION(Q_ID, TITLE, QUESTION) values(15, '캠핑_니즈', '내가 원하는 캠핑분위기는?');

--문항
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (1,1,'1박인데 뭘 챙겨 옷가지랑 세면도구면 충분하지!', 8);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (1,2,'핸드폰은 계속 써야지, 보조 배터리정도는 챙긴다!', 9);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (1,3,'나만의 필수 전자기기 (드라이기, 면도기, 멀티탭 등)가 있다!', 6);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (1,4,'모든 장비가 갖춰진 여행지로만 간다 (또는 캐리어 가득 챙김)!', 6);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,1,'먹는데 뭘 신경을 써, 라면이면 충분!', 8);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,2,'오손도손 차려먹는 맛이 있지, 간단한 조리식품으로!', 5);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,3,'놀 때 먹는게 제일 중요하지! 불 피우고 바비큐 고고!', 6);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (2,4,'없음', 0);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,1,'혼자 조용히 시간을 보내며 마음을 채운다.', 9);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,2,'마음이 잘 통하는 한두명과 속 깊은 이야기를 나눈다.', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,3,'세네명의 친구들과 맛있는 음식과 소소한 수다를 즐긴다.', 7);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (3,4,'사람이 많을 수록 좋다. 파티나 모임에 참석한다.', 2);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (4,1,'경치와 분위기를 만들어 준다', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (4,2,'자연과 교감하며 영감을 받는다', 9);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (4,3,'자연을 지키는 것이 최우선! 눈으로만 본다!', 12);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (4,4,'좋은 자연경관은 여행지 선택의 가장 중요한 요소다!', 12);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,1,'비바람, 벌레 정도 피할 수 있는 움막', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,2,'갑자기 누가 들어오면 어떻게 해, 울타리는 있어야지!', 4);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,3,'걸어다닐 수는 있었으면 해~ 층고가 높은 집!', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (5,4,'자연 속에서 지내지 뭐, 땅만 파면 집 완성!', 8);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,1,'자연이 곧 화장실, 적당한 장소만 지정하면 끝!', 8);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,2,'쪼그려 앉는건 싫어, 변기정도는 만들어주세요.', 9);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,3,'물은 잘 나와야지~ 급수대는 꼭 필요해요!', 7);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (6,4,'나는 매일 샤워를 꼭 해야해! 샤워부스까지 부탁해요!', 2);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (7,1,'편안한', 5);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (7,2,'화려한', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (7,3,'고독한', 8);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (7,4,'힙한', 6);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (8,1,'재즈', 8);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (8,2,'힙합', 10);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (8,3,'팝송', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (8,4,'가요', 6);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (9,1,'여행/사진', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (9,2,'영화/전시', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (9,3,'운동/레져', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (9,4,'게임/맛집', 0);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (10,1,'취미는 장비빨! 멋진 장비 몇가지 갖춰야 취미라 할 수 있다.', 5);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (10,2,'잠시 즐기는 것이니 장비는 대여가 마음 편하다!', 3);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (10,3,'많은 투자 없이도 간단히 즐길 수 있는 취미가 좋다!', 3);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (10,4,'할거면 제대로! 준 프로급으로 장비를 갖춰서 즐긴다!', 12);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (11,1,'없음', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (11,2,'경차', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (11,3,'승용차', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (11,4,'SUV 이상', 4);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (12,1,'남', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (12,2,'여', 0);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (13,1,'20대', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (13,2,'30대', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (13,3,'40대', 0);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (13,4,'50대 이상', 0);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (14,1,'없음', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (14,2,'1-3회', 5);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (14,3,'3-5회', 9);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (14,4,'5회 이상', 8);

insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (15,1,'소소한 힐링', 1);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (15,2,'자연속 고요', 8);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (15,3,'즐거운 파티', 2);
insert into CHOICES(Q_ID,C_NUMBER,TEXT,POINT) values (15,4,'자연속 아늑함', 4);

-- 결과
insert into RESULT(R_ID, NAME) values(1, '캠핑');
insert into RESULT(R_ID, NAME) values(2, '글램핑');
insert into RESULT(R_ID, NAME) values(3, '오토캠핑');
insert into RESULT(R_ID, NAME) values(4, '비박');