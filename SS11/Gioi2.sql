create table accounts (
    account_id serial primary key,
    customer_name varchar(100),
    balance numeric(12,2)
);

create table transactions (
    trans_id serial primary key,
    account_id int references accounts(account_id),
    amount numeric(12,2),
    trans_type varchar(20),
    created_at timestamp default now()
);

insert into accounts (customer_name, balance) 
values ('nguyen van a', 1000.00);


--Viết Transaction thực hiện rút tiền
begin;

update accounts 
set balance = balance - 200.00 
where account_id = 1;

insert into transactions (account_id, amount, trans_type) 
values (1, 200.00, 'withdraw');

commit;

select * from accounts;
select * from transactions;

--Mô phỏng lỗi

begin;

update accounts 
set balance = balance - 500.00 
where account_id = 1;

insert into transactions (account_id, amount, trans_type) 
values (999, 500.00, 'withdraw');

rollback;

select * from accounts;
select * from transactions;

select 
    a.customer_name, 
    a.balance as current_balance,
    (select sum(amount) from transactions t where t.account_id = a.account_id and t.trans_type = 'withdraw') as total_withdrawn
from accounts a;