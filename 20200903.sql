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
 

