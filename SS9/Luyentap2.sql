create table users (
    user_id serial primary key,
    email varchar(150) unique,
    username varchar(100)
);

insert into users (email, username) values
('example@example.com', 'user_test'),
('admin@website.com', 'admin_boss'),
('contact@service.vn', 'support_team');

insert into users (email, username)
select 
    'user' || i || '@example.com', 
    'display_name_' || i
from generate_series(1, 1000) as i;

create index idx_users_email_hash on users using hash (email);

explain select * from users where email = 'example@example.com';

-- chuyển sang index scan tốc độ truy vấn nhanh kich thước nhỏ nhưng chỉ hỗ trợ cho =

