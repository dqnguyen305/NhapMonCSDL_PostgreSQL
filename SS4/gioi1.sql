CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    birth_year INT,
    major VARCHAR(50),
    gpa DECIMAL(3,1)
);

INSERT INTO students (full_name, gender, birth_year, major, gpa) VALUES
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
('Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
('Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Lưu Đức Tài', 'Nam', 2004, 'Cơ khí', NULL),
('Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

-- chèn dữ liệu mới
insert into students (full_name, gender, birth_year, major, gpa)
values ('Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- cập nhật dữ liệu
update students
set gpa = 3.4
where full_name = 'Lê Quốc Cường';

-- xóa dữ liệu
delete from students
where gpa is null;

-- truy vấn cơ bản
select *
from students
where major = 'CNTT' and gpa >= 3.0
limit 3;

-- loại bỏ trùng lặp
select distinct major
from students;

-- sắp xếp
select *
from students
where major = 'CNTT'
order by gpa desc, full_name asc;

-- tìm kiếm
select *
from students
where full_name like 'Nguyễn%';

-- khoảng giá trị
select *
from students
where birth_year between 2001 and 2003;