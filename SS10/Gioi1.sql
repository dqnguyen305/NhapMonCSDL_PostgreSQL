create table employees (
	 id serial primary key, 
	 name varchar(100) not null, 
	 position varchar(50) not null, 
	 salary numeric(10,2) not null
);

create table employees_log(
	log_id serial primary key,
	employee_id int,
	operation varchar(10) check (operation in('INSERT','UPDATE','DELETE')),
	old_data jsonb,
	new_data jsonb,
	change_time timestamp default current_timestamp
);

create or replace function check_log()
returns trigger as $$
begin
	if (TG_OP = 'INSERT') then
		insert into employees_log (employee_id, operation, new_data, change_time ) values
		(new.id, TG_OP, to_jsonb(new),current_timestamp);
	elsif (TG_OP = 'UPDATE') then
		insert into employees_log (employee_id, operation, old_data, new_data, change_time ) values
		(new.id, TG_OP,to_jsonb(old), to_jsonb(new),current_timestamp);
	elsif (TG_OP = 'DELETE') then
		insert into employees_log (employee_id, operation, old_data, new_data, change_time ) values
		(new.id, TG_OP,to_jsonb(old), to_jsonb(new),current_timestamp);
	end if;

	if (TG_OP = 'DELETE') then return old; end if;
	return new;
	
end;
$$ language plpgsql;

create or replace trigger trg_check_log
after insert or update or delete on employees
for each row
execute function check_log();

insert into employees (name, position, salary) values
('Dinh Quoc Nguyen', 'Frontend Developer', 15000000);
update employees set salary = 0 where id = 1;
delete from employees where id =1;
select * from employees_log;
