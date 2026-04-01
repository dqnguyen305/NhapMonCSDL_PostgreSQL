drop trigger if exists trg_manage_stock on orders;
drop table if exists orders;
drop table if exists products;

create table products (
    id serial primary key,
    name varchar(100),
    stock int default 0
);

create table orders (
    id serial primary key,
    product_id int references products(id),
    quantity int not null
);

insert into products (name, stock) values ('iphone 15', 50), ('ipad pro', 30);

create or replace function update_inventory()
returns trigger as $$
declare
    current_stock int;
begin
    if (tg_op = 'INSERT') then
        select stock into current_stock 
        from products 
        where id = new.product_id;

        if current_stock < new.quantity then
            raise exception 'so luong ton kho khong du';
        end if;

        update products
        set stock = stock - new.quantity
        where id = new.product_id;

        return new;

    elsif (tg_op = 'UPDATE') then
        if (old.product_id <> new.product_id) then
            update products
            set stock = stock + old.quantity
            where id = old.product_id;

            select stock into current_stock 
            from products 
            where id = new.product_id;

            if current_stock < new.quantity then
                raise exception 'so luong ton kho khong du';
            end if;

            update products
            set stock = stock - new.quantity
            where id = new.product_id;

        else
            select stock into current_stock 
            from products 
            where id = new.product_id;

            if current_stock + old.quantity < new.quantity then
                raise exception 'so luong ton kho khong du';
            end if;

            update products
            set stock = stock + old.quantity - new.quantity
            where id = new.product_id;
        end if;

        return new;

    elsif (tg_op = 'DELETE') then
        update products
        set stock = stock + old.quantity
        where id = old.product_id;

        return old;
    end if;

    return null;
end;
$$ language plpgsql;

create trigger trg_manage_stock
after insert or update or delete on orders
for each row
execute function update_inventory();

insert into orders (product_id, quantity) values (1, 10);
select * from products;
select* from orders;
update orders set quantity = 15 where id = 1;

delete from orders where id = 1;