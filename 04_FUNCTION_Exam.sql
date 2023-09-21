-- 파일명 : 04_FUNCTION_Exam.sql
-- 연습문제

-- 1) SUBSTR 함수를 사용하여 사원들의 
--  입사한 년도와(HIREDATE) 입사한 달만(HIREDATE) 출력하세요.
-- 사용법) SUBSTR(컬럼명, 인덱스위치, 잘라낼개수) 
-- : 문자열 자르기 함수, 날짜형 컬럼도 자르기가 가능
-- 사원테이블 : EMPLOYEE
SELECT HIREDATE
      ,SUBSTR(HIREDATE, 1, 2) AS 년도
      ,SUBSTR(HIREDATE, 4, 2) AS "달(월)"
FROM EMPLOYEE;

-- 2) 입사일(HIREDATE) 연도는 2자리(YY), 월은 (MON)로 표시하고, 
--    일(DD), 요일은 (DY)로 표기하세요. (날짜포맷)
-- TO_CHAR(날짜컬럼, '날짜포맷') : 날짜 -> 문자로 바꾸는 함수 사용
-- 출력 예) 80/12월/17 수
-- 사원테이블 : EMPLOYEE
SELECT HIREDATE,
TO_CHAR(HIREDATE, 'YY/MON/DD DY') AS "날짜"
FROM EMPLOYEE;

-- 3) 올해 며칠이 지났는지 출력하시오. 
--    현재 날짜에서 올해 1월1일을 뺀 결과를 출력하고 
--    TO_DATE 함수를 사용하여 데이터 형을 일치시켜서 연산하세요
-- 힌트) 현재날짜 - '2023/01/01'(날짜로 변환)
-- 단, 포맷은 'YYYY/MM/DD' (참고)
SELECT TRUNC(SYSDATE - TO_DATE('2023/01/01', 'YYYY/MM/DD'))
FROM DUAL;

-- 4) 사원들의(EMPLOYEE) 매니저(MANAGER) 사번을(ENO) 출력하되 매니저가 없는 
--    사원에 대해서는 NULL값 대신에 0을 출력하세요. ( NVL함수 사용하라 )
SELECT MANAGER, NVL(MANAGER, 0), ENO
FROM EMPLOYEE;

-- 5) DECODE(CASE WHEN) 함수로 직급에(JOB) 따라 
--    급여를(SALARY) 인상하도록 하세요.
--    직급이(JOB) 'ANALYST' 이면 200, 
--    'SALESMAN' 이면 180, 'MANAGER' 이면 150
--    'CLERK' 이면 100을 인상하세요.
-- 출력 : ENO(사원번호), ENAME(사원명), JOB(직급), SALARY(월급),
--       급여인상 
-- 사원테이블 : EMPLOYEE
--DECODE 함수 : SQL 에서 조건문을 표시하는 함수
SELECT ENO, ENAME, JOB, SALARY
      ,DECODE(JOB, 'ANALYST', SALARY + 200
                 , 'SALESMAN', SALARY + 180
                 , 'MANAGER', SALARY + 150
                 , 'CLERK', SALARY + 100
                 , SALARY) AS 급여인상
FROM EMPLOYEE;
-- DECODE 업그레이드 사용법) CASE WHEN 
SELECT ENAME, DNO
      ,CASE WHEN DNO=10 THEN '회계부'
           WHEN DNO=20 THEN '연구소'
           WHEN DNO=30 THEN '판매부'
           WHEN DNO=40 THEN '운영부'
           ELSE '디폴트'
       END AS 부서명
FROM EMPLOYEE
ORDER BY DNO;

-- 6) 사원테이블에서(EMPLOYEE) 사원들의 월 평균 근무일 수는 21.5일입니다.(working day)
-- 하루 근무 시간을 8시간으로 보았을 때 
-- 사원들의 하루 급여와 시급을 계산하여 
-- 사원번호(ENO), 사원명(ENAME), 급여(SALARY), 하루급여, 시급 결과를 출력합니다.
-- 단 하루 급여는 소수점 세 번째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림하세요.
-- 공식 : 하루 급여 : 급여(SALARY) / 21.5
--       시급     : 급여 / 21.5 / 8
-- 힌트) TRUNC(급여(SALARY) / 21.5, 자리수)
--      ROUND(급여(SALARY) / 21.5 / 8, 자리수)
SELECT ENO, ENAME, SALARY
      ,TRUNC(SALARY / 21.5, 2)
      ,ROUND(SALARY / 21.5 / 8, 1)
