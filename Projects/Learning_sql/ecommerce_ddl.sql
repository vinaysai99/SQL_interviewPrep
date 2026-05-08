/*
Write a SQL query to create a new table called product_companies inside your ecommerce schema. Please include the following specifications:

A company_id that acts as the primary key and automatically increments.

A company_name that can hold up to 150 characters and cannot be left blank.

A contact_email that cannot be left blank and must be unique across all companies.

A country column that defaults to 'USA' if no other country is provided.
*/

create table product_companies(
	company_id serial primary key,
	company_name varchar(150) not null,
	contact_email varchar(150) unique not null,
	country varchar(150) default 'USA'
);

/*
Write a SQL query (or multiple queries) to do the following:

Add a new column to the product_companies table called established_year which should be an integer.

Modify the existing company_name column so that it can hold up to 250 characters instead of just 150.
*/

alter table ecommerce.product_companies add column established_year int;

alter table ecommerce.product_companies alter column company_name type varchar(250);

/*
Write a SQL query (or two queries) to do the following:

Remove the column established_year from the product_companies table (maybe we realized we don't actually need it).

Delete the entire product_companies table from the database completely.
*/

alter table product_companies drop column established_year;

drop table product_companies;