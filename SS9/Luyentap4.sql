create table sales (
    sale_id serial primary key,
    customer_id int,
    product_id int,
    sale_date date,
    amount numeric
);

insert into sales (customer_id, product_id, sale_date, amount) values
(1, 101, '2024-01-01', 500),
(1, 102, '2024-01-05', 700), 
(2, 101, '2024-01-10', 300),
(3, 103, '2024-01-12', 1500), 
(2, 102, '2024-01-15', 400);  

create or replace view customersales as
select 
    customer_id, 
    sum(amount) as total_amount
from sales
group by customer_id;

select * from customersales 
where total_amount > 1000;

update customersales 
set total_amount = 2000 
where customer_id = 1;
