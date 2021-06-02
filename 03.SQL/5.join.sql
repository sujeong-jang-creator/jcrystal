-- 5.join.sql

/*
1. 조인이란?
	다수의 table간에  공통된 데이터를 기준으로 검색하는 명령어

	다수의 table이란?
		동일한 table을 논리적으로 다수의 table로 간주
			- self join

		물리적으로 다른 table간의 조인

2. 사용 table 
	1. emp & dept(부서정보)
	  : deptno 컬럼을 기준으로 연관되어 있음

	 2. emp & salgrade(급여 등급 정보 보유)
	  : sal 컬럼을 기준으로 연관되어 있음

  
3. table에 별칭 사용 
	검색시 다중 table의 컬럼명이 다를 경우 table별칭 사용 불필요, 

	서로 다른 table간의 컬럼명이 중복된 경우 컬럼 구분을 위해 오라클 엔진에게 정확한 table 소속명을 알려줘야 함
	- table명 또는 table별칭
	- 주의사항 : 컬럼별칭 as[옵션], table별칭 as 사용 불가


4. 조인 종류 
	1. 동등 조인
		 = 동등비교 연산자 사용
		 : 사용 빈도 가장 높음
		 : 테이블에서 같은 조건이 존재할 경우에만 값 검색 


	2. not-equi 조인
		: 100% 일치하지 않고 특정 범위내의 데이터 조인시에 사용
		: between ~ and(비교 연산자)

	3. self 조인 
		: 동일 테이블 내에서 진행되는 조인
		: 동일 테이블 내에서 상이한 칼럼 참조
			emp의 empno[사번]과 mgr[사번] 관계

	4. outer 조인 
		: 두개 이상의 테이블이 조인될때 특정 데이터가 모든 테이블에 존재하지 않고 컬럼은 존재하나 null값을 보유한 경우
		  검색되지 않는 문제를 해결하기 위해 사용되는 조인
		  null 값이기 때문에 배제된 행을 결과에 포함 할 수 있드며 (+) 기호를 조인 조건에서 정보가 부족한 컬럼쪽에 적용
		
		: oracle DB의 sql인 경우 데이터가 null 쪽 table 에 + 기호 표기
		: outer join의 연산 표기법 : + 
		 */

-- 1. dept table의 구조 검색
desc dept;
-- dept, emp, salgrade table의 모든 데이터 검색
select * from dept;
select * from emp;
select * from salgrade;



--*** 1. 동등 조인 ***
-- = 동등 비교
-- 2. SMITH 의 이름(ename), 사번(empno), 근무지역(부서위치)(loc) 정보를 검색
select ename, empno, loc
from emp, dept
where ename='SMITH';

-- ORA-00918: column ambiguously defined
-- dpetno는 두개의 table에 존재 따라서 어떤 table의 어떤 컬럼 검색이 불명확
-- select ename, empno, loc, deptno
-- from emp, dept
-- where ename='SMITH';

-- 문제 발생? 검색된 결과값을 육안으로 확인 후에 20번 부서에 매핑된 dept의 정보 탐색
select ename, empno, loc, emp.deptno, dept.deptno
from emp, dept
where ename='SMITH';


-- 3. deptno가 동일한 모든 데이터(*) 검색
-- emp & dept의 모든 데이터가 각 row수별 곱셈연산 처럼 결과가 output
select * from emp, dept;


-- 4. 2+3 번 항목 결합해서 SMITH에 대한 모든 정보 검색하기
select ename, empno, loc
from emp, dept
where ename='SMITH' and emp.deptno = dept.deptno;


-- 5. ?SMITH에 대한 이름(ename)과 부서번호(deptno), 부서명(dept의 dname) 검색하기
-- table에 별칭 부여 방식
select ename, e.deptno, dname
from emp e, dept d
where ename='SMITH' and e.deptno = d.deptno;



-- 6. ? 조인을 사용해서 뉴욕에 근무하는 사원의 이름과 급여를 검색 
-- loc='NEW YORK', ename, sal
select loc from dept;

-- 데이터가 몇천건이라 가정
/* loc가 NEW YORK인 데이터의 emp deptno 와 dept의 deptno 비교 */
-- 좀더 선호하는 형식
select ename, sal 
from emp, dept
where loc='NEW YORK' and emp.deptno=dept.deptno;


