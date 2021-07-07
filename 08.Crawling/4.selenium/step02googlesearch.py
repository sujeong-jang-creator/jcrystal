# 미션 : 구글에서 검색 가능하게 step01 처럼 작업 권장

from selenium import webdriver
import time # 실행을 잠시 중지(sleep(초단위))

driver = webdriver.Chrome("c:/driver/chromedriver")

driver.get("https://www.google.com/")

# 구글의 페이지에서 f12를 눌렀을때 검색칸을 보면 naver와 다르게 name이 q인것을 확인할 수 있다.
tag = driver.find_element_by_name("q")

#검색한 input tag의 내용 수정
tag.clear()  # 혹시 내용이 있으면 삭제

#input  tag에 데이터 입력 - 키보드로 입력하는 것과 동일하다
tag.send_keys("AI")  # 입력

#전송 버튼 클릭 
# 입력된 데이터로 검색을 하게 되는 기능
# 사용자들이 입력후에 키보드에서 enter 입력과 동일한 action
# 네이버에서 자체적으로 구현된 기능으로 검색된 page로 이동
tag.submit()

# 이동된 웹페이지가 실행되는 초단위
time.sleep(20) # 실행중인 프로그램 중지(sleep ( 이만큼 초가 지난후 ))

# 자원 반환 측면에서 driver도 중지
driver.quit()