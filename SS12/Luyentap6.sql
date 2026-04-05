create table accounts (
    account_id serial primary key,
    account_name varchar(50),
    balance numeric
);

insert into accounts (account_name, balance)
values ('nguyen van a', 1000), ('tran thi b', 500);

-- Commit
begin;

update accounts 
set balance = balance - 200 
where account_id = 1 and balance >= 200;

update accounts 
set balance = balance + 200 
where account_id = 2;

commit;

select * from accounts;

--Rollback
begin;

update accounts 
set balance = balance - 2000 
where account_id = 1 and balance >= 2000;

rollback;

select * from accounts;