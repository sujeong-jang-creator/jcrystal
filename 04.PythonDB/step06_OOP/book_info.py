# 데이터 표현 클래스 : VO pattern or DTO pattern
class Book:
    def __init__(self, title, author, price):  #   local변수
        # 멤버 변수 선언
        self.title = title
        self.author = author
        self.price = 0
        if price > 100:
            self.price = price
        self.setPrice(price) # 100 이상의 유효성 로직 처리 필수. 따라서 이미 구현되어 있는 메소드 호출

    def getTitle(self):
        return self.title

    def setTitle(self, new_title):
        self.title = new_title    

    def getAuthor(self):
        return self.author

    def setAuthor(self, new_author):
        self.author = new_author

    def getPrice(self):
        return self.price

    def setPrice(self, new_price):
        # 금액은 100원이하는 표기하면 안돼!
        if new_price > 100:
            self.price = new_price 
        elif new_price < 0:
            self.price = ("마이너스 오바에요.")
        else:
            self.price = ("금액이 부족합니다.")

# if __name__ == '__main__':