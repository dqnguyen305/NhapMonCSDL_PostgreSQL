create table customers (
    customer_id serial primary key,
    customer_name varchar(100),
    city varchar(50)
);

create table orders (
    order_id serial primary key,
    customer_id int references customers(customer_id),
    order_date date,
    total_amount numeric(10,2)
);

create table order_items (
    item_id serial primary key,
    order_id int references orders(order_id),
    product_name varchar(100),
    quantity int,
    price numeric(10,2)
);

insert into customers (customer_name, city) values
('nguyễn văn an', 'hà nội'),
('trần thị bình', 'tp hcm'),
('lê minh cường', 'đà nẵng'),
('phạm hồng đào', 'hà nội');

insert into orders (customer_id, order_date, total_amount) values
(1, '2024-01-10', 5000),
(2, '2024-02-15', 12000),
(3, '2024-03-20', 3000),
(1, '2024-04-05', 7000),
(4, '2024-05-12', 2000);

insert into order_items (order_id, product_name, quantity, price) values
(1, 'laptop dell', 1, 5000),
(2, 'iphone 15', 1, 12000),
(3, 'chuột logitech', 2, 1500),
(4, 'bàn phím cơ', 1, 7000);

-- alias
select 
    c.customer_name, 
    o.order_date, 
    o.total_amount
from customers c
join orders o on c.customer_id = o.customer_id;

-- aggregate functions
select 
    sum(total_amount) as total_revenue,
    avg(total_amount) as average_order_value,
    max(total_amount) as max_order,
    min(total_amount) as min_order,
    count(order_id) as total_orders
from orders;

-- group by / having
select c.city, sum(o.total_amount) as total_city_revenue
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_amount) > 10000;

-- join 3 bảng
select 
    c.customer_name, 
    o.order_date, 
    oi.product_name, 
    oi.quantity, 
    oi.price
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id;

-- subquery
select customer_name
from customers
where customer_id = (
    select customer_id
    from orders
    group by customer_id
    order by sum(total_amount) desc
    limit 1
);

-- union
select city from customers
union
select c.city 
from customers c 
join orders o on c.customer_id = o.customer_id;

-- intersect
select city from customers
intersect
select c.city 
from customers c 
join orders o on c.customer_id = o.customer_id;