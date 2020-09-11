SELECT * | {column | expression [alias] }
FROM 테이블 이름;

SELECT *
FROM emp;

SELECT *
FROM dept;

select empno, ename
from emp;

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SELECT ename, sal, sal+100
FROM emp;

DESC emp;

SELECT *
FROM emp;

SELECT ename, hiredate, hiredate+365
FROM emp;

SELECT ename, hiredate, hiredate+365 after_1year, hiredate-365 before_1year
FROM emp;

SELECT *
FROM dept;

SELECT ename, sal, comm, sal + comm AS total_sal
FROM emp;




SELECT prod_id as id, prod_name as name
FROM prod;

SELECT lprod_gu as gu, lprod_nm as nm
FROM lprod;

SELECT buyer_id as "바이어아이디", buyer_name "이름"
FROM buyer;

SELECT ename||' ' || job
FROM emp;

SELECT CONCAT(CONCAT(ename,' '),job) 
FROM emp;


SELECT CONCAT('SELECT * FROM',CONCAT(' ',CONCAT(table_name, ';'))) as QUERY
FROM user_tables;

SELECT empno "test"
FROM emp;



테이블의 구조(컬러명, 데이터타입) 확인하는 방법
1. DESC 테이블명 : DESCRIBE
2. 컬럼 이름만 알 수 있는 방법(데이터 타입은 유추)
SELECT *
FROM 테이블명;
3.툴에서 제공하는 메뉴 이용
    접속정보 - 테이블 - 확인하고자하는 테이블 클릭
    
    조건 연산자(whre)
    동등 비교(equal)
    sal=1500
    not equal
    !=,<>
    
    대입연산자 :    :=
    
    SELECT userid, usernm, alias,reg_dt
    FROM users
    WHERE 1=2;
    
    emp테이블에서 부서번호가 30보다 크거나 같은 사원들만 조회 컬럼은 모든 컬럼 조회
    
    SELECT *
    FROM emp
    WHERE deptno>=30;
    
    
    날짜 리터럴 : 서버마다 다르게 해석할수 있기 때문에 서버 설정과 관계없이 동일하게 해석할 수 있는 방법으로 사용
    TO_DATE('날짜문자열','날짜문자열양식')
    
    SELECT ename, hiredate
    FROM emp
    WHERE hiredate >= TO_DATE('1982/01/01','yyyy/mm/dd');
    
    BETWEEN AND 대상자
    WHERE 비교대상 BETWEEN 시작값 AND 종료값;
    
    SELECT *
    FROM emp
    WHERE 2000>=sal AND sal>=1000;
    
    SELECT ename, hiredate
    FROM emp
    WHERE hiredate BETWEEN '1982/01/01' AND '1983/01/01' ;
    
    SELECT ename, hiredate
    FROM emp
    WHERE  hiredate >='1982/01/01' 
    AND '1983/01/01'>= hiredate  ;
    
    IN연산자
    특정값이 집학에 포함되어있는지 여부를 확인(값1or값2)
    
    
    SELECT *
    FROM emp
    WHERE deptno IN(10,30);
    
    SELECT *
    FROM emp
    WHERE deptno =10 OR deptno =30;
    
    SELECT userid as "아이디", usernm as "이름", alias as "별명"
    FROM users
    WHERE userid = 'brown'
    or userid = 'cony'
    or userid = 'sally';
    
    LIKE 연산자 : 문자열 매칭
    userid가 b로 시작하는 캐릭터만 조회
    
    %: 문자가 없거나, 여러개의 문자열
    _ : 하나의 임의의 문자
    
    
    ename이 W로 시작하고 이어서 3개의 글자가 있는 사원
    SELECT *
    FROM emp
    WHERE ename LIKE 'W___'; 
    
    SELECT mem_id, mem_name
    FROM member
    WHERE mem_name LIKE '%이%';
 WHERE 절 : 스프레드 시트
        -filter : 전체 데이터중에서 내가 원하느 행만 나오도록 제한
        
NULL 비교

NULL값은 -,!= 등의 비교연산으로 비교가 불가능
EX : emp 테이블에는 comm컬럼의 값이 NULL인 데이터가 존재
comm이 NULL인 데이터를 조회 하기 위해 다음과 같이 실행할 경구 정상적으로 동작하지 않음
WHERE 절에서 NULL값일때는 IS 사용
SELECT *
FROM emp
WHERE comm IS NOT NULL;

comm 컬럼의 값이 NULL이 아닐떄
-,!=<>

IN <==> NOT IN

사원중 소속 부서가 10번이 아닌 사원 조회
SELECT *
FROM emp
WHERE deptno NOT IN(10);

SELECT *
FROM emp
WHERE mgr IS NULL;

논리연산 : AND, OR, NOT
AND, OR : 조건을 결합

