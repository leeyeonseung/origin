2. NVL2(expr1, expr2, expr3)
if(expr1 !=null)
Return expr2;
else
return expr3;

comm 컬럼이 null일때 0으로 변경하여 sal 컬럼과 합계를 구한다

SELECT empno, ename, sal, comm,
sal + NVL(comm,0) nvl_sum,
sal + NVL2(comm,comm,0) nvl2_sum,
NVL2(comm,sal+comm,sal) nvl2_sum2,
NULLIF(sal,sal) nullif,
NULLIF(sal,5000) nullif_sal,
sal +COALESCE(comm,0) coalesce_sum,
COALESCE(sal + comm,sal) coalesce_sum2
FROM emp;

잘 안써~
3. NULLIF(expr1, expr2)
if(expr1==expr2)
return 0;
esle
return expr1;

함수의 인지 개수가 정해지지 않고 유동적으로 변경이 가능한 인자 : 가변인자

4. coalesce(expr1, expr2, expr3.........): 가장 처음으로 NULL이 아닌 인자를 반환
if(expr1 != NULL)
return (expr1)
else
coalesce(expr2, expr2,expr3............)

SELECT empno, ename, mgr,
NVL(mgr,9999) MGR_N,
NVL2(mgr,mgr,9999) MGR_N_1,
coalesce(mgr,9999) MGR_N_2
FROM emp;

SELECT  userid,
usernm,
TO_CHAR(reg_dt,'yyyy/mm/dd'),
TO_CHAR(NVL(reg_dt,sysdate),'yyyy/mm/dd') N_REG_DT
FROM users
WHERE userid !='brown';

조건 : condition

SQL : CASE절
CASE
    WHEN 조건 THEN 반환할 문장
    ELSE
END

SELECT ename,job,sal,
CASE
WHEN job='SALESMAN' THEN sal*1.05
WHEN job='MANAGER' THEN sal*1.10
WHEN job='PRESIDENT' THEN sal*1.20
ELSE sal
END sal_b
FROM emp
ORDER BY job;

가변인자 
DECODE(col|expr1,    search1,return1,         search2,return2,                search3,return3    [default])
첫번째 컬럼이 두번째 컬럼(search1)과 같으면 세번째 컬럼(return1)을 리턴 밑으로도 동일, 일치하는값 없으면 default 리턴

SELECT ename,job,sal,
DECODE(job, 'SALESMAN', sal*1.05, 
'MANAGER', sal*1.10, 
'PRESIDENT', sal*1.20,
sal) sal_decode
FROM emp;



CASE, DECODE 차이점
DECODE : 값 비교가 = 대해서 만 가능
CASE : 부등호 사용가능, 복수개의 조건 사용가능






SELECT EMPNO, ENAME,
CASE
WHEN deptno=10 THEN 'ACCOUNTING'
WHEN deptno=20 THEN 'RESEARCH'
WHEN deptno=30 THEN 'SALES'
WHEN deptno=40 THEN 'OPERATIONS'
ELSE 'DDIT'
END DNAME_CASE,
DECODE(deptno, 
10,'ACCOUNTING', 
20,'RESEARCH',
30,'SALES',
40,'OPERATIONS',
'DDIT') DNAME_DECODE
FROM emp;
SELECT EMPNO, ENAME, 
CASE
WHEN deptno=10 THEN 'ACCOUNTING'
WHEN deptno=20 THEN 'RESEARCH'
WHEN deptno=30 THEN 'SALES'
WHEN deptno=40 THEN 'OPERATIONS'
ELSE 'DDIT'
END DNAME_CASE,
DECODE(deptno, 
10,'ACCOUNTING', 
20,'RESEARCH',
30,'SALES',
40,'OPERATIONS',
'DDIT') DNAME_DECODE
FROM emp
ORDER BY DEPTNO;




SELECT empno, ename,TO_CHAR(hiredate,'yyyy/mm/dd') hiredate,
CASE
WHEN MOD(TO_CHAR(hiredate,'yy'),2)=MOD(TO_CHAR(sysdate,'yy'),2) THEN '건강검진 대상자'
ELSE '건강검진 비대상자'
END contact
FROM emp;


SELECT userid, usernm,TO_CHAR(reg_dt,'yyyy/mm/dd') reg_dt,
CASE
WHEN MOD(TO_CHAR(reg_dt,'yy'),2)=MOD(TO_CHAR(sysdate,'yy'),2) THEN '건강검진 대상자'

ELSE '건강검진 비대상자'
END contact
FROM users;

SELECT *
FROM emp
