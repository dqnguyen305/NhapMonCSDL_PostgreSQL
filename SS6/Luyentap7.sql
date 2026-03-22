create table department (
    id serial primary key,
    name varchar(50)
);

create table employee (
    id serial primary key,
    full_name varchar(100),
    department_id int,
    salary numeric(10,2)
);


insert into department (name) values 
('hành chính'),
('kỹ thuật'),
('kinh doanh'),
('marketing');

insert into employee (full_name, department_id, salary) values
('nguyễn văn a', 1, 15000000),
('trần thị b', 2, 25000000),
('lê văn c', 2, 22000000),
('phạm minh d', 3, 18000000),
('hoàng thị e', 4, 20000000),
('ngô văn f', 3, 17500000);

select * from department;
select * from employee;

--Liệt kê danh sách nhân viên cùng tên phòng ban của họ (INNER JOIN)
select e.full_name, d.name
from employee e 
join department d on e.department_id = d.id;
--Tính lương trung bình của từng phòng ban, hiển thị:
select d.name, round(avg(salary),2) avg_salary
from employee e 
join department d on e.department_id = d.id
group by d.name;

--Hiển thị các phòng ban có lương trung bình > 10 triệu (HAVING)
select d.name, round(avg(salary),2) avg_salary
from employee e 
join department d on e.department_id = d.id
group by d.name
having round(avg(salary),2) > 10000000;
--Liệt kê phòng ban không có nhân viên nào (LEFT JOIN + WHERE employee.id IS NULL)
select d.name
from employee e 
left join department d on e.department_id = d.id
where e.id is null
