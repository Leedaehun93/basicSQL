-- 파일명 : 17_System_Role_Exam.sql
-- 연습문제)유저(사용자)만들기(계정생성), 권한주기, 삭제
--------------------------------------------------------------------------------
-- 사용자 계정/권한 연습문제 : SYSTEM(관리자 계정으로 연습문제 풀기)
-- 로그인 테스트 : 계정명: kbs , 암호:pass, 서비스명: xepdb1
-- 1) KBS라는 사용자를 생성하세요(암호는 pass)
CREATE USER KBS IDENTIFIED BY pass;

-- 2) 기본적인 권한 부여를 하지 않으면 데이터베이스에 로그인이 불가능하므로,
--    CONNECT, RESOURCE 롤과 CREATE VIEW 를 KBS 사용자에게 부여하세요.
GRANT CONNECT, RESOURCE, CREATE VIEW TO KBS;

-- 3) 접속테스트 성공한 후에는 위에서 만든 유저 삭제하세요.
DROP USER KBS;