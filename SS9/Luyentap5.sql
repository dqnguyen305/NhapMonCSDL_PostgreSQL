create table sales (
    sale_id serial primary key,
    customer_id int,
    amount numeric,
    sale_date date
);

insert into sales (customer_id, amount, sale_date) values
(1, 150000, '2026-03-01'),
(2, 200000, '2026-03-05'),
(3, 350000, '2026-03-10'),
(1, 100000, '2026-03-15'),
(2, 500000, '2026-03-25');

create or replace procedure calculate_total_sales(
    p_start_date date, 
    p_end_date date, 
    out p_total numeric
)
language plpgsql
as $$
begin
	select sum(amount) into p_total
    from sales
    where sale_date between p_start_date and p_end_date;

	p_total := coalesce(p_total, 0);
    
    raise notice 'tong doanh thu tu % den % la: %', p_start_date, p_end_date, p_total;
end;
$$;

do $$
declare
    v_total_revenue numeric;
begin
    call calculate_total_sales('2026-03-01', '2026-03-31', v_total_revenue);
    
    raise notice 'ket qua tra ve: %', v_total_revenue;
end;
$$;
