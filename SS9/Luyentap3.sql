create table products (
    product_id serial primary key,
    category_id int,
    price numeric,
    stock_quantity int
);

insert into products (category_id, price, stock_quantity)
select 
    floor(random() * 10 + 1), -- 10 loại danh mục
    (random() * 5000 + 100)::numeric, -- giá từ 100 đến 5100
    floor(random() * 100)
from generate_series(1, 1000);

create index idx_products_category_on_disk on products (category_id);

cluster products using idx_products_category_on_disk;

create index idx_products_price on products (price);

explain analyze
select * from products 
where category_id = 5 
order by price;

--index giống như mục lục của cuốn sách giúp database tìm dữ liệu nhanh hơn thay vì lật từng trang.
--Clustered Index Sắp xếp luôn dữ liệu thật trên ổ đĩa
--Non-clustered Index Tạo bảng phụ đã sắp xếp sẵn Chứa giá trị + con trỏ tới dữ liệu thật


