-- 파일명 : 13_Table_Constraint_Exam.sql
-- 연습문제) 테이블 제약조건 : 테이블에 입력될 값을 제한하는 것
--------------------------------------------------------------------------------
-- 1) EMPLOYEE 테이블의 구조를 복사하여 EMP_SAMPLE 란 
--    이름의 테이블을 만드시오.
--    사원 테이블의 사원번호 컬럼(ENO)에 
--    테이블 레벨로 PRIMARY KEY 제약조건을 지정하되,
--    제약 조건 이름은 PK_MY_EMP 하시오.
-- 1-1) 복사본 : 제약조건 복사 안됨(기본키,외래키 직접 생성해야 함)
CREATE TABLE EMP_SAMPLE
AS
SELECT * FROM EMPLOYEE
WHERE 1 = 2;
-- 1-2) 기본키
ALTER TABLE EMP_SAMPLE
ADD CONSTRAINT PK_MY_EMP PRIMARY KEY(ENO);

-- 2) DEPARTMENT 테이블의 구조를 복사하여 
--    DEPT_SAMPLE란 이름의 테이블을 만드시오.
--    부서번호 컬럼(DNO)에 PRIMARY KEY 제약조건을 지정하되,
--    제약 조건 이름은 PK_MY_DEPT 하시오.
-- 2-1) 테이블의 구조 복사
CREATE TABLE DEPT_SAMPLE
AS
SELECT * FROM DEPARTMENT
WHERE 1 = 2;
-- 2-2)  기본키
ALTER TABLE DEPT_SAMPLE
ADD CONSTRAINT PK_MY_DEPT PRIMARY KEY(DNO);

-- 3) 사원 테이블의(EMP_SAMPLE) 부서번호 컬럼에 존재하지 않는 
--    부서의 사원이 배정되지 않도록
--    외래 키(FOREIGN KEY:FK) 제약조건을 지정하되, 
--    FK_MY_DEPT_EMP 로 하시오.
--    참조테이블 : DEPARTMENT (데이터가 있음)
--    참조키,외래키(FOREIGN KEY:FK)
ALTER TABLE EMP_SAMPLE
ADD CONSTRAINT FK_MY_DEPT_EMP
FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DNO);