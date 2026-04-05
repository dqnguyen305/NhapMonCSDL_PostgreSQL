create table orders (
	order_id serial primary key,
	product_id int references products(product_id),
	quantity int,
	total_amount numeric
);
alter table products
add column price numeric(10,0);

update products set price = 1000.0 where product_id =1;

create or replace function f_trg_in_or()
returns trigger as $$
declare f_price numeric(10,2);
begin
	select price into f_price from products where product_id = new.product_id;
	new.total_amount = new.quantity*f_price;
	return new;
end; $$ language plpgsql;

create or replace trigger trg_in_or
before insert on orders
for each row
execute function f_trg_in_or();

insert into orders (product_id, quantity) 
values (1, 3);

select * from orders;
 