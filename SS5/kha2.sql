--Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders

select p.product_id,p.product_name, SUM(o.total_price) total_revenue
from products p
join orders o on p.product_id = o.product_id
group by p.product_name, p.product_id
having SUM(o.total_price) = (
	select max(tong)
	from (
		select SUM(total_price) tong
		from orders
		group by product_id
	) a
);

--Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
select p.category, SUM(o.total_price) total_revenue
from products p
join orders o on p.product_id = o.product_id
group by p.category;

--Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
select distinct p.category
from products p
join orders o on p.product_id = o.product_id
group by p.product_id, p.category
having SUM(o.total_price) = (
	select max(tong)
	from (
		select SUM(total_price) tong
		from orders
		group by product_id
	) a
)
intersect
select p.category
from products p
join orders o on p.product_id = o.product_id
group by p.category
having SUM(o.total_price) > 3000;
