CREATE TABLE departments (
    dept_no varchar(30)   NOT NULL Primary Key,
    dept_name varchar(30)   NOT NULL
	
);

CREATE TABLE titles (
    title_id varchar(30) primary key  NOT NULL,
    title VARCHAR(30)   NOT NULL
);

CREATE TABLE employees (
    emp_no int primary key  NOT NULL,
    emp_title_id varchar(30)   NOT NULL,
    birth_date varchar(30)   NOT NULL,
    first_name varchar(30)   NOT NULL,
    last_name varchar(30)   NOT NULL,
    sex varchar(5)   NOT NULL,
    hire_date varchar(30)   NOT NULL,
	foreign key (emp_title_id) references titles (title_id)
);

CREATE TABLE dept_emp_junction (
    emp_no int   NOT NULL,
    dept_no varchar(30)   NOT NULL,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no),
	primary key (dept_no, emp_no)
);

CREATE TABLE dept_manager_junction (
    dept_no varchar(30)   NOT NULL,
    emp_no int  NOT NULL,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees (emp_no),
	primary key (dept_no, emp_no)
);


CREATE TABLE salaries (
    emp_no int Primary key NOT NULL,
    salary int  NOT NULL,
	foreign key (emp_no) references employees(emp_no)
);

--DATA ANALYSIS 
--1. List employee salaries 
select 
	e.emp_no as "employee number"
	, e.last_name as "last name"
	, e.first_name as "first name"
	, e.sex as "gender"
	, s.salary
from employees as e
    inner join salaries as s on
    e.emp_no=s.emp_no;

--2. List employees with a 1986 hire date
select 
	first_name as "first name"
	, last_name as "last name"
	, hire_date as "hire date"
from employees 
	where hire_date like '%1986'

--3. List manager of each dept
select 
	d.dept_name as "dept name"
	, m.dept_no as "dept number"
	, e.emp_no as "emplyee number"
	, e.last_name as "last name"
	, e.first_name as "first name"
from employees as e 
	inner join dept_manager_junction m on e.emp_no=m.emp_no
	inner join departments d on m.dept_no=d.dept_no

order by "dept number" asc

--4. Dept employees
select 
	d.dept_no as "dept number"
	, e.emp_no as "employee number"
	,e.last_name as "last name"
	, e.first_name as "first name"
	, n.dept_name as "dept name"
from employees as e 
	inner join dept_emp_junction d on e.emp_no=d.emp_no
	inner join departments n on d.dept_no=n.dept_no
	
order by "dept number" asc

--5. Employees named Hercules B
select 
	first_name as "first name"
	, last_name as "last name"
	, sex as "gender"
from employees
where first_name = 'Hercules' and last_name like 'B%'

order by "last name" asc

--6. Sales dept employees
select 
	n.dept_name as "dept name"
	, e.emp_no as "employee number"
	, e.last_name as "last name"
	,e.first_name as "first name"

from employees as e 
	inner join dept_emp_junction d on e.emp_no=d.emp_no
	inner join departments n on n.dept_no=d.dept_no
		where dept_name = 'Sales'
		
order by "employee number" asc

--7. Sales and Development employees
select 
	e.emp_no as "employee number"
	, e.last_name as "last name"
	, e.first_name as "first name"
	, n.dept_name as "dept name"

from employees as e 
	inner join dept_emp_junction d on e.emp_no=d.emp_no
	inner join departments n on n.dept_no=d.dept_no
		where dept_name in ('Sales','Development')
		
order by "employee number" asc

--8. Shared last name employees
select 
	last_name
	, count(last_name)
from employees 
	group by last_name

order by count(last_name) desc

