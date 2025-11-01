-- CUSTOMERS table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR,
    city VARCHAR
);
INSERT INTO CUSTOMERS (customer_id, customer_name, city) VALUES
(1, 'Aarav Mehta', 'Delhi'),
(2, 'Riya Sharma', 'Mumbai'),
(3, 'Kabir Jain', 'Delhi'),
(4, 'Neha Verma', 'Pune');

select * from customers

-- ORDERS table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount INT,
    status VARCHAR(20),
    CONSTRAINT fk_customFOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO ORDERS (order_id, customer_id, order_date, total_amount, status) VALUES
(1001, 1, '2023-06-01', 4500, 'Delivered'),
(1002, 1, '2023-06-03', 5200, 'Delivered'),
(1003, 2, '2023-06-02', 3000, 'Delivered'),
(1004, 2, '2023-06-10', 3000, 'Cancelled'),
(1005, 3, '2023-06-05', 5200, 'Delivered'),
(1006, 3, '2023-06-06', 7000, 'Delivered'),
(1007, 4, '2023-06-09', 4000, 'Delivered');


select * from orders 

-- PAYMENTS table
CREATE TABLE payments (
    payment_id VARCHAR PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_amount INT,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO PAYMENTS (payment_id, order_id, payment_date, payment_amount) VALUES
('P01', 1001, '2023-06-02', 4500),
('P02', 1002, '2023-06-01', 5200),
('P03', 1003, '2023-06-05', 3000),
('P04', 1006, '2023-06-08', 7000),
('P05', 1007, '2023-06-10', 4000);

select * from payments 
---1
SELECT o.order_id, o.order_date, p.payment_date, p.payment_amount
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_date < o.order_date;

---2

SELECT DISTINCT o1.*
FROM orders o1
JOIN orders o2 ON o1.total_amount = o2.total_amount AND o1.customer_id != o2.customer_id;

---3
SELECT c.customer_name, o.order_date, o.total_amount, p.payment_amount
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
JOIN customers c ON o.customer_id = c.customer_id;

----4
SELECT c.customer_name, o.order_id, o.status, p.payment_amount
FROM orders o
JOIN payments p ON o.order_id = p.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'Cancelled';





