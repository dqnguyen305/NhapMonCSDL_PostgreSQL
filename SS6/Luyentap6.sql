create table orders (
    id serial primary key,
    customer_id int,
    order_date date,
    total_amount numeric(10,2)
);

insert into orders (customer_id, order_date, total_amount) values
(1, '2023-05-10', 15000000),
(2, '2023-08-15', 40000000),
(3, '2024-01-20', 25000000),
(1, '2024-03-12', 35000000),
(4, '2025-02-05', 10000000),
(2, '2024-12-25', 5000000);

--Hiển thị tổng doanh thu, số đơn hàng, giá trị trung bình mỗi đơn (dùng SUM, COUNT, AVG) - Đặt bí danh cột lần lượt là total_revenue, total_orders, average_order_value
select Sum(total_amount) as "total_revenue",
		Count(id) as " total_orders",
		Avg(total_amount) as average_order_value
from orders;
--Nhóm dữ liệu theo năm đặt hàng, hiển thị doanh thu từng năm (GROUP BY EXTRACT(YEAR FROM order_date))
select extract(year from order_date), sum(total_amount) as total_revenue
from orders
group by extract(year from order_date);
--Chỉ hiển thị các năm có doanh thu trên 50 triệu (HAVING)
select extract(year from order_date), sum(total_amount) as total_revenue
from orders
group by extract(year from order_date)
having sum(total_amount) > 50000000;
--Hiển thị 5 đơn hàng có giá trị cao nhất (dùng ORDER BY + LIMIT)
select * from orders
order by total_amount desc
Limit 5;