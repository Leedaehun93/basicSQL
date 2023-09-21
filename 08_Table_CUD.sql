-- 파일명 : 08_Table_CUD.sql
-- 테이블(데이터) 조작 방법(생성, 복사, 삭제, 테이블/컬럼 주석 사용)

-- CRUD : DB 또는 실무 프로젝트 많이 사용하는 약어
-- C(CREATE 문(생성)), R(READ, SELECT 문(조회)), U(UPDATE 문(수정)), D(DELETE 문(삭제))
-- 테이블 의미 : DB(데이터베이스)에서 자료를 저장하는 곳(논리적 공간)
-- 프로젝트 : 개발자 계정으로 접속해서 테이블 등을 생성함 (SCOTT 계정

-- 기타 명령어 테이블 설계구조 보기
-- 사용법 : DESC 테이블명
DESC DEPT_COPY;
--------------------------------------------------------------------------------
-- 1) 테이블 생성 : DDL( DATA DEFINITION LANGUAGE : 데이터 정의어(용어))
--    사용법 : CREATE TABLE 테이블명
--            (컬럼명 자료형(크기),
--            ...
--            );

-- NUMBER(크기) : 숫자 자료형, (실수, 정수 등)
-- 예) NUMBER(2) : 2자리수 정수, NUMBER(2, 3) : 2자리수 정수 + 3자리수 소수점
--     NUMBER : 실수, 정수 무한 크기로 지정가능(크기 생략)
-- 단, 크기가 지정되면 그 크기 이하로만 값을 넣을 수 있음(기본)
-- VARCHAR2(크기) : 문자열 자료형, 가변자료형 (VS CHAR(크기): 고정자료형)
-- 예) VARCHAR2(4000) : 최고 크기, VARCHAR2 : 잘 안씀(1글자만 들어감)

CREATE TABLE DEPT
(DNO NUMBER(2), DNAME VARCHAR2(14), LOC VARCHAR2(13));

-- 예제1) 사원테이블 : EMP
--        컬럼명 : ENO(사원번호, 숫자(4,0)
--                ENAME (사원명, 문자형(10)
--                JOB(직위, 문자형(9)
--                MANAGER(관리자) 숫자(4,0)
--                HIREDATE 입사일, 날짜형 *(DATE)
--                SALARY 월급, 숫자형(7,2)
--                COMMISSION 상여금, 숫자형(7,2)
--                DNO  부서번호,  숫자형(2,0)  
CREATE TABLE EMP
(ENO NUMBER(4, 0), ENAME VARCHAR2(10), JOB VARCHAR2(9), MANAGER NUMBER(4, 0),
HIREDATE DATE, SALARY NUMBER(7, 2), COMMISSION NUMBER(7, 2), DNO NUMBER(2, 0));
--------------------------------------------------------------------------------
-- 2) 테이블 만들기 복사 생성
-- 실무 예 : 테이블만들기 : 테이블 복사(카피) 

-- 예제2) DEPARTMENT 테이블 복사하기 : DEPT_COPY 테이블을 만드세요
-- 2-1) 데이터까지 포함해서 복사
-- 사용법 : CREATE TABLE 복사할테이블명
--         AS
--         SELECT * FROM 원본테이블;
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

-- 2-2) 데이터 빼고 테이블 설계(디자인)만 복사
-- 사용법) CREATE TABLE 복사할테이블명
--        AS
--        SELECT * FROM 원본테이블
--        WHERE 거짓조건
CREATE TABLE DEPT_COPY2
AS
SELECT * FROM DEPARTMENT
WHERE 1 = 2;  -- 거짓조건 아무거나 붙이면 데이터 빼고 복사됨( 1은 2와 같다 등..)
--------------------------------------------------------------------------------
-- 3) 컬럼/테이블 주석 달기 : 테이블/컬럼에 상세 설명을 불일 수 있음

-- 예제3) DEPT 테이블에 테이블/컬럼 주석 달기
-- 3-1) 테이블 주석 달기
-- 사용법 : COMMENT ON TABLE 테이블명 IS '테이블주석';
COMMENT ON TABLE DEPT IS '부서정보';

-- 3-2) 컬럼 주석 달기
-- 사용법 : COMMENT ON COLUMN 테이블명.컬럼명 IS '컬럼주석';
COMMENT ON COLUMN DEPT.DNO IS '부서번호';
COMMENT ON COLUMN DEPT.DNAME IS '부서명';
COMMENT ON COLUMN DEPT.LOC IS '부서위치';

