--- tables  

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;



--- phase 2 BASIC BUSINESS QUESTIONS


	--Total number of orders

	select count (*) as total_orders from orders

	-- total number of customer 

	select count (*) as total_customers from customers

	-- Total Revenue

	select sum (payment_value) as revenue from payment where payment_status = 'success'

	--- Number of Cancelled Orders
	 
	 select count(order_status) as cancelled_orders from orders where order_status = 'cancelled'

	 --- Average Order Value

	 SELECT avg(payment_value)as average_value FROM payment where payment_status ='success'

	--- Highest Order Value

	
	select max(payment_value) as max_value from payment 

	---Lowest Order 

	
	select min(payment_value) as min_value from payment 

	---Successful vs Failed Payments

	select count(*), payment_status from payment group by payment_status 

	--- Orders with No Payment

	select order_id from orders o where exists (select order_id from payment p where o.order_id = p.order_id)

	---Revenue Contribution %

SELECT order_id,payment_value,
    (payment_value * 100.0) / 
    (SELECT SUM(payment_value) FROM payment WHERE payment_status = 'Success')
        AS revenue_percentage
FROM payment
WHERE payment_status = 'Success';