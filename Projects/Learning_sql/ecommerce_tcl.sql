/*
Let's simulate a catastrophic error and use TCL to save your job. Imagine your boss asks you to delete a single customer, but you forget the WHERE clause.

Write a sequence of SQL commands to do the following:

Start a draft session (tell the database you are beginning a transaction).

Make the mistake: Write a query to delete every single row from the ecommerce.order_items table.

Save the day: Write the command to undo that massive mistake so your order_items are brought back.
 */

begin transaction;

delete from ecommerce.order_items where item_id>0;

rollback;


/*
Write a script with the following sequence:

Start a transaction draft.

INSERT a new row into ecommerce.orders for Alice (customer_id 1, total_amount 150.00, status 'pending').

Create a SAVEPOINT named order_created.

INSERT a new row into ecommerce.order_items (linking the order you just made to product_id 5, quantity 1, unit_price 150.00).

Make it permanent: Assume everything went perfectly, and write the command to save the entire transaction to the database permanently.  
*/

begin transaction;

insert into ecommerce.orders (customer_id,total_amount ,status)
values (1,150.00,'pending');

savepoint order_created;

insert into ecommerce.order_items (order_id,product_id,quantity, unit_price)
values (27,5,1,150.00);

commit;