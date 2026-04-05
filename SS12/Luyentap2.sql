create table products (
	product_id serial primary key,
	name varchar(50),
	stock int
);

create table sales (
	sales_id serial primary key,
	product_id int references products(product_id),
	quantity int
);

insert into products(name, stock) values
('laptop', 8);


create function f_trg_in_sa()
returns trigger as $$
declare f_stock int;
begin
	select stock into f_stock from products
	where product_id = new.product_id;
	if new.quantity > f_stock then
		raise exception 'Vuot qua ton kho';
	end if;
	return new;
end; $$ language plpgsql;

create trigger trg_in_sa
before insert on sales
for each row
execute function f_trg_in_sa();

insert into sales (product_id, quantity) values
(1,9);