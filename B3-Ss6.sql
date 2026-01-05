create database ecommerce_db;
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
