CREATE DATABASE ecommerce_db;
USE ecommerce_db;

ALTER TABLE orders
ADD total_amount DECIMAL(10,2);

UPDATE orders SET total_amount = 1500000 WHERE order_id = 101;
UPDATE orders SET total_amount = 800000  WHERE order_id = 102;
UPDATE orders SET total_amount = 1200000 WHERE order_id = 103;
UPDATE orders SET total_amount = 500000  WHERE order_id = 104;
UPDATE orders SET total_amount = 2000000 WHERE order_id = 105;

SELECT c.full_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT c.full_name,
       MAX(o.total_amount) AS max_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT c.full_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC;


SELECT order_date,
       SUM(total_amount) AS total_revenue,
       COUNT(order_id) AS total_orders
FROM orders
WHERE status = 'completed'
GROUP BY order_date
HAVING SUM(total_amount) > 10000000;


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop', 15000000),
(2, 'Chuột', 300000),
(3, 'Bàn phím', 800000),
(4, 'Tai nghe', 1200000),
(5, 'Màn hình', 5000000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 1),
(101, 2, 2),
(102, 3, 1),
(103, 5, 1),
(105, 1, 1);

SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT p.product_name,
       SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * p.price) > 5000000;


SELECT c.full_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.total_amount) AS total_spent,
       AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 3
   AND SUM(o.total_amount) > 10000000
ORDER BY total_spent DESC;

SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity,
       SUM(oi.quantity * p.price) AS total_revenue,
       AVG(p.price) AS avg_price
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) >= 10
ORDER BY total_revenue DESC
LIMIT 5;
