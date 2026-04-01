create table customers(
	id serial primary key,
	name varchar(100) not null,
	credit_limit numeric(10,2)
);

create table orders(
	id serial primary key,
	customer_id int references customers(id),
	order_amount numeric(10,2)
);

create or replace function check_credit_limit() 
returns trigger as $$
declare v_credit_limit numeric(10,2);
begin
	select credit_limit into v_credit_limit
	from customers
	where id = new.customer_id;
	if new.order_amount > v_credit_limit then
		raise exception 'Vuot han muc roi!';
	end if;
	return new;
end;
$$ language plpgsql;

create or replace trigger trg_check_credit
before insert on orders
for each row
execute function  check_credit_limit();

insert into customers (name, credit_limit) 
values ('Nguyễn Văn A', 10000000);

insert into orders (customer_id, order_amount) values (1, 5000000);

insert into orders (customer_id, order_amount) values (1, 50000000);
select * from orders;