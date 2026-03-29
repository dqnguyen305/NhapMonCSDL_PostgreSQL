create table products (
    id serial primary key,
    name varchar(100),
    price numeric,
    discount_percent int
);

insert into products (name, price, discount_percent) values
('điện thoại iphone', 20000000, 10),
('tai nghe bluetooth', 2000000, 60), -- test trường hợp > 50%
('ốp lưng silicon', 500000, 20);

create or replace procedure calculate_discount(
    p_id int, 
    out p_final_price numeric
)
language plpgsql
as $$
declare 
    v_price numeric; 
    v_discount int;
begin
    select price, discount_percent into v_price, v_discount
    from products
    where id = p_id;

    if not found then
        raise exception 'không tìm thấy sản phẩm id %', p_id;
    end if;

    if v_discount > 50 then
        v_discount := 50;
    end if;

    p_final_price := v_price - (v_price * v_discount / 100);

    update products
    set price = p_final_price
    where id = p_id;
end;
$$;

do $$
declare
    v_result numeric;
begin
    call calculate_discount(2, v_result);
    raise notice 'giá sau khi áp dụng giảm giá (tối đa 50%%) là: %', v_result;
end;
$$;

select * from products;