/*emp deptno 와 dept의 deptno 동등비교 후에 동등한 모든 데이터들중에
 loc가 NEW YORK인 데이터 비교 */
select ename, sal 
from emp, dept
where emp.deptno=dept.deptno and loc='NEW YORK';



-- 7. 조인 사용해서 ACCOUNTING 부서(dept dname)에 
-- 소속된 사원(emp)의 이름(emp ename)과 입사일(emp hiredatea) 검색
select ename, hiredate
from emp, dept
where dname='ACCOUNTING' and dept.deptno=emp.deptno;



-- ? 8. 직급이 MANAGER인 사원의 이름, 부서명 검색
select ename, dname
from emp, dept
where job = 'MANAGER' and emp.deptno = dept.deptno;


-- *** 2. not-equi 조인 ***

-- salgrade table(급여 등급 관련 table)
-- 9. 사원의 급여(sal -> grade)가 몇 등급인지 검색
-- between ~ and : 포함 
select ename, sal, grade
from emp, salgrade
where sal between losal and hisal;


-- 10. ? 사원(emp) 테이블의 부서 번호(deptno)로 
-- 부서 테이블을 참조하여 사원명, 부서번호, 부서의 이름(dname) 검색
-- 동등조인 문제 
select ename, emp.deptno, dname
from emp, dept
where emp.deptno = dept.deptno;


-- ??? *************** 초 몰입 시작 ***********************

-- 81년 4월 1일 이후에 입사한 사원들이 가장 많은 부서의 부서명을 구하세요.
-- 다영씨(4월 26일 이수 선배) 작품
-- dname의 개수를 카운팅해서 max 최대값 

select hiredate, deptno from emp 
where hiredate > '81/04/01';

-- 논리적인 실행 오류, 부적합
-- select hiredate, emp.deptno, dname
-- from emp, dept
-- where hiredate > '81/04/01';

select hiredate, emp.deptno, dname
from emp, dept
where hiredate > '81/04/01' and emp.deptno = dept.deptno;

-- max() 그룹 함수의 필요성 체감
-- * 문자열인 경우 검색된 동일한 문자열(데이터)  개수 파악 후에 해당 데이터 검색
-- 삑 : 답안 현수...

select max(dname)
from emp, dept
where hiredate > '81/04/01' and emp.deptno = dept.deptno;


select min(dname)
from emp, dept
where hiredate > '81/04/01' and emp.deptno = dept.deptno;

-- 문법 오류
-- select count(max(dname))
-- from emp, dept
-- where hiredate > '81/04/01' and emp.deptno = dept.deptno;


select count(dname)
from emp, dept
where hiredate > '81/04/01' and emp.deptno = dept.deptno;

-- max() / min() 이견 확인 - 이홍주 Q & A
select job from emp;
select max(job) from emp;

-- *****************************



-- *** 3. self 조인 : 하나의 table에 연관된 컬럼들로 다수의 table인듯 논리적으로 작업 ***
-- 11. SMITH 직원(사원)의 메니저(SMITH 관점에선 상사) 이름 검색
-- 사원 table 의 별칭 : e / 메니저 table의 별칭 : m

select m.ename 
from emp e, emp m
where e.ename='SMITH' and e.mgr=m.empno;



-- 12. 메니저 이름이 KING(m ename='KING')인 사원들의 이름(e ename)과 직무(e job) 검색
-- m.ename = 'KING'  / e.ename , e.job
-- 사원 table e / 메니저 table m
select e.ename, e.job
from emp e, emp m
where m.ename = 'KING' and e.mgr = m.empno;

select e.ename, e.job, m.ename
from emp e, emp m
where m.ename = 'KING' and e.mgr = m.empno;


-- 13. SMITH와 동일한 근무지에서 근무하는 사원의 이름 검색
	-- SMITH와 동일한 근무지(deptno가 일치)에서 근무하는 
	-- 사원(동료)의 이름 검색

-- SMITH 라는 이름까지 검색되는 이슈 발생 
select you.ename
from emp my, emp you
where my.ename='SMITH' and my.deptno = you.deptno;

-- SMITH 를 검색에서 제외
select you.ename
from emp my, emp you
where my.ename='SMITH' 
	and my.deptno = you.deptno
	and you.ename != 'SMITH';


