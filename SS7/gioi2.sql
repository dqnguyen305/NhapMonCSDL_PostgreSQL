create table customer (
    customer_id serial primary key,
    full_name varchar(100),
    region varchar(50)
);

create table orders (
    order_id serial primary key,
    customer_id int references customer(customer_id),
    total_amount decimal(10,2),
    order_date date,
    status varchar(20)
);

create table product (
    product_id serial primary key,
    name varchar(100),
    price decimal(10,2),
    category varchar(50)
);

create table order_detail (
    order_id int references orders(order_id),
    product_id int references product(product_id),
    quantity int
);
insert into customer (full_name, region) values
('nguyễn văn a', 'miền bắc'),
('trần thị b', 'miền nam'),
('lê văn c', 'miền trung'),
('phạm minh d', 'miền bắc'),
('hoàng lan e', 'miền nam');

insert into product (name, price, category) values
('laptop dell xps', 25000000.00, 'điện tử'),
('chuột logitech', 500000.00, 'phụ kiện'),
('bàn phím cơ', 1200000.00, 'phụ kiện'),
('màn hình 4k', 8000000.00, 'điện tử'),
('tai nghe sony', 3500000.00, 'âm thanh');

insert into orders (customer_id, total_amount, order_date, status) values
(1, 25500000.00, '2024-03-20', 'đã giao'),
(2, 500000.00, '2024-03-21', 'đang xử lý'),
(3, 9200000.00, '2024-03-22', 'đã giao'),
(1, 1200000.00, '2024-03-23', 'đã hủy'),
(5, 3500000.00, '2024-03-24', 'đã giao');

insert into order_detail (order_id, product_id, quantity) values
(1, 1, 1),
(1, 2, 1),
(2, 2, 1),
(3, 3, 1),
(3, 4, 1),
(4, 3, 1),
(5, 5, 1);

-- Tạo View tổng hợp doanh thu theo khu vực:
create view v_revenue_by_region as
select 
    c.region, 
    sum(o.total_amount) as total_revenue
from customer c
join orders o on c.customer_id = o.customer_id
group by c.region;

-- Viết truy vấn xem top 3 khu vực có doanh thu cao nhất
select * from v_revenue_by_region
order by total_revenue desc
limit 3;

-- Tạo View chi tiết đơn hàng có thể cập nhật được:
create view v_order_status_active as
select order_id, customer_id, total_amount, status
from orders
where status != 'đã hủy'
with check option;

-- Cập nhật status của đơn hàng thông qua View này
update v_order_status_active
set status = 'đã giao'
where order_id = 1;
Select * from v_order_status_active;
-- Kiểm tra hành vi khi vi phạm điều kiện WITH CHECK OPTION
update v_order_status_active
set status = 'đã hủy'
where order_id = 1;

--ERROR:  new row violates check option for view "v_order_status_active"
--Failing row contains (1, 1, 25500000.00, 2024-03-20, đã hủy). 

--SQL state: 44000
--Detail: Failing row contains (1, 1, 25500000.00, 2024-03-20, đã hủy).

-- Tạo View phức hợp (Nested View
create view v_revenue_above_avg as
select *
from v_revenue_by_region
where total_revenue > (select avg(total_revenue) from v_revenue_by_region);

select * from v_revenue_above_avg;