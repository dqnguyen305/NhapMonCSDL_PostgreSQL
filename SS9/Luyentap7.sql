create table customers (
    customer_id serial primary key,
    name varchar(100),
    email varchar(100)
);

create table orders (
    order_id serial primary key,
    customer_id int,
    amount numeric,
    order_date date default current_date
);

insert into customers (name, email) values 
('Nguyễn Văn An', 'an@gmail.com'),
('Trần Thị Bình', 'binh@gmail.com');

create or replace procedure add_order(p_customer_id int, p_amount numeric)
language plpgsql
as $$
declare
    v_exists boolean;
begin
    select exists(select 1 from customers where customer_id = p_customer_id) into v_exists;

    if not v_exists then
        raise exception 'Khách hàng với ID % không tồn tại trong hệ thống', p_customer_id;
    end if;

    insert into orders (customer_id, amount, order_date)
    values (p_customer_id, p_amount, current_date);
    
    raise notice 'Đã thêm thành công đơn hàng cho khách hàng ID %', p_customer_id;
end;
$$;

call add_order(1, 500000);
call add_order(99, 1000000);