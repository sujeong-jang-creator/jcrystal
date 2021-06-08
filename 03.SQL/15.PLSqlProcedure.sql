--15.PLSqlProcedure.sql
/*
1. 저장 프로시저
	- 이름을 부여해서 필요한 시점에 재사용 가능한 plsql
	- DB에 사용자 정의 기능을 등록 -> 필요한 시점에 사용

2. 문법
	2-1. 생성만
		- 이미 동일한 이름의 procedure가 존재할 경우 error 발생 
		create procedure  이름
		is
		begin
		end;
		/

	2-2. 생성 및 치환
    		- 미 존재할 경우 생성, 존재할 경우 치화
		create or replace procedure
		is
		begin
		end;
		/

3. 에러 발생시
show error

4. 예시 - table관점


*/


--1. procedure 정보 확인 sql문장
desc user_source;
select * from user_source;


--2. 실습을 위한 test table
drop table dept01;
create table dept01 as select * from dept;
drop table emp01;
create table emp01 as select * from emp;


--3. emp01의 부서 번호가 20인 모든 사원의 job을 
-- STUDENT로 변경하는 프로시저 생성
-- 함수와 호출 방식이 다름
create or replace procedure update_job
is
begin
	update emp01 set job = 'STUDENT' where deptno=20;
end;
/
select * from emp01;
select * from user_source;

-- db에 등록은 되어 있으나 호출은 아직 안 한 상태

-- 프로시저 실행하는 명령어
execute update_job;
select * from emp01;

rollback;
select * from emp01;



--4. 가변적인 사번(동적)으로 실행시마다 해당 사원의 급여에 +500 하는 프로시저 생성하기
-- sql문장 상의 컬럼에 plsql 변수값 대입할 경우엔 
-- 기본 대입 연산자 활용(=)
-- plsql 변수에 값 할당시에는 할당 연산자 활용(:=)
select empno, sal from emp01 where empno=7369;

create or replace procedure sal_update(v_empno emp.empno%type)
is
begin
	update emp01 set sal=sal+500 where empno=v_empno;
end;
/


execute sal_update(7369);
select empno, sal from emp01 where empno=7369;


--5.? 사번(empno)과, 급여(sal)를 입력받아서 해당 직원의 희망급여를 변경하는 프로시저 
-- 프로시저명 : update_sal

select empno, sal from emp01 where empno=7369;

create or replace procedure update_sal
(v_empno emp01.empno%type, v_sal emp01.sal%type)
is
begin
	update emp01 set sal=v_sal where empno=v_empno; 
end;
/

execute update_sal(7369, 2000);
select empno, sal from emp01 where empno=7369;



--6. 이름과 사번, 급여 검색하기
	-- inout 모드(용도를 키워드로 표현)
	-- IN : procedure 내부에서 사용되기만 하는 변수 의미
	-- OUT : procedure 수행 후에 호출한 곳으로 값을 제공해주는 특별한 변수
-- 일반 함수 : return 키워드로 명확하게 값을 함수를 호출한 곳으로 반환
create or replace procedure info_empinfo
(
	v_ename IN emp01.ename%type,
	v_empno OUT emp01.empno%type,
	v_sal OUT emp01.sal%type
)
is
begin
	select empno, sal
		into v_empno, v_sal
	from emp
	where ename=v_ename;
end;
/ 


-- sqlplus 창에서 변수 선언
--plsql 프로시저를 test하기 위한 단순 변수 선언
variable vempno number;
variable vsal number;

execute info_empinfo('SMITH', :vempno, :vsal);

print vempno;
print vsal;

-- 프로시저에 예외 발생시 예외 처리 문법
--7. dept table은 pk(deptno) 설정되어 있음, dept에 새로운 데이터 저장 함수

create or replace procedure insert_dept3(
	v_deptno dept.deptno%type,
	v_dname dept.dname%type,
	v_loc dept.loc%type)
is
begin
	-- insert 시에 중복 예외 발생하면 exception 블록 실행
	-- "                    " 정상 insert라면 
	insert into dept values(v_deptno, v_dname, v_loc);
	exception
		when dup_val_on_index  then
			insert into dept values(v_deptno+1, v_dname, v_loc);
end;
/
exec insert_dept3(77, 'a', 'a');
exec insert_dept3(77, 'a', 'a');












