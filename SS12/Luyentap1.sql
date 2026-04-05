create table customers (
	customer_id serial primary key,
	name varchar(50),
	email varchar(50)
);

create table customer_log (
	log_id serial primary key,
	customer_name varchar(50),
	action_time timestamp
);

create function f_trg_in_cus ()
returns trigger as $$
begin 
	insert into customer_log (customer_name, action_time) values
	(new.name, current_timestamp);
	return new;
end; $$ language plpgsql;

create trigger trg_in_cus
after insert on customers
for each row
execute function f_trg_in_cus ();

insert into customers (name, email) values
('Nguyen Van A', 'Anguyen@gmail.com');

select * from customer_log;