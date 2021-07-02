html='''
<html>
    <body>
        <h1>스크래핑이란?</h1>
        <h1>스크래핑이란???</h1>
        <p id="one">웹페이지 1</p>
        <p id="two">웹페이지 2</p>
        <span class="redColor">
            <p>웹페이지3</p>
        </span>
        <ul>
            <li><a href="www.daum.net">다음</a></li>
            <li><a href="www.naver.com">네이버</a></li>
        </ul>        
    </body>
</html>
'''
# bs4 - html 문서를 tag, 속성, css 등으로 섬세하게 관리 가능한 API
from bs4 import BeautifulSoup

# 크롤링 대상의 데이터와 구문해석, 문법체크, 변환가능한 parser 설정
soup = BeautifulSoup(html, 'html.parser')

print('-----2 : find() 함수 -----')
print(soup.find(id="one"))  # <p id="one">웹페이지 1</p>
print(soup.find(id="one").string)  # 웹페이지 1
print(soup.select('.redColor'))  # 웹페이지 3

# html(x) 문서는 족보구조 즉 tree 구조
# html 상에서 new line(br tag)은 text 자식으로 간주
# next_sibling : 현 위치 상에서 다음 내 형제

'''
        <p id="one">웹페이지 1</p>
        <p id="two">웹페이지 2</p>
'''

print(soup.html.p)      # <p id="one">웹페이지 1</p>
print(soup.html.p.next_sibling)   # new line 즉 text 동생
print(soup.html.p.next_sibling.next_sibling)     # <p id="two">웹페이지 2</p>

# text 데이터들은 string 속성명과 get_text() 함수로 착출
print(soup.html.span.p.string)  # 웹페이지3
print(soup.html.span.p.get_text())  # 웹페이지3