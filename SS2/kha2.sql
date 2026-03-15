create database UniversityDB;

create schema university;

create table university.students (
	student_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birth_date date,
	email text not null unique
);

create table university.courses (
	course_id serial primary key,
	course_name varchar(100) not null,
	credit int
);

create table university.Enrollments (
	enrollment_id serial primary key,
	student_id int references university.students(student_id),
	course_id int references university.courses(course_id),
	enroll_date date
	unique (student_id, course_id)
);

select * from pg_database;
select datname from pg_database;

select schema_name from information_schema.schemata;
-- hoặc \dn trong psql

Select * from information_schema.columns
where table_name = 'students';

Select * from information_schema.columns
where table_name = 'courses';

Select * from information_schema.columns
where table_name = 'enrollments';

