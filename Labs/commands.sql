-- 3. Querying Tasks
-- 3.1 Use LIMIT and OFFSET for Pagination
-- Retrieve the first 5 products:
SELECT * FROM products
ORDER BY id
LIMIT 5;

-- Retrieve the next 5 products (pagination):
SELECT * FROM products
ORDER BY ID
LIMIT 5
OFFSET 5;

-- 3.2 Filter Data with IN and BETWEEN
-- Retrieve all products that belong to ('Electronics', 'Clothing', 'Home') categories:
SELECT * FROM products
WHERE category IN ('Electronics', 'Clothing', 'Home');

-- Find all orders placed between 2023-01-01 and 2023-06-30:
SELECT * FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-06-30';

-- 3.3 Use ROUND and COALESCE for Data Manipulation
-- Round all product prices to the nearest whole number
SELECT name, ROUND(price) As rounded_price FROM products;

-- Ensure ratings display 0.0 instead of NULL:
SELECT name, COALESCE(rating, 0.0) AS rating FROM products;

-- 3.4 Perform Aggregations
-- Count the total number of orders:
SELECT COUNT(*) AS total_orders FROM orders;

-- Find the sum of all sales revenue:
SELECT SUM(total_price) AS total_revenue FROM orders;

-- Calculate the average price of products:
SELECT ROUND(AVG(price),2) AS average_price FROM products;

-- Identify the cheapest and most expensive products:
SELECT name, price
FROM products
WHERE price = (SELECT MIN(price) FROM products)
   OR price = (SELECT MAX(price) FROM products);

-- BONUS: 3.5 Use CASE for Conditional Logic
-- Create a column that labels products:
SELECT name, price,
	CASE
		WHEN price > 100 THEN 'Expensive'
		WHEN price BETWEEN 50 AND 100 THEN 'Moderate'
		WHEN price < 50 THEN 'Affordable'
	END AS price_category
FROM products;

-- 3.6 Perform Case-Insensitive Searches with ILIKE
-- Find all products that contain the word "phone" (case insensitive):
SELECT * FROM products
WHERE name ILIKE '%phone%';

-- 3.7 Handle Conflicts with ON CONFLICT
-- Insert a product and ensure that if a duplicate name exists, 
-- the price and stock are updated instead
ALTER TABLE products ADD CONSTRAINT unique_product_name UNIQUE (name);

INSERT INTO products (name, price, stock, category, rating)
VALUES ('TV', 2500.00, 10, 'Electronics', 4.1)
ON CONFLICT (name) DO UPDATE
SET price = EXCLUDED.price,
    stock = EXCLUDED.stock;

INSERT INTO products (name, price, stock, category, rating)
VALUES ('TV', 2450.00, 13, 'Electronics', 4.1)
ON CONFLICT (name) DO UPDATE
SET price = EXCLUDED.price,
    stock = EXCLUDED.stock;

-- 3.8 Order Results Handling NULLs Last
-- Retrieve all products ordered by rating in descending order,
-- ensuring that NULL ratings appear last:
SELECT * FROM products
ORDER BY rating DESC NULLS LAST;
