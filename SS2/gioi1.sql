create database salesdb;

create schema sales;

create table sales.customers (
	customer_id serial primary key,
	fist_name varchar(50) not null,
	last_name varchar(50) not null,
	email text not null unique,
	phone text
);

create table sales.products (
	product_id serial primary key,
	product_name varchar(50) not null,
	price real not null,
	stock_quantity int not null
);

create table sales.orders (
	order_id serial primary key,
	customer_id int references sales.customers(customer_id),
	order_date date not null
);

create table sales.orderitems (
	order_item_id serial primary key,
	order_id int references sales.orders(order_id),
	product_id int references sales.products(product_id),
	quantity int check (quantity > 0),
	unique (order_id, product_id)
);