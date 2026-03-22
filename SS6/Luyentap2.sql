create table Employee (
	id serial primary key,
	full_name varchar(100),
	department varchar(50),
	salary numeric(10,2),
	hire_date date
);

--Thêm 6 nhân viên mới
insert into employee (full_name, department, salary,hire_date) values
('Nguyễn Văn An', 'IT', 8000000, '2023-02-15'),
('Trần Thị Bình', 'HR', 7000000, '2023-03-10'),
('Lê Văn Cường', 'IT', 9000000, '2023-05-20'),
('Phạm Thị An', 'Marketing', 6000000, '2023-07-01'),
('Hoàng Văn Nam', 'IT', 10000000, '2022-12-25'),
('Đỗ Anh Tuấn', 'Sales', 5500000, '2023-09-12');
--Cập nhật mức lương tăng 10% cho nhân viên thuộc phòng IT
update employee 
set salary = salary * 1.1
where department = 'IT';
--Xóa nhân viên có mức lương dưới 6,000,000
delete from employee
where salary < 6000000;
--Liệt kê các nhân viên có tên chứa chữ “An” (không phân biệt hoa thường)
select * from employee
where full_name ilike '%An%';
--Hiển thị các nhân viên có ngày vào làm việc trong khoảng từ '2023-01-01' đến '2023-12-31'
select * from employee
where hire_date between '2023-01-01' and '2023-12-31';