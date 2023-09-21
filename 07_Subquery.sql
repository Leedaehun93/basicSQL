-- 파일명 : 07_Subquery.sql
-- 서브쿼리(자식쿼리) 단일행, 다중행
--------------------------------------------------------------------------------
-- 서브쿼리 : 단일행 서브쿼리(1건만 나옴)
-- 예제1) SCOTT 사원보다 급여를 많이 받는 사원을 찾기위한 SQL문을 작성하세요
-- 해결 : 1-1) 사원테이블에서 SCOTT 사원의 급여를 찾은 후에(1번)
--       1-2) 그 급여를 비교해서 많이 받는 사원을 추가로 찾아야함(2번)
-- 1-1
SELECT SALARY
FROM EMPLOYEE
WHERE ENAME = 'SCOTT'; -- 1-1조건 : 3000(급여)
-- 1-2
SELECT ENAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000; -- 1-2조건

-- 문제점 ) 여러번 쿼리로 인해 성능 저하 
-- 사용법) SELECT 컬럼명 FROM 테이블명
--        WHERE 비교컬럼 > (SELECT 비교컬럼 FROM 테이블명)
SELECT ENAME, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE ENAME = 'SCOTT');
                
-- 예제1) SCOTT 사원과(1개) 동일한 부서에서(DNO) 근무하는 사원(ENAME)(2개) 출력하기
-- 힌트) 1) 2개의 SQL 만들고 
--         1-1) SCOTT 사원의 부서번호를 찾기
--         1-2) 위의 부서번호로 다른 사원 찾기
--       2) 1개로 합치기
SELECT ENAME FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM EMPLOYEE
                WHERE ENAME = 'SCOTT');
                
-- 예제 2) 30번 부서에서 최소급여를(MIN) 구한 후) 2)그 최소 급여보다(MIN) 
-- 부서별(DNO) 최소 급여가 큰 부서만 출력하세요.
-- 서브쿼리를 사용하세요.
-- 2-1) 30번 부서에서 최소급여를 구한 후 : 950
SELECT MIN(SALARY)
FROM EMPLOYEE
WHERE DNO = 30;

-- 2-2) 부서별 최소 급여 구하기 : 
SELECT DNO, MIN(SALARY)
FROM EMPLOYEE
GROUP BY DNO
HAVING MIN(SALARY) > (SELECT MIN(SALARY)
                        FROM EMPLOYEE
                        WHERE DNO = 30);
--------------------------------------------------------------------------------                        
-- 3) 특수한 경우 아래처럼 사용도 가능
-- SELECT 예약어 다음에도 서브쿼리 사용가능
SELECT 2*3, (SELECT 4*3 FROM DUAL)
FROM DUAL;
--------------------------------------------------------------------------------
-- FROM 예약어 다음에도 서브쿼리 사용가능
SELECT EMP.ENAME, EMP.ENO
FROM (SELECT ENAME, ENO FROM EMPLOYEE) EMP;

-- 2) 다중 행 서브쿼리(자식쿼리) : 여러 건이 나옴
-- 예제4) (1)부서별 최소 급여를 받는 사원 중에서 (2) 사원번호와 이름을 출력하세요
-- (1) 부서번호별(DNO) 최소 급여(SALARY) : (950, 1300, 800)
SELECT MIN(SALARY)
FROM EMPLOYEE
GROUP BY DNO;

-- (2) (950, 1300, 800) 급여를(SALARY) 받는 사원번호(ENO), 이름을(ENAME) 출력하라
SELECT ENO, ENAME
FROM EMPLOYEE
WHERE SALARY IN (950, 1300, 800);

-- 최종 쿼리
SELECT ENO, ENAME
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)
                FROM EMPLOYEE
                GROUP BY DNO);