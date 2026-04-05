create function f_trg_1_sa()
returns trigger as $$
begin
	update products set stock = stock - new.quantity;
	return new;
end; $$ language plpgsql;

create trigger trg_1_sa
after insert on sales
for each row
execute function f_trg_1_sa();

select * from products;
insert into sales (product_id, quantity) values
(1,4);