SELECT *
FROM emp
WHERE mgr = 7698 
    OR sal>1000;
    
SELECT *
FROM emp
WHERE mgr !=7698 AND  mgr !=7839;

SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839);


WHERE mgr IN (7698,7839); ==>WHERE mgr =7698 OR 7839
WHERE mgr NOT IN (7698,7839); ==>WHERE mgr !=7698 AND 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839,NULL);

SELECT *
FROM emp
WHERE job='SALESMAN' AND hiredate > TO_DATE('1981/06/01','yyyy/mm/dd') ; 

SELECT *
FROM emp
WHERE deptno !=10 AND hiredate > TO_DATE('1981/06/01','yyyy/mm/dd') ; 



SELECT *
FROM emp
WHERE job = 'SALESMAN' AND empno LIKE '78%'; AND hiredate > TO_DATE('1981/06/01','yyyy/mm/dd'); 

sql의 실행결과, 데이터 조회 순서는 보장되지않는다. (매번 다름)

ORDER BY : 정렬
[ORDER BY 컬럼1, 컬럼2]

오름차순, ASC : 값이 작은 데이터부터 큰 데이터 순으로 나열
내림차순, DESC : 값이 큰 데이터부터 작은 데이터 순으로 나열

ORACLE에서는 오름차순 기본 값 , 내림차순으로 정렬하고 싶으면 기준 컬럼 뒤에 DESC

SELECT *
FROM emp
ORDER BY job, empno DESC;


참고
1.ORDER BY 절에 별칭 사용가능

SELECT empno eno, ename enm
FROM emp
ORDER BY enm;

2.ORDER BY 절에 SELECT 절의 컬럼 순서번호를 기술 하여 정렬 가능

SELECT empno, ename
FROM emp
ORDER BY 2;

3. expression 도 가능

SELECT empno, ename, sal
FROM emp
ORDER BY sal+500;

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

SELECT *
FROM EMP
WHERE comm IS NOT NULL AND comm !=0
ORDER BY  comm DESC, empno DESC  ;

SELECT *
FROM emp
WHERE MGR IS NOT NULL
ORDER BY job, Empno DESC;

SELECT *
FROM emp
WHERE deptno IN(10,30) AND sal>1500
ORDER BY ename DESC;

---------실무에서 많이 사용-------------
ROWNUM : 행의 번호를 부여해주는 가상 컬럼
                -- 조회된 순서대로 번호를 부여
                
1. WHERE 절에서 사용가능

* WHERE ROWNUM =1 (= 동등 비교 연산의 경우 1만 가능)
WHERE ROWNUM<=15                  =====================> 돼
WHERE ROWNUM BETWEEN 1 AND 15       ======================>돼

    ROWNUM은 1번부터 순차적으로 데이터를 읽어 올 때만 사용 가능
    
SELECT ROWNUM empno, ename
FROM emp
WHERE ROWNUM BETWEEN 6 AND 10;   ==========> 안돼


SELECT ROWNUM, empno, ename
FROM emp;

2. ORDER BY 절은 SELECT 이후에 실행된다.
-- SELECT절에 ROWNUM을 사용하고 ORDER BY절을 적용하게 되면 원하는 결과를 얻지 못한다.

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;   ===============> 뒤죽박죽

정렬을 먼저 하고, 정렬된 결과에 ROWNUM 적용

==> INLINE-VIEW
    SELECT 결과를 하나의 테이블 처럼 만들어 준다.
    
    
    
사원정보를 페이징 처리
1페이지에 5명씩 조회
1페이지 : 1~5,     (page-1)*pageSize+1 ~ page * pageSize
2페이지 : 6~10,    
3페이지 : 11~15

page, pageSize=5



SELECT * 
FROM(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN (:page- 1)*:pageSize + 1 AND :page * :pageSize;

SELECT 절에 *사용했는데,를 통해 다른 특수 컬럼이나 EXPRESSION을 사용 할 경우는 
*앞에 해당 데이터가 어떤 테이블에서 왔는지 명시를 해줘야 한다.(한정자)


SELECT ROWNUM, *
FROM emp;   ================>안됌

SELECT ROWNUM, emp.*
FROM emp;

별칭은 테이블에도 적용 가능, 단 컬럼이랑 다르게 AS 옵션은 없다

SELECT ROWNUM, e;
FROM emp e;

SELECT *
FROM emp
WHERE job = 'SALESMAN';


SELECT *
FROM emp
WHERE job = 'SALESMAN' AND empno LIKE '78%';

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%';


SELECT *
FROM emp
WHERE job ='SALESMAN' OR (hiredate>TO_DATE('1981.06.01','yyyy,mm,dd') AND empno LIKE '78%');

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno BETWEEN 7800 AND 7899;
