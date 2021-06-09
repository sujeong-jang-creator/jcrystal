DROP SEQUENCE seq_book_no;
CREATE SEQUENCE seq_book_no;

DROP TABLE book cascade constraint;
--자식테이블 있어도 book 삭제 명령어

CREATE TABLE book(
    bk_no number(6) primary key,
    title varchar2(10) not null,
    author varchar2(10) not null,
    price number(6,2) not null   -- 총 5자리, 단 소수점 2자리
);

INSERT INTO book VALUES (seq_book_no.nextval, 'python', '반썸', 100);

commit;

SELECT * FROM book;