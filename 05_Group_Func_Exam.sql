-- 파일명 : 05_Group_Func_Exam.sql
-- 연습문제
--------------------------------------------------------------------------------
-- 연습문제1) 모든 사원의 급여 최고액, 최저액, 총액 및 평균 급여를 출력하세요.
--  컬럼의 별칭은 : 최고액, 최저액, 총액, 평균급여
-- 단 실수가 나오면 반올림 해주세요(ROUND)
-- 사원 : EMPLOYEE
SELECT MAX(SALARY) AS 최고액,
MIN(SALARY) AS 최저액,
SUM(SALARY) AS 총액,
ROUND(AVG(SALARY)) AS 평균급여
FROM EMPLOYEE;

-- 연습문제2) 각 담당 업무(직위)(JOB) 유형별로 급여(SALARY) 최고액, 최저액, 
--             총액 및 평균액을 출력하세요.
--  컬럼의 별칭은 : 최고액, 최저액, 총액, 평균급여
-- 단 실수가 나오면 반올림 해주세요(ROUND)
-- 사원 : EMPLOYEE
SELECT JOB,
MAX(SALARY) AS 최고액,
MIN(SALARY) AS 최저액,
SUM(SALARY) AS 총액,
ROUND(AVG(SALARY)) AS 평균급여
FROM EMPLOYEE
GROUP BY JOB;

-- 연습문제3) 담당업무별로(JOB) count(*) 함수를 이용하여  
--           사원 수를 출력하세요.
-- 사원 : EMPLOYEE
SELECT JOB, COUNT(*) -- NULL 값이 있을 가능성 때문에 정확한 조건이 없다면 전체 범위로 지정한다.
FROM EMPLOYEE
GROUP BY JOB;

-- 연습문제4) 관리자(MANAGER) 수를 출력하세요 
-- (MANAGER 컬럼의 데이터 개수를 나열하세요.)
-- 사원 : EMPLOYEE
SELECT  COUNT(MANAGER)
FROM EMPLOYEE;

-- 연습문제5) 급여(SALARY) 최고액, 급여 최저액의 차액을 출력하세요.
-- 컬럼의 별칭은 "차액"으로 표기하세요
-- 사원 : EMPLOYEE
SELECT MAX(SALARY) - MIN(SALARY) AS 차액
FROM EMPLOYEE;

-- 연습문제6) 직급별(JOB) 사원의 최저 급여를(SALARY) 출력하세요, 
-- 단, 관리자를(MANAGER) 알 수 없는 사원 및 최저 급여가 2000 미만인 그룹은 제외시키고,
-- 급여에 대한 내림차순으로 정렬해서 출력하세요
SELECT JOB, MIN(SALARY)
FROM EMPLOYEE
WHERE MANAGER IS NOT NULL
GROUP BY JOB
HAVING MIN(SALARY) >= 2000
ORDER BY MIN(SALARY) DESC;

-- 연습문제7) 각 부서에 대해(부서번호별로)(DNO) 부서번호(DNO), 사원수(COUNT), 
--       부서 내의 모든 사원의 평균 급여를(ROUND(AVG(),2)) 출력하세요.
--      (부서별 사원수, 평균급여 출력)
-- 컬럼별칭을 사용해서 부서번호, 사원수, 평균급여를 출력하세요.
-- 평균급여는 소수점 2째자리에서 반올림하세요.

SELECT DNO AS "부서번호",
COUNT(DNO) AS "부서별 사원수",
ROUND(AVG(SALARY), 2) AS "평균 급여"
FROM EMPLOYEE
GROUP BY DNO;

-- 연습문제8) 사원테이블을(EMPLOYEE) 이용하여 
-- 부서번호(DNO), 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL), 사원수를(CNT) 출력하세요.
-- 단 평균 급여를 출력할 때 소수점을 제외하고 각 부서번호별로 출력하세요.
SELECT DNO AS DNO,
TRUNC(AVG(SALARY)) AS AVG_SAL,
MAX(SALARY) AS MAX_SAL,
MIN(SALARY) AS MIN_SAL,
COUNT(DNO) AS CNT
FROM EMPLOYEE
GROUP BY DNO;

-- 연습문제9) 같은 직책에(JOB) 종사하는 사원이 3명 이상인 직책과 인원수를 출력하세요
-- 문제해석) 직위별(JOB) 사원수를 구하고, 그 사원수가 3명이상인 사람만 출력하세요
SELECT JOB AS 직책,
COUNT(*) AS 사원수 
FROM EMPLOYEE
GROUP BY JOB
HAVING COUNT(JOB) >= 3;

-- 연습문제10) 사원들의(EMPLOYEE) 입사 연도를(HIREDATE) 기준으로(입사연도별로) 
-- 부서별로(DNO) 몇 명이 입사했는지 출력하세요
-- 힌트) 입사년도 : TO_CHAR(HIREDATE, 'YYYY')
SELECT
TO_CHAR(HIREDATE, 'YYYY') AS 입사년도,
DNO AS 부서번호,
COUNT(*)AS 인원 -- NULL 값이 있을 가능성 때문에 정확한 조건이 없다면 전체 범위로 지정한다.
FROM EMPLOYEE
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DNO;