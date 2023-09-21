-- 파일명 : 12_Table_Constraint.sql
-- 테이블 제약조건 : 테이블에 입력될 값을 제한하는 것
--------------------------------------------------------------------------------
-- 1-1) UNIQUE 제약조건 : 유일한 값만 입력될 수 있음(데이터 중복 금지), NULL 값은 허용
-- 1-2*) NOT NULL 제약조건 : NULL 값이 입력될 수 없음, 반드시 입력되게 설정
-- 사용법 : 제약조건은 컬럼별로 각각 지정할 수 있음
-- CREATE TABLE 테이블명(
--                컬럼명 자료형(크기) 제약조건이름
--        );

-- 예제1) CUSTOMER 테이블을 정의하고 ID 컬럼에 UNIQUE 제약조건을 지정하세요.
-- (ID       VARCHAR2(20) -> UNIQUE 제약조건 지정
--  PWD     VARCHAR2(20)
--  NAME    VARCHAR2(20)
--  PHONE   VARCHAR2(30)
-- ADDRESS VARCHAR2(1000))
CREATE TABLE CUSTOMER(
ID       VARCHAR2(20) UNIQUE,
PWD     VARCHAR2(20) NOT NULL,
NAME    VARCHAR2(20) NOT NULL,
PHONE   VARCHAR2(30)         ,
ADDRESS VARCHAR2(1000)
);
--------------------------------------------------------------------------------
-- 2**) 기본키 제약조건 : PRIMARY KEY(PK)
-- 기본키의 특징 : 유일한 값만 입력되고(중복방지) + NOT NULL 제약조건포함 + (참고 : INDEX 자동생성)
-- 특징) 주로 테이블 설계시 1개의 테이블당 거의 1개는 기본키가 존재함
-- 기본키 제약조건에 이름을 부여 : CONSTRAINT 제약조건 이름 제약조건
-- *** 제약조건이름 붙이기 약속(명명법) : PK_테이블명_컬럼명, UK_테이블명_컬럼명 ...

-- 사용법1 제약조건만 따로 지정시 컬럼명 포함 필요 :
--        CREATE TABLE 테이블명(
--        컬럼명 자료형(크기),
--        CONSTRAINT 제약조건이름 PRIMARY KEY(컬럼명)
--        );

-- 사용법2 같은 컬럼명에 제약조건 넣어서 컬럼명 생략가능 :
--        CREATE TABLE 테이블명(
--        컬럼명 자료형(크기) CONSTRAINT 제약조건이름 PRIMARY KEY
--        );

CREATE TABLE CUSTOMER2(
ID       VARCHAR2(20)        ,
PWD     VARCHAR2(20) NOT NULL,
NAME    VARCHAR2(20) NOT NULL,
PHONE   VARCHAR2(30)         ,
ADDRESS VARCHAR2(1000)       ,
CONSTRAINT PK_CUSTOMER_ID PRIMARY KEY(ID)
);
SELECT * FROM CUSTOMER2;    -- 조회
-- INSERT 테스트 : 기본키(유일성 + NOT NULL 지정됨)
INSERT INTO CUSTOMER2
VALUES(NULL, NULL, NULL, '010-123-4567', 'SEOUL'); -- ID값 기본키로 인해 에러발생
--------------------------------------------------------------------------------
-- 3) 외래키(참조키) 제약조건 : FOREIGN KEY(FK)
-- 무결성 제약조건 : 기본키(***) / 외래키(참조키**)
-- 무결성 의미 : 데이터에 결점이 없는것
-- 기본키 : 회원의 ID (중복되면 안됨 + NULL 입력되도 안됨)
-- 참조키 : 부서테이블의 부서번호(DNO : 10 ~ 40), 사원테이블 부서번호(DNO : 10 ~ 30, 50)일 때,
--         부서테이블의 부서번호 값만 사원테이블의 부서번호에 INSERT 할수 있음(참조 무결성)
-- 사용법 : CREATE TABLE 테이블명(
--         컬럼명 자료형(크기) CONSTRAINT 제약조건이름 PRIMARY KEY,
--         컬럼명2 자료형(크기) CONSTRAINT 제약조건이름 REFERENCES 부모테이블명
--         );

-- 예제3) EMP_SECOND 테이블을 생성하여 아래 구조로 지정
--         ENO NUMBER(4) (기본키)
--         ENAME VARCHAR2(10), 
--         JOB VARCHAR2(9)
--         DNO NUMBER(2) (참조키)
CREATE TABLE EMP_SECOND(
ENO NUMBER(4) CONSTRAINT PK_EMP_SECOND_ENO PRIMARY KEY,
ENAME VARCHAR2(10), 
JOB VARCHAR2(9),
DNO NUMBER(2) CONSTRAINT FK_EMP_SECOND_DNO REFERENCES DEPARTMENT
);
-- 테이블 삭제
DROP TABLE EMP_SECOND;
--------------------------------------------------------------------------------
-- 4) CHECK 제약조건(참고만) : CHECK(CK)
-- 컬럼에서 허용 가능한 데이터의 범위나 조건을 정의할 수 있음
-- 사용법 : CREATE TABLE 테이블명(
--         컬럼명 자료형(크기) CONSTRAINT 제약조건이름 PRIMARY KEY,
--         컬럼명2 자료형(크기) CONSTRAINT 제약조건이름 CHECK(컬럼명2_조건식)
--         );


-- 예제4) EMP_SECOND 테이블에 CHECK 제약조건을 지정하세요 (SALARY > 0 값만 INSERT 될 수 있도록)
CREATE TABLE EMP_SECOND(
ENO NUMBER(4) CONSTRAINT EMP_SECOND_ENO_PK PRIMARY KEY,
ENAME VARCHAR2(10),
SALARY NUMBER(7,2) CONSTRAINT CK_EMP_SECOND_SALARY CHECK(SALARY > 0)
);

