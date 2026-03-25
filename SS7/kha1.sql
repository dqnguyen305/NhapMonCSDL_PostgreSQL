create table book (
	book_id serial primary key,
	title varchar(255),
	author varchar(100),
	genre varchar(50),
	price decimal(10,2),
	description text,
	created_at timestamp default current_timestamp
);
INSERT INTO book (title, author, genre, price, description)
SELECT 
    'Book Title ' || i, 
    CASE 
        WHEN i % 100 = 0 THEN 'J.K. Rowling' -- Cứ 100 cuốn thì có 1 cuốn của Rowling để test ILIKE
        ELSE 'Author ' || i 
    END,
    CASE 
        WHEN i % 4 = 0 THEN 'Fantasy'
        WHEN i % 4 = 1 THEN 'Sci-Fi'
        WHEN i % 4 = 2 THEN 'Mystery'
        ELSE 'Romance'
    END,
    (random() * 100)::decimal(10,2),
    'This is a long description for book number ' || i || ' to test full-text search capabilities.'
FROM generate_series(1, 5000) AS i;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

create index idx_book_genre on book(genre);
create index idx_book_author on book using GIN (author gin_trgm_ops);

DROP INDEX idx_book_genre;
DROP INDEX idx_book_author;

EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';
EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%Rowling%';

CREATE INDEX idx_book_fulltext ON book 
USING GIN (to_tsvector('english', title || ' ' || description));

EXPLAIN ANALYZE 
SELECT * FROM book 
WHERE to_tsvector('english', title || ' ' || description) @@ to_tsquery('english', 'Title & description');

CLUSTER book USING idx_book_genre;

EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM book WHERE genre = 'Fantasy';


