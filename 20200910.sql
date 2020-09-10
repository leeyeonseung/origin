그룹함수 : 여러개의 행을 입력으로 받아 하나의 행으로 결과를 반환하는 함수

오라클 제공 그룹함수 
MIN(컬럼|익스프레션) : 그룹중에 최소값
MAX(컬럼|익스프레션) : 그룹중에 최대값
AVG(컬럼|익스프레션) : 그룹의 평균값
SUM(컬럼|익스프레션) : 그룹의 합
COUNT(컬럼|익스프레션|*) : 그룹핑된 행의 갯수

SELECT 행을 묶을 컬럼, 그룹함수
FROM 테이블명
[WHERE]
GROUP BY 행을 묶을 컬럼
(HAVING 그룹함수 체크조건);

SELECT *
FROM emp
ORDER BY deptno;


그룹함수 어려운부분
SELECT 절에 기술할수 있는 컬럼의 구분 :GROUP BY 절에 나오지 않은 컬럼이 SELECT 절에 나오면 에러
;

SELECT deptno,ename, MIN(ename),COUNT(*), MIN(sal), MAX(sal),SUM(sal),AVG(sal)
FROM emp
GROUP BY deptno, ename;

전체 직원중에 (모든 행을 대상으로)가장 많은 급여를 받는 사람의 값
: 전체 행을 대상으로 그룹핑 할 경우 GROUP BY절을 기술하지 않는다


SELECT MAX(sal)
FROM emp;

전체직원중에 가장 큰급여 값을 알수는 있지만 해당 급여를 받는 사람이 누군지는 그룹함수만 이용해서는 구할수 없다.
emp 테이블 가장 큰 급여를 받는 사람의 값이 5000인 것은 알지만 해당 사원이 누구인지는 그룹함수만 사용해서는 누군지 식별할 수 없다.
==> 추후진행

SELECT MAX(sal)
FROM emp;

COUNT 함수 * 인자
* : 행의 갯수를 반환
컬럼|익스프레션 : NULL값이 아닌 행의 갯수

SELECT COUNT(*), COUNT(mgr), COUNT(comm)
FROM emp;

SELECT sal+comm
from emp;

그룹함수의 특징: NULL값 무시
NULL 연산의 특징 : 결과 항상 NULL이다.

SELECT SUM(sal +COMM), SUM(sal)+SUM(comm), SUM(sal), SUM(comm)
FROM emp;

그룹함수 특징 2: 그룹화가 없는 상수들은 SELECT절에 기술할 수 있다.
SELECT deptno, SYSDATE, 'TEST',1,COUNT(*)
FROM emp
GROUP BY deptno;

그룹함수 특징3:
SINGLE ROW 함수의 경우 WHERE에 기술하는 것이 가능하다
ex: 

SELECT 
FROM emp
WHERE ename=UPPER('smith');

그룹함수의 경우 WHERE에서 사용하는것이 불가능함
==>HAVING 절에서 그룹함수에 대한 조건을 기술하여 행을 제한 할 수 있다.


그룹함수는 WHERE 절에 사용불가
SELECT deptno, COUNT(*)
FROM emp
WHERE COUNT(*)>=5
GROUP BY deptno;

그룹함수에 대한 행 제한 HAVING 절에 기술

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING COUNT(*)>=5;

SELECT comm, COUNT(*)
FROM emp
GROUP BY comm;

COUNT(*)이들어가면 null값 상관없이 다 나옴
count(sal) 이런식으로 인자가 들어가면 null 제외;

SELECT  MAX(sal),MIN(sal), ROUND(AVG(sal),2), SUM(sal) ,COUNT(sal),COUNT(MGR),COUNT(*)
FROM emp;

SELECT CASE
WHEN deptno = 10 THEN 'ACCOUNTING'
WHEN deptno = 20 THEN 'RESEARCH'
WHEN deptno = 30 THEN 'SALES'
ELSE 'OPERATIONS'
END DANAME, MAX(sal),MIN(sal),ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(*)

