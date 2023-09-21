-- 파일명 : 19_Procedure.sql
-- pl/sql : 프로시저/펑션, DB 프로그래밍 분야(SQL 숙련자들)
-- 난이도 높음
-- 소스 : Oracle DB에 저장됨
-- 장점 : 1) 성능향상
-- 자바/js 처럼 코딩하는 것 말함
-- 코딩 특징 : 1) 제어문(조건문/반복문), 변수/상수
--------------------------------------------------------------------------------
-- 예제1) 화면 출력 모드 변경 : ON (출력 켜기)
SET SERVEROUTPUT ON;
-- 1-1) 입력 대화상자 : 대화상자 입력값이 변수명에 입력되어 DB에 소스가 저장됨
-- 사용법) ACCEPT 변수명 prompt '문자열'
-- p_변수명 : 입력용 변수
-- v_변수명 : 단순 변수
ACCEPT p_num1 prompt '첫번째 숫자를 입력하세요'
ACCEPT p_num2 prompt '두번째 숫자를 입력하세요'
-- 1-2) 선언부 : DECLARE
DECLARE
-- 변수 초기화 , 변수 정의 : 숫자(NUMBER), 문자(VARCHAR2), 날짜(DATE) [자료형]
v_sum NUMBER(10);
-- 1-3) 실행부 : BEGIN
BEGIN

--  예제1-1) 프로시저 코딩해보기: 업무 코딩(비지니스 로직 코딩 : 실무용어)
--  사용법) 입력값(p_num1) 변수 : &변수명 사용
--         대입연산자  - :=
--         v_sum      : 선언부에서 정의한 변수
    v_sum := &p_num1 + &p_num2; -- 입력값 2개를 더하기
    
-- 1-4) 결과 출력 : v_sum
--    문자열 붙이기 : 문자열 || 문자열2 ...
    dbms_output.put_line('총합은 : ' || v_sum); -- 화면에 1줄씩 출력하는 함수
END;
/
--------------------------------------------------------------------------------
-- 예제2) 입력받은 사원번호에 해당하는 월급 출력하기 : EMPLOYEE
-- 입력값 : 7788(SCOTT)

-- 2-1) 입력 대화상자
ACCEPT P_empno prompt '사원번호 입력하세요'

-- 프로시저 코딩
-- 2-2) 선언부 : 변수 정의
DECLARE
v_sal NUMBER(10); -- 10자리 숫자

-- 2-3) 실행부
BEGIN
-- 사용법 : SELECT 컬럼명 INTO 변수명 FROM 테이블명 : 컬럼값 -> 변수로 저장됨
SELECT SALARY INTO v_sal
FROM EMPLOYEE
WHERE ENO = &p_empno;

-- 2-4) 결과 출력 : v_sal
dbms_output.put_line('해당 사원의 월급은 : ' || v_sal);
END;
/
--------------------------------------------------------------------------------
-- 예제3) 조건문 : IF/ELSIF/ELSE/END IF

-- 3-1) 입력 대화상자
ACCEPT p_num PROMPT '숫자를 입력하세요.'
-- 3-2) DECLARE(선언부) 생략

-- 3-3) 실행부 및 결과 출력
BEGIN
-- 사용법) IF 조건식 THEN
--        실행문;
--        ELSE 
--        실행문2;
--        END IF

-- MOD(값, 나눌값) : 나머지 연산하는 함수
-- 비교연산자 : =(일치)
IF MOD(&p_num, 2) = 0 THEN
DBMS_OUTPUT.PUT_LINE('짝수입니다.'); -- 화면 출력
 ELSE 
DBMS_OUTPUT.PUT_LINE('홀수입니다.'); -- 화면 출력
END IF;
END;
/
--------------------------------------------------------------------------------
-- 예제4) 조건문 계속 : IF/ELSIF/ELSE/END IF;
--   사원테이블에 사원명을 입력받아 급여가 3000 이상이면 고소득자입니다. 출력
--                                   2000 이상이면 중간 소득자입니다. 출력
--                                   모두 아니면 저소득자입니다. 출력
-- 4-1) 입력 대화상자
ACCEPT p_ename PROMPT '사원 이름를 입력하세요.'

-- 4-2) 선언부(정의부)
DECLARE
-- 변수 2개 : 대문자 변환 함수 UPPER(문자열)
-- 대상 테이블의 컬럼의 자료형을 참조해서 변수의 자료형으로 정의함
-- 사용법 : 변수명 테이블명.컬럼명%TYPE
v_ename EMPLOYEE.ENAME%TYPE := UPPER('&p_ename');
v_sal   EMPLOYEE.SALARY%TYPE;

