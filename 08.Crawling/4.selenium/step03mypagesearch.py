
from selenium import webdriver
import time 

driver = webdriver.Chrome("c:/driver/chromedriver")

driver.get("http://127.0.0.1:5500/4.selenium/step03mypage.html")

# input tag
tag = driver.find_element_by_name("data")



# button tag
btn = driver.find_element_by_id("btn") # id 속성으로 찾는 함수

# input 에 입력
tag.send_keys("encore") 

# button 클릭
btn.click()

time.sleep(7) 

driver.quit()