FROM emp

GROUP BY deptno;


SELECT DECODE(
deptno ,10, 'ACCOUNTING'
 , 20 , 'RESEARCH'
 ,30 , 'SALES'

) dname, MAX(sal),MIN(sal),ROUND(AVG(sal),2),SUM(sal),COUNT(sal),COUNT(mgr),COUNT(*)

FROM emp

GROUP BY 
DECODE(deptno ,10, 'ACCOUNTING' , 20 , 'RESEARCH' ,30 , 'SALES');


SELECT  TO_CHAR(hiredate,'yyyymm') HIRE_YYYYMM,COUNT(*) CNT
FROM emp
GROUP BY TO_CHAR(hiredate,'yyyymm');

WHERE + JOIN SELCT SQL의 모든것
JOIN : 다른 테이블과 연결하여 데이터를 확장하는 방법
.컬럼을 확장
** 행을 확장 - 집합연산자(UNION, INTERSECT, MINUS)

JOIN 문법 구분
1. ANSI -SQL
:RDMBS에서 사용하는 SQL표준
(표준을 잘지킨 모든 RDMBS-MYSQL, MSSQL, POSTGRESQL...에서 실행가능)
2.ORACLE -SQL
:ORACLE사만의 고유 문법

NATURAL JOIN : 조인하고자 하는 테이블의 컬럼명이 같은 컬럼끼리 연결

ANSI-SQL

SELECT 컬럼
FROM 테이블명 NATURAL JOIN 테이블명;

조인 컬럼에 테이블 한정자를 붙이면 NATURAL JOIN 에서는 에러로 취급
SELECT emp.empno, deptno, dept.dname
FROM emp NATURAL JOIN dept;

NATURAL JOIN을 ORACLE 문법으로
1. FROM 절에 조인할 테이블을 나열한다(,)
2. WHERE절에 테이블 조인 조건을 기술한다

SELECT *
FROM emp,dept
WHERE EMP.deptno=dept.deptno;


SELECT *
FROM emp e,dept d
WHERE e.deptno=d.deptno;

ANSI-SQL : JOIN WITH USING
조인 하려는 테이블간 같은 이름의 컬럼이 2개이상일 떄 하나의 컬럼으로만 조인 하고 싶을때 사용

SELECT *
FROM emp JOIN dept USING(deptno);

ORCLE 문법
SELECT *
FROM emp e, dept d
WHERE e.deptno=d.deptno;

ANSI-SQL : JOIN WITH ON - 조인 조건을 개발자가 직접 기술
           NATURAL JOIN, JOIN WITH USING 절을 JOIN WITH ON 절을 통해 표현 가능


SELECT *
FROM emp JOIN dept ON(emp.deptno=dept.deptno);

ORACLE

SELECT *
FROM emp e, dept d
WHERE e.deptno=d.deptno AND e.deptno IN(20,30);


논리적인 형태에 따른 조인 구분

1.SELF JOIN : 조인하는 테이블이 서로 같은경우

SELECT e.empno ,e.ename, e.mgr,m.ename
FROM emp e JOIN emp m ON(e.mgr=m.empno);

SELECT e.empno ,e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr= m.empno;

2. NONEQUI JOIN : 조인 조건이 =이 아닌 조인

SELECT *
FROM emp e, dept d
WHERE e.empno=7369
AND e.deptno!=d.deptno;


empno, ename, sal,
,emp e



SELECT  empno, ename, sal , grade

FROM salgrade  ,emp

WHERE sal >=losal AND sal<=hisal;


SELECT  empno, ename, sal , grade

FROM salgrade  ,emp

WHERE sal BETWEEN losal AND hisal;

SELECT  empno, ename, sal , grade

FROM salgrade  JOIN emp ON (sal BETWEEN losal AND hisal);
