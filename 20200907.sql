1번

SELECT ROWNUM rn, empno,ename
FROM emp
WHERE ROWNUM<=10;


2번


SELECT * 
FROM(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp) a)
WHERE rn BETWEEN (:page- 1)*:pageSize + 1 AND :page * :pageSize;

SELECT *
FROM(SELECT ROWNUM rn, empno, ename
FROM emp)
WHERE rn >=11 AND rn<=20;


3번


SELECT *
FROM (SELECT ROWNUM rn, empno, ename
FROM(SELECT empno, ename
FROM emp
ORDER BY ename))
WHERE rn>10 AND rn<=20;

SELECT dummy
FROM dual;

ORACLE 함수 분류
*** 1. SINGLE ROW FUNCTION : 단일 행을 작업의 기준, 결과도 한건 반환
2. MULTI ROW ROW FUNCTION : 여러 행을 작업의 기준, 하나의 행을 결과로 반환

dual 테이블
    1.sys 계정에 존재하는 누구나 사용할 수 있는 테이블
    2. 테이블에는 하나의 컬럼, dummy 존재, 값은 x
    3. 하나의 행만 존재
        *****SINGLE
        
SELECT empno, ename, LENGTH('hello'),LENGTH(ename)
FROM emp;


sql 칠거지악

1. 좌변을 가공하지 말아라(테이블 컬럼에 함수를 사용하지 말것)
- 함수 실행 횟수
-인덱스 사용관련(추후에)
SELECT LENGTH('hello')
FROM dual;

SELECT ename, LOWER(ename)
FROM emp
WHERE ename = UPPER('smith');

문자열 관련 함수:
SELECT CONCAT('HELLO',', World') concat, -- 문자열 조합
SUBSTR('HELLO, World',1,5) substr, -- 문자열 추출
SUBSTR('HELLO, World',5) substr2,
LENGTH('HELLO, World') length, -- 문자열 길이
INSTR('Hello, World','o') instr, -- 문자열 찾기
INSTR('Hello, World', 'o', 5+1) instr2,
INSTR('Hello, World', 'o', INSTR('Hello, World','o')+1) instr3,
LPAD('Hello, world',15,'*') lpad, -- 왼쪽에 문자열 삽입
LPAD('Hello, world',15) lpad2,
RPAD('Hello, world',15,'*') rpad, -- 오른쪽에 문자열 삽입
REPLACE('Hello, World','HELLO','Hell') replace, -- 문자열 변경
TRIM('HEllo, World') trim, -- 처음과 끝부분 공백 지우기
TRIM('                        HEllo, World                          ') trim2,
TRIM('H' FROM 'HEllo, World') trim3
FROM dual;


숫자 관련 함수
ROUND : 반올림 함수
TRUNC : 버림 함수
    ==> 몇번째 자리에서 반올림, 버림을 할지?
    반올림 하고자하는 숫자가 0,양수 :ROUND(숫자, 반올림해서 살리는 자리)
    반올림 하고자하는 숫자가 음수 :ROUND(숫자, 반올림 하는자리)
MOD : 나머지 구하기

SELECT ROUND(105.54,1) round1,
ROUND(105.55,1) round2,
ROUND(105.55,0) round3,
ROUND(105.55,-1) round4
FROM dual;

SELECT TRUNC(105.54,1) trunc1,
TRUNC(105.55,1) trunc2,
TRUNC(105.55,0) trunc3,
TRUNC(105.55,-1) trunc4
FROM dual;

mod 나머지 구하는 함수
피재수 , 재수

SELECT TRUNC(10/3,0) TRUNC
from dual;

날짜 관련함수

문자열==> 날짜 타입 TO_DATE
SYSDATE : 오라클 서버의 현재 날짜, 시간을 돌려 주는 특수함수
          함수의 인자가 없다.
          
SELECT SYSDATE
FROM dual;

날짜 타입 +- 정수(일자) : 날짜에서 정수만큼 더하고 뺀 날짜

SELECT SYSDATE, SYSDATE +5, SYSDATE -5,
SYSDATE +1/24, SYSDATE + 1/24/60, SYSDATE+1/24/60/60
FROM dual;

SELECT TO_DATE('2019/12/31','yyyy/mm/dd') lastday,
TO_DATE('2019/12/31','yyyy/mm/dd')-5 lastday_before5, 
SYSDATE now ,
SYSDATE-3 now_before3
FROM dual;

