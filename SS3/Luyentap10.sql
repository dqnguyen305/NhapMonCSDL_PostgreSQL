create database companydb;

create schema company;

create table company.departments (
    department_id serial primary key,
    department_name varchar(100)
);

create table company.employees (
    emp_id serial primary key,
    name varchar(100),
    dob date,
    department_id int references company.departments(department_id)
);

create table company.projects (
    project_id serial primary key,
    project_name varchar(100),
    start_date date,
    end_date date
);

create table company.employeeprojects (
    emp_id int references company.employees(emp_id),
    project_id int references company.projects(project_id),
    primary key (emp_id, project_id)
);