-- 파일명 : 11_Table_Alter.sql
-- 테이블 구조(설계) 변경하기 : DBA(Database Administrator : DB 관리자)
-- 테이블 구조 변경에는 ROLLBACK 실행 안됨
-- 이전에 수행한 데이터 추가(INSERT(CREATE))/삭제(DELETE)/수정(UPDATE) 등의 작업만 가능
--------------------------------------------------------------------------------
-- 실습 테이블 : DEPT20
CREATE TABLE DEPT20
AS
SELECT * FROM DEPARTMENT
WHERE 1=2;
SELECT * FROM DEPT20;   -- 결과 보기

-- 예제1) 부서 테이블에 날짜 자료형을 가지는 BIRTH 컬럼 추가하기
-- 날짜 자료형 : DATE 사용(크기 없음)
-- 테이블에 새로운 컬럼 추가하기
-- 사용법 : ALTER TABLE 테이블명 ADD(컬럼명 자료형);
ALTER TABLE DEPT20
ADD(BIRTH DATE);    -- 날짜 자료형 BIRTH 컬럼 추가 생성됨
SELECT * FROM DEPT20;   -- 결과 보기

-- 예제2) 부서 테이블(DEPT20) 부서명(DANEM) 의 크기를 변경하기(기존 -> 수정(MODIFY))
-- 테이블에 컬럼 변경(크기 변경, 자료형 변경 등)
ALTER TABLE DEPT20 MODIFY DNAME VARCHAR2(30);
-- 테이블 구조 보기 명령어 : DESC 테이블명
DESC DEPT20;
DESC DEPT20; -- 테이블 구조 DNAME(14)->(30) 크기로 변경
DESC DEPARTMENT;

-- 예제3) 부서 테이블(DEPT20) BIRTH 컬럼 삭제하기(DROP)
-- 사용법 : ALTER TABLE 테이블명 DROP COLUMN 삭제할컬럼명;
ALTER TABLE DEPT20 DROP COLUMN BIRTH;   -- 날짜 자료형 BIRTH 컬럼 삭제됨
SELECT * FROM DEPT20;   -- 결과 보기

-- 예제4) 테이블 이름 변경하기 : DEPT 20 -> DEPT30
-- 사용법 : RENAME 테이블명 TO 테이블명2;
RENAME DEPT20 TO DEPT30;
-- 테이블 구조 보기 명령어 : DESC 테이블명
DESC DEPT30;    -- 결과 보기 : 테이블명 DEPT30 이름이 변경됨을 확인됨
DESC DEPT20;    -- 결과 보기 : 테이블명 DEPT20 삭제됨을 확인