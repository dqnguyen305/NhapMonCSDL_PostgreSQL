create table order_detail (
	id serial primary key,
	order_id int,
	product_name varchar(100),
	quantity int,
	unit_price numeric
);

insert into order_detail (order_id, product_name, quantity, unit_price) values
(101, 'laptop dell', 1, 20000000),
(101, 'chuột logitech', 2, 500000),
(102, 'bàn phím cơ', 1, 1500000);
select * from order_detail;
-- Viết một Stored Procedure có tên calculate_order_total(order_id_input INT, OUT total NUMERIC)
create or replace procedure calculate_order_total (
	order_id_input int,
	out total numeric
)
language plpgsql
as $$
begin
	select sum(quantity*unit_price) into total
	from order_detail
	where order_id = order_id_input;
end
$$;

do $$
declare
	result_total numeric;
begin
	call calculate_order_total(101, result_total);
	raise notice 'tong gia tri don hang: %',result_total;
end;
$$;