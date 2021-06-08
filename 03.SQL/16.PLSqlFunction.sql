--16.PLSqlFunction.sql
/*

1. 저장 함수(function)
	- 오라클 사용자 정의 함수 
	- 오라클 함수 종류
		- 지원함수(count(??){ }, avg()...) + 사용자 정의 함수
2. 주의사항
	- 절대 기존 함수명들과 중복 불가

3. 프로시저와 다른 문법(함수문법)
	- plsql에서의 함수는 반드시 리턴값 있음
	- 리턴 타입 선언 + 리턴 값

4. oracle db 자체내에 구현하는 사용자 정의 함수 문법
	4-1. 함수 생성만
		create function 함수명([..])
		return 함수 실행겨로가 반환하는 타입
		is
			함수내에서 사용될 변수선언
		begin
			처리로직
		end;
		/

	4.2 함수생성 또는 치환(기존 함수대신 새로 갱신)
		create or replace function 함수명([..])
		return 함수 실행겨로가 반환하는 타입
		is
			함수내에서 사용될 변수선언
		begin
			처리로직
		end;
		/
*/

--1. emp table의 사번으로 사원 이름
-- (리턴 값, 이름의 타입이 리턴타입) 검색 로직 함수 
create function user_fun(no number)    -- 함수 user_fun() : 함수명 / no parameter
return varchar2				 -- 리턴 타입 명시
is
	v_ename emp.ename%type;  --새로운 변수 선언
begin
	select ename	
		into v_ename
	from emp where empno=no;

	return v_ename;			-- 리턴 데이터
end;
/
select user_fun(7369) from dual;

--? 14단계의 로직 함수로 구현해 보기
-- mystar()
create or replace function mystar(no number)
return varchar2     -- 리턴 타입 명시할 경우 타입의 사이즈 생략하셔요!!
is 
	v_empno emp.empno%type := no;
	v_ename emp.ename%type;
	v_number number(3);
	v_star varchar2(10) := '';
begin
	select ename, length(ename)
		into v_ename, v_number
	from emp
	where empno=v_empno;

	for i in 1..v_number loop
		v_star := v_star || '*';
	end loop;
	
	return v_star;
end;
/

select mystar(7369) from dual;

--no는 가변적 따라서 함수의 parameter로 전환
create or replace function mystar(no number)
return varchar2(10)
is
	v_empno emp.empno%type := &no;
	v_ename emp.ename%type;
	v_number number(3);
	v_star varchar2(10) := '';
begin
	select ename, length(ename)
		into v_ename, v_number
	from emp
	where empno=v_empno;

	for i in 1..v_number loop
		v_star := v_star || '*';
	end loop;

	return v_star;	
end;
/

select mystar(7369) from dual;

-- 2차 개선
create or replace function mystar(v_empno emp.empno%type)
return varchar2(10)
is
	v_ename emp.ename%type;
	v_number number(3);
	v_star varchar2(10) := '';
begin
	select ename, length(ename)
		into v_ename, v_number
	from emp
	where empno=v_empno;

	for i in 1..v_number loop
		v_star := v_star || '*';
	end loop;

	return v_star;	
end;
/

select mystar(7369) from dual;


--2.? %type 사용해서 사원명으로 해당 사원의 직무(job) 반환하는 함수 
-- 함수명 : emp_job

create or replace function emp_job(v_ename emp.ename%type)
return emp.job%type  
is 
    v_job emp.job%type;
begin
    select job
        into v_job
    from emp
    where ename=v_ename;
    return v_job;
end;
/
select emp_job('SMITH') from dual;

--3.? 특별 보너스를 지급하기 위한 저장 함수
	-- 급여를 200% 인상해서 지급(sal*2)
-- 함수명 : cal_bonus
-- test sql문장

create or replace function cal_bonus(v_empno emp.empno%type)
return emp.sal%type  
is 
    v_sal2 emp.sal%type;
begin
    select sal * 2
        into v_sal
    from emp
	where ename=v_ename;
    return v_sal2;
end;
/

select empno, job, sal, cal_bonus(7369) from emp where empno=7369;





-- 4.? 부서 번호를 입력 받아 최고 급여액(max(sal))을 반환하는 함수
-- 사용자 정의 함수 구현시 oracle 자체 함수도 호출
-- 함수명 : s_max_sal

create or replace function s_max_sal(v_empno emp.empno%type)
return emp.sal%type  
is 
    v_sal2 emp.sal%type;
begin
    select sal * 2
        into v_sal
    from emp
	where ename=v_ename;
    return v_sal2;
end;
/

select s_max_sal(10) from dual;

-- emp에 존재하는 row 수 만큼 검색 : 논리적으로 부적합
select s_max_sal(10) from emp;



--5. ? 부서 번호를 입력 받아 부서별 평균 급여를 구해주는 함수
-- 함수명 : avg_sal
-- 함수 내부에서 avg() 호출 가능

create or replace function avg_sal(s_deptno emp.deptno%type)
return number
is 
    avg_sal number;
begin
    select round( avg(sal), 2 )
        into avg_sal
    from emp
	where deptno=s_deptno;

    return avg_sal;
end;
/

select avg_sal(10) from dual;

-- 논리적 부적합
select distinct deptno, avg_sal(deptno) from emp;

--6. 존재하는 함수 삭제 명령어
drop function avg_sal;



-- 함수 내용 검색 : 사전 table
desc user_source;
select text from user_source where type='FUNCTION';


--7. procedure 또는 function에 문제 발생시 show error로 메세지 출력하기
show error

