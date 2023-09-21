-- 파일명 : 18_View_Exam.sql
-- 연습문제) 뷰(View) : 하나 이상의 테이블이나 다른 뷰를 이용해서 생성하는 가상의 테이블
--------------------------------------------------------------------------------
-- 1) 20번 부서에(DNO) 소속된 사원의 사원번호와(ENO) 
--     이름과(ENAME) 부서번호를(DNO) 출력하는 
--    VIEW를 정의하시오.(VW_EMP_DNO)
--    대상테이블 : EMPLOYEE
--  뷰 : SQL 문을 특정 이름으로 정해놓은 가상 테이블

-- 1-1) 뷰 생성
CREATE OR REPLACE VIEW VW_EMP_DNO(사번, 사원이름, 부서번호)
AS
SELECT ENO, ENAME, DNO
FROM EMPLOYEE
WHERE DNO = 20;

-- 1-2) 뷰 사용
SELECT * FROM VW_EMP_DNO;



-- 2) 이미 생성되어 있는 상기 뷰에(1번뷰) 대해 급여(SALARY) 
--     역시 출력하도록 수정해서 재생성하세요
-- (VW_EMP_DNO)
--    대상테이블 : EMPLOYEE
-- 2-1) 뷰 생성
CREATE OR REPLACE VIEW VW_EMP_DNO(사번, 사원이름, 부서번호)
AS
SELECT ENO, ENAME, DNO, SALARY
FROM EMPLOYEE
WHERE DNO = 20;

-- 2-2) 뷰 사용
SELECT * FROM VW_EMP_DNO;

-- 3) 생성된 뷰를 제거하세요(VW_EMP_DNO)
-- 3-1) 뷰 제거
DROP VIEW VW_EMP_DNO;




















