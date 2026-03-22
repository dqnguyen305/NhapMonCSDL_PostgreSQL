create table customer (
	id serial primary key,
	name varchar(100),
	email varchar(100),
	phone varchar(20),
	points int
);

--Thêm 7 khách hàng (trong đó có 1 người không có email)
insert into customer (name, email, phone, points) values
('Nguyễn Văn A', 'a@gmail.com', '0901234567', 100),
('Trần Thị B', 'b@gmail.com', '0912345678', 200),
('Lê Văn C', NULL, '0923456789', 150),
('Phạm Thị D', 'd@gmail.com', '0934567890', 300),
('Hoàng Văn E', 'e@gmail.com', '0945678901', 250),
('Đỗ Thị F', 'f@gmail.com', '0956789012', 180),
('Nguyễn Văn A', 'a2@gmail.com', '0967890123', 100); 
--Truy vấn danh sách tên khách hàng duy nhất (DISTINCT)
select distinct name from customer;
--Tìm các khách hàng chưa có email (IS NULL)
select * from customer
where email is null;
--Hiển thị 3 khách hàng có điểm thưởng cao nhất, bỏ qua khách hàng cao điểm nhất (gợi ý: dùng OFFSET)
select name from customer
order by points desc
limit 3 offset 1;
--Sắp xếp danh sách khách hàng theo tên giảm dần
select * from customer
order by name;