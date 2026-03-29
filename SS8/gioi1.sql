create table employees (
    emp_id serial primary key,
    emp_name varchar(100),
    job_level int,
    salary numeric
);

insert into employees (emp_name, job_level, salary) values
('nguyễn văn an', 1, 10000000),
('trần thị bình', 1, 12000000),
('lê văn cường', 2, 18000000),
('phạm minh đức', 2, 20000000),
('ngô thanh hà', 3, 30000000),
('đỗ hoàng yến', 3, 35000000),
('vũ quang huy', 1, 11000000),
('bùi tú anh', 2, 19000000),
('đặng hồng liên', 3, 32000000),
('lý gia bảo', 1, 10500000);

create or replace procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC)
language plpgsql
as $$
declare lv int; s numeric;
begin
	select job_level, salary into lv,s
	from employees
	where emp_id = p_emp_id;

	if not found then
		raise exception 'Khong co du lieu';
	end if;
	if lv = 1 then
		p_new_salary := s *1.05;
	elsif lv = 2 then
		p_new_salary := s *1.1;
	else 
		p_new_salary := s *1.15;
	end if;

	update employees
	set salary = p_new_salary
	where emp_id = p_emp_id;
end;
$$;

do $$
declare
    v_salary_after numeric;
begin
    call adjust_salary(3, v_salary_after);
    raise notice 'lương mới sau khi cập nhật là: %', v_salary_after;
end;
$$;