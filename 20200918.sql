CREATE 객체타입 객체 이름- 개발자가 부여
DROP 객체 타입 객체 이름;

**** 알아두기
모델링 툴을 사용하여 설계를 하게되면 툴에서 설꼐된 테이블을 생성하는 구문을 자동으로 만들어준다


테이블을 생성하는 문법


CREATE TABLE [오라클 사용자].테이블명(
컬럼명 컬럼의 데이터 타입,
컬럼명2 컬럼의 데이터 타입2....
);

테이블생성
테이블명-ranger
컬럼 ranger_no NUMBER
ranger_nm VARCHAR2(50);
reg_dt DATE

CREATE TABLE yslee.ranger(
ranger_no NUMBER,
ranger_nm VARCHAR(50),
reg_dt DATE);

INSERT INTO ranger(ranger_no,ranger_nm) VALUES(1,'brown');
INSERT INTO ranger(reg_dt) VALUES(sysdate);

SELECT *
FROM ranger

INSERT INTO ranger(ranger_no,ranger_nm,reg_dt) VALUES(1,'brown',sysdate);

DROP TABLE ranger;

주로 사용하는 데이터 타입

1.숫자NUMBER(p,s) p:전체자리수, s:소수점 자리수 라고 생각
2.문자 한글자당 3byte
3.날짜 7byte고정
varchar2 날짜관리 :YYYYMMDD ==>'20200918'==>date
8byte 문자열 많이 쓰면 varchar2 고려해볼만함 
4.LARGE OBJECT
4.1 CLOB : 문자열을 저장할 수 있는 타입, 사이즈 :4GB
4.2 BLOB : 바이너리 데이터: 4GB
-CMS - 월2만원

제약조건 : 데이터에 이상한값이 들어가지 않도록 강제하는 설정

제약조건은 4가지가 존재, 그중에 한가지의 일부를 별도의 키워드로 제공
ORACLE에서 만들수 있는 제약조건이 5가지

1.NOT NULL : 컬럼에 반드시 값이 들어가게 하는 제약조건
2.UNIQUE : 해당 컬럼에 중복된 값이 들어오는 것을 방지하는 제약조건
3.PRIMARY KEY : 기본키 UNIQUE + NOT NULL
4.FOREIGN KEY : 해당컬러미 참조하는 다른 테이블의 컬럼에 값이 존재해야하는 제약조건
5. CHECK : 컬럼에 들어갈 수 있는 값을 제한하는 제약조건
ex) 성별이라는 컬럼이 있으면, 들어갈수 있는값이 남,여

제약조건을 생성하는 방법 3가지
1.테이블을 생성하면서 컬럼 레벨에 제약조건을 생성
==> 제약조건을 결함 컬럼(여러개의 컬럼을 합쳐서)에는 적용 불가
2.테이블을 생성하면서 테이블 레벨에 제약조건을 생성
3.이미 생성된 테이블에 제약조건을 추가해야 생성

1.테이블 생성시 컬럼 레벨로 제약조건 생성
CREATE TABLE 테이블명 (

);
depte_test 테이블 생성
컬럼 : dept 테이블과 동일하게
deptno NUMBER(2), dname VARCHAR2(14), loc VARCHAR2(13)
제약조건 :deptno 컬럼을 primary key 제약조건으로 생성

CREATE TABLE dept_test(
deptno NUMBER(2) PRIMARY KEY, dname VARCHAR2(14), loc VARCHAR2(13));

SELECT *
FROM dept_test;

Unique constraint (SEM.SYS_C007093) violated;
INSERT INTO dept_test VALUES (90,'ddit','daejeon');


제약조건 생성시 이름을 부여
DROP TABLE dept_test;
CREATE TABLE dept_test(
deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY, dname VARCHAR2(14), loc VARCHAR2(13));


INSERT INTO dept_test VALUES (90,'ddit','daejeon');
INSERT INTO dept_test VALUES (90,'ddit','daejeon');

2.테이블 생성시 테이블 레벨로 제약조건 생성

CREATE TABLE 테이블명 
(컬럼 1 컬럼1의 데이터타입,
컬럼2 컬럼2의 데이터타입,
[TABLE LEVEL 제약조건]
);
DROP TABLE dept_test;

