create table customers (
    customer_id serial primary key,
    name varchar(100),
    total_spent numeric default 0
);

create table orders (
    order_id serial primary key,
    customer_id int references customers(customer_id),
    total_amount numeric,
    order_date date default current_date
);

insert into customers (name, total_spent) values ('Nguyễn Văn An', 0), ('Trần Thị Bình', 500000);

create or replace procedure add_order_and_update_customer(
    p_customer_id int, 
    p_amount numeric
)
language plpgsql
as $$
declare
    v_customer_exists boolean;
begin
    select exists(select 1 from customers where customer_id = p_customer_id) into v_customer_exists;

    if not v_customer_exists then
        raise exception 'Khách hàng ID % không tồn tại!', p_customer_id;
    end if;

    insert into orders (customer_id, total_amount)
    values (p_customer_id, p_amount);

    update customers
    set total_spent = total_spent + p_amount
    where customer_id = p_customer_id;

    raise notice 'Thành công: Đã thêm đơn hàng và cập nhật chi tiêu cho khách %', p_customer_id;

exception
    when others then
        -- Báo lỗi nếu có bất kỳ sự cố nào xảy ra (ví dụ: lỗi kết nối, lỗi ràng buộc...)
        raise exception 'Giao dịch thất bại: %', sqlerrm;
end;
$$;

call add_order_and_update_customer(1, 200000);

select * from orders where customer_id = 1;

select * from customers where customer_id = 1;
