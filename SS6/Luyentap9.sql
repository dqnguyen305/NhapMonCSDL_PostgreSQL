create table product (
    id serial primary key,
    name varchar(100),
    category varchar(50),
    price numeric(10,2)
);

create table orderdetail (
    id serial primary key,
    order_id int,
    product_id int,
    quantity int
);


insert into product (name, category, price) values
('laptop dell', 'điện tử', 25000000),
('iphone 15', 'điện tử', 30000000),
('bàn làm việc', 'nội thất', 5000000),
('ghế công thái học', 'nội thất', 8000000),
('chuột không dây', 'phụ kiện', 500000);

insert into orderdetail (order_id, product_id, quantity) values
(1, 1, 2), -- 50tr
(1, 2, 1), -- 30tr
(2, 3, 5), -- 25tr
(3, 4, 1), -- 8tr
(3, 1, 1); -- 25tr

-- tính tổng doanh thu từng sản phẩm
select p.name as product_name, sum(p.price * od.quantity) as total_sales
from product p
join orderdetail od on p.id = od.product_id
group by p.name;
--Tính doanh thu trung bình theo từng loại sản phẩm (GROUP BY category)
select p.category, avg(p.price * od.quantity) as avg_revenue
from product p
join orderdetail od on p.id = od.product_id
group by p.category;
-- doanh thu trung bình theo từng loại sản phẩm > 20 triệu
select p.category, avg(p.price * od.quantity) as avg_revenue
from product p
join orderdetail od on p.id = od.product_id
group by p.category
having avg(p.price * od.quantity) > 20000000;

-- 4. tên sản phẩm có doanh thu cao hơn doanh thu trung bình toàn bộ sản phẩm
select p.name
from product p
join orderdetail od on p.id = od.product_id
group by p.name
having sum(p.price * od.quantity) > (
    select avg(total_per_product)
    from (
        select sum(p2.price * od2.quantity) as total_per_product
        from product p2
        join orderdetail od2 on p2.id = od2.product_id
        group by p2.id
    ) a
);

-- 5. liệt kê toàn bộ sản phẩm và số lượng bán được (kể cả sản phẩm chưa có đơn)
select p.name, coalesce(sum(od.quantity), 0) as total_quantity
from product p
left join orderdetail od on p.id = od.product_id
group by p.name;