-- 4-3) 실행부 및 결과 출력
BEGIN
-- 사원명을 입력받아 조회하는 SQL문 : 결과 : v_sal 변수
SELECT SALARY INTO v_sal
FROM EMPLOYEE
WHERE ENAME = v_ename;

IF v_sal >= 3000 THEN
DBMS_OUTPUT.PUT_LINE('고소득자입니다.');
ELSIF v_sal >= 2000 THEN
DBMS_OUTPUT.PUT_LINE('중간 소득자입니다.');
ELSE
DBMS_OUTPUT.PUT_LINE('저소득자입니다.');
END IF;
END;
/
--------------------------------------------------------------------------------
-- 예제5) 반복문 : 커서
-- 5-1) 입력 대화상자
ACCEPT p_dno PROMPT '부서번호를 입력하세요.'

-- 5-2) 선언부(정의부)
DECLARE
-- 커서(2차원배열) : 여러 데이터를 가지고 있는 SELECT 조회문
-- 커서 정의하는 부분
-- 사용법 : CURSOR 커서변수명 IS
--         SELECT 컬럼명, 컬럼명2 ...
--         FROM 테이블명
--         WHERE 조건절;
CURSOR emp_cursor IS
SELECT ENAME, SALARY, DNO
FROM EMPLOYEE
WHERE DNO = &p_dno;

-- 5-3) 실행부
BEGIN
-- FOR문(반복문) == 자바/JS 향상된 FOR문과 비슷
-- 증감식 없고, 데이터의 끝에 도달하면 반복문 종료
-- 사용법 : FOR 변수명(객체) IN 커서변수명(배열) LOOP
--         반복문(변수명.컬럼명);
--         END LOOP;
FOR emp_record IN emp_cursor LOOP

-- 5-4) 차례로 화면에 출력하기
DBMS_OUTPUT.PUT_LINE(emp_record.ename || ' ' || emp_record.salary || ' ' || emp_record.dno);
END LOOP;
END;
/
--------------------------------------------------------------------------------
-- 참고) 실무에서 사용하는 이름있는 프로시저 형태
-- 사용법 : CREATE OR REPLACE PROCEDURE 프로시저명
--         (매개변수 in 자료형
--          내보내기변수 out 자료형) -- js return 값
--          )
--          IS
--          선언부(정의부)
--          BEGIN
--          실행문;
--          END;
--          /

-- 프로시저 정의 : DB에 소스가 저장됨
CREATE OR REPLACE PROCEDURE pro_ename_sal
(p_ename in employee.ename%type)
IS
-- 선언부
    v_sal employee.salary%type; -- 사원테이블의 급여 자료형을 참조
-- 실행부
BEGIN
-- 사원명을 받아서 급여 조회 sql
SELECT SALARY INTO v_sal
FROM EMPLOYEE
WHERE ENAME = p_ename;

-- 화면 출력
    DBMS_OUTPUT.PUT_LINE(v_sal || ' 입니다.');
END;
/

-- 프로시저 실행 (2가지)
-- 사용법 : CALL 프로시저명(입력값)
--         EXEC 프로시저명(입력값)
-- 호출
CALL pro_ename_sal('SCOTT');
-- 완료
EXEC pro_ename_sal('SCOTT');

-- 예제7) 평션 만들기
-- 부서번호를(DNO) 매개변수로 받아서 부서위치를(LOC) 출력하는 함수 정의
-- 함수(Fuction) 특징 : 무조건 return 값이 있음(결과 내보내기가 있음)
-- 사용법 : CREATE OR REPLACE FUNCTION 평션이름
-- (매개변수 in 자료형)
-- RETURN department.loc%type
-- IS
-- 선언부(정의)
-- BEGIN
-- 실행문;
-- RETURN 결과변수;
-- END;
-- /
CREATE OR REPLACE FUNCTION fn_ename_sal
(p_dno in department.dno%type)
RETURN department.loc%type
IS

-- 7-1) 선언부
   v_loc department.loc%type; -- 부서테이블의 위치 자료형 참조

-- 7-2) 실행부
BEGIN
-- 부서번호를 매개변수로 받아 위치를 조회하는 SQL문
    SELECT LOC INTO v_loc
    FROM DEPARTMENT
    WHERE DNO = p_dno;
    
    RETURN v_loc;
END;
/

-- 함수 실행 : SELECT 문으로 조회
-- 사용법 : SELECT 함수명(입력값) FROM 테이블명;
SELECT fn_ename_sal(10) FROM DUAL;