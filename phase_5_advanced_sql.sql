--- tables  

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;


---PHASE 5: PAYMENT ANALYSIS

--Payment Method Usage


select payment_method , 
  count (*) as type_of_payment
   from payment 
   where payment_status = 'success'
   group by payment_method
   having  count (*) >1


--Payment Failure Rate by Payment Method

SELECT
    payment_method,
    COUNT(*) AS failed_payments
FROM payment
WHERE payment_status = 'Failed'
GROUP BY payment_method;
