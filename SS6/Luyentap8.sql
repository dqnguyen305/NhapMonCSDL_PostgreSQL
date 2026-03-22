
create table customer (
    id serial primary key,
    name varchar(100)
);


insert into customer (name) values 
('nguyễn văn an'),
('trần thị bình'),
('lê minh cường'),
('phạm hồng đào'),
('hoàng văn em');

--Hiển thị tên khách hàng và tổng tiền đã mua, sắp xếp theo tổng tiền giảm dần
select c.name , sum(o.total_amount) as tong
from customer c
join orders o on c.id = o.customer_id
group by c.name
order by sum(o.total_amount) desc;
--Tìm khách hàng có tổng chi tiêu cao nhất (dùng Subquery với MAX)
select c.name , sum(o.total_amount) as tong
from customer c
join orders o on c.id = o.customer_id
group by c.name
having sum(o.total_amount) = (
	select max(tong)
	from (
		select sum(total_amount) as tong
		from orders
		group by customer_id
	) a
);
--Liệt kê khách hàng chưa từng mua hàng (LEFT JOIN + IS NULL)
select *
from customer c
left join orders o on c.id = o.customer_id
where o.id is null;
--Hiển thị khách hàng có tổng chi tiêu > trung bình của toàn bộ khách hàng (dùng Subquery trong HAVING)
select c.name , sum(o.total_amount) as tong
from customer c
join orders o on c.id = o.customer_id
group by c.name
having sum(o.total_amount) > (
	select avg(tong)
	from (
		select sum(total_amount) as tong
		from orders
		group by customer_id
	) a
);