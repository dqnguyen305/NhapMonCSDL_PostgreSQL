create table products (
    product_id serial primary key,
    name varchar(100),
    price numeric,
    category_id int
);

insert into products (name, price, category_id) values
('Bàn gỗ', 1000, 1),
('Ghế xoay', 500, 1),
('Đèn bàn', 200, 2),
('Tủ sắt', 2000, 1);

create or replace procedure update_product_price(
    p_category_id int, 
    p_increase_percent numeric
)
language plpgsql
as $$
declare
    r record; 
    v_new_price numeric; 
begin
    for r in 
        select product_id, price 
        from products 
        where category_id = p_category_id
    loop
        v_new_price := r.price * (1 + p_increase_percent / 100);
        
        update products 
        set price = v_new_price
        where product_id = r.product_id;
        
        raise notice 'Sản phẩm ID %: Giá cũ % -> Giá mới %', r.product_id, r.price, v_new_price;
    end loop;
    
    raise notice 'Hoàn tất cập nhật giá cho danh mục %', p_category_id;
end;
$$;

call update_product_price(1, 10);

select * from products where category_id = 1;