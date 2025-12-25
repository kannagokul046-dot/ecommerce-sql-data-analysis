CREATE DATABASE ecommerce_real_project;

USE ecommerce_real_project;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);



CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_type VARCHAR(30),
    payment_value DECIMAL(10,2),
    payment_date DATE
);


INSERT INTO customers VALUES
(101,'Amit Singh','amit.s@gmail.com','Pune','Maharashtra','2023-11-18'),
(102,'Neha Reddy','neha.r@gmail.com','Hyderabad','Telangana','2023-12-02'),
(103,'Rohit Mehta','rohit.mehta@gmail.com','Mumbai','Maharashtra','2024-01-10'),
(104,'Farzana Khan','farzana.k@gmail.com','Bhopal','Madhya Pradesh','2024-01-25'),
(105,'Karthik Iyer','karthik.i@gmail.com','Coimbatore','Tamil Nadu','2024-02-14');


DECLARE @i INT = 1;

WHILE @i <= 10000
BEGIN
    INSERT INTO customers
    VALUES (
        1000 + @i,
        CONCAT('Customer_', @i),
        CONCAT('customer', @i, '@mail.com'),
        'Bangalore',
        'Karnataka',
        DATEADD(DAY, -@i, GETDATE())
    );
    SET @i = @i + 1;
END;


INSERT INTO products VALUES
(1,'Samsung Galaxy M14','Electronics',13999,11000),
(2,'Boat Rockerz 450','Electronics',1999,1200),
(3,'HP Wireless Mouse','Accessories',799,400),
(4,'Office Chair Ergonomic','Furniture',8499,6200),
(5,'Nike Running Shoes','Footwear',4599,3000);
GO

INSERT INTO products VALUES
(6,'Redmi Note 13','Electronics',17999,14000),
(7,'Lenovo Keyboard','Accessories',1299,700),
(8,'Wooden Study Table','Furniture',12500,9000),
(9,'Adidas Sports Shoes','Footwear',5599,3800),
(10,'Sony Bluetooth Speaker','Electronics',6999,5200);
GO

delete from orders

INSERT INTO orders VALUES
(1001,1,'2024-01-05','Delivered'),
(1002,2,'2024-01-07','Delivered'),
(1003,1,'2024-01-20','Delivered'),
(1004,3,'2024-02-02','Cancelled'),
(1005,4,'2024-02-10','Delivered'),
(1006,5,'2024-02-18','Returned');
GO

DECLARE @o INT = 1;

WHILE @o <= 8000
BEGIN
    INSERT INTO orders
    VALUES (
        10000 + @o,
        (ABS(CHECKSUM(NEWID())) % 5000) + 1,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 400, GETDATE()),
        CHOOSE((@o % 4)+1,'Delivered','Delivered','Cancelled','Returned')
    );
    SET @o += 1;
END;
GO



;
INSERT INTO order_items
(order_item_id, order_id, product_id, quantity)
VALUES
(1, 101, 1, 1),
(2, 101, 3, 2),
(3, 102, 3, 1),
(4, 104, 4, 1),
(5, 105, 2, 1);


DECLARE @oi INT = 1;

WHILE @oi <= 12000
BEGIN
    INSERT INTO order_items
    VALUES (
        @oi,
        10000 + (ABS(CHECKSUM(NEWID())) % 8000) + 1,
        (ABS(CHECKSUM(NEWID())) % 5) + 1,
        (ABS(CHECKSUM(NEWID())) % 3) + 1
    );
    SET @oi += 1;
END;
GO

INSERT INTO payments
(payment_id, order_id, payment_type, payment_value, payment_date, payment_method, payment_status)
VALUES
(1, 101, 'Online', 71998, '2024-02-01', 'UPI', 'Success');


drop table payments
-- Example structure
CREATE TABLE payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    payment_type VARCHAR(20),
    payment_value DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20)
);
INSERT INTO payment
(order_id, payment_type, payment_value, payment_date, payment_method, payment_status)

SELECT 
    o.order_id,
    'Online' AS payment_type,
    SUM(p.price * oi.quantity) AS payment_value,
    o.order_date AS payment_date,
    CHOOSE(
        ABS(CHECKSUM(NEWID())) % 4 + 1,
        'UPI','Credit Card','Debit Card','Net Banking'
    ) AS payment_method,
    'Success' AS payment_status
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY o.order_id, o.order_date;
GO





SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payment;


