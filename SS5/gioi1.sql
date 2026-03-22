create table customers (
    customer_id int primary key,
    customer_name varchar(100),
    city varchar(50)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    total_price numeric(10,2)
);

create table order_items (
    item_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    price numeric(10,2)
);

insert into customers values
(1, 'nguyễn văn a', 'hà nội'),
(2, 'trần thị b', 'đà nẵng'),
(3, 'lê văn c', 'hồ chí minh'),
(4, 'phạm thị d', 'hà nội');

insert into orders values
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);

insert into order_items values
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);

-- Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng
select 
    c.customer_name, 
    sum(o.total_price) as total_revenue, 
    count(o.order_id) as order_count
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_name
having sum(o.total_price) > 2000;

-- Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
select 
    c.customer_name, 
    sum(o.total_price) as total_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_name
having sum(o.total_price) > (
    select avg(tong_tung_nguoi)
    from (
        select sum(total_price) as tong_tung_nguoi
        from orders
        group by customer_id
    ) as sub
);

-- Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
select c.city, sum(o.total_price) as city_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_price) = (
    -- tìm con số doanh thu cao nhất trong các thành phố
    select max(revenue)
    from (
        select sum(o2.total_price) as revenue
        from customers c2
        join orders o2 on c2.customer_id = o2.customer_id
        group by c2.city
    ) as sub_city
);

--  Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết:
select 
    c.customer_name, 
    c.city, 
    sum(oi.quantity) as total_products, 
    sum(o.total_price) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_name, c.city;