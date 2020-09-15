SELECT *
FROM customer;
--CID
SELECT *
FROM CYCLE;

SELECT *
FROM product;
4번

SELECT cycle.CID, customer.CNM, cycle.PID, cycle.DAY, cycle.CNT
FROM customer, cycle
WHERE customer. cid= cycle.cid AND (CNM='brown' OR CNM='sally');

5번

SELECT cycle.CID, customer.CNM, cycle.PID,product.pnm,cycle.DAY, cycle.CNT
FROM  product,customer, cycle
WHERE customer. cid= cycle.cid AND cycle.pid = product.PID AND (CNM='brown' OR CNM='sally');





6번
SELECT cycle.CID, customer.CNM, cycle.PID,product.pnm, cycle.CNT
FROM  product,customer, cycle

WHERE customer. cid= cycle.cid AND cycle.pid = product.PID;


JOIN구분
1. 문법에 따른 구분 :ANSI_SQL, ORACLE
2. join의 형태에 따른 구분 : SELF-JOIN, NONEQUI-JOIN, CROSS-JOIN
3. join 성공여부에 따라 데이터 표시 여부
INNER JOIN 조인이 성공했을 떄 데이터를 표시
OUTER JOIN 컬럼 연결이 실패해도 기준이 되는 테이블의 데이터가 나오도록 표시

사번, 사원의 이름, 관리자 사번, 관리자 이름

SELECT *
FROM emp;



SELECT e.empno, e.enmae, e.mgr, m.ename
FROM emp e  , emp m
WHERE e.mgr = m.empno;

SELECT e.empno, e.ename, e.mgr,m.ename
FROM emp e, emp m
WHERE e.mgr=m.empno;

ANSI-SQL
SELECT e.empno, e.ename, e.mgr,m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr=m.empno);



행에 대한 제한 조건 기술시 WHERE 절에 기술 했을떄와 ON절에 기술 했을떄 결과가 다르다.

조건을 WHERE 절에 기술한경우 ==>OUTER JOIN 이 아닌 INNER 조인 결과가 나온다
SELECT e.empno, e.ename,e.deptno, e.mgr,m.ename,m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr=m.empno)
WHERE e.deptno=10;


SELECT e.empno, e.ename,e.deptno, e.mgr,m.ename,m.deptno
FROM emp e JOIN emp m ON (e.mgr=m.empno)
WHERE e.deptno=10;

ORCLE-SQL:      데이터가 없는 쪽의 컬럼에 (+) 기호를 붙인다
                ANSI_SQL 기준 테이블 반대편 테이블의 컬럼에 (+) 를 붙인다
                WHERE절 연결 조건에 적용
                

SELECT e.empno, e.ename, e.mgr,m.ename
FROM emp e ,emp m
WHERE e.mgr(+)=m.empno;


SELECT e.empno, e.ename, e.mgr,m.empno,m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr=m.empno)
UNION
SELECT e.empno, e.ename, e.mgr,m.empno,m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr=m.empno)
INTERSECT
SELECT e.empno, e.ename, e.mgr,m.empno,m.ename
FROM emp e FULL OUTER JOIN emp m ON(e.mgr=m.empno);


OUTERJOIN1
SELECT *
FROM PROD;

SELECT *
FROM buyprod;


SELECT b.buy_date , b.buy_prod, p.prod_id,p.prod_name,b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod (+)= p.prod_id AND buy_date(+)=TO_DATE('2005/01/25','yyyy/mm/dd');



