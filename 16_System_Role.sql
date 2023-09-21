-- 파일명 : 16_System_Role.sql
-- 유저(사용자)만들기(계정생성), 권한주기, 삭제
--------------------------------------------------------------------------------
-- 1-1) 유저 만들기
-- Oracle DB 생성 : 기본 관리자 : SYSTEM 계정(SYS(최고관리자) 등)
-- 예제1) USERTEST01 유저를 만들고 암호를 pass1라고 지정하세요.
-- 사용법 : CREATE USER 계정명 IDENTIFIED BY 암호;

CREATE USER USERTEST01 IDENTIFIED BY pass1;
--         계정 만들기 완료 후 접속 테스트 "성공" 메시지 확인하기

-- 1-2) 계정 권한주기(예제 2보단 예제3에 방법으로 권한 부여를 많이 함)
-- 예제2) 위에서 만든 USERTEST01 유저에 접속 권한을 부여하세요.
-- 사용법 : GRANT 권한명 TO 유저명;
GRANT CREATE SESSION TO USERTEST01;
-- 테이블 생성 권한 주기
GRANT CREATE TABLE TO USERTEST01;
-- 공간에 대한 권한 주기(무한) : 테이블(논리공간) -> 물리공간 배정(할당)
GRANT UNLIMITED TABLESPACE TO USERTEST01;
-- 예제3) 권한들의 집합 == ROLE(롤)
-- 접속 권한들의 모임 == CONNECT 롤
-- 테이블, 인덱스, 함수등을 사용하는 권한 모임 == RESOURCE 롤
-- VIEW 생성 권한이 없음
-- 사용법 : GRANT 권한명, 롤명, ... TO 유저명;
GRANT CONNECT, RESOURCE, CREATE VIEW TO USERTEST01;

-- 1-3) 유저 삭제(DROP ~)
-- 사용법 : DROP USER 유저명;
DROP USER USERTEST01;
--------------------------------------------------------------------------------
-- 동의어(SYNONYM)
-- SYSTEM 계정으로 작업
-- 다른 데이터베이스나 다른 계정의 테이블, 인덱스 등에 별명에 붙이는 것
-- 예제)
-- 샘플테이블(SYSTEM 계정) : SAMPLETBL
-- 컬럼 : MEMO VARCHAR2(50)
CREATE TABLE SAMPLETBL(
MEMO VARCHAR2(50)
);
-- 데이터 2건 생성
INSERT INTO SAMPLETBL VALUES('오월은 푸르구나');
INSERT INTO SAMPLETBL VALUES('최선을 다합시다');
COMMIT;
SELECT * FROM SAMPLETBL;
-- SYSTEM 계정의 테이블 -> 권한 부여 : SELECT (조회 권한)
-- SELECT 권한 주기
-- 사용법 : GRANT SELECT ON 테이블명 TO 계정명;
GRANT SELECT ON SAMPLETBL TO SCOTT;
-- 동의어 생성 권한(CREATE SYNONYM) : SCOTT;
GRANT CREATE SYNONYM TO SCOTT;
--------------------------------------------------------------------------------
-- 동의어 실습
--------------------------------------------------------------------------------
-- SCOTT 계정으로 접속시
-- SELECT * FROM SAMPLETBL; 권한이 없어 조회 불가
-- SAMPLETBL (STSTEM 계정이 소유하고 있는 테이블)
-- SCOTT 계정으로 접속시 조회 보기
-- 사용법 :  SELECT * FROM 계정명.테이블명;
SELECT * FROM SYSTEM.SAMPLETBL;
-- 위의 경우와 같이 다른 유저의 테이블 조회시 테이블명 길어짐
-- 동의어(테이블별명) 생성
CREATE SYNONYM SAMPLETBL FOR SYSTEM.SAMPLETBL;
SELECT * FROM SAMPLETBL;    -- 동의어로 조회됨
-- 동의어(시노님) 삭제하기(DROP ~) 
DROP SYNONYM SAMPLETBL;