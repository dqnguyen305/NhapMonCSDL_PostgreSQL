create table accounts (
	account_id serial primary key,
	owner_name varchar(100),
	balance numeric(10,2)
);
insert into accounts ( owner_name, balance) values
('A', 500.00), ('B', 300.00);

--Thực hiện giao dịch chuyển tiền hợp lệ

begin;
	update accounts set balance = balance - 100
	where account_id =1;
	update accounts set balance = balance + 100
	where account_id =2;

commit;
select * from accounts;

-- Thử mô phỏng lỗi và Rollback

begin;
	update accounts set balance = balance - 100
	where account_id =1;
	update accounts set balance = balance + 100
	where account_id =4; ----///

rollback;
select * from accounts;
