SELECT 'TEST1' alias1,
'TEST2' AS alias2,
'TEST3' AS "alias3"
FROM dual;

SELECT 'TEST1' ||dummy
FROM dual;


DESC emp;

SELECT *
FROM emp
WHERE hiredate BETWEEN '19800101' AND'19821231';

SELECT *
FROM dual;


outer join 4번

SELECT p.pid, p.pnm, NVL(c.cid,1) CID, NVL(c.day,0) day, NVL(c.cnt,0) CNT 
FROM cycle c, product p
WHERE c.cid(+)=1 AND p.pid=c.pid(+);


5번

SELECT p.pid, p.pnm, t.cid, t.cnm, c.day, c.cnt
FROM cycle c, product p, customer t
WHERE c.pid= p.pid 
AND c.cid= t.cid 
AND c.cid=1;


SELECT *
FROM customer c, product p

SQL 활요에 있어서 매우 중요
서브쿼리 : 쿼리안에서 실행되는 쿼리
1. 서브쿼리 분류 - 서브쿼리가 사용되는 위치에 따른 분류
1.1 SELECT : 스칼라 서브쿼리(scalar subquery)
1.2 FROM : 인라인 뷰(INLINE-VIEW)
1.3 WHERE : 서브쿼리(sub query)
                                                (행1, 행 여러개),(컬럼1, 컬럼 여러개)
2.서브쿼리 분류 - 서브쿼리가 반환하는 행, 컬럼의 개수의 따른 분류
(행1,행 여러개),(컬럼1,컬럼 여러개):
행(,컬럼) :4가지
2.1 단일행, 단일 컬럼
2.2 단일행, 복수컬럼==>X
2.3 복수행,단일 컬럼
2.4 복수행, 복수컬럼

3. 서브쿼리 분류 - 메인쿼리의 컬럼을 서브쿼리에서 사용여부에 따른 분류
3.1 상호 연관 서브쿼리(COREALATED SUB QUERY)
-메인 쿼리의 컬럼을 서브쿼리에서 사용하는경우
3.2 비상호 연관 서브 쿼리(NON-COREALATED SUB QUERY)
-메인 쿼리의 컬럼을 서브쿼리에서 사용하지 않는 경우


SELECT deptno
FROM emp
WHERE ename='SMITH';

SELECT*
FROM emp
WHERE deptno IN (SELECT deptno
FROM emp
WHERE ename='SMITH' OR  ename='ALLEN');

SELECT count(*)
FROM emp
WHERE SAl>(SELECT AVG(sal)
FROM emp);

SELECT*
FROM emp
WHERE deptno IN(
SELECT deptno
FROM emp
WHERE ename='SMITH' OR ename='WARD');


SELECT*
FROM emp
WHERE sal < ANY(
SELECT sal
FROM emp
WHERE ename='SMITH' OR ename='WARD');

SELECT*
FROM emp
WHERE sal > ALL(
SELECT sal
FROM emp
WHERE ename='SMITH' OR ename='WARD');

복수행 연산자 : IN(중요), ANY, ALL

NOT IN 해서 서브쿼리쓰면 서브쿼리에 NULL 값있으면 값 안나옴(AND)
IN 은 나옴(OR)

pair wise 개념 : 순서쌍, 두가지 조건을 동시에 만족시키는 데이터를 조회할때 사용 AND 연산자와 결과값이 다를 수 있다
만약 1,2,3,4숫자가 있으면
AND 연산자는 1,3  1,4  2,3  2,4 가 가능하다면
pair wise는 1,3            2,4 만 가능


서브쿼리 : 복수행, 복수컬럼

SELECT *
FROM emp
WHERE (mgr,deptno) IN ( SELECT mgr, deptno
FROM emp
WHERE empno IN(7499,7782));

SCALAR SUBQUERY : SELECT 절에 기술된 서브쿼리
                하나의 컬럼
*** 스칼라 서브 쿼리는 하나의 행, 하나의 컬럼을 조회하는 쿼리여야한다.
SELECT dummy, (SELECT SYSDATE
FROM dual)
FROM dual;

스칼라 서브쿼리가 복수개의 행(4개), 단일 컬럼을 조회==>에러

SELECT empno, ename, deptno,(SELECT dname FROM  dept)
FROM emp;

emp 테이블과 스칼라 서브 쿼리를 이용하여 부서명 가져오기

기존 : emp테이블과 dept 테이블을 조인하여 컬럼을 확장

SELECT empno,ename, deptno,(SELECT dname FROM dept WHERE deptno=emp.deptno) dname
FROM emp

상호연관 서브쿼리 : 메인 쿼리의 컬럼을 서브쿼리에서 사용한 서브쿼리
                -서브쿼리만 단독으로 실행하는 것이 불가능 하다.
                -메인쿼리와 서브쿼리의 실행순서가 정해져 있다.
                메인쿼리 먼저 실행
                
비상호연관 서브쿼리 : 메인 쿼리의 컬럼을 서브쿼리에서 사용하지 않은 서브쿼리
                    -서브쿼리만 단독으로 실행하는것이 가능하다
                    -메인 쿼리와 서브 쿼리의 실행 순서가 정해져 있지 않다
                    메인=>서브, 서브->메인 둘다 가능
          
          
          
                    
SELECT *
FROM dept
WHERE deptno IN(SELECT deptno
FROM emp);