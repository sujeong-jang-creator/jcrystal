'''
제공 후 분석 및 이해하기

절대 경로와 상대 경로 url 관리하는 연습

1. 현 위치에서 c drive 하단에 directory 하단에 c directory로 이동 의미
    - 어디에서든 해당 명령어 입력하면 무조건 c:/a/c로 이동
>cd c:/a/c

2. 현 위치(c드라이브 하위의 a/c 디렉토리)에서 상위 directoryfh로 이동 의미
    - 상대경로
c:/a/c>cd ..
c 디렉토리에서 a 디렉토리로 이동

cd .. 는 현 위치에서 무조건 상위 즉 현 위치가 중요한 상황
cd c:/a:/c 현 위치 중요하지 않음 무조건 cd c:/a/c로 이동
'''

#urllib - package명
#parse - 파일명(모듈명)
#urljoin - parse.py 내부에 내장된 urljoin(절대url, 상대url) 함수

from urllib.parse import urljoin

# 절대 url
base = "http://example.com/html/a.html"

# b.html은 a.html와 같은 폴더에 저장되어 있음.
# a.html 대신 b.html로 자동 변환
print(urljoin(base, "b.html")) #http://example.com/html/b.html

# 제공받은 pdf p29~30 : 
# authority : 뒤에 나오는 일반적인 호스트 이름 , 사용자이름 , 비밀번호 , 포트 번호 등을 포함
# /표기가 적용될 경우 authority 부분까지만 유효하게 인식
print(urljoin(base, "/b.html")) #http://example.com/b.html

# ../ : 현 위치에서 상위 디렉토리 의미
# base = "http://example.com/html/a.html"
# a.html 위치에서 상위 위치는 html의 위치

print(urljoin(base, "../b.html")) #http://example.com/b.html

print(urljoin(base, "../img/b.html")) #http://example.com/img/b.html

# base = "http://example.com/html/a.html"
print(urljoin(base, "../css/cssView.css")) #http://example.com/css/cssView.css

# 문법 오류는 없으나 표현은 논리적으로 부적합
print(urljoin(base, "../../css/cssView.css")) #http://example.com/css/cssView.css

print(urljoin(base, "/../../css/cssView.css"))  #http://example.com/css/cssView.css  