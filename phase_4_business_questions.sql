--- tables  

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;   
	  --- phase 4

	--Total Quantity Sold per Product

	select p.product_id, p.product_name ,
	 sum(oi.quantity) as total_quantity
	  from products p
	   join order_items oi on 
	     p.product_id =oi.product_id
       group by
	     p.product_id,
		  p.product_name
	   order by total_quantity desc


 --Top-Selling Products by Revenue

SELECT TOP 1
    c.customer_id,
    c.customer_name,
    o.order_id,
    SUM(oi.quantity * p.price) AS order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name,
    o.order_id
ORDER BY order_value DESC;

    
	
--Products Never Sold


	select p.product_id, p.product_name 
	  from products p where  not exists (select 1 from order_items oi where   p.product_id = oi.product_id  )