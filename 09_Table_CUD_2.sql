-- 파일명 : 09_Table_CUD_2.sql
-- 테이블(데이터) 조작 방법(UPDATE)

-- 기타 명령어
-- 테이블 설계구조 보기 : DESC 테이블명
DESC DEPT_COPY;
--------------------------------------------------------------------------------
-- 대상 : DEPT_COPY 실습
SELECT * FROM DEPT_COPY;
-- 예제1) 10번 부서의 이름 수정하기 : 'ACCOUNTING' -> 'PROGRAMMING'
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING'
WHERE DNO = 10; -- DNO : 10 , DNAME : ACCOUNTING -> PROGRAMMING

COMMIT; -- 영구 반영 : 다른 사람이 변경된 데이터를 볼 수 있음

-- 연습1) 20번 부서 이름 수정하기 : 'HR' (인사과)
UPDATE DEPT_COPY
SET DNAME = 'HR'
WHERE DNO = 20;
SELECT * FROM DEPT_COPY;

COMMIT;

-- 연습(응용) 2) 컬럼 값을 여러 개 수정하기
--             10번 부서의 부서명을 'PROGRAMMING2', 부서위치를 'SEOUL' 로 수정하세요.
-- 힌트) 추가 작성은 쉼표로 이어서 작성 : SET 컬럼명 = 값, 컬럼명2 = 값2 ...
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING2', LOC = 'SEOUL'
WHERE DNO = 10;
SELECT * FROM DEPT_COPY;
COMMIT;

-- 전체 부서에 대해서 수정하기
UPDATE DEPT_COPY
SET DNAME = 'PROGRAMMING2', LOC   = 'SEOUL';

ROLLBACK;
--------------------------------------------------------------------------------
-- 예제 1) 10번 부서의 지역명을 (20번 부서의 지역명)으로 수정하기
-- 힌트) 서브쿼리로 수정하기
-- 1-1) 20번 부서의(DNO) 지역명(LOC)
SELECT LOC FROM DEPT_COPY WHERE DNO = 20; -- DALLAS
-- 1-2) UPDATE
UPDATE DEPT_COPY
SET LOC = (SELECT LOC FROM DEPT_COPY WHERE DNO = 20)
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;
COMMIT;

-- 연습2) 10번 부서의 부서명, 지역명을 30번 부서의 부서명, 지역명으로 변경하기
-- 힌트) 서브쿼리
-- 2-1) 30번 부서의 부서명, 지역명
SELECT DNAME, LOC FROM DEPT_COPY WHERE DNO = 30; -- SALES, CHICAGO
-- 2-2) UPDATE 
UPDATE DEPT_COPY
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT_COPY WHERE DNO = 30)
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;
COMMIT;
--------------------------------------------------------------------------------
-- DELETE : 삭제(D), 전체삭제, 부분삭제 모두 가능, 취소 가능
-- VS TRUNCATE TABLE 테이블; (빠른 전체삭제, 취소불가)
-- 예제) 10번 부서를 삭제하세요.
DELETE FROM DEPT_COPY
WHERE DNO = 10;

SELECT * FROM DEPT_COPY;
COMMIT;

-- 연습1) 영업부에(SALES) 에 근무하는 사원(DNO) 삭제하기
-- 힌트) 서브쿼리 사용해서 삭제
-- 1-1) 영업부에(SALES)에 해당하는 부서번호
SELECT DNO
FROM DEPT_COPY
WHERE DNAME = 'SALES';  -- 30


-- 1-2) 그 부서번호를 가진 사원을 삭제하기
DELETE FROM DEPT_COPY
WHERE DNO = (SELECT DNO FROM DEPT_COPY WHERE DNAME = 'SALES');

SELECT * FROM DEPT_COPY;
COMMIT;
--------------------------------------------------------------------------------