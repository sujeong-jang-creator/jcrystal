from book_info import Book 
import cx_Oracle


# client 화면을 통해서 책 정보를 등록 
# -> 데이터 획득 Book 객체 생성
# -> oracle db에 저장 

def book_insert(book):   
    conn = cx_Oracle.connect(user="SCOTT", password="TIGER", dsn="xe")
    cur = conn.cursor()

    cur.execute("insert into book values (seq_book_no.nextval, :title, :author, :price)", \
        title=book.getTitle(), author=book.getAuthor(), price=book.getPrice())
    conn.commit()

    cur.close()
    conn.close()


def book_update(book):   
    conn = cx_Oracle.connect(user="SCOTT", password="TIGER", dsn="xe")
    cur = conn.cursor()
    cur.execute("update book set author=:author, price=:price where title=:title", \
        author=book.getAuthor(), price=book.getPrice(), title=book.getTitle())
    conn.commit()

    cur.close()
    conn.close()


if __name__ == '__main__':
    # book_insert(Book('python', '반썸1', 205))
    book_update(Book('python', '유재석', 700))