-- CHECK 제약조건 테스트
INSERT INTO EMP_SECOND VALUES(8000, '윤정호', -200);   -- 에러 발생(음수)
-- 테이블 삭제
DROP TABLE EMP_SECOND;
--------------------------------------------------------------------------------
-- 5) DEFAULT 제약조건 : NULL 값이 INSERT 될 때 기본적으로 다른 값으로 생성하는 제약조건
CREATE TABLE EMP_SECOND(
ENO NUMBER(4) CONSTRAINT EMP_SECOND_ENO_PK PRIMARY KEY,
ENAME VARCHAR2(10),
SALARY NUMBER(7,2) DEFAULT 1000
);

-- DEFAULT 제약조건 테스트
INSERT INTO EMP_SECOND(ENO, ENAME) VALUES(8000, '윤정화');
-- 영구반영
COMMIT;
-- 조회시 SALARY 컬럼 데이터 값이 1000이 들어왔음
SELECT * FROM EMP_SECOND;
--------------------------------------------------------------------------------
-- 기타사항 : 제약조건확인
-- 테이블 복사 : CREATE TABLE ~ AS SELECT ~
-- 제약조건 복사 안됨(제약조건 추가 생성작업 : 기본키/참조키)

-- 참고***) 시스템용 테이블 또는 뷰(VIEW) : DB 관리용 테이블
-- 용도) 현재 생성된 테이블의 정보, 제약조건, 크기 등을 확인하는 용도
-- 테이블 정보(제약조건) 사용법 : .
-- SELECT TABLE_NAME, CONSTRAINT_NAME
-- FROM USER_CONSTRAINTS
-- WHERE TABLE_NAME IN ('테이블명', '테이블명2'...)
-- ORDER BY TABLE_NAME;

SELECT TABLE_NAME, CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMPLOYEE', 'DEPARTMENT')
ORDER BY TABLE_NAME;

-- 복사본테이블 제약조건 확인
SELECT TABLE_NAME, CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP_COPY', 'DEPT_COPY')
ORDER BY TABLE_NAME;
--------------------------------------------------------------------------------
-- 초기화
--------------------------------------------------------------------------------
DROP TABLE DEPT_COPY;
DROP TABLE EMP_COPY;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
-- 6) 테이블 생성 후 제약조건 추가/변경/제거하기
-- 사용법 : ALTER TABLE 테이블명
--         ADD CONSTRAINT PK_테이블명_컬럼명 PRIMARY KEY(컬럼명);

-- 예제1) 사원복사본 테이블(EMP_COPY) 기본키(PRIMARY KEY) 추가하기
-- ENO : 사원번호(기본키)
ALTER TABLE EMP_COPY
ADD CONSTRAINT PK_EMP_COPY_ENO PRIMARY KEY(ENO);

-- 예제2) 부서복사본(DEPT_COPY) 테이블에 기본키(PK) 추가하기
-- 기본키 : DNO(부서번호),(테이블의 데이터 중에서 유일한 값을 가져야 되는것)
ALTER TABLE DEPT_COPY
ADD CONSTRAINT PK_DEPT_COPY_DNO PRIMARY KEY(DNO);

-- 예제3) 테이블 생성 후에 외래키(참조키 : FK) 추가하기
-- 자식테이블에 추가(부서(부모), 사원(자식))
ALTER TABLE EMP_COPY
ADD CONSTRAINT FK_EMP_COPY_DNO
FOREIGN KEY(DNO) REFERENCES DEPT_COPY(DNO);

-- 예제4) 테이블 생성 후에 제약조건 삭제하기
-- 부모테이블의 기본키(부서 : 부서번호) <-> 자식테이블의 참조키(사원 : 부서번호)
-- 부모테이블의 기본키 삭제하기 : 강제삭제하기 옵션(CASCADE)
-- ALTER TABLE DEPT_COPY
-- DROP PRIMARY KEY; -- 고유/기본 키가 외부 키에 의해 참조되었습니다. 라는 문구로 명령어 실행안됨
-- CASCADE : 자식테이블에 있는 외래키도 같이 삭제됨
ALTER TABLE DEPT_COPY
DROP PRIMARY KEY CASCADE;

-- 예제5) 제약조건 변경하기
-- EMP_COPY(사원) : ENAME (NULL 허용) -> ENAME (NOT NULL 제약조건으로 변경)
-- 사용법 : ALTER TABLE 테이블명 
--         MODIFY 컬럼명 CONSTRAINT 제약조건이름 NOT NULL;
ALTER TABLE EMP_COPY
MODIFY ENAME CONSTRAINT NN_EMP_COPY_NAME NOT NULL;

-- 예제6)제약조건 이름으로 제약조건 삭제하기
-- 사용법) ALTER TABLE 테이블명
--        DROP CONSTRAINT 제약조건이름;
ALTER TABLE EMP_COPY
DROP CONSTRAINT NN_EMP_COPY_NAME;

-- 참고사항 : 1) 실무에서 참조무결성(참조키) 관련 논란의 여자기 있음
--             - (1) DB 에서 참조키를 지정해서 연결
--                   (INSERT/UPDATE 시 부모테이블에 해당 데이터 있는지 확인
--                   -> 있으면 INSERT/UPDATE
--                   -> 없으면 오류 발생 )
--                   단점 : DB 성능저하, 최악의 경우에 다른 테이블도 성능 저하를 일으킴 
--             - (2) 자바코딩에서 참조키 로직을 만들어 해결
--                   if(부모테이블에 해당 데이터 있는지 확인) {
--                      INSERT 실행
--                   }