DROP TABLE dept_test;
CREATE TABLE dept_test(
deptno NUMBER(2), dname VARCHAR2(14), loc VARCHAR2(13),
CONSTRAINT PK_dept_test PRIMARY KEY(deptno,dname));


deptno 컬럼의 값은 90으로 같지만 dname 컬럼 값이 다르므로 PRIMARY KEY (deptno, dname) 설정에 따라 데이터가 입력될 수 있다.

복합 컬럼에 대한 제약조건은 컬럼 레벨에서는 설정이 불가하고 테이블 레벨, 혹은 테이블 생성후 제약조건을 추가하는 형태에서만 가능
INSERT INTO dept_test VALUES (90,'ddit','daejeon');
INSERT INTO dept_test VALUES (90,'ddit2','daejeon');

NOT NULL 제약조건 생성

DROP TABLE dept_test;

CREATE TABLE dept_test(
deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY, dname VARCHAR2(14) NOT NULL, loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES (90,'ddit','daejeon');
INSERT INTO dept_test VALUES (90,NULL,'daejeon');

UNIQUE 제약 조건 : 값의 중복이 없도록 방지하는 제약조건 , 단 NULL은 허용한다.

DROP TABLE dept_test;

CREATE TABLE dept_test(
deptno NUMBER(2), dname VARCHAR2(14) 
, loc VARCHAR2(13) ,
CONSTANT U_dept_test UNIQUE(dname)
);

FOREIGN KEY 제약조건 : 참조하는 테이블에 데이터만 입력가능하도록 제어
다른 제약조건과 다르게 두개의 테이블 간의 제약조건 설정

1.dept_test (부모) 테이블 생성
2.emp_test(자식) 테이블 생성
2.1 참조 제약 조건을 같이 생성

CREATE TABLE dept_test(
deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY, dname VARCHAR2(14) NOT NULL, loc VARCHAR2(13)
);

CREATE TABLE emp_test(
empno NUMBER (4),ename VARCHAR2(10),deptno NUMBER(2), 
CONSTANT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno));

참조 무결성 조건 옵션

1.default : 자식이 있는 부모 데이터를 삭제할 수 없다
2.참조 무결성 생성시 OPTION -ON DELETE SET NULL
삭제시 참조 하고 있는 자식테이블의 컬럼을 NULL로 만든다
3.참조 무결성 생성시 OPTION -ON DELETE SET NULL
삭제시 참조 하고 있는 자식테이블 데이터도 같이 삭제

2. 
DROP TABLE emp_test;

CREATE TABLE emp_test(
empno NUMBER(4),
ename VARCHAR2(10),
deptno NUMBER(2),
CONSTANT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno) ON DELETE SET NULL
);



INSERT INTO emp_tset VALUES (9000,'brown',90);

3. 
INSERT INTO dept_test VALUES(90,'ddit','daejeon');
DROP TABLE emp_test;

CREATE TABLE emp_test(
empno NUMBER(4),
ename VARCHAR2(10),
deptno NUMBER(2),
CONSTANT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno) ON DELETE SET NULL);


INSERT INTO emp_tset VALUES (9000,'brown',90);


체크 제약 조건 : 컬럼의 값을 확인하여 입력을 허용
DROP TABLE emp_test;


CREATE TABLE emp_tset(
empno NUmBER(4),
ename VARCHAR2(14),
sal NUMBER(7), CHECK(sal>0),
gender VARCHAR2(1) CHECK(gender IN('M','F'))
);





INSERT INTO emp_tset VALUES (9000,'brown',-5,'M'); --sal
INSERT INTO emp_tset VALUES (9000,'brown',100,'T');--성별
INSERT INTO emp_tset VALUES (9000,'brown',100,'M');-- 둘다 ㅇㅋ



CREATE TABLE emp_tset(
empno NUmBER(4),
ename VARCHAR2(14),
sal NUMBER(7),CONSTRAINT c_sal CHECK(sal>0),
gender VARCHAR2(1) CHECK(gender IN('M','F'))
);

ROLLBACK;

DDL 주의점
1. DDL ROLLBACK 이 안된다.

DROP TABLE emp_test;
CREATE TABLE emp_test(
empno NUMBER(4),ename VARCHAR(14));
ROLLBACK;
SELECT *
FROM emp_test;
2. DDL은 AUTO COMMIT
DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE emp_test(
empno NUMBER(4),ename VARCHAR(14)); 커밋

