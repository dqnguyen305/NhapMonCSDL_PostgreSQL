create database LibraryDB;

create schema library;

Create table library.Books (
	book_id serial primary key,
	title varchar(100) not null,
	author varchar(50) not null,
	published_year int,
	available boolean default true
);

Create table library.Members (
	member_id int primary key,
	name varchar(50),
	email text unique,
	join_date date default CURRENT_DATE
);

create schema sales;

create table sales.products (
    product_id serial primary key,
    product_name varchar(255),
    price numeric(10,2),
    stock_quantity int
);

create table sales.orders (
    order_id serial primary key,
    order_date date default current_date,
    member_id int references library.members(member_id)
);

create table sales.orderdetails (
    order_detail_id serial primary key,
    order_id int references sales.orders(order_id),
    product_id int references sales.products(product_id),
    quantity int
);

alter table library.books
add column genre varchar(100);

alter table library.books
rename column available to is_available;

alter table library.members
drop column email;

drop table sales.orderdetails;

