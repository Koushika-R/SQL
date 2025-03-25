/*TASK THREE: ONLINE RETAIL STORE DATABASE
 Develop a database for an online retail store, including products, customers, orders,
 and payments. Design tables for products, customers, orders, and payments. Write SQL queries to
 handle customer orders and payment processing.
 */
 
CREATE DATABASE OnlineRetailStore;
USE OnlineRetailStore;

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(50) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
phone VARCHAR (15),
address TEXT
);

CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100) NOT NULL,
category VARCHAR(50),
price DECIMAL(10,2) NOT NULL,
stock_quantity INT NOT NULL
);

CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2),
status ENUM ('Pending','Shipped','Delievered','Cancelled') DEFAULT 'Pending',
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE order_items (
order_item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_id INT,
quantity INT NOT NULL,
price DECIMAL (10,2),
FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

CREATE TABLE payments (
payment_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
payment_date DATE,
amount DECIMAL(10,2) NOT NULL,
payment_method ENUM ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash'),
status ENUM ('Pending','Completed','Failed') DEFAULT 'Pending',
FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE
);

INSERT INTO customers (customer_name, email, phone, address)
VALUES
('Ashwitha','ashwitha@gmail.com','2836251738','23 MG ROAD'),
('Amritha','amritha@gmail.com','6789364523','99 KR NAGAR'),
('Raksha','raksha@gmail.com','7364748392','24 BHEL ROAD');

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
('Laptop','Electronics','26000.00','19'),
('Organza saree','Clothing','4600.00','108'),
('Sugar','Grocery','40.00','67');

INSERT INTO orders (customer_id, total_amount, status)
VALUES
(2, 40.00,'Pending'),
(1, 4600.00, 'Shipped'),
(3, 26000.00, 'Shipped');

INSERT INTO order_items(order_id, product_id, quantity,price)
VALUES
(2,3,1,40,00),
(1,2,1,4600,00),
(3,1,1,26000.00);

INSERT INTO payments(order_id, amount, payment_method, status)
VALUES
(1, 40.00, 'Credit Card','Completed'),
(2, 4600.00, 'PayPal','Completed');


-- Data Retrieval --
-- CUSTOMER AND ORDER QUERIES -- 
-- List all customer orders --
SELECT o.order_id, c.customer_name AS customer_name, o.order_date, o.total_amount, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Find all orders placed by a specific customer --
SELECT o.order_id, o.order_date, o.total_amount, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_name = 'Amritha';

-- Find customers who havent placed any orders --
SELECT c.customer_name, c.email
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Find customers who have spent the most money --
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;


-- PRODUCT AND INVENTORY QUERIES --
-- Find products that are low in stock, less than 20 items --
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity < 20;

-- Find the most popular products --
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_sold DESC
LIMIT 3;

-- The total revenue generated per product -- 
SELECT p.product_name, SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY revenue DESC;

-- PAYMENT AND REVENUE QUERIES --
-- Find all payments that are pending -- 
SELECT p.payment_id, o.order_id, c.customer_name, p.amount, p.payment_method
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE p.status = 'Pending';



