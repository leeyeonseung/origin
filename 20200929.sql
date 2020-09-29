ana3

SELECT empno, ename, sal ,deptno, MAX(sal) OVER (PARTITION BY deptno) MAX_SAL
FROM emp;

SELECT e.empno,e.ename,e.sal,e.deptno,a.max_sal
FROM emp e,(SELECT deptno,MAX(sal) max_sal
FROM emp 
GROUP BY deptno) a
WHERE a.deptno = e.deptno;

분석함수정리

1.순위 : RANK,DENSE_RANK,ROWNUMBER
2.집계: SUM,AVG,MAX,MIN,COUNT
3.그룹내 행순서 : LAG,LEAD
                현재 행을 기준으로 이전/이후 N번째 행의 컬럼 값 가져오기


사원번호, 사원이름, 입사일자, 급여, 급여순위가 자신보다 한단계 낮은 사람의 급여
(단, 급여가 같을 경우 입사일이 빠른 사람이 높은 우선순위)
;

실습 ana5
SELECT empno, ename, hiredate, sal, LEAD(sal) OVER (ORDER BY sal DESC, hiredate ASC)
FROM emp;

5-1
SELECT empno, ename, hiredate, sal, LAG(sal) OVER (ORDER BY sal DESC, hiredate ASC)
FROM emp;

6번
SELECT empno,ename,hiredate,job,sal,LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate ASC) lag_sal
FROM emp;


이전/이후 n행 값 가져오기
;
LAG(col[, 건너뛸 행 수 - default 1,값이 없을 경우 적용할 값])

SELECT empno,ename,hiredate,job,sal,LAG(sal,2,0) OVER (ORDER BY sal DESC, hiredate ASC) lag_sal
FROM emp;


현재 행까지의 누적합 구하기
범위지정 : windowing
windowing에서 사용할 수 있는 특수 키워드
1. UNBOUNDED PRECEDING : 현재행을 기준으로 선행하는 모든행(이전행)
2. CURRENT ROW : 현재행
3. UNBOUNDED FOLLOWING : 현재행을 기준으로 후행하는 모든행(이후행)
4.n PRECEDING (n은 정수) : n행 이전부터
5.n FOLLOWING (n은 정수) : n행 이후 까지

현재행 이전의 모든 행부터 ~ 현재까지 --> 행들을 정렬할 수 있는 기준이 있어야 한다.

SELECT empno, ename, sal,
SUM(sal) OVER(ORDER BY sal, hiredate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)c_sum,
SUM(sal) OVER (ORDER BY sal, hiredate ASC ROWS UNBOUNDED PRECEDING) c_sum2
FROM emp;

선행하는 이전 첫번째 행부터 후행하는 이후 첫번째 행까지
선행-현재행-후행 총 3개 행에 대해 급여 함구하기
SELECT empno, ename, sal,
SUM(sal) OVER(ORDER BY sal, hiredate ASC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)c_sum
FROM emp;

ana7
SELECT empno, ename, deptno,sal,
SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;


SELECT empno, ename, deptno,sal,
SUM(sal) OVER(ORDER BY sal  ROWS  UNBOUNDED PRECEDING ) rows_sum,
SUM(sal) OVER(ORDER BY sal  RANGE UNBOUNDED PRECEDING ) rows_sum,
SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;

DBMS 입장에서 SQL 처리 순서
1.요청된 SQL과 동일한 SQL이 이미 실행된 적이 있는지 확인하여 실행된 적이 있다면 SHARED POOL에 저장된 실행계획을 재활용한다

1-2. 만약 SHARED POOL에 저장된 실행 계획이 없다면 (동일한 SQL이 실행된 적이 없음) 실행계획을 세운다.


***동일한 SQL이란?
-결과만 같다고 동일한 SQL이 아님
-DBMS 입장에서는 완벽하게 문자열이 동일해야 동일한 sql임
다음 sql은 서로 다른 sql로 인식한다
1.SELECT /*SQL_TEST*/* FROM emp;
2.Select /*SQL_TEST*/* FROM emp;
3.Select /*SQL_TEST*/*  FROM emp;

10번 부서에 속하는 사원 정보 조회
==>특정 부서에 속하는 사원 정보 조회

4. Select /*SQL_TEST*/ * FROM emp WHERE deptno=10;
Select /*SQL_TEST*/ * FROM emp WHERE deptno=20;

바인드 변수를 왜 사용해야 하는가에 대한 설명
Select /*SQL_TEST*/ * FROM emp WHERE deptno = :deptno;

ISOLATION LEVEL (고립화 레벨)
후행 트랙잭션이 선행 트랜잭션에 어떻게 영향을 미치는지를 정의한 단계

LEVEL 0~3
LEVEL 0 : READ UNCOMMITED
         선행 트랜잭션이 커밋하지 않은 데이터도 후행 트랜잭션에서 조회된다
         오라클에서는 공식적으로 지원하지 않는 단계
         
LEVEL 1 : READ COMMITTED
        후행 트랜잭션에서 커밋한 데이터가 선행 트랜잭션에서도 조회된다.
        오라클의 기본 고립화 레벨
        대부분의 DBMS가 채택하는 레벨
LEVEL 2: REPEATABLE READ (반복적 읽기)
        트랜잭션안에서 동일한 SELECT 쿼리를 실행해도 트랜잭션의 어떤 위치에서던지 후행트랜잭션의 변경(UPDATE), 삭제(DELETE)의 영향을
        받지않고 항상 동일한 실행결과를 조회하는 레벨
        
        오라클에서는 공식적으로 지원하지는 않지만 SELECT FOR UPDATE 구문을 통해 효과를 낼 수 있다.
        후행 트랜잭션의 변경, 삭제에 대해서는 막을 수 있지만 (테이블에 기존에 존재했던 데이터에 대해) 
        신규(INSERT)로 입력하는 데이터에 대해서는 선행 트랜잭션에 영향이 간다
        ==>Phantom Read(귀신 읽기)
            존재하지 않았던 데이터가 갑자기 조회되는 현상
LEVEL 3 : SERIALIZABLE READ (직렬화 읽기)
        후행 트랜잭션의 직업이 선행 트랜잭션에 아무런 영향을 주지 않는 단계
        *** DBMS마다 LOCKING 메카니즘이 다르기 때문에 ISOLATION LEVEL을 함부로 수정하는 것은 위험하다.