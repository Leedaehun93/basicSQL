-- 1) 개발자 계정 생성 : scott
-- (개발시 관리자 계정은 사용하지 않음)
-- sql 주석 ( ctrl + / )
-- 계정명 : SCOTT
-- 패스워드 : Ds1234567890
-- 유저가 사용할 기본 공간 : USERS 공간
-- 유저가 사용할 임시 공간 : TEMP
-- 계정 생성 명령어
-- (패스워드에 특수기호) : "특수기호"
-- 없으면              : ""빼고 그냥 문자열 넣으면 됨 예) Ds1234567890
-- 사용법 : USER 계정명 IDENTIFIED BY 패스워드
CREATE USER SCOTT IDENTIFIED BY "!Ds1234567890"
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- 2) 권한 부여
-- CONNECT 권한              : 접속 권한
-- RESOURCE 권한             : 테이블 등을 사용할 권한
-- CREATE VIEW 권한          : 뷰를 만들 권한

-- UNLIMITED TABLESPACE 권한 : 테이블 생성시 사용할 물리공간 무한으로 사용하는 권한
-- 사용법 : GRANT 권한명, 권한명2... TO 계정명;
GRANT CONNECT, RESOURCE, CREATE VIEW TO SCOTT;
GRANT UNLIMITED TABLESPACE TO SCOTT;

