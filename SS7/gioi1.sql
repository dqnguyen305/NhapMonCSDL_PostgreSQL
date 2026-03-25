create table post (
    post_id serial primary key,
    user_id int not null,
    content text,
    tags text[],
    created_at timestamp default current_timestamp,
    is_public boolean default true
);

create table post_like (
    user_id int not null,
    post_id int not null,
    liked_at timestamp default current_timestamp,
    primary key (user_id, post_id)
);

insert into post (user_id, content, tags, is_public) values
(101, 'hôm nay trời đẹp quá!', '{"du lich", "thoi tiet"}', true),
(102, 'học sql thật thú vị', '{"lap trinh", "sql"}', true),
(101, 'bài viết riêng tư', '{"ca nhan"}', false);

insert into post_like (user_id, post_id) values
(201, 1),
(202, 1),
(201, 2);

create index idx_post_content on post (LOWER(content));

explain analyze
select * from post
where is_public = true and content ilike '%du lich%';

create index idx_post_tags_gin on post using gin (tags);

explain analyze
select * from post where tags @> array['travel'];

create index idx_post_recent_public 
on post (created_at desc) 
where is_public = true;

explain analyze
select * from post
where is_public = true and created_at >= now() - interval '7 days';


create index idx_post_user_recent 
on post (user_id, created_at desc);

explain analyze
select * from post
where user_id = 101
order by created_at desc
limit 5;