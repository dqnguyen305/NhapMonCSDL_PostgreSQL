create table course (
    id serial primary key,
    title varchar(100),
    instructor varchar(50),
    price numeric(10,2),
    duration int 
);

-- 1. thêm ít nhất 6 khóa học mẫu vào bảng
insert into course (title, instructor, price, duration) values
('lập trình python cơ bản', 'nguyễn văn a', 450000, 25),
('sql cho người mới bắt đầu', 'trần thị b', 600000, 35),
('web design demo', 'lê văn c', 300000, 15),
('khóa học sql nâng cao', 'phạm minh d', 1200000, 45),
('data analysis với excel', 'hoàng thị e', 850000, 40),
('project demo app', 'ngô văn f', 200000, 10);

-- 2. cập nhật giá tăng 15% cho các khóa học có thời lượng trên 30 giờ
update course
set price = price * 1.15
where duration > 30;

-- 3. xóa khóa học có tên chứa từ khóa “demo”
delete from course
where title ilike '%demo%';

-- 4. hiển thị các khóa học có tên chứa từ “sql” (không phân biệt hoa thường)
select *
from course
where title ilike '%sql%';

-- 5. lấy 3 khóa học có giá nằm giữa 500,000 và 2,000,000, sắp xếp theo giá giảm dần
select *
from course
where price between 500000 and 2000000
order by price desc
limit 3;