import re

from urllib.request import urlopen

def main():

    html = crawling('https://brunch.co.kr/')

    books = scraping(html)

def crawling(url):  
    f = urlopen(url)

    encoding = f.info().get_content_charset(failobj="utf-8")
    print("--- 1. 인코딩 정보 : ", encoding)


    html = f.read().decode(encoding)

    return html

def scraping(html):

    books = []
# <a class="keyword_item brunch_keyword_item" href="/keyword/지구한바퀴_세계여행?q=g" target="_blank" 
# style="left: 0px; top: 0px;"><span class="keyword_item_txt">지구한바퀴<br>세계여행</span></a>

#    for data in re.findall(r'<td class="left"><a.*?</td>', html):

    for data in re.findall(r'<a class="keyword_item bru/nch_keyword_item" href=".*?"<\/span><\/a>', html):
        print(data)
        link = re.search(r'<a href="(.*?)">', data)
        url = 'https://brunch.co.kr/keyword/' + link.group(1)
        title = re.sub(r'<.*?>', '', data)
        
        books.append({'url':url, 'title':title})
    
    return books


if __name__ == '__main__':
    main()