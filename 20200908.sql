날짜 데이터 : emp.hiredate
            SYSDATE
            
TO_CHAR(날짜타입, '변경할 문자열 포맷')

현재 설정된 NLS DATE FORMAT : YYYY/MM/DD HH24:MI:SS

TO_DATE('날짜문자열', '첫번째 인자의 날짜 포맷')
TO_CHAR, TO_DATE 첫번째 인자 값을 넣을 때 문자열인지, 날짜인지 구분

SELECT  SYSDATE, TO_CHAR(SYSDATE, 'DD_MM_YYYY'), TO_CHAR(SYSDATE, 'D'), TO_CHAR(SYSDATE, 'IW')
FROM dual;

YYYYMMDD ==>'yyyy/mm/dd'
'20200908'==>'2020/09/08'

SELECT --SUBSTR('20200908',1,4)|| '/' || SUBSTR('20200908',5,2)||'/'|| SUBSTR('20200908',7,2)
        ename, hiredate, TO_CHAR(hiredate, 'yyyy/mm/dd hh24:mi:ss') h1,
        TO_CHAR(hiredate +1, 'yyyy/mm/dd hh24:mi:ss') h2,
        TO_CHAR(hiredate +1/24, 'yyyy/mm/dd hh24:mi:ss') h3,
        TO_CHAR(TO_DATE('20200908','YYYYMMDD'),'YYYY/MM/DD') h4
        
FROM emp;

날짜 :일자 +시분초
2020년 9월 8일 14시 10분 5초 ==> '20200908' ==> 2020년 9월 8일

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') --시분초를 날려버리기 위해서 사용
FROM dual;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') DT_DASH,
TO_CHAR(SYSDATE,'YYYY-MM-DD hh24-mi-ss') DT_DASH_WITH_TIME,
TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

날짜 조작 함수
MONTHS_BETWEEN(date1, date2) : 두 날짜 사이의 개월수를 반환
                                두 날짜의 일정보가 다르면 소수점이 나오기 때문에 잘 사용하지 않음
                                
***ADD_MONTHS(DATE,NUMBER) : 주어진 날짜에 개월수를 더하거나 뺀 날짜를 반환
                            한달이라는 기간이 월마다 달라서 직접 구현이 힘듬
ADD_MONTHS(SYSDATE,5) : 오늘 날짜로부터 5개월 뒤의 날짜는 몇일인가    

NEXT_DAY(DATE, NUMBER(주간요일: 1-7)) : DATE이후에 등장하는 첫번째 주간요일을 갖는 날짜
NEXT_**DAY(SYSDATE, 6) : SYSDATE이후에 등장하는 첫번째 금요일에 해당하는 날짜

*****LAST_DAY(DATE) : 주어진 날짜가 속한 월의 마지막 일자를 날짜로 반환
LAST_DAY(SYSDATE) : SYSDATE(2020/09/09)가 속한 9월의 마지막 날짜 : 2020/09/30
                    월마다 마지막 일자가 다르기 떄문에 해당 함수를 통해서 편하게 마지막 일자를 구할 수 있다.

SELECT MONTHS_BETWEEN( TO_DATE('20200908','YYYYMMDD'), TO_DATE('20200808','YYYYMMDD')),
ADD_MONTHS(SYSDATE,5),
NEXT_DAY(SYSDATE, 6),
LAST_DAY(SYSDATE),
TO_CHAR(SYSDATE, 'YYYYMMDD') - TO_CHAR(SYSDATE,'DD')+1,
TO_DATE('01','DD'),
ADD_MONTHS( LAST_DAY(SYSDATE), -1) +1

FROM dual;

SELECT :yyyymm, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'dd') DT
FROM dual;

형변환

명시적 형변환
TO_CHAR, TO_DATE,TO_NUMBER
묵시적 형변환
알아서 형변환 해주는것

두가지 가능한 경우
1. empno(숫자)를 문자로 묵시적 형변환
2. '7369'(문자)를 숫자로 묵시적 형변환

알면 좋다~
고급 개발자가 되기위해
실행계획 : 오라클에서 요청받은 SQL을 처리하기 위해 절차를 수립한 것
1. EXPLAIN PLAN FOR
실행계획을 분석할 SQL;
2. SELECT *
FROM TABLE(dbms_xplain.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno= '7369';

TABLE 함수 : PL/SQL의 테이블 타입 자료형을 테이블로 변환

SELECT *
FROM TABLE(dbms_xplan.display);

실행계획의 operation을 해석하는 방법
1. 위에서 아래로
2. 단 자식노드(들여쓰기가 된 노드)있을 경우 자식부터 실행하고 본인 노드를 실행

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) ='7369';

SELECT *
FROM TABLE(dbms_xplan.display);


잘안씀

1600==>1,600
숫자를 문자로 포맷팅 : DB보다는 국제화(i18n)에서 더많이 활용


SELECT empno, ename, sal, TO_CHAR(sal,'009,999L')
FROM emp;

NULL과 관련된 함수

1. NVL(컬럼 || 익스프레션, 컬럼럼 || 익스프레션)

NVL(expr1, expr2)
if(expr1 == null)
return expr2;
else
return expr1;

SELECT empno, comm,sal+ NVL(comm,0),sal+comm
FROM emp;