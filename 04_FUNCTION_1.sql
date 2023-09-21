-- 파일명 : 04_FUNCTION_1.sql
-- 오라클 내장 함수 + 자리(정렬) 채우기 함수
--------------------------------------------------------------------------------
-- 1) 문자 함수
-- 사용법) 대문자 변환 : UPPER('문자열') -- 문자열 대신 컬럼명도 올 수 있음
--        소문자 변환 : LOWER('문자열')
--        첫글자만 대문자 변환 : INITCAP('문자열')
-- 위의 변환 : 원본을 조작하지 않음(화면에만 임시로 바뀜)
SELECT 'Oracle mania',
UPPER('Oracle mania') AS 대문자,
LOWER('Oracle mania') AS 소문자,
INITCAP('Oracle mania') AS "첫글자만 대문자"
FROM DUAL;

-- 연습 1) 사원테이블에서 사원명(ENAME) 을 소문자로 출력하고,
--        직위(JOB)은 첫 글자만 대문자로 출력하세요.
SELECT LOWER(ENAME),
INITCAP(JOB)
FROM EMPLOYEE;

-- 연습 2) SCOTT 사원을 조회해서 사원번호(ENO), 사원명(ENAME), 부서번호(DNO) 출력하기
-- 단, SCOTT 이 대소문자 구분없이 입력된다고 가정하고 작성하세요.
--WHERE ENAME = 'Scott' -- 어쨋든 SCOTT 사원의 정보를 화면에 출력하세요.
SELECT ENO, ENAME, DNO
FROM EMPLOYEE
WHERE ENAME = UPPER('scott');
 --------------------------------------------------------------------------------
-- 1-2) 문자 길이를 RETURN 하는 함수
-- LENGTH(문자열) : 한글/영어 상관없이 문자개수를 세어서 RETURN 하는 함수
-- 코딩 언어셋 : 영어 표현(1BYTE), 한글 표현(3BYTE) [UTF-8 표현식(국제표준)]
SELECT LENGTH('Oracle mania'),
LENGTH('오라클매니아')
FROM DUAL;
--------------------------------------------------------------------------------
-- 1-3) 문자 조작 함수 : 문자열 붙이기
-- 함수 : CONCAT('문자열','문자열2')
-- 기호 : '문자열' || '문자열2'
SELECT 'Oracle''mania',
CONCAT('Oracle','mania'), 'Oracle' || 'mania'
FROM DUAL;
--------------------------------------------------------------------------------
-- 1-4) 문자 조작 함수 : 문자열 자르기
-- SQL : 인덱스번호(1부터 시작)
-- 사용법) SUBSTR(대상컬럼,시작위치,자를개수)
-- 단, 시작위치가 음수이면 뒤에서 셈)
SELECT SUBSTR('Oracle mania',1,12),
SUBSTR('Oracle mania',-1,1)
FROM DUAL;
-- 예제 3) 이름이 N 으로 끝나는 사원명(ENAME) 화면에 출력하기
-- 단, SUBSTR() 함수를 이용하세요.
-- 사원 : EMPLOYEE
-- (참고)
-- SQL 성능이 좋게 작성하는것이 어려움 
-- WHERE 왼편(함수 사용) = 오른쪽값 ==> 성능이 대폭 저하
SELECT * FROM EMPLOYEE
WHERE SUBSTR(ENAME, -1,1) = 'N';
--------------------------------------------------------------------------------
-- 1-5) 문자열에서 대상 문자를 찾아서 인덱스번호를 RETURN 함수
-- SQL) 인덱스번호 : 1부터 시작
-- 사용법: INSTR('대상문자(문자열)','일치하는 대상의 문자 입력')
-- 결과 : 일치하는 대상의 인덱스 번호가 출력됨.
SELECT INSTR('Oracle mania','a'),
INSTR('오라클매니아','라')
FROM DUAL;
--------------------------------------------------------------------------------
-- 1-6) 컬럼에 어떤 문자를 붙이기 함수 : LPAD, RPAD
-- LPAD 함수 : 어떤 문자를 왼쪽에 채우기 함수
-- 사용법) LPAD(대상컬럼, 자릿수, 채울문자)
--       ( 자릿수에서 빈칸은 채울문자로 채워짐(왼쪽))
SELECT LPAD(SALARY, 10, '*')
FROM EMPLOYEE;

-- RPAD 함수 : 어떤 문자를 오른쪽에 채우기 함수
-- 사용법) RPAD(대상컬럼, 자릿수, 채울문자)
--       ( 자릿수에서 빈칸은 채울문자로 채워짐(오른쪽))
SELECT RPAD(SALARY, 10, '*')
FROM EMPLOYEE;
--------------------------------------------------------------------------------
-- 1-7) 문자열에서 공백제거하기 : LTRIM, RTRIM, TRIM(*)
-- 사용법) LTRIM(컬럼명): 왼쪽 공백제거
-- 사용법) RTRIM(컬럼명): 오른쪽 공백제거
-- 사용법) TRIM(컬럼명): 양쪽 공백제거
SELECT 'Oracle mania'
      ,LTRIM('   Oracle mania   ')
      ,RTRIM('   Oracle mania   ')
      ,TRIM('   Oracle mania   ')
FROM DUAL;