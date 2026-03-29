create table orders (
    order_id serial primary key,
    customer_id int,
    order_date date,
    total_amount numeric
);

insert into orders (customer_id, order_date, total_amount)
select 
    floor(random() * 1000 + 1), -- giả sử có 1000 khách hàng
    current_date - (random() * 365)::int, 
    (random() * 1000)::numeric
from generate_series(1, 10000);

explain analyze 
select * from orders where customer_id = 500;

create index idx_orders_customer_id on orders(customer_id);

-- Từ seq scan thành bitmap heap scan tốc độ truy cập nhanh hơn