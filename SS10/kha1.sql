create table products (
	id serial primary key,
	name varchar(100) not null,
	price numeric(10,2) not null,
	last_modified timestamp default current_timestamp
);

create or replace function update_last_modified()
returns trigger as $$
begin
	new.last_modified = current_timestamp;
	return new;
end; $$ language plpgsql;

create or replace trigger trg_update_last_modified
before update on products
for each row
execute function update_last_modified();

insert into products (name, price)
values 
('iPhone 15 Pro', 25000000),
('MacBook M3', 45000000),
('AirPods Pro', 5000000);

SELECT * FROM products;

update products set price = 1.2*price
where id =1;