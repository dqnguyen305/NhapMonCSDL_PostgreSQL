create table customer (
    customer_id serial primary key,
    full_name varchar(100),
    email varchar(100),
    phone varchar(15)
);

create table orders (
    order_id serial primary key,
    customer_id int references customer(customer_id),
    total_amount decimal(10,2),
    order_date date
);

insert into customer (full_name, email, phone) values
('nguyễn văn a', 'vana@gmail.com', '0901234567'),
('trần thị b', 'thib@gmail.com', '0912345678'),
('lê văn c', 'vanc@gmail.com', '0987654321');

insert into orders (customer_id, total_amount, order_date) values
(1, 1500000.00, '2024-03-20'),
(2, 2300000.50, '2024-03-21'),
(1, 450000.00, '2024-03-22'),
(3, 900000.00, '2024-03-23');

create view  v_order_summary as
select c.full_name, o.total_amount, o.order_date
from customer c
join orders o on c.customer_id = o.customer_id;

select * from v_order_summary;

create view  v_order_summary1 as
select order_id, total_amount, order_date
from orders 
where total_amount >= 1000000;

select * from v_order_summary1;
select * from orders;
update v_order_summary1
set total_amount = 2000000.0
where order_id =1;

create view  v_monthly_sales  as
select extract(month from order_date), sum(total_amount) as tong
from orders 
group by extract(month from order_date);

select * from v_monthly_sales;

drop view v_monthly_sales;

DROP MATERIALIZED VIEW v_monthly_sales; -- lỗi

--VIEW là bảng ảo, chỉ lưu câu lệnh truy vấn; còn MATERIALIZED VIEW lưu dữ liệu thực tế.
--DROP VIEW dùng để xóa view thường, còn DROP MATERIALIZED VIEW dùng cho materialized view.
--Materialized view thường dùng khi cần tối ưu hiệu năng truy vấn phức tạp.
--View thường phù hợp khi dữ liệu cần cập nhật theo thời gian thực.