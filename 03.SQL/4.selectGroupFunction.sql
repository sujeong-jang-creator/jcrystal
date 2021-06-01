--4.selectGroupFunction.sql
-- 그룹함수란? 다수의 행 데이터를 한번에 처리
-- 장점 : 함수 연산시 null 데이터를 함수 내부적으로 사전에 고려해서 null값 보유한 field는 함수 로직 연산시 제외, sql 문장 작업 용이
/*
1. count() : 개수 확인 함수
2. sum() : 합계 함수
3. avg() : 평균
4. max(), min() : 최대값, 최소값 
*/
 
/* 기본 문법
1. select절
2. from 절
3. where절 

 * 그룹함수시 사용되는 문법
1. select절 : 검색하고자 하는 속성
2. from절	: 검색 table
3. group by 절 : 특정 조건별 그룹화하고자 하는 속성
4. having 절 : 그룹함수 사용시 조건절
5. order by절 : 검색된 데이터를 정렬
*/

--1. count() : 개수 확인 함수
-- emp table의 직원이 몇명?
-- * : all 즉 모든 row 수 의미
select count(*) from emp;

select count(empno) from emp;

--? comm 받는 직원 수만 검색
-- count() : null 값은 철저히 정리해서 집계
select comm from emp;
select count(comm) from emp;


--2. sum() : 합계 함수
-- ? 모든 사원의 월급여(sal)의 합
select sum(sal) from emp;


--? 모든 직원이 받는 comm 합
select sum(comm) from emp;

--?  MANAGER인 직원들의  월급여의 합 
select sum(sal)
from emp
where job = 'MANAGER';

-- 문법 오류 단 논리적으로도 부적합
-- 왜? sum() 결과는 하나의 row/job 컬럼은 3개의 row 즉 겨로가 갯수가 달라서.


--? job 종류 counting[절대 중복 불가 = distinct]
-- 데이터 job 확인
select count(distinct job) from emp;

-- 논리적인 오류 : 집계 이후에 distinct 는 의미 없음 
select distinct count(job) from emp;



--3. avg() : 평균
--? emp table의 모든 직원들의 급여(sal) 평균 검색
select avg(sal) from emp;


--? 커미션 받는 사원수, 총 커미션 합, 평균 구하기
SELECT count(ename), sum(comm), avg(sal) FROM emp;
SELECT count(ename) FROM emp;
SELECT sum(comm) FROM emp;
SELECT avg(sal) FROM emp;


--4. max(), min() : 최대값, 최소값
-- 숫자, date 타입에 사용 가능
--최대 급여, 최소 급여 검색
SELECT max(sal), min(sal) FROM emp;

-- 오라클의 date 즉 날짜를 의미하는 타입도 연산 가능
-- max(), min() 함수 사용해 보기

--최근 입사한 사원의 입사일과, 가장 오래된 사원의 입사일 검색
SELECT max(hiredate), min(hiredate) FROM emp;


--*** 
/* group by절
- 특정 컬럼값을 기준으로 그룹화
	가령, 10번 부서끼리, 20번 부서끼리..
*/
-- 부서별 커미션 받는 사원수 

SELECT deptno, count(comm)
FROM emp
GROUP BY deptno;

-- 부서별(group by deptno) (월급여) 평균 구함(avg())(그룹함수 사용시 부서 번호별로 그룹화 작업후 평균 연산)

SELECT deptno, avg(sal)
FROM emp
GROUP BY deptno;

-- 소속 부서별 급여 총액과 평균 급여 검색[deptno 오름차순 정렬]

SELECT deptno, sum(sal), avg(sal)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

-- 소속 부서별 최대 급여와 최소 급여 검색[deptno 오름차순 정렬]
-- 컬럼명 별칭에 여백 포함한 문구를 사용하기 위해서는 쌍따옴표로만 처리

SELECT deptno, max(sal) as "최대급여", min(sal) as "최소급여"
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

-- *** having절 *** [ 조건을 주고 검색하기 ]
-- 그룹함수 사용시 조건문

-- 부서별(group by) 사원의 수(count(*))와 커미션(count(comm)) 받는 사원의 수

SELECT deptno, count(*), count(comm)
FROM emp
GROUP BY deptno;

-- 조건 추가
-- 부서별 그룹을 지은후(group by deptno), 
-- 부서별(deptno) 평균 급여(avg())가 2000 이상(>=)부서의 번호와 평균 급여 검색 

SELECT deptno, count(*), count(comm), avg(sal)
FROM emp
GROUP BY deptno
HAVING avg(sal) >= 2000;

SELECT deptno, count(*), count(comm), avg(sal)
FROM emp
GROUP BY deptno;


-- 실행 순서 : from -> group by -> having -> select

-- select 절 수행 후에는 평균 이라는 별칭으로 avg 함수 결과값 보유한 상태
SELECT deptno, avg(sal) as 평균
FROM emp
GROUP BY deptno
HAVING avg(sal) >= 2000;

/* 샐행 오류. 왜? select 절은 having 절 실행 후에 실행되기 때문
SELECT deptno, avg(sal) as 평균
FROM emp
GROUP BY deptno
HAVING 평균 >= 2000;
*/

-- 부서별 급여중 최대값(max)과 최소값(min)을 구하되 최대 급여가 2900이상(having)인 부서만 출력

SELECT deptno, max(sal) as "최대급여", min(sal) as "최소급여"
FROM emp
GROUP BY deptno
HAVING max(sal) >= 2900;
