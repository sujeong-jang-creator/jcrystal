from book_info import Book
import cx_Oracle
# client가 화면을 통해서 책 정보를 등록 -> 데이터 획득
# -> 데이터 획득 Book객체 생성
# -> oracle db에 저장 
    # oracle db에 insert
def book_insert(book):
    conn = cx_Oracle.connect(user = "SCOTT", password="TIGER", dsn = "xe")
    cur = conn.cursor()
    # print(cur)
    #cur.execute("insert into book values(seq_book_no.nextval, 'python', '반썸', 1000)")
    cur.execute("insert into book values(seq_book_no.nextval, :title, :author, :price)", title = book.getTitle(), author = book.getAuthor(), price = book.getPrice())
    conn.commit() # 이거 안쓰니까 안들어감.
    cur.close()
    conn.close()
    
def book_update(book):
    conn = cx_Oracle.connect(user = "SCOTT", password="TIGER", dsn = "xe")
    cur = conn.cursor()
    # print(cur)
    cur.execute("update book set author = :author, price = :price where title = :title", \
        title = book.getTitle(), author = book.getAuthor(), price = book.getPrice())
    conn.commit() # 이거 안쓰니가 안들어감.
    cur.close()
    conn.close()
if __name__ == '__main__':
    book_insert(Book('python3', '로드', 105))
    book_update(Book('python3', '백종', 700)) 
    # 상황에 따라 다르다!
    # 이번은 만약 하나를 값을 기준으로 그 외 나머지를 바꾸기 때문에 객체로 생성해서 보냄!