--- tables  

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;

--- PHASE 6: TIME-BASED ANALYSIS 

--Daily Revenue
   SELECT CAST(o.order_date AS DATE) AS order_date,
    SUM(p.payment_value) AS daily_revenue
FROM orders o
JOIN payment p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Success'
GROUP BY CAST(o.order_date AS DATE)
ORDER BY order_date;
