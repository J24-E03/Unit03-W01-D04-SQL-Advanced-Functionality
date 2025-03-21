create table products (
	productId serial primary key,
	productName varchar(255) not null,
	productPrice decimal(10, 2) not null,
	stock integer not null,
	category varchar(300),
	rating decimal(3, 2) default null
);

select * from products;

create table orders (
	orderId serial primary key,
	customerName varchar(255) not null,
	productId int references products(productId),
	quantity integer not null,
	totalPrice decimal(10, 2) not null,
	orderDate date not null
);



select * from orders;

INSERT INTO products (productName, productPrice, stock, category, rating) VALUES
('Laptop', 1200.50, 10, 'Electronics', 4.5),
('Smartphone', 800.99, 15, 'Electronics', 4.7),
('T-shirt', 19.99, 50, 'Clothing', 4.2),
('Coffee Maker', 75.00, 30, 'Home', NULL),
('Headphones', 150.00, 20, 'Electronics', 4.3),
('Desk Chair', 220.75, 5, 'Furniture', 4.0),
('Tablet', 400.00, 12, 'Electronics', NULL),
('Sneakers', 85.00, 25, 'Clothing', 4.6);

INSERT INTO orders (customerName, productId, quantity, totalPrice, orderDate) VALUES
('Alice Johnson', 1, 1, 1200.50, '2023-01-15'),
('Bob Smith', 2, 2, 1601.98, '2023-02-20'),
('Charlie Davis', 3, 3, 59.97, '2023-03-05'),
('David Brown', 4, 1, 75.00, '2023-04-10'),
('Emma Wilson', 5, 2, 300.00, '2023-05-22'),
('Frank Thomas', 6, 1, 220.75, '2023-06-15'),
('Grace Lee', 7, 1, 400.00, '2023-07-08'),
('Hannah White', 8, 2, 170.00, '2023-08-12');

--Task 3.1
select * from products limit 5;
select * from products offset 5 limit 5;

--Task 3.2
select * from products where category in ('Electronics', 'Clothing', 'Home');
select * from orders where orderDate between '2023-01-01' and '2023-06-30';

--Task 3.3
select round(productPrice) from products;
select coalesce(rating, '0.0') from products;

--Task 3.4
select count(*) from orders;
select sum(totalPrice) from orders;
select avg(productPrice) from products;
select min(productPrice), max(productPrice) from products;

--Task 3.5
select *, productPrice,
	case
		when productPrice > 100 then 'expensive'
		when productPrice between 50 and 100 then 'moderate'
		when productPrice < 50 then 'affordable'
	end
	as priceLabel
FROM products;


--Task 3.6
select * from products where productName ilike '%phone%';

--Task 3.7
alter table products add constraint varchar unique (productName);
insert into products (productName, productPrice, stock, category, rating) values
('Laptop', 1000.00, 50, 'Electronics', 4.5)
on conflict (productName) do update set
productPrice = excluded.productPrice,
stock = excluded.stock;

--Task 3.8
select * from products order by rating desc nulls last;