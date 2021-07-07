
# pip install selenium & chrome driver 셋팅
from selenium import webdriver
import time  # 실행을 잠시 중지(sleep(초단위))

# step01 : 네이버에 실행 후  AI 키워드로 검색

# 크롬 브라우저 실행
# window : driver/chromedriver.exe
# mac : driver/chromedriver 유닉스실행파일(장동기왈)
driver = webdriver.Chrome("c:/driver/chromedriver.exe")

# http의 문서를 획득(브라우저에 실행시킬 사이트 url)
# http 프로토콜 관점에선 https://www.naver.com/ 즉 url로 직접 요청하는 기본 방식을 get 방식
driver.get("https://www.naver.com/")


# tag 검색
'''
<input id="query" name="query" type="text" title="검색어 입력" maxlength="255" 
class="input_text" tabindex="1" accesskey="s" style="ime-mode:active;" 
autocomplete="off" placeholder="검색어를 입력해 주세요." 
onclick="document.getElementById('fbm').value=1;" value="" data-atcmp-element="">
'''
tag = driver.find_element_by_name("query")

# 검색한 input tag의 내용 삭제
tag.clear()  

# input  tag에 데이터 입력 - 키보드로 입력하는 것과 동일
tag.send_keys("AI")  # 입력

# 전송 버튼 클릭
# 입력된 데이터로 검색을 하게 되는 기능
# 사용자들이 입력후에 키보드에서 enter 입력과 동일한 action
# 네이버 자체적으로 구현된 기능으로 검색된 page로 이동
tag.submit()

# 이동된 웹페이지가 실행되는 초단위
time.sleep(20)  # 실행중인 프로그램 중지(sleep)

# 자원 반환 측면에서 driver도 중지
driver.quit()


'''
1단계 : 브라우저 실행
2단계 : 검색 입력창 clear
3단계 : AI 를 입력
4단계 : 검색 버튼 클릭
5단계 : AI 데이터 검색된 화면으로 이동 
'''
