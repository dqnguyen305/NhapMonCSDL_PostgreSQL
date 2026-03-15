create database schooldb;

create schema school;

create table school.students (
    student_id serial primary key,
    name varchar(100),
    dob date
);

create table school.courses (
    course_id serial primary key,
    course_name varchar(100),
    credits int
);

create table school.enrollments (
    enrollment_id serial primary key,
    student_id int references school.students(student_id),
    course_id int references school.courses(course_id),
    grade char(1) check (grade in ('A','B','C','D','F'))
);