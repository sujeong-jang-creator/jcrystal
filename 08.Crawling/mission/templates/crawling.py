import time
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait

# class EmpDAO:
#     def craw():
main_url = "https://www.naver.com/"
keyword = "장크리수탉"

driver = webdriver.Chrome("C:/driver/chromedriver")
driver.get(main_url)
time.sleep(3)
driver.implicitly_wait(5)

elem = driver.find_element_by_id("query")
elem.clear()
0
elem.submit()
time.sleep(3)
driver.implicitly_wait(5)

blog = driver.find_element_by_class_name("link_tit")
blog.click()

