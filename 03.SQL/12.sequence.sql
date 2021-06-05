--12.sequence.sql
/*
1. 시퀀스 
	: 순차적인 순서 번호를 자동으로 반영할수 있는 매우 유용한 기술
	: 기본은 1씩 자동 증가
		- 증가치, 최대값 추가 설정도 가능
		- 권장 : 하나의 시퀀스를 다수의 table에서 사용 비추

2. 대표적인 활용 영역
	- 게시물 글번호에 주로 사용

*/	
	     
--1. sequence 생성 명령어


--2. seq~를 활용한 insert



--3. 다수의 table에서 하나의 seq를 공동 사용시?



--4. 시작 index 지정 및 증가치도 지정하는 seq 생성 명령어
drop sequence seq_test_no1;
create sequence seq_test_no1
start with 10
increment by 2
maxvalue 20;


--5. seq 삭제 명령어


--6. 현 sequence의 데이터값 검색하기




 


