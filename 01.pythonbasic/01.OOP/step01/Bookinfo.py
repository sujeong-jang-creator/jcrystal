class Book:

    def __init__(self, title, author):
        self.title = title
        self.author = author
        print('Book __init__')


    def getBookName(self):        
        print('Book getBookName')
        return self.title