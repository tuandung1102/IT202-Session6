
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255),
    city VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'Hải Phòng'),
(3, 'Lê Văn Cường', 'Đà Nẵng'),
(4, 'Phạm Thị Dung', 'Hồ Chí Minh'),
(5, 'Hoàng Văn Em', 'Cần Thơ');

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(101, 1, '2024-10-01', 'completed'),
(102, 1, '2024-10-05', 'pending'),
(103, 2, '2024-10-03', 'completed'),
(104, 3, '2024-10-04', 'cancelled'),
(105, 3, '2024-10-06', 'completed');

SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT c.full_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT c.full_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 1;
