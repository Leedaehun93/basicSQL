-- 파일명 : 01_SQL_기초.sql
-- sql-developr 툴 : DB 접속툴( == DB 클라이언트 툴 )
-- oracle 설치     : DB 서버
-- DB 서버 <- 사용자가 접속해서 사용함(계정/암호)
-- system 계정 : 관리자( 계정생성, 권한관리 또는 DB 환경관리 용으로 사용 )
-- scott  계정 : 개발자( 사용자 ) 계정 - 백엔드 개발을 진행함
-- sql-developer 툴 단축키 :
-- 1) 주석              : ctrl + /
-- 2) 커서 위치 한줄 실행 : ctrl + enter ( 아이콘 : 삼각형 )
-- 3) 여러줄 실행        : f5           ( 아이콘 : 문서 + 삼각형 )
-- SQL 질의문( query )특징 : 대소문자 구분이 없음( 오라클 DB : 대문자가 성능이 빠름 )
-- DB(데이터베이스) : 데이터를 관리 또는 저장하기 위한 최소단위 : 테이블

-- 1) SQL 문 : 검색(조회) : SELECT ~ FROM 문
-- 사용법) SELECT 컬럼명,컬럼명... FROM 테이블명;
--        * : 모든 컬럼
SELECT * FROM DEPARTMENT; -- 전체부서를 조회하는 쿼리(질의문)

-- 예제 1) 사원테이블의 모든 컬럼 정보를 보기
-- 사원테이블명 : EMPLOYEE
SELECT * FROM EMPLOYEE;

-- 예제 2) 사원테이블의 컬럼중에서 ENO, ENAME 컬럼만 정보를 보는 SQL 문을 작성하세요.
SELECT ENO, ENAME FROM EMPLOYEE;

-- 예제 3) 부서테이블의 컬럼중에서 DNO(부서번호), LOC(부서위치) 컬럼만 조회하기
-- 부서테이블 : DEPARTMENT
SELECT DNO, LOC FROM DEPARTMENT;

-- 예제 4) 힌트) 컬럼에 *( /, +, - : 산술연산자 ) 연산해서 화면에 출력 할 수 있습니다.
--             SALARY * 12 (1년 연봉)
-- 사원테이블 : EMPLOYEE
-- 월급 컬럼 : SALARY
-- 사원명 컬럼 : ENAME
-- 사원테이블에서 사원명과 1년연봉을 화면에 출력해 보세요
SELECT ENAME, SALARY * 12 FROM EMPLOYEE;

-- 예제 5) 사원테이블에서 커미션을 더한 연봉 구하기
-- 사원테이블 : EMPLOYEE
-- 월급 컬럼  : SALARY
-- 사원명 컬럼 : ENAME
-- 상여금 컬럼 : COMMISSION
SELECT ENAME, SALARY * 12 + COMMISSION FROM EMPLOYEE; --> NULL 값 발생

-- 예제 5-2) 위의 데이터 값을 보정하기
-- NULL 특징 : NULL 산술연산을 할 수 없음 ( 결과 : NULL )
-- 함수 : 사용법 : NVL( NULL값이_있는_컬럼,변경될값 )
SELECT ENAME, SALARY * 12 + NVL(COMMISSION,0) FROM EMPLOYEE; --> NULL 값 보정 완료

-- 예제 6) 컬럼에 별명( 별칭 ) 붙이기
-- 사용법) SELECT 컬럼명 AS 별명 FROM 테이블명;
SELECT ENAME, SALARY * 12 + NVL(COMMISSION,0) AS 연봉 FROM EMPLOYEE;

-- 예제 6-2) 별명에 공백을 넣어서 사용하기 : ""(쌍따옴표 사용)
SELECT ENAME, SALARY * 12 + NVL(COMMISSION,0) AS "연      봉" FROM EMPLOYEE;

-- 예제 7) 중복된 데이터를 한 씩만 출력하게 하는 예제
-- 사용법) SELECT DISTINCT 중복컬럼명 FROM 테이블명;
-- 사원테이블에 부서번호(DNO) 를 중복을 제거해서 화면에 출력하세요.
SELECT DISTINCT DNO FROM EMPLOYEE;

-- 비교) 원본 DNO 질의문
SELECT DNO FROM EMPLOYEE;

-- 예제 8) 간단한 산술연산 및 테스트 용도 테이블을 소개합니다.
-- DUAL 테이블 : 테스트 용도 테이블
SELECT * FROM DUAL;

-- 활용도)
SELECT 4*5+1 FROM DUAL;
-- SQL 문의 문자열 : '문자열' : 홑따옴표 사용
SELECT '홍길동' FROM DUAL;
-- 오늘 날짜 : SYSDATE 속성
SELECT SYSDATE FROM DUAL;











