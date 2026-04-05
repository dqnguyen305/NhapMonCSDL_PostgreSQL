create table employees (
    emp_id serial primary key,
    name varchar(50),
    position varchar(50)
);

create table employee_log (
    log_id serial primary key,
    emp_name varchar(50),
    action_time timestamp
);

create or replace function f_log_emp_update()
returns trigger as $$
begin
    insert into employee_log (emp_name, action_time)
    values (old.name, now());
    return new;
end;
$$ language plpgsql;

create trigger trg_emp_update
after update on employees
for each row
execute function f_log_emp_update();

insert into employees (name, position) 
values ('nguyen van a', 'dev');

update employees 
set position = 'senior dev' 
where name = 'nguyen van a';

select * from employees;
select * from employee_log;