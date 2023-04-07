create table customers
(
	customer_id varchar(5) primary key,
	company_name varchar(40) not null,
	contact_name varchar(40) not null
);

create table employees
(
	employee_id int primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	title varchar(40) not null,
	birth_date date not null,
	notes text not null
);

create table orders
(
	order_id int primary key,
	customer_id varchar(5) references customers(customer_id) not null,
	employee_id int references employees(employee_id) not null,
	order_date date not null,
	ship_city varchar(20) not null
);