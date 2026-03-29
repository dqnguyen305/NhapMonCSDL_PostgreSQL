create table inventory (
	product_id serial primary key,
	product_name varchar(100),
	quantity int
);

insert into inventory (product_name, quantity) values
('laptop dell xps', 15),
('macbook pro m3', 10),
('bàn phím cơ akko', 25),
('chuột logitech g502', 40),
('màn hình lg 27 inch', 12),
('tai nghe sony wh-1000xm5', 8),
('ssd samsung 1tb', 30),
('ram corsair 16gb', 50),
('nguồn máy tính 750w', 20),
('vỏ case lian li', 5);

select * from inventory;


create or replace procedure check_stock(p_id INT, p_qty INT)
language plpgsql
as $$
declare check_qa int;
begin
	select quantity into check_qa
	from inventory
	where product_id = p_id;

	if not found then
		raise exception 'Khong tim thay san pham';
	end if;

	if check_qa < p_qty then
		raise exception 'Khong du hang trong kho';
	else
		raise notice 'du hang';
	end if;
end
$$;

call check_stock(1,20);
call check_stock(1,10);