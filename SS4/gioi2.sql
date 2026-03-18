-- tạo bảng
create table products (
    id serial primary key,
    name varchar(100),
    category varchar(50),
    price bigint,
    stock int,
    manufacturer varchar(50)
);

-- chèn dữ liệu
insert into products (name, category, price, stock, manufacturer) values
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
('Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
('Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
('iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Tai nghe AirPods 3', 'Phụ kiện', 4500000, null, 'Apple');

-- chèn dữ liệu mới
insert into products (name, category, price, stock, manufacturer)
values ('Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- cập nhật dữ liệu
update products
set price = price * 1.1
where manufacturer = 'Apple';

-- xóa dữ liệu
delete from products
where stock = 0;

-- lọc theo điều kiện (khoảng giá)
select *
from products
where price between 1000000 and 30000000;

-- lọc giá trị null
select *
from products
where stock is null;

-- loại bỏ trùng
select distinct manufacturer
from products;

-- sắp xếp dữ liệu
select *
from products
order by price desc, name asc;

-- tìm kiếm (không phân biệt hoa thường)
select *
from products
where name ilike '%laptop%';

-- giới hạn kết quả
select *
from products
order by price desc, name asc
limit 2;