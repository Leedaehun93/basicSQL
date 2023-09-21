-- 파일명 : 14_Sequence_Index.sql
-- 시퀀스(Sequence), 인덱스(INDEX)
--------------------------------------------------------------------------------
-- 1. 시퀀스(Sequence) : 호출(실행)할 때마다 자동적으로 숫자를 증가시키는 것(객체)
-- 목적) 키본키 용도로 사용(중복 없음, null 없음)
-- 활용 예) 자유게시판 : NO(1 ~ n), 고객 : 고객NO(1 ~ n)
-- 실무용어 : 채번 : 자동적으로 1씩 증가시키는 값(1 ~ n : 시퀀스대상)
-- 예제1) SAMPLE_SEQ 시퀀스를 1부터 시작해서 10씩 증가시키는 시퀀스를 만드세요.
-- 사용법 : CREATE SEQUENCE 시퀀스명
--         INCREMENT BY 증가값
--         MINVALUE 시작값
--         START WITH 최소값
--         MAXVALUE 최대값
CREATE SEQUENCE SAMPLE_SEQ
INCREMENT BY 10
START WITH 1;

-- 사용법1 : 시퀀스명.NEXTVAL : 시퀀스가 증가함
SELECT SAMPLE_SEQ.NEXTVAL FROM DUAL;

-- 현재 증가된 시퀀스의 값을 확인 : 최초 1번은 시퀀스명.NEXTVAL 로 실행 후 확인 가능
-- 사용법) 시퀀스명.CURRVAL
SELECT SAMPLE_SEQ.CURRVAL FROM DUAL;

-- 시스템 테이블들 : 시퀀스 확인용 테이블(뷰) : 데이터사전(DICTIONARY VIEW)
SELECT SEQUENCE_NAME,
MIN_VALUE,
MAX_VALUE,
INCREMENT_BY
FROM USER_SEQUENCES;

-- 예제 2) 임시 테이블에 시퀀스 INSERT 하기
-- 임시 테이블(구조) : 부서(DEPARTMENT) ->(복사) DEPT_TEMP
CREATE TABLE DEPT_TEMP
AS
SELECT * FROM DEPARTMENT
WHERE 1=2;
-- 조회
SELECT * FROM DEPT_TEMP;
-- 시퀀스 INSERT : 대상 컬럼 : 시퀀스명.NEXTVAL (DNO : 부서번호)
-- 시퀀스 삭제 및 재생성
-- 사용법 : DROP SEQUENCE 시퀀스명
DROP SEQUENCE SAMPLE_SEQ;   -- 삭제
CREATE SEQUENCE SAMPLE_SEQ
INCREMENT BY 10
START WITH 1;   -- 생성(10씩 증가)
-- INSERT 문 정의 후 4번 실행
INSERT INTO DEPT_TEMP
VALUES(SAMPLE_SEQ.NEXTVAL, 'ACCOUNTING','NEW YORK');

SELECT * FROM DEPT_TEMP;
-- 영구 반영
COMMIT;
--------------------------------------------------------------------------------
-- 2. 인덱스(INDEX) : 컬럼에 인덱스를 지정하여 사용함
-- 목적 : 조회속도 향상을 위해 조건에 해당하는 컬럼에 인덱스를 생성함(지정함)
-- 기본키(PK) : 중복방지 + NULL값방지 + 자동인덱스생성

-- 예제3) 사이트에서 조회시 이름검색이(ENAME) 많은데 속도가 느리다고 한다.(EMPLOYEE)
-- 해결 : ENAME 컬럼에 인덱스 생성 -> 조회속도 향상
-- 명명법 : IX_테이블명_컬럼명, IDX_테이블명_컬럼명
CREATE INDEX IX_EMPLOYEE_ENAME ON EMPLOYEE(ENAME);

-- 속도 느림 대상 SQL 문
SELECT * FROM EMPLOYEE
WHERE ENAME LIKE 'SCOTT%';  -- 이 부분이 INDEX 를 만들곳

-- 데이터사전 : USER_IND_COLUMNS 뷰에서 확인
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN ('EMPLOYEE','DEPARTMENT');

-- 인덱스(INDEX) 삭제하기(DROP ~)
DROP INDEX IX_EMPLOYEE_ENAME;
-- 1) 테이블에 행의 개수가 많을 경우(데이터 건수가 많을경우)
--     : 10만건 이상
-- 2) WHERE(조건절) 에 해당 컬럼이 많이 등장할 경우
-- 3) 테이블 조인의 공통컬럼으로 사용될 경우

-- 특수 인덱스 : 
-- 1) 결합 인덱스 : 컬럼 여러 개를 1번에 인덱스로 지정
-- 예) 아래가 조회속도가 느림(가정)
SELECT * FROM DEPARTMENT
WHERE DNAME = 'SALES'
AND   LOC   = 'NEW YOUK';

-- 결합 인덱스 만들기
-- 사용법 : CREATE INDEX 인덱스명 ON 테이블명(컬럼명, 컬럼명2, ...);
CREATE INDEX IX_DEPT_COM ON DEPARTMENT(DNAME, LOC);

-- 함수 인덱스 : 함수에 인덱스 걸기
SELECT * FROM EMPLOYEE
WHERE SALARY = SALARY * 12;

-- 함수 인덱스(수식 인덱스)
CREATE INDEX IX_EMP_ANNSAL ON EMPLOYEE(SALARY * 12);
--------------------------------------------------------------------------------