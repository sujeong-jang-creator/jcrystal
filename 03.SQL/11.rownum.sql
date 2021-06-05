--11.rownum.sql

-- *** rownum
-- oracle 자체적으로 제공하는 컬럼
-- table 당 무조건 자동 생성
-- 검색시 검색된 데이터 순서대로 rownum값 자동 반영(1부터 시작)

-- *** 인라인 뷰
	-- 검색시 빈번히 활용되는 스펙
	-- 다수의 글들이 있는 게시판에 필수로 사용(paging 처리)
	-- 서브쿼리의 일종으로 from절에 위치하여 테이블처럼 사용
	-- 원리 : sql문 내부에 view를 정의하고 이를 테이블처럼 사용 

select rownum, empno from emp;
select rownum, deptno from dept;

-- 코드만으로 rownum 탐색 ?
-- 검색시 검색된 데이터 순서대로 rownum값 자동 반영(1부터 시작)
-- from 절 select절 where절 순으로 실행되는 것은 변함없으나
-- where절에 사용시에는 1~ 부터 유효한 경우에 한해서만 정상인지
-- rownum은 오라클 자체적인 키워드 즉 이미 존재하는 기능
-- 모든 언어가 키워드는 적절한 위치에 있으면 문법 오류는 

--  실행순서 : from -> where -> select 
-- 암기사항 : rownum은 검색시에 검색된 결과에 자동index를 부여.
    -- 1부터 활용해야 함.
    -- 하단 > 4보다 크다인 경우엔 4부터 시작점으로 내부적으로 간주해서
    -- 문법 오류가 아니라 논리적으로 1부터 시작을 안했다 라는 관점에서 무효화
select rownum, deptno from dept where rownum > 4;
select rownum, deptno from dept where rownum > 5;
-- no rows selected

select rownum, deptno from dept where rownum < 4;
select rownum, deptno from dept where rownum < 5;
-- 데이터 검색이 조건에 맞게 검색되었음


select rownum, deptno from dept where rownum < 4;
select rownum, deptno 
from (select rownum, deptno 
	 from dept 
	 where rownum < 4);

select rownum, deptno from dept where rownum < 5;
select rownum, deptno 
from (select rownum, deptno 
	 from dept 
	 where rownum < 5);

-- //  ---------------------
/*
inline view 방식
	from절에 select문장으로 검색된 데이터가 반영되는 구조를 inline
	임시로 생성된 table로 간주 즉 물리적으로 존재하지는 table로 간주
	논리적인 table 즉 view

select 검색 컬럼
from 존재하는table 또는 검색된 데이터(임시table)
*/
select rownum, deptno from dept;
select rownum, deptno from emp;

select rownum, deptno 
from (select rownum, deptno 
	 from dept 
	 where rownum < 4);


-- 1. ? dept의 deptno를 내림차순(desc)으로 검색, rownum
select rownum, deptno from dept order by deptno desc;

-- 오름 차순
select rownum, deptno from dept order by deptno asc;


-- 2. ? deptno의 값이 오름차순으로 정렬해서 30번 까지만 검색,
-- rownum 포함해서 검색

select rownum, deptno 
from dept 
order by deptno asc;

select rownum, deptno 
from dept 
where rownum < 4
order by deptno asc;



-- 3. deptno의 값이 오름차순으로 정렬해서 상위 3개의 데이터만 검색, 
-- rownum 포함해서 검색
select rownum, deptno 
from dept 
where rownum < 4
order by deptno asc;

-- 내림차순
select rownum, deptno 
from dept 
where rownum < 4
order by deptno desc;


-- 4. ?[인라인 뷰]를 사용하여 급여(sal)를 많이(desc) 받는 순서대로 
-- 3명만 이름과 급여 검색 
-- 인라인 뷰 사용? 미사용?
select ename, sal from emp order by sal desc;
select rownum, ename, sal from emp order by sal desc;
-- from -> select(rownum) -> order by sal ..: 
-- rownum 이미 검색된 결과
/*
 ROWNUM ENAME                       SAL
---------- -------------------- ----------
         8 KING                       5000
        11 FORD                       3000
         4 JONES                      2975
         6 BLAKE                      2850
         7 CLARK                      2450
         2 ALLEN                      1600
         9 TURNER                     1500
        12 MILLER                     1300
         5 MARTIN                     1250
         3 WARD                       1250
        10 JAMES                       950
         1 SMITH                       800
*/

select rownum, ename, sal from emp;
/*
ROWNUM ENAME                       SAL
---------- -------------------- ----------
         1 SMITH                       800
         2 ALLEN                      1600
         3 WARD                       1250
         4 JONES                      2975
         5 MARTIN                     1250
         6 BLAKE                      2850
         7 CLARK                      2450
         8 KING                       5000
         9 TURNER                     1500
        10 JAMES                       950
        11 FORD                       3000
        12 MILLER                     1300
*/

select ename, sal
from (select rownum, ename, sal 
 	 from emp order by sal desc);
/*
ENAME                       SAL
-------------------- ----------
KING                       5000
FORD                       3000
JONES                      2975
BLAKE                      2850
CLARK                      2450
ALLEN                      1600
TURNER                     1500
MILLER                     1300
MARTIN                     1250
WARD                       1250
JAMES                       950
SMITH                       800
*/
select rownum, ename, sal
from (select rownum, ename, sal 
 	 from emp order by sal desc);
/*

    ROWNUM ENAME                       SAL
---------- -------------------- ----------
         1 KING                       5000
         2 FORD                       3000
         3 JONES                      2975
         4 BLAKE                      2850
         5 CLARK                      2450
         6 ALLEN                      1600
         7 TURNER                     1500
         8 MILLER                     1300
         9 MARTIN                     1250
        10 WARD                       1250
        11 JAMES                       950
        12 SMITH                       800
*/

select rownum, ename, sal
from (select rownum, ename, sal 
 	 from emp order by sal desc)
where rownum <= 3;


-- 5.? emp의 deptno의 값이 오름차순으로 정렬된 상태로
-- 상위 3개 데이터 검색

SELECT deptno FROM emp ORDER BY deptno asc; 
SELECT rownum, deptno FROM emp ORDER BY deptno asc; 

SELECT rownum, deptno 
FROM (SELECT rownum, deptno 
      FROM emp 
      ORDER BY deptno asc);
 
SELECT rownum, deptno 
FROM (SELECT rownum, deptno 
      FROM emp 
      ORDER BY deptno asc)
WHERE rownum < 4;

