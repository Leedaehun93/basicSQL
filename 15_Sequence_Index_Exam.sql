-- 파일명 : 15_Sequence_Index_Exam.sql
-- 연습문제) 시퀀스(Sequence), 인덱스(INDEX)
--------------------------------------------------------------------------------
-- 1) 사원 테이블의(EMPLOYEE) 사원번호가(ENO) 자동으로 생성되도록 
--    시퀀스를 생성하시오.
--  시퀀스 이름 : SQ_EMP , 시작번호 : 1, 증가 : 1, 최대값 : 100000
--  사용법 : CREATE SEQUENCE 시퀀스명
--        INCREMENT BY 증가값
--        START WITH 시작값
--        MINVALUE   최소값
--        MAXVALUE   최대값;
CREATE SEQUENCE SQ_EMP
START WITH 1
INCREMENT BY 1
MAXVALUE   100000;
-- 확인 조회
SELECT SQ_EMP.NEXTVAL FROM EMPLOYEE;

-- 2) 사원번호를(ENO) 시퀀스로부터 발급(부여)받으시오.
-- 임시 사원 테이블 : EMP01
--                  컬럼명 : EMPNO NUMBER(4) PRIMARY KEY,
--                          ENAME VARCHAR2(10),
--                          HIREDATE DATE
-- INSERT문을 이용해서 EMPNO에 시퀀스값을(1번에서 만든) 추가 하시오.
-- (단, 이름이나 날짜는 임의로(가라성데이터) 하시오)
CREATE TABLE EMP01(
EMPNO NUMBER(4) PRIMARY KEY,
ENAME VARCHAR2(10),
HIREDATE DATE
);
-- INSERT : 시퀀스 : SQ_EMP.NEXTVAL
INSERT INTO EMP01 VALUES(SQ_EMP.NEXTVAL,'JULIA', SYSDATE);
COMMIT;
SELECT * FROM EMP01;

-- 3) EMP01 테이블에 이름(ENAME) 컬럼에 INDEX를 생성하시오.
--    (인덱스명: IDX_EMP01_ENAME)
--    CREATE INDEX 인덱스명
--    ON 대상테이블명(대상컬럼명);
CREATE INDEX IDX_EMP01ENAME ON EMP01(ENAME);