create table products (
    product_id serial primary key,
    product_name varchar(100),
    stock int,
    price numeric(10,2)
);

create table orders (
    order_id serial primary key,
    customer_name varchar(100),
    total_amount numeric(10,2),
    created_at timestamp default now()
);

create table order_items (
    order_item_id serial primary key,
    order_id int references orders(order_id),
    product_id int references products(product_id),
    quantity int,
    subtotal numeric(10,2)
);

insert into products (product_name, stock, price)
values ('laptop', 10, 1000), ('mouse', 5, 50);

--Viết Transaction thực hiện toàn bộ quy trình đặt hàng cho khách "Nguyen Van A"
begin;

update products set stock = stock - 2 where product_id = 1;
update products set stock = stock - 1 where product_id = 2;

insert into orders (customer_name, total_amount) 
values ('nguyen van a', 2050); -- (1000*2 + 50*1)

insert into order_items (order_id, product_id, quantity, subtotal)
values (1, 1, 2, 2000), (1, 2, 1, 50);

commit;

select * from products;
select * from orders;
select * from order_items;

--Mô phỏng lỗi

update products set stock = 0 where product_id = 2;

begin;

update products set stock = stock - 2 where product_id = 1;

update products set stock = stock - 1 where product_id = 2; 

rollback;

select * from products;