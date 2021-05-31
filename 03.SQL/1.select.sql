-- 1.select.sql
-- oracle db에서의 주석 표기
/* 블록 주석
존재하는 데이터를 검색하는 명령어 학습

1. 기본 syntax
select 검색하고자하는 컬럼명
from table명;

2. 정렬 syntax
-- order by, asc, desc

selcet 검색하고자하는 컬럼명
from table명
order by 정렬기준컬럼명 asc?desc? ;
/*
		  
--1. sqlplus창 보기 화면 여백 조절 편집 명령어
	-- 단순 sqlplus tool만의 편집 명령어
	-- 영구 저장 안됨. sqlplus 실행시마다 해 줘야 함
set linesize 200
set pagesize 200
 

--2. 해당 계정의 모든 table 목록 검색
select * from tab;


--3. emp table의 모든 정보 검색
select * from emp;


--4. emp table의 구조 검색[묘사]
desc emp;


--5. emp table의 사번(empno)과 이름(ename)만 검색
select empno, ename from emp;

--6. emp table의 입사일(hiredate) 검색
select hiredate from emp;
	
--7. emp table의 검색시 칼럼명 empno를 사번이란 별칭으로 검색 
select empno as 사번 from emp;

--8. emp table에서 부서번호 검색시 중복 데이터 제거후 검색 

select deptno from emp;

-- distinct 중복 제거 기능의 키워드
select distinct deptno from emp;

--9. 데이터를 오름차순(asc)으로 검색하기(순서 정렬)

select distinct deptno
from emp
order by deptno asc;

-- ? 사번을 오름차순으로 정렬 해서 사번만 검색

select distinct empno 
from emp
order by empno asc;


-- 10.emp table 에서 deptno 내림차순 정렬 적용해서 ename과 deptno 검색하기

select distinct deptno 
from emp
order by deptno desc;

--? empno와 deptno를 검색하되 단 deptno는 오름차순 검색

select ename, deptno from emp order by deptno asc;


-- 11. 입사일(date 타입의 hiredate) 검색, 
-- date 타입은 정렬가능 따라서 경력자(입사일이 오래된 직원)부터 검색(asc)

select hiredate
from emp
order by hiredate asc;

/* dummy table - dual 이란 table
잉여 table
임시 table로 가령 syntax 문법 오류 방지용으로 주료 사용

-- *** 연산식 ***
-- select
--12. emp table의 모든 직원명(ename), 월급여(sal), 연봉(sal*12) 검색
-- 단 sal 컴럼값은 comm을 제외한 sal만으로 연봉 검색

select sal*12 from emp;

select sal, sal*12 from emp;

select ename, sal, sal*12 from emp;

select ename as 사원명, sal as 월급여, sal*12 as 연봉 from emp;


-- 13. 모든 직원의 연봉 검색(sal *12 + comm) 검색
-- comm 존재 또는 comm 미존재(null값, 존재자체가 없다는 의미)

select comm from emp;
select empno, comm from emp;
select empno, deptno,comm from emp;
select * from dept;

select asl*12+comm as 연봉 from emp;

-- null값을 다른 값으로 치환하는 함수 : nv1(null보유컬럼, 변경할값)
-- nv1 은 null value의 약어..

select sal, sal*12+comm as 연봉 from emp;
select sal, comm, sal*12+comm as 연봉 from emp;

select sal, comm, nvl(comm,0) from emp;

select sal, comm, sal*12+nvl(comm,0) as 연봉 from emp;

-- *** 조건식 ***
--14. comm이 null인 사원에 대한 검색(ename, comm)
select ename, comm from emp;
	
select ename, comm
from emp
where comm is null;

--15. comm이 null이 아닌 사원에 대한 검색(ename, comm)
select ename, comm
from emp
where comm is not null;

--? 15번 문제에 comm을 오름차순으로 정렬해 주세요.

select ename, comm
from emp 
where comm is not null
order by comm asc;

--16. ename, 전체연봉... comm 포함 연봉 검색
select ename, sal*12+nvl(comm,0) as 전체연봉 from emp;

--17. emp table에서 deptno 값이 20인(조건식 where) 
--직원 정보 모두(*) 출력하기  : = [sql 동등비교 연산자]

select * 
from emp
where deptno=20;


--? 검색된 데이터의 sal 값이 내림차순으로 정렬 검색 

select empno, sal
from emp
order by sal desc;

--18. emp table에서 ename이 smith(SMITH)에 해당하는 deptno값 검색
--* sql 상에서 문자열 데이터 표기 : ' '

select ename from emp;
select ename, deptno from emp where ename='SMITH';
select ename, deptno from emp where ename='smith';


--19. sal가 900이상(>=)인 직원들의 이름(ename), sal 검색
select sal from emp;

select ename, sal
from empwhere sal >= 900;


-- 조건식이 하나 이상인 경우
-- 고려사항 : 모든 조건이 TRUE? 개중에 하나만 TRUE?
--20. deptno가 10이고(and) job이 메니저(job='MANAGER')인 사원이름 검색 
select deptno, job from emp;

select deptno, job 
from emp 
where deptno=10 and job = 'MANAGER';

select ename
from emp 
where deptno=10 and job = 'MANAGER';

-- 21. ?deptno가 10이거나(or) job이 메니저(MANAGER)인 사원이름(ename) 검색
select ename
from emp 
where deptno=10 or job ='MANAGER';

select ename, deptno, job
from emp 
where deptno=10 or job ='MANAGER';

-- 22. deptno가 10이 아닌 모든 사원명(ename) 검색
-- 부정연산자 : !=, <>, not

select ename, deptno from emp;
select ename, deptno from emp where deptno=10;

select ename, deptno from emp where deptno != 10;
select ename, deptno from emp where deptno <> 10;

--23. sal이 2000 이하(sal<=2000)이거나(or) 3000이상인(sal>=3000) 사원명(ename) 검색

select ename, sal 
from emp
where sal<=2000 or sal>=3000;

--24. comm이 300 or 500 or 1400인 사원명, comm 검색
	
select ename, comm, deptno
from emp
where comm = 300 or comm = 500 or comm = 1400;

select ename, comm, deptno
from emp
where comm in ( 300,500,1400);

--25. ?comm이 300 or 500 or 1400이 아닌(not) 사원명, comm 검색
-- comm 검색

select comm, deptno
from emp
where comm not in (300,500,1400);

-- 26. 81년도에 입사(hiredate)한 사원 이름(ename) 검색
select hiredate, ename from emp;
-- date 타입도 비교 연산 가능 한지의 문제
-- 81년라면 동등비교로 검색
select hiredate from emp;

--동등 비교 가능 확인
select hiredate from emp where hiredate='80/12/17';

--고민
--81년도? 범위 1981/01/01~1981/12/31
--81이라는 표현과 이맃되는 방법? date의 결과에서 yy만 도출해서

-- 범위로 비교하는 연산식 : between 여기서 and 저기까지
select ename, hiredate from emp
where hiredate between '81/01/01' and '81/12/13';

-- 27. ename이 M으로 시작되는 모든 사원번호(empno), 이름(ename) 검색  
-- 연산자 like : 한 음절 _ , 철자 개수 무관하게 검색할 경우 %
select ename
from emp
where ename like 'M%';


-- 28. ename이 M으로 시작되는 전체 자리수가 두음절의 
-- 사원번호, 이름 검색
select empno, ename
from emp
where ename like 'M_';


-- 29. 두번째 음절의 단어가 M인 모든 사원명 검색 
select empno, ename
from emp
where ename like '_M%';

-- 30. 단어가 M을 포함한 모든 사원명 검색 
select empno, ename
from emp
where ename like '%M%';


