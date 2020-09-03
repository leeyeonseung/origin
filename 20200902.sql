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