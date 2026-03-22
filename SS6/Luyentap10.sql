create table oldcustomers (
    id serial primary key,
    name varchar(100),
    city varchar(50)
);

create table newcustomers (
    id serial primary key,
    name varchar(100),
    city varchar(50)
);

-- thêm dữ liệu mẫu (có khách hàng trùng lặp để test intersect)
insert into oldcustomers (name, city) values
('nguyễn văn a', 'hà nội'),
('trần thị b', 'tp hcm'),
('lê văn c', 'đà nẵng');

insert into newcustomers (name, city) values
('trần thị b', 'tp hcm'), -- trùng với bảng cũ
('phạm minh d', 'hà nội'),
('hoàng thị e', 'hà nội');

-- lấy danh sách tất cả khách hàng (cũ + mới) không trùng lặp (union)
select name, city from oldcustomers
union
select name, city from newcustomers;

-- tìm khách hàng vừa thuộc bảng oldcustomers vừa thuộc bảng newcustomers (intersect)
select name, city from oldcustomers
intersect
select name, city from newcustomers;

-- tính số lượng khách hàng ở từng thành phố (gộp cả 2 bảng trước khi đếm)
select city, count(*) as so_luong
from (
    select name, city from oldcustomers
    union all 
    select name, city from newcustomers
) as tat_ca_khach
group by city;

-- tìm thành phố có nhiều khách hàng nhất (dùng subquery và max)
select city, count(*) so_khach
from (
	select name, city from oldcustomers
    union 
    select name, city from newcustomers) a
group by city
having count(*) = (
	select max(tong)
	from (
		select count(*) tong
		from (
			select name, city from oldcustomers
		    union all 
		    select name, city from newcustomers
		) a
		group by city
	) b
);