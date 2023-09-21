-- 파일명 : 11_Table_Alter_Exam.sql
-- 연습문제)테이블 구조(설계) 변경하기 : DBA(Database Administrator : DB 관리자)
-- 테이블 구조 변경에는 ROLLBACK 실행 안됨
-- 이전에 수행한 데이터 추가(INSERT(CREATE))/삭제(DELETE)/수정(UPDATE) 등의 작업만 가능
--------------------------------------------------------------------------------
-- 1) DEPT 테이블을 생성하세요.
-- 단 , DEPT 이 있으면 삭제하고(DROP TABLE ~) 재생성하세요.
-- 컬럼명 : DNO   NUMBER(2)
--         DNAME VARCHAR2(14)
--         LOC   VARCHAR2(13)
SELECT * FROM DEPT; -- 중복 확인됨
DROP TABLE DEPT;    -- 기존 테이블 삭제
CREATE TABLE DEPT -- 테이블 생성
(DNO NUMBER(2), DNAME VARCHAR2(14), LOC VARCHAR2(13)); 

-- 2) EMP 테이블을 생성하세요.
-- 단, EMP 테이블이 있으면 삭제하고(DROP TABLE ~) 재생성하세요.
-- 컬럼명 : ENO   NUMBER(4)
--         ENAME VARCHAR2(10)
--         DNO   NUMBER(2)
SELECT * FROM EMP; -- 중복 확인됨
DROP TABLE EMP;    -- 기존 테이블 삭제
CREATE TABLE EMP -- 테이블 생성
(ENO NUMBER(4), ENAME VARCHAR2(10), DNO NUMBER(2));

-- 3) EMP 테이블을 수정하세요.(ENAME 컬럼 크기)
-- 컬럼명 : ENO   NUMBER(4)
--         ENAME VARCHAR2(25)
--         DNO   NUMBER(2)
-- 사용법) ALTER TABLE 테이블명 MODIFY 컬럼명 자료형(크기);
DESC EMP; -- 테이블 구조 컬럼 크기 변경 ENAME VARCHAR2(10) ->(25)
ALTER TABLE EMP MODIFY ENAME VARCHAR2(25);

-- 4) EMPLOYEE 테이블을 복사해서 EMPLOYEE2 테이블을 생성하되
--    사원번호, 이름, 급여, 부서번호 컬럼만 복사하고,
--    새로 생성된 테이블의 컬럼명은 각각 
--    EMP_ID, NAME, SAL, DEPT_ID로 지정하세요.
--   (데이터도 복사)
-- 힌트) CREATE TABLE 복사테이블명(변경될컬럼명, 변경될컬럼명2 ...)
--      AS 
--      SELECT 원본컬러명, 원본컬럼명2,... FROM 테이블명
-- 참고 사용법) ALTER TABLE 테이블명 RENAME COLUMN 원본컬럼명 TO 변경될컬럼명;
CREATE TABLE EMPLOYEE2(EMP_ID, NAME, SAL, DEPT_ID)
AS
SELECT ENO, ENAME, JOB, MANAGER FROM EMPLOYEE;
SELECT * FROM EMPLOYEE2;

-- 5) EMP 테이블을 삭제하세요.
DROP TABLE EMP;    -- 기존 테이블 삭제
SELECT * FROM EMP;  -- 테이블 삭제 결과 확인

-- 6) EMPLOYEE2란 이름을 EMP로 변경하세요.
RENAME EMPLOYEE2 TO EMP;
SELECT * FROM EMP;  -- 테이블명 변경 결과 확인

-- 7) DEPT 테이블에서 DNAME 컬럼을 제거하세요.
SELECT * FROM DEPT;
ALTER TABLE DEPT DROP COLUMN DNAME;