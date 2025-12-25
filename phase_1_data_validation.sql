--- table 

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;  



--- phase 1 DATA VALIDATION
--count
SELECT count(*) FROM customers;

SELECT count(*) FROM products;

SELECT count(*) FROM orders;

SELECT count(*) FROM order_items;

SELECT count(*) FROM payment;

-- Check if any orders exist without order items

select order_id from orders o1  where not exists (select order_id from order_items o2 where o1.order_id = o2.order_id )

--Check if any payments exist without orders

select order_id from payment p where not exists(select 1 from orders o where p.order_id = o.order_id )

--Verify if order total ≠ payment value for any order

SELECT 
    o.order_id,
    SUM(oi.quantity * p.price) AS order_total,
    pay.payment_value
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON oi.product_id = p.product_id
JOIN payment pay 
    ON o.order_id = pay.order_id
GROUP BY 
    o.order_id, 
    pay.payment_value
HAVING 
    SUM(oi.quantity * p.price) <> pay.payment_value;