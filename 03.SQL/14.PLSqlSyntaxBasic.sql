--14.PLSqlSyntaxBasic.sql
/* 
* 프로시저 & 함수
- 재사용을 위한 기능 구현
1. 프로시저
	- 호출 방법이 함수와 차이가 있음
2. 함수
	- oracle 함수 호출하듯 사용자 정의 함수 호출 가능

------
1. oracle db만의 프로그래밍 개발 방법
	1. 이름 없이 단순 개발
	2. 프로스저라는 타이틀로 개발 - 이름 부여(재사용)
	3. 함수라는 타이틀로 개발 - 이름 부여(재사용)

2. 장점
	- 단 한번의 실행 만으로 내장 함수처럼 만들어서 필요시 호출해서 실행 가능
	- 프로시저와 함수로 구현시 db내부에 pcode로 변환

3. test를 위한 필수 셋팅 
	- set serveroutput on 
	
4. 필수 암기 
	1. 할당(대입) 연산자  :=
	2. 선언, 시작, 끝
		declare ~ begin ~ end; /
*/

--1. 실행 결과 확인을 위한 필수 설정 명령어
set serveroutput on

--2. 연산을 통한 간단한 문법 습득
declare
	no integer;
begin
	no := 10;
	dbms_output.put_line('결과 ' || no);

	no := 10 / 5;
	dbms_output.put_line('결과 ' || no);
end;
/

--3. 연산을 통한 간단한 문법 습득 + 예외 처리 문장
-- 혹여 문제가 생겨도 프로그램 종료가 아니라 유연하게 실행 유지

-- 예외처리시 실행 유지
-- 예외 미처리시 실행 강제 종료




--4. 중첩 block & 변수 선언 위치에 따른 구분
-- step01 - 전역, 로컬 변수 선언 및 활용



--5. step02 - 전역, 로컬 변수 선언 및 활용 범위 확인 



--6. emp01 table의 컬럼 타입을 그대로 사용하고 싶다면?
	-- %type : db의 특정 컬럼의 타입 의미
drop table emp01;
create table emp01 as select * from emp;




--7. 이미 존재하는 table의 record의 모든 컬럼 타입 활용 키워드 : %rowtype
/* 7369 사번으로 해당 사원의 모든 정보를 검색해서 사번, 이름만 착출해서 출력 */




--8. ???
-- emp05라는 table을 데이터 없이 emp table로 부터 생성하기
-- %rowtype을 사용하셔서 emp의 사번이 7369인 사원 정보 검색해서 
-- emp05 table에 insert
-- 힌트 : begin 부분엔 다수의 sql문장 작성 가능, into 절
drop table emp05;
create table emp05 as select * from emp where 1=0;





select * from emp05;


--9. 조건식
/*  1. 단일 조건식
	if(조건) then
		
	end if;
	
   2. 다중 조건
	if(조건1) then
		조건1이 true인 경우 실행되는 블록 
	elsif(조건2) then
		조건2가 true인 경우 실행되는 블록
	end if; 
*/
-- 사원의 연봉을 계산하는 procedure 개발[comm이 null인 
-- 직원들은 0으로 치환]


select empno, ename, sal, comm 
	from emp 
	where ename='SMITH';

-- 10.??? 실행시 가변적인 데이터 적용해 보기
-- 실행시마다 가변적인 데이터(동적 데이터) 반영하는 문법 : 변수 선언시 "&변수명"

-- emp table의 deptno=10 : ACCOUNT 출력, 
-- deptno=20 이라면 RESEARCH 출력
-- test data는 emp table의 각 사원의 사번(empno)




--11. 반복문
/* 
1. 기본
	loop 
		ps/sql 문장들 + 조건에 사용될 업데이트
		exit 조건;
	end loop;

2. while 기본문법
	 while 조건식 loop
		plsql 문장;
	 end loop;

3. for 기본 문법
	for 변수 in [reverse] start ..end loop
		plsql문장
	end loop;
*/
-- loop 
declare
	num number(2) := 0;
begin
	loop
		dbms_output.put_line(num);
		num := num+1;
		exit when num > 5;
	end loop;
end;
/

-- while



-- for 
-- 오름차순




-- 내림차순



--12.? emp table 직원들의 사번을 입*력받아서(동적데이터) 해당하는 
-- 사원의 이름 음절 수 만큼 * 표 찍기 
-- length()

