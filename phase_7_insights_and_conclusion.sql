--- tables  

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;


--- PHASE 7: REPORTING & OPTIMIZATION

--Create Analytical Views (Reporting Layer)
CREATE VIEW daily_revenue AS
SELECT
    CAST(o.order_date AS DATE) AS order_date,
    SUM(p.payment_value) AS daily_revenue
FROM orders o
JOIN payment p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Success'
GROUP BY CAST(o.order_date AS DATE);



--Final Business Summary Query

SELECT
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT SUM(payment_value) 
     FROM payment 
     WHERE payment_status = 'Success') AS total_revenue;
