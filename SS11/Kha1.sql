create table flights (
    flight_id serial primary key,
    flight_name varchar(100),
    available_seats int
);

create table bookings (
    booking_id serial primary key,
    flight_id int references flights(flight_id),
    customer_name varchar(100)
);

insert into flights (flight_name, available_seats)
values ('vn123', 3), ('vn456', 2);
drop table flights
-- Tạo Transaction đặt vé thành công
begin;

update flights 
set available_seats = available_seats - 1 
where flight_name = 'vn123';

insert into bookings (flight_id, customer_name) 
values (1, 'nguyen van a');

commit;

select * from flights;
select * from bookings;

-- Mô phỏng lỗi và Rollback
begin;

update flights 
set available_seats = available_seats - 1 
where flight_name = 'vn123';

insert into bookings (flight_id, customer_name) 
values (999, 'nguyen van a');

rollback;

select * from flights;
select * from bookings;