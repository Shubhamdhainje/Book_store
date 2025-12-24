-- Create database
CREATE DATABASE bookstore;

-- Switch to the database
--\c bookstore;

-- Create table
DROP TABLE IF EXISTS books;
CREATE TABLE books(
	Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10, 2),
	Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES customers(Customer_ID),
	Book_ID INT REFERENCES books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10, 2)
);

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- Import data into book table
COPY books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'F:\2023_Desktop\SQL_Project\Bookstore\Book.csv'
CSV HEADER

-- Import data into customers
COPY customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'F:\2023_Desktop\SQL_Project\Bookstore\Customers.csv'
CSV HEADER;

-- Import data into Orders table
COPY orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'F:\2023_Desktop\SQL_Project\Bookstore\Orders.csv'
CSV HEADER;

-- TO DELETE DATA FROM BOOKS TABLE.
TRUNCATE TABLE books RESTART IDENTITY;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM books
WHERE Published_year > '1950'; -- WITH SINGLE COUT YEAR MENTION

SELECT * FROM books
WHERE Published_year > 1950; --- WITHOUT SINGLE COUT YEAR MENTION


-- 3) List all customers from the Canada:
SELECT * FROM customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS total_stock
FROM books ;

-- 6) Find the details of the most expensive book:
SELECT * FROM books
ORDER BY price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity > 1 ;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM orders
WHERE total_amount > 20; 

-- 9) List all genres available in the Books table:
SELECT genre FROM books
GROUP BY genre; -- using group by function

SELECT DISTINCT genre 
FROM books; -- using distinct 

-- 10) Find the book with the lowest stock:
SELECT * FROM books
ORDER BY stock 
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS total_revenue
FROM orders ;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

SELECT b.genre, SUM(o.quantity) AS total_book_sold
FROM orders o
JOIN books b
ON b.book_id = o.book_id
GROUP BY b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT * FROM books;
SELECT AVG(price) AS avg_price
FROM books
WHERE genre ='Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT * FROM customers;
SELECT * FROM orders;
SELECT customer_id, COUNT(order_id) AS total_order
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 2;

-- using join 
SELECT c.customer_id,c.name, COUNT(o.order_id) AS total_order
FROM orders o
JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 2;

-- 4) Find the most frequently ordered book:
SELECT book_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY book_id
ORDER BY order_count DESC
LIMIT 1;

--- Using Join
select * from books;
SELECT b.title, b.author, b.genre, o.book_id, COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b
ON o.book_id = b.book_id 
GROUP BY o.book_id, b.title, b.author, b.genre
ORDER BY order_count DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- USING WHERE CALUSE
SELECT genre, price
FROM books
WHERE genre = 'Fantasy'
GROUP BY genre, price
ORDER BY price DESC
LIMIT 3;

--USING HAVING CLASUE
SELECT genre, price
FROM books
GROUP BY genre, price
HAVING genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT * FROM orders;
SELECT * FROM books;

SELECT b.author, SUM(o.quantity) AS total_quantity_sold
FROM books b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.author
ORDER BY total_quantity_sold DESC;
-- 7) List the cities where customers who spent over $30 are located:
SELECT * FROM orders;
SELECT * FROM customers;

-- USING GROUP BY
SELECT c.city, o.total_amount 
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.total_amount > 30
GROUP BY c.city, o.total_amount;

-- USING DISTINCT
SELECT DISTINCT c.city, o.total_amount
FROM orders o
JOIN customers c
ON c.customer_id = o.customer_id
WHERE o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT * FROM orders;
SELECT * FROM customers;

SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent 
FROM orders o
JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 3;

--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(quantity),0) AS order_quantity,
		 b.stock - COALESCE(SUM(quantity),0) AS remaining_stock
FROM books b
LEFT JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id ;