-- 예제3) 사원테이블의 EMP 의 테이블 주석/컬럼주석을 작성해서
--      만들어 주세요
--    보기 : EMP ( 테이블주석 : 사원정보 )
--       컬럼주석 : ENO(사원번호), 
--                 ENAME(사원명), 
--                 JOB(직위), 
--                 MANAGER(관리자), 
--                 HIREDATE(입사일), 
--                 SALARY(월급), 
--                 COMMISSION(상여금), 
--                 DNO(부서번호)
-- 3-1) 테이블 주석 달기
COMMENT ON TABLE EMP IS '사원정보';
-- 3-2) 컬럼 주석 달기
COMMENT ON COLUMN EMP.ENO IS '사원번호';
COMMENT ON COLUMN EMP.ENAME IS '사원명';
COMMENT ON COLUMN EMP.JOB IS '직위';
COMMENT ON COLUMN EMP.MANAGER IS '관리자';
COMMENT ON COLUMN EMP.HIREDATE IS '입사일';
COMMENT ON COLUMN EMP.SALARY IS '월급';
COMMENT ON COLUMN EMP.COMMISSION IS '상여금';
COMMENT ON COLUMN EMP.DNO IS '부서번호';
--------------------------------------------------------------------------------
-- 4) 테이블 삭제
-- 사용법 : DROP TABLE 테이블명;
DROP TABLE DEPT_COPY;
-- 예제 5) DEPT_COPY2 테이블 삭제하세요.
DROP TABLE DEPT_COPY2;
--------------------------------------------------------------------------------
-- 5) 데이터 추가(INSERT(CREATE))/삭제(DELETE)/수정(UPDATE) 명령어 : CUD
-- DML 문(DATA MANIPULATION LANGUAGE : 데이터 조작어)
-- 특징 : 명령문 실행 후 취소(ROLLBACK)
-- 5-1) 테이블 복사 : DEPT_COPY (원본 : DEPARTMENT(부서) ) [데이터 빼고]
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT
WHERE 1=2;
-- 예제6) DEPT_COPY 테이블에 데이터 INSERT
-- 컬럼 : DNO(NUMBER(2,0)), DNAME(VARCHAR2(14), LOC(VARCHAR2(13)
-- 사용법 : INSERT INTO 테이블명(컬럼명, 컬럼명2, ...)
--         VALUES(값, 값2, ...); -- 데이터 추가
-- 데이터 추가
INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(10, 'ACCOUNTING', 'NEW YORK');
-- 데이터 확인
SELECT * FROM DEPT_COPY;
-- 취소
ROLLBACK;
-- 영구 반영 : 취소(ROLLBACK)불가상태
-- 의미 : 영구 반영하면 다른 유저가 현재 생성한/수정/삭제한 데이터를 볼 수 있음
COMMIT;

-- 예제7) 임시적으로 NULL 값을 입력해서 INSERT 하기
-- 7-1) 암묵적으로(눈에 안보이지만) NULL 값 INSERT 하기
INSERT INTO DEPT_COPY(DNO, DNAME)
VALUES(30, 'SALES');    -- 데이터 생성
SELECT * FROM DEPT_COPY;    -- 데이터 확인
-- 영구 반영
COMMIT;

-- 7-2) 명시적으로 NULL 값 넣기
INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(40, 'OPERATIONS', NULL); -- 데이터 생성

SELECT * FROM DEPT_COPY;    -- 데이터 확인
-- 영구 반영
COMMIT;

-- 연습2) DEPT_COPY 테이블에 50 부서 'COMPUTING' 만들고,
--        LOC 는 ' ' 공백으로 INSERT 하세요.
INSERT INTO DEPT_COPY(DNO, DNAME, LOC)
VALUES(50, 'COMPUTING', ' ' );    -- 데이터 생성
SELECT * FROM DEPT_COPY;    -- 데이터 확인
-- 영구 반영
COMMIT;

-- 연습용 테이블 복사 : EMP_COPY (원본 : EMPLOYEE) [데이터 빼고]
CREATE TABLE EMP_COPY
AS
SELECT * FROM EMPLOYEE
WHERE 1 = 2;    -- 거짓조건

-- 연습2) EMP_COPY 테이블에 데이터 입력하기
--  ENO - 7000, ENAME - 'CANDY', JOB - 'MANAGER',
--  HIREDATE - '2012/05/01', DNO - 10
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7000, 'CANDY', 'MANAGER', '2012/05/01', 10);
SELECT * FROM EMP_COPY; -- 데이터 확인
COMMIT; -- 영구 반영

-- 예제8) 명시적으로 날짜형으로 변환해서 INSERT 하기
-- 날짜함수 : TO_DATE(문자열, '날짜포맷')
-- 날짜포맷 : 'YYYY-MM-DD HH24:MI:SS'
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7010, 'CANDY2', 'MANAGER', TO_DATE('2012/05/01','YYYY-MM-DD HH24:MI:SS'), 10);
COMMIT;
SELECT * FROM EMP_COPY; -- 데이터 확인

-- 예제9) INSERT 할때 현재날짜(시간) 데이터 넣기 : SYSDATE (현재날짜)
INSERT INTO EMP_COPY(ENO, ENAME, JOB, HIREDATE, DNO)
VALUES(7020, 'CANDY3', 'MANAGER', SYSDATE, 10);
COMMIT; -- 영구 반영
SELECT * FROM EMP_COPY; -- 데이터 확인
--------------------------------------------------------------------------------
-- 예제10) 다른 테이블의 데이터만 복사하기
SELECT * FROM DEPT_COPY;
-- 빠른 삭제 : DELETE 문 보다 속도 빠름
-- 전체 삭제만 됨, 취소불가(ROLLBACK)
-- 사용법 : TRUNCATE TABLE 테이블명;
TRUNCATE TABLE DEPT_COPY;

-- 다른 테이블의 데이터 복사(원본데이터 : DEPARTMENT(부서))
-- 사용법 : INSERT INTO 복사될테이블명
--         SELECT * FROM 원본테이블명;
INSERT INTO DEPT_COPY
SELECT * FROM DEPARTMENT;
-- 결과 확인
SELECT * FROM DEPT_COPY;
-- 영구 반영
COMMIT;
