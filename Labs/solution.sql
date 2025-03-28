CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          price DECIMAL(10,2) NOT NULL,
                          stock INT NOT NULL,
                          category VARCHAR(100),
                          rating DECIMAL(3,2) DEFAULT NULL
);
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        customer_name VARCHAR(255) NOT NULL,
                        product_id INT REFERENCES products(id),
                        quantity INT NOT NULL,
                        total_price DECIMAL(10,2) NOT NULL,
                        order_date DATE NOT NULL
);
INSERT INTO products (name, price, stock, category, rating) VALUES
                                                                ('Laptop', 1200.50, 10, 'Electronics', 4.5),
                                                                ('Smartphone', 800.99, 15, 'Electronics', 4.7),
                                                                ('T-shirt', 19.99, 50, 'Clothing', 4.2),
                                                                ('Coffee Maker', 75.00, 30, 'Home', NULL),
                                                                ('Headphones', 150.00, 20, 'Electronics', 4.3),
                                                                ('Desk Chair', 220.75, 5, 'Furniture', 4.0),
                                                                ('Tablet', 400.00, 12, 'Electronics', NULL),
                                                                ('Sneakers', 85.00, 25, 'Clothing', 4.6);

INSERT INTO orders (customer_name, product_id, quantity, total_price, order_date) VALUES
                                                                                      ('Alice Johnson', 1, 1, 1200.50, '2023-01-15'),
                                                                                      ('Bob Smith', 2, 2, 1601.98, '2023-02-20'),
                                                                                      ('Charlie Davis', 3, 3, 59.97, '2023-03-05'),
                                                                                      ('David Brown', 4, 1, 75.00, '2023-04-10'),
                                                                                      ('Emma Wilson', 5, 2, 300.00, '2023-05-22'),
                                                                                      ('Frank Thomas', 6, 1, 220.75, '2023-06-15'),
                                                                                      ('Grace Lee', 7, 1, 400.00, '2023-07-08'),
                                                                                      ('Hannah White', 8, 2, 170.00, '2023-08-12');
-- Retrieve the first 5 products
SELECT * FROM products
                  LIMIT 5;
-- Retrieve the next 5 products (pagination)
SELECT * FROM products
                  LIMIT 5 OFFSET 5;

-- Retrieve all products in ('Electronics', 'Clothing', 'Home') categories
SELECT * FROM products
WHERE category IN ('Electronics', 'Clothing', 'Home')

---Find all orders placed between 2023-01-01 and 2023-06-30
SELECT *FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-06-30'

-- Round all product prices to the nearest whole number
SELECT id, name, ROUND(price) AS rounded_price FROM products;
--Ensure ratings display 0.0 instead of NULL
SELECT id, name, COALESCE(rating, 0.0) AS adjusted_rating FROM products;
Count the total number of orders

-- Count the total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Find the sum of all sales revenue
SELECT SUM(total_price) AS total_revenue FROM orders;

--Calculate the average price of products
SELECT AVG(price) AS average_price FROM products;

-- Identify the cheapest and most expensive products
SELECT name, price FROM products
ORDER BY price ASC
    LIMIT 1;
SELECT name, price FROM products
ORDER BY price DESC
    LIMIT 1;
-- Label products as Expensive, Moderate, or Affordable
SELECT id, name, price,
       CASE
           WHEN price > 100 THEN 'Expensive'
           WHEN price BETWEEN 50 AND 100 THEN 'Moderate'
           ELSE 'Affordable'
           END AS price_category
FROM products;
-- Find all products containing the word 'phone' (case-insensitive)
SELECT * FROM products
WHERE name ILIKE '%phone%';











