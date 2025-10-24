CREATE DATABASE online_retail;
USE online_retail;
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(20)
);

CREATE TABLE categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2),
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  unit_price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  amount DECIMAL(10,2),
  payment_method VARCHAR(50),
  payment_date DATE,
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers (first_name, last_name, email, phone)
VALUES 
('Asha', 'Sharma', 'asha@example.com', '9876543210'),
('John', 'Doe', 'john@example.com', '9999999999');

INSERT INTO categories (name) VALUES ('Books'), ('Electronics');

INSERT INTO products (name, price, category_id)
VALUES 
('Database Design Book', 400.00, 1),
('Smartphone X', 25000.00, 2);

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES 
(1, '2025-10-01', 400.00),
(2, '2025-10-02', 25000.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES 
(1, 1, 1, 400.00),
(2, 2, 1, 25000.00);

INSERT INTO payments (order_id, amount, payment_method, payment_date)
VALUES 
(1, 400.00, 'Credit Card', '2025-10-01'),
(2, 25000.00, 'Net Banking', '2025-10-02');

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

SELECT o.order_id, c.first_name, c.last_name, o.total_amount, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT o.order_id, p.name AS product_name, oi.quantity, oi.unit_price
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id;