select you.ename
from emp my, emp you
where my.ename='SMITH' 
	and my.deptno = you.deptno
	and not you.ename = 'SMITH';


--*** 4. outer join ***
/* 
1. join은 ANSI join 즉 RDBMS에 종속적이지 않은 표준 SQL 문장 학습 필수
2. 참고 link
	https://www.w3schools.com/sql/sql_join.asp
*/


-- dept의 deptno에 40번 부서 존재, emp에는 40번 부서에 소속된 직원 없음
-- emp의 사원명인 KING은 mgr 즉 KING의 메니저는 존재하지 않음(null)


-- 14. 모든 사원명, 메니저 명 검색, 단 메니저가 없는 사원도 검색되어야 함
-- + 기호를 적용한 쪽이 데이터가 있는 쪽? 없는 쪽?
-- null 이라는 번호를 메니저 table 상에서는 사번으로 미 존재
-- oracle인 경우 + 기호로 null값을 보유하고 있는 데이터들도 join해서 검색하고자 할 경우 적용해서 검색 
select e.ename 사원명, m.ename 메니저명
from emp e, emp m
where e.mgr=m.empno(+);
/*
사원명               메니저명
-------------------- --------------------
FORD                 JONES
JAMES                BLAKE
TURNER               BLAKE
MARTIN               BLAKE
WARD                 BLAKE
ALLEN                BLAKE
MILLER               CLARK
CLARK                KING
BLAKE                KING
JONES                KING
SMITH                FORD
KING
*/

-- 논리적인 심각한 실행 오류
-- select e.ename 사원명, m.ename 메니저명
-- from emp e, emp m
-- where e.mgr(+)=m.empno;



-- 15. 모든 직원명(ename), 부서번호(deptno), 부서명(dname) 검색
-- 부서 테이블의 40번 부서와 조인할 사원 테이블의 부서 번호가 없지만,
-- outer join이용해서 40번 부서의 부서 이름도 검색하기 

-- emp에는 40번 부서 번호의 부재로 검색시 40부서번호 검색 불가  
select ename, emp.deptno, dname
from emp, dept
where emp.deptno(+) = dept.deptno;


-- dept.deptno로 부서 번호 정보까지 검색
select ename, dept.deptno, dname
from emp, dept
where emp.deptno(+) = dept.deptno;


-- oracle db에선 table 별칭 부여서 as 키워드 사용 불가 
-- select ename, dept.deptno, dname
-- from emp as e, dept
-- where e.deptno(+) = dept.deptno;



-- *** hr/hr 계정에서 test 
-- cmd>sqlplus system/manager
-- SQL>alter user hr identified by hr account unlock;
-- SQL>connect hr/hr
-- SQL>select * from tab;
-- SQL>set linesize 300
-- SQL>set pagesize  300
-- SQL>select * from employees;


--16. 직원의 이름(FIRST_NAME)과 직책(job job_title)을 출력(검색)

--	??? 단, 사용되지 않는 직책이 있다면 그 직책이 정보도 검색에 포함 
-- table 자체의 데이터 확인시에는 outer join 미 고려해도 되는 상황이나 때에 따라서는 outer join 필수 
-- 고려사항으로 17번 문제 제시되어 있음

--     검색 정보 이름(FIRST_NAME)들과 job_title(직책) 

	-- 문제 풀이를 위한 table의 컬럼값들 확인해 보기

desc employees;	
desc jobs;

select count(*) from employees;
select count(*) from jobs;
select job_id from emplpoyees;
select distinct job_id from employees;
select job_id from jobs;

-- hr계정 table의 데이터 탐색이 되고 예민하게 검증필요
select first_name, job_title
from employees e, jobs j
where e.job_id(+) = j.job_id;



-- outer join 
-- 미션 : 문제의 불 명확스러움을 제시된 답안을 기점으로 이해하기 위한 sql문장 구성하기 
--17. 직원들의 이름(first_name), 입사일, 부서명(department_name) 검색하기

-- 단, 부서가 없는 직원이 있다면 그 직원 정보도 검색에 포함시키기
-- 경우의 수 1 : 사원이 소속된 부서가 없을 경우
-- 경우의 수 2 : 부서에 소속된 사원이 없을 경우 
select first_name, hire_date, department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- 내일 아침에 제출 필수 
