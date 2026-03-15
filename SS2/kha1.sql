-- Chú thích
/*  abc
	abc
*/

create database LibraryDB;

create schema library;

Create table library.Books (
	book_id serial primary key,
	title varchar(100) not null,
	author varchar(50) not null,
	published_year int,
	price real
);

select * from pg_database;
select datname from pg_database;

select schema_name from information_schema.schemata;
-- hoặc \dn trong psql

Select * from information_schema.columns
where table_name = 'books';

Select column_name, data_type from information_schema.columns
where table_name = 'books';
-- \d library.books