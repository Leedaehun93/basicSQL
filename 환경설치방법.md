# 도커 설치 및 윈도우 가상화 설정 :
# 도커 (요즘 뜨는 기술) : 가상화 기술
# 윈도우즈 설치된 pc : 윈도우에서 실행되는 프로그램만 사용이 가능
# 기업) 리눅스/유닉스 : 리눅스/유닉스에 실행되는 프로그램만 사용이 가능
# (자바 특징 : 윈도우/리눅스/유닉스 모두 실행됨 )
# 도커를 이용해서 여러 OS(운영체제)를 넘나들면서 실행시킬 수 있음
# 도커 : 오라클 설치

# 도커 설치 및 윈도우 가상화 설정 :
# 1) 윈도우 가상화 설정
#    - 제어판 - 프로그램제거 - Windows 기능 켜기/끄기 선택
#    - hyper-v , windows 하위시스템 : 체크 후 pc 리부팅(다시시작) 
#    - 돋보기 : 윈도우 스토어 : ubuntu 설치
#   관리자로 명령 프롬프트 실행 후 아래 명령어 입력 (pc 리부팅)
#   C:> wsl --update
#    (ubuntu ...)
#   C:> wsl --set-default-version 2
#    (완료되었습니다.)

# 2) 도커 데스크탑 다운로드(무료, 기업(상용)) 및 도커허브 회원가입
#   - 도커허브     : https://hub.docker.com/
#   - 도커데스크탑 : https://www.docker.com/products/docker-desktop/ 

# 3) 오라클 접속툴 : sql-developer 다운로드
#    - 오라클 회원가입 후 검색창 : sql-developer
#    - SQL Developer 23.1 다운로드(1st 다운로드)
#    - https://www.oracle.com/database/sqldeveloper/technologies/download/

# 4) 도커에서 오라클 이미지 다운로드
#    - 도커 데스크탑 실행 : 왼쪽탭 images 클릭
#    - 중앙 버튼 클릭 후 : Kangtaegyung  검색 : kangtaegyung/oraclexe-18c
#    - 위의 목록 선택 후 PULL 버튼 클릭(도커허브 사이트에서 다운로드됨)

# 5) 오라클 설치 및 실행 
#   - 관리자 명령 프롬프트에서 아래 명령어 실행
#   C:> docker run --name oraclexe-18c -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=Ds1234567890 kangtaegyung/oraclexe-18c

#   - 도커 container 왼쪽탭에서 설치하면 목록이 보임
#   - 도커 오라클 실행 / 중지 : Action 에 아이콘 클릭

# DBMS 사용할려면 접속해서 사용해야함(로그인 필요)
# 기타 : 오라클 관리자 계정     : system
#        오라클 관리자 패스워드 : Ds1234567890
#        DB 이름              : xepdb1
# 패스워드 대소문자 구분함(대문자,소문자 12자이상 사용해야함)