INSERT INTO emp_test VALUES(9000,'brown'); 실행

CREATE TABLE dept_test(
deptno NUMBER(2),dname VARCHAR(14)); 커밋

ROLLBACK; 

롤백을 해도 이미 dept_test 테이블을 만들때 커밋이되어서 롤백이 되지않음

SELECT 결과를 이용하여 테이블 생성하기

CREATE TABLE AS==>CTAS
1.NOT NULL을 제외한 나머지 제약조건을 복사하지는 않는다.
2. 개발시
테스트 데이터를 만들어 놓고 실험을 해보고 싶을때
개발자 수준의 데이터 백업



CREATE TABLE 테이블명 [(컬럼,컬럼2)] AS
SELECT  쿼리;

DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

SELECT *
FROm dept_test;

DROP TABLE dept_test;

CREATE TABLE dept_test (dno, dnm,location) AS
SELECT *
FROM dept;


SELECT *
FROM dept;

데이터 없이 테이블 구조만 복사하고 싶을떄
DROP TABLE dept_test;

CREATE TABLE dept_test  AS
SELECT *
FROM dept
WHERE 1=2;

SELECT *
FROM dept_test;

지금까지는 TABLE 생성, 삭제
변경
1. 새로운 컬럼을 추가
2. 기존에 존재하는 컬럼의 변경(이름, 데이터 타입)
**데이터 타입의 경우는 이미 데이터가 존재하면 수정이 불가능(동일한 데이터 타입으로 사이즈를 늘리는 경우는 상관없음)
==> 설계시 고려
3.테이블이 이미 생선된 시점에 서 제약조건을 추가

테이블 변경으로 못하는 사항
1.컬럼 순서는 못바꿈
2.새로운 컬럼을 추가하더라도 마지막 커럼 뒤에 순서가 부여된다.

테이블 변경시..
ALTER TABLE 테이블명...
컬럼추가
DROP TABLE emp_test;

CREATE TABLE emp_test(
empno NUMBER(4),
ename VARCHAR(14));
DESC emp_test;

emp_test 테이블에 hp 컬럼을 VARCHAR(15)로 추가
ALTER TABLE emp_test ADD( hp VARCHAR(15));
DESC emp_test;

hp컬럼의 문자열 사이즈를 30으로 변경
ALTER TABLE emp_test MODIFY( hp VARCHAR(30));
hp컬럼의 문자열 타입을 NUMBER으로 변경
ALTER TABLE emp_test MODIFY( hp NUMBER(10));
DESC emp_tset;

**데이터 타입을 바꾸는 것은 데이터가 없을떄는 상관 없지만 데이터가 있을 경우는 사이즈를 늘리는것을 제외하고는 불가능

컬럼명 변경(데이터 타입 변경과 다르게 이름 변경은 자유롭다.)
hp컬럼을 phone으로 컬럼명을 변경
ALTER TABLE emp_test RENAME COLUMN hp TO phone;

컬럼 삭제
ALTER TABLE emp_test DROP (phone);
DESC emp_tset;

테이블이 생성된 시점에서 제약조건 추가,삭제하기
문법
ALTER TABLE 테이블명 ADD CONSTRAINT 제약 조건명 제약조건 타입;
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test(
deptno NUMBER(2),
dname VARCHAR2(14)
);

CREATE TABLE emp_test(
empno NUMBER(4),
ename VARCHAR2(10),
deptno NUMBER(2));

1.dept_test 테이블의 deptno 컬럼에 PRIMARY KEY 제약조건 추가

ALTER TABLE dept_test ADD CONSTRAINT PK_DEPT_TSET PRIMARY KEY(deptno);


2.emp_test 테이블의 empno컬럼에 PRIMARY KEY 제약 조건 추가

ALTER TABLE emp_test ADD CONSTRAINT PK_DEPT_TSET PRIMARY KEY(empno);


3.emp_test 테이블의 deptno 컬럼이 dept_test 컬럼의 deptno컬럼을 참조하는 FOREIGN KEY 제약 조건 추가

ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test
FOREIGN KEY (deptno) REFERENCES dept_test (deptno);
