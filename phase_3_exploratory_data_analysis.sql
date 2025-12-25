--- tables  

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;

---phase 3 CUSTOMER ANALYSIS

 -- Customers who placed more than one order
 SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;


-- Customers who placed ONLY ONE order
 
 select customer_id , count(order_id) as onlyoneorder from orders group by customer_id having  count(order_id) =1

 --Top 5 Customers by Total Spending

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.payment_value) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payment p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Success'
GROUP BY 
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--Customers Who Never Placed an Order

select customer_id, customer_name from customers c where not exists (select 1 from orders o where c.customer_id <> o.customer_id ) 

--City-wise Customer Count
SELECT  state, COUNT(customer_id) AS customer_count
FROM customers
GROUP BY state;


--City-wise Revenue

SELECT 
    c.city,
    SUM(p.payment_value) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payment p
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Success'
GROUP BY c.city;


--Average Spend per Customer

select c.customer_id ,c.customer_name , avg(p.payment_value)as average_spend from customers  c
 join orders o
   on 
     c. customer_id = o.customer_id
  join payment p 
  on
   p.order_id = o.order_id

   where p.payment_status = 'Success'
   group by 
    c.customer_id ,c.customer_name 

--Repeat Customer Rate
SELECT 
    CAST(COUNT(DISTINCT CASE 
            WHEN order_count > 1 THEN customer_id 
        END) AS FLOAT) * 100
    / COUNT(DISTINCT customer_id) AS repeat_customer_rate
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t;

--How many customers placed more than one order



  SELECT COUNT(*) AS repeat_customer_count
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) t;

---Customers with Failed Payments

 select c.customer_id,c.customer_name ,p.payment_status
  from customers c 
   join orders o 
   on c.customer_id = o.customer_id
   join payment p
    on p.order_id =o.order_id
	where p.payment_status = 'failed'
	

--First-time vs Returning Customers

select customer_id,   
 case 
  when count(order_id) = 1 then 'customer_ordered_onetime'

  else 'customer_ordered_morethan_onetime'

  end as customer_order
  from orders
  group by customer_id

  -- Customer with the Highest Single Order Value

  select c.customer_id,c. customer_name ,o.order_id ,
    sum (oi.quantity * po.price) as order_value
	from customers c 
	join 
	 orders o on
	  c.customer_id = o.customer_id
    join
	 order_items oi on 
	 o.order_id =oi.order_id 
	 join 
	 products po on
	  oi.product_id = po .product_id
	  group by
	  c.customer_id,
	  c. customer_name ,
	  o.order_id
	  order by  order_value desc