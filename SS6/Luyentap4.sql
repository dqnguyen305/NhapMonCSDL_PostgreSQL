create table orderinfo (
    id serial primary key,
    customer_id int,
    order_date date,
    total numeric(10,2),
    status varchar(20)
);

--Thêm 5 đơn hàng mẫu với tổng tiền khác nhau
insert into orderinfo (customer_id, order_date, total, status) values
(1, '2024-10-01', 300000, 'pending'),
(2, '2024-10-05', 600000, 'completed'),
(3, '2024-10-10', 800000, 'cancelled'),
(1, '2024-09-25', 450000, 'completed'),
(2, '2024-10-20', 1000000, 'pending');

-- Truy vấn các đơn hàng có tổng tiền lớn hơn 500,000
select *
from orderinfo
where total > 500000;

-- Truy vấn các đơn hàng có ngày đặt trong tháng 10 năm 2024
select *
from orderinfo
where order_date between '2024-10-01' and '2024-10-31';

-- Liệt kê các đơn hàng có trạng thái khác “Completed”
select *
from orderinfo
where status <> 'completed';

-- Lấy 2 đơn mới nhất
select *
from orderinfo
order by order_date desc
limit 2;