# PostgreSQL Advanced Queries Lab

## Objective
In this lab, students will:
- Use `LIMIT` and `OFFSET` to paginate results.
- Filter data using `IN` and `BETWEEN`.
- Use `ROUND` and `COALESCE` for data manipulation.
- Perform aggregate calculations with `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`.
- Apply conditional logic using `CASE`.
- Perform case-insensitive searches using `ILIKE`.
- Handle conflicts using `ON CONFLICT`.
- Order results while handling `NULL` values.

## Scenario: E-Commerce Database
You are working for an e-commerce company that sells products online. The company has a PostgreSQL database that stores customer orders, product details, and sales transactions. Your goal is to analyze and manipulate data efficiently using SQL queries.

---

## **1. Set Up the Database and Tables**
Ensure the following tables exist in the database:

### **Products Table**
```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    category VARCHAR(100),
    rating DECIMAL(3,2) DEFAULT NULL
);
```

### **Orders Table**
```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);
```

### **2. Insert Initial Data**
Run the following `INSERT` statements to populate the tables:

#### **Insert Data into Products**
```sql
INSERT INTO products (name, price, stock, category, rating) VALUES
('Laptop', 1200.50, 10, 'Electronics', 4.5),
('Smartphone', 800.99, 15, 'Electronics', 4.7),
('T-shirt', 19.99, 50, 'Clothing', 4.2),
('Coffee Maker', 75.00, 30, 'Home', NULL),
('Headphones', 150.00, 20, 'Electronics', 4.3),
('Desk Chair', 220.75, 5, 'Furniture', 4.0),
('Tablet', 400.00, 12, 'Electronics', NULL),
('Sneakers', 85.00, 25, 'Clothing', 4.6);
```

#### **Insert Data into Orders**
```sql
INSERT INTO orders (customer_name, product_id, quantity, total_price, order_date) VALUES
('Alice Johnson', 1, 1, 1200.50, '2023-01-15'),
('Bob Smith', 2, 2, 1601.98, '2023-02-20'),
('Charlie Davis', 3, 3, 59.97, '2023-03-05'),
('David Brown', 4, 1, 75.00, '2023-04-10'),
('Emma Wilson', 5, 2, 300.00, '2023-05-22'),
('Frank Thomas', 6, 1, 220.75, '2023-06-15'),
('Grace Lee', 7, 1, 400.00, '2023-07-08'),
('Hannah White', 8, 2, 170.00, '2023-08-12');
```

---

## **3. Querying Tasks**

### **3.1 Use LIMIT and OFFSET for Pagination**
- Retrieve the first **5 products**.
- Retrieve the next **5 products** (pagination).

### **3.2 Filter Data with IN and BETWEEN**
- Retrieve all products that belong to `('Electronics', 'Clothing', 'Home')` categories.
- Find all orders placed between `2023-01-01` and `2023-06-30`.

### **3.3 Use ROUND and COALESCE for Data Manipulation**
- Round all product prices to the nearest whole number.
- Ensure ratings display `0.0` instead of `NULL`.

### **3.4 Perform Aggregations**
- Count the total number of orders.
- Find the **sum** of all sales revenue.
- Calculate the **average price** of products.
- Identify the **cheapest and most expensive** products.

### **BONUS: 3.5 Use CASE for Conditional Logic**
- Create a column that labels products as:
  - `Expensive` (price > 100)
  - `Moderate` (price between 50-100)
  - `Affordable` (price < 50)

### **3.6 Perform Case-Insensitive Searches with ILIKE**
- Find all products that contain the word "phone" (case insensitive).

### **3.7 Handle Conflicts with ON CONFLICT**
- Insert a product and ensure that if a duplicate `name` exists, the `price` and `stock` are updated instead.

### **3.8 Order Results Handling NULLs Last**
- Retrieve all products ordered by rating in descending order, ensuring that `NULL` ratings appear last.

