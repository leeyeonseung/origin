본인이 속한 부서의 급여 평균보다 높은 급여를 받는 사람들을 조회

SELECT *
FROM emp
WHERE  sal>
(SELECT AVG(sal)
FROM emp
WHERE deptno=emp.deptno);

sub4
테스트용 데이터 추가

DSEC dept;
INSERT INTO dept VALUES(99,'ddit','daejeon');

SELECT *
FROM dept
WHERE deptno>=40;

SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno
FROM emp);

SELECT pid ,pnm
FROM product 
WHERE pid NOT IN (SELECT pid
FROM cycle
WHERE cid=1);

SELECT CID, PID, DAY, CNT
FROM cycle
WHERE cid=1 AND pid IN(SELECT PID
FROM cycle
WHERE cid=2);

EXISTS 연산자 : 조건을 만족하는 서브 쿼리의 행이 존재하면 TRUE


매니저가 존재하는 사원 정보 조회



SELECT *
FROM emp e
WHERE EXISTS ( SELECT *
FROM emp m
WHERE e.mgr=m.empno);


서브쿼리 8

SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
FROM emp e , emp m
WHERE e.mgr=m.empno;


서브쿼리 9

SELECT *
FROM product 
WHERE EXISTS(SELECT pid
FROM cycle
WHERE cid=1 AND product.pid=pid);

서브쿼리 10
SELECT *
FROM product 
WHERE NOT EXISTS(SELECT pid
FROM cycle
WHERE cid=1 AND product.pid=pid);

집합연산자
UNION : 합집합 
UNION ALL : 중복제거하지않은 합집합(연산이 빠름)
INTERSECT : 교집합
MINUS = 차집합

SELECT empno, ename
FROM emp
WHERE deptno =10
UNION
SELECT empno, ename
FROM emp
WHERE deptno =10;

SELECT empno, ename
FROM emp
WHERE empno IN(7369,7566)
UNION
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7782);


SELECT empno, ename
FROM emp
WHERE empno IN(7369,7566)
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7782);

SELECT empno, ename
FROM emp
WHERE empno IN(7369,7566)
INTERSECT
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7782);

SELECT empno, ename
FROM emp
WHERE empno IN(7369,7566)
MINUS
SELECT empno, ename
FROM emp
WHERE empno IN(7369,7782);

집합연산자 특징
1. 컬럼명은 첫번쨰 집합의 컬러명을 따라간다
2.ORDER BY 절은 마지막 집합에 적용한다.
마지막 sql이 아닌 sql에서 정렬을 사용하고 싶은경우 INLINE-VIEW 활용
UNION ALL의 경우 위,아래 집합을 이어 주기 떄문에 집합의 순서를 그대로 유지하기 떄문에 요구사항에 따라 정렬된 데이터 집합이 필요하다면 해당방법을 고려
