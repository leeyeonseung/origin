CUBE(col1,col2...
컬럼의 순서는 지키되, 가능한 모든 조합을 생성한다

GROUP BY CUBE(job,deptno)
job deptno
o   o  ==>GROUP BY job,deptno
o   x  ==>GROUP BY job 
x   o  ==>GROUP BY deptno(ROLLUP에는 없던 서브 그릅)
x   x  ==>GROUP BY 전체

GROUP BY ROLLUP(job,deptno)==>3개

SELECT job, deptno, SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY CUBE(job,deptno);

CUBE의 경우 가능한 모든 조합으로 서브 그룹을 생성하기 때문에 2의 기술한 컬럼 개수 승 만큼 서브그룹이 생성된다
CUBE(col1,col2):4
CUBE(col1,col2,col3):8
CUBE(col1,col2,col3,col4):16

REPORT GROUP FUNCTION 조합
GROUP BY job, ROLLUP(deptno), CUBE(mgr)
                deptno            mgr
                전체              전체
                
            job,deptno,mgr
            job, deptno
            job,  mgr
            job    ,전체
            
SELECT job, deptno,mgr,SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

상호 연관 서브 쿼리를 이용한 업데이트
1.emp_test 테이블 삭제
2.emp테이블을 이용하여 c

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));

UPDATE emp_test SET dname=(SELECT dname FROM dept WHERE deptno=emp_test.deptno);




SELECT *
FROM emp_test;

COMMIT;

DROP TABLE dept_test;
CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

UPDATE dept_test SET empcnt=(SELECT COUNT(deptno) 
FROM emp 
WHERE deptno=dept_test.deptno );


SELECT *
FROM dept_test;

SELECT count( e.deptno)
FROM emp e,dept_test d
WHERE e.deptno=d.deptno;




COMMIT;


sub_a2
INSERT INTO dept_test (deptno, dname, loc) VALUES(99,'it1','daejeon');
INSERT INTO dept_test (deptno, dname, loc) VALUES(98,'it2','daejeon');
COMMIT;

SELECT *
FROM dept_test;

부서에 속한 직원이 없는 부서를 삭제하는 쿼리를 작성
ALTER TABLE dept_test DROP COLUMN empcnt;



DELETE dept_test 
WHERE deptno NOT IN(SELECT deptno
FROM emp);

위에거랑 동일

DELETE dept_test
WHERE NOT EXISTS(SELECT 'x'
FROM emp WHERE deptno=dept_test.deptno);


SELECT COUNT(*)
FROM dept;


달력만들기 : 행을 열로 만들기 - 레포트 쿼리에서 자주 사용하는 형태
주어진것: 년월 (수업시간에는 '202009' 문자열을 사용)

SELECT
DECODE(d,1,iw+1,iw),
MIN(DECODE(d,1,day))sun,
MIN(DECODE(d,2,day)) mon,
MIN(DECODE(d,3,day)) tue,
MIN(DECODE(d,4,day)) wed,
MIN(DECODE(d,5,day)) thu,
MIN(DECODE(d,6,day)) fri,
MIN(DECODE(d,7,day)) sat
FROM (SELECT TO_DATE(:yyyymm,'YYYYMM')+LEVEL-1 day,
TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+LEVEL-1,'D') d,
TO_CHAR(TO_DATE(:yyyymm,'YYYYMM')+LEVEL-1,'iw') iw
FROM dual
CONNECT BY LEVEL <=TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'dd'))
GROUP BY DECODE(d,1,iw+1,iw)
ORDER BY DECODE(d,1,iw+1,iw);

SELECT dual.*,LEVEL
FROM dual
CONNECT BY LEVEL <=30;


SELECT *
FROM sales;




SELECT (SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=01
GROUP BY TO_CHAR(DT,'mm') ) JAN,  
(SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=02
GROUP BY TO_CHAR(DT,'mm') ) FEB,
NVL((SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=03
GROUP BY TO_CHAR(DT,'mm') ),0 )MAR ,
(SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=04
GROUP BY TO_CHAR(DT,'mm') ) APR ,
(SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=05
GROUP BY TO_CHAR(DT,'mm') ) MAY, 
(SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=06
GROUP BY TO_CHAR(DT,'mm') ) JUN
FROM dual ;



SELECT TO_CHAR(DT,'mm')
FROM sales;


SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=01
GROUP BY TO_CHAR(DT,'mm') ;



SELECT (SELECT SUM(sales)
FROM sales
WHERE TO_CHAR(DT,'mm')=01
GROUP BY TO_CHAR(DT,'mm'))
FROM dual;

SELECT *
FROM dept_h
START WITH deptcd='dept0'
CONNECT BY PRIOR deptcd=p_deptcd;


SELECT deptcd, LPAD(' ',(LEVEL-1)*3) || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;