FROM EMPLOYEE;

-- 7) 사원테이블에서(EMPLOYEE) 사원들은 입사일을 기준으로 3개월이 지난 후 (조건1: ADD_MONTHS())
--  첫 월요일에 정직원이 됩니다.(조건2 : NEXT_DAY())
-- 사원들이 정직원이 되는 날짜를 YYYY-MM-DD 형식으로(조건3 : TO_CHAR(날짜, 포맷)) 출력해 주세요.
-- 단, 상여금이(COMMISSION) 없는 사원의 상여금은 N/A로 출력하세요
-- 힌트) ADD_MONTHS(), NEXT_DAY(), TO_CHAR(), NVL()
-- 힌트) TO_CHAR(NEXT_DAY(ADD_MONTHS(컬럼명, 더할개월수),'월요일'), 'YYYY-MM-DD')
SELECT HIREDATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
       NVL(TO_CHAR(COMMISSION), 'N/A') AS COMMISSION
FROM EMPLOYEE;

-- 8) 사원 테이블의 모든 사원을 대상으로 직속 상관의 사원 번호를 다음과 같은 조건을 기준으로 
--    변환해서 CHG_MGR 별칭으로 출력하세요
-- 조건) CASE WHEN 사용
-- 1) 직속 상관의 사원 번호가 존재하지 않을 경우( WHEN 컬럼명 IS NULL THEN '결과') : 0000
-- 2) 직속 상관의 사원 번호 앞 두 자리가 75일 경우 : 5555
-- ( WHEN SUBSTR(컬럼명,1,2) = '값' THEN '결과2')
-- 3) 직속 상관의 사원 번호 앞 두 자리가 76일 경우 : 6666
-- 4) 직속 상관의 사원 번호 앞 두 자리가 77일 경우 : 7777
-- 5) 직속 상관의 사원 번호 앞 두 자리가 78일 경우 : 8888
-- 6) 그 외 직속 상관 사원 번호의 경우           : 본래 직속 상관의 사원 번호 그대로 출력 
-- 8) 사원 테이블의 모든 사원을 대상으로 직속 상관의(MANAGER) 
--    사원 번호를(ENO) 다음과 같은 조건을 기준으로 
--    변환해서 CHG_MGR 별칭으로 출력하세요
-- 조건) CASE WHEN 사용
-- 1) 직속 상관의 사원 번호가 존재하지 않을 경우( WHEN 컬럼명 IS NULL THEN '0000') : 0000
-- 2) 직속 상관의 사원 번호 앞 두 자리가 75일 경우 : 5555
-- ( WHEN SUBSTR(컬럼명,1,2) = '75' THEN '5555')
-- 3) 직속 상관의 사원 번호 앞 두 자리가 76일 경우 : 6666
-- 4) 직속 상관의 사원 번호 앞 두 자리가 77일 경우 : 7777
-- 5) 직속 상관의 사원 번호 앞 두 자리가 78일 경우 : 8888
-- 6) 그 외 직속 상관 사원 번호의 경우           : 본래 직속 상관의 사원 번호 그대로 출력 
SELECT ENO, ENAME, MANAGER
      ,CASE WHEN MANAGER IS NULL THEN '0000'
           WHEN SUBSTR(MANAGER,1,2) = '75' THEN '5555'
           WHEN SUBSTR(MANAGER,1,2) = '76' THEN '6666'
           WHEN SUBSTR(MANAGER,1,2) = '77' THEN '7777'
           WHEN SUBSTR(MANAGER,1,2) = '78' THEN '8888'
           ELSE TO_CHAR(MANAGER)
       END AS CHG_MGR
FROM EMPLOYEE;







