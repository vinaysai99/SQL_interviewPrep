/*
Write two SQL queries to do the following:

Add a record: Write an INSERT statement to add 'Vinay Sai Reddy Mandala' into the ecommerce.customers table, 
along with an email address of your choice.

Retrieve the record: Write a SELECT statement to pull only your specific row from the ecommerce.customers table 
to prove the insert was successful. (Hint: you will need to use a WHERE clause).
*/

insert into customers(name,email)
values ('Vinay Sai Reddy Mandala','vinay@gmail.com');

select * from customers
where name='Vinay Sai Reddy Mandala';

/*
Challenge 1: The Inflation Update
Management realized we are undercharging for our workout gear. 
Write an UPDATE statement to increase the price of all products in the 'Fitness' category by 15%, 
but only if the product is currently active (is_active = TRUE).

Challenge 2: The Relational Deletion
Order #20 (placed by Rachel Green) was cancelled. For privacy compliance, 
the business wants order #20 completely scrubbed from the database.
Write the DELETE statement(s) to remove Order #20.
Hint: Remember your Foreign Keys! If you try to just DELETE FROM ecommerce.orders WHERE order_id = 20, 
the database is going to yell at you. Think about the order of operations needed to remove a record that is linked to other tables.
*/


update ecommerce.products 
set price = price*1.15
where category = 'Fitness' and is_active = true;

select * from ecommerce.products
where category = 'Fitness' and is_active = true;

delete from order_items
where order_id = 20;

delete from orders
where order_id = 20;

