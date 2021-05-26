from CustomerInfo import Customer
from BookInfo import Book

class BookShopAdmin:

    def cust_create():
        c1 = Customer('재석', 'vvip')   # 0x000001DCF3277850
        return c1  
    
    def book_create():
        b1 = Book('python basic', '종원')
        return b1

    if __name__ == '__main__':
        print(  cust_create()  ) 
        c = cust_create()
        print(c.getCustName())
