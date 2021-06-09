from book_info import Book

if __name__ =='__main__':
    print(1)
    b = Book('python', '로드반썸', 90)
    # 각 멤버 변수값 출력
    print(b.getTitle())
    print(b.getAuthor())
    print(b.getPrice())

    print("-----")
    b.setPrice(-10)
    print(b.getPrice())
    #? 미션 금액 100 초과여야만 대입되겠금
