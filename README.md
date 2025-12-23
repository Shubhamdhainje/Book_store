# Book_store
📚 Bookstore Management System – SQL Project (PostgreSQL)
📌 Project Overview
This project is a Bookstore Management System developed using PostgreSQL and managed through PGAdmin.
The purpose of this project is to store, manage, and analyze bookstore data by importing CSV files into a relational database and performing SQL queries to gain meaningful insights.
This project demonstrates practical SQL skills including database design, data manipulation, and analytical querying using PostgreSQL.
🗄️ Database & Tool Used

Database: PostgreSQL
Database Tool: pgAdmin 4
Language: SQL
Data Source: CSV files

📂 Dataset Description
The project uses three CSV files:
1️⃣ Book Table (book.csv)
Stores information about books available in the bookstore.

book_id (Primary Key)
title
author
genre
price
stock_quantity

2️⃣ Customer Table (customer.csv)
Contains customer details.

customer_id (Primary Key)
customer_name
email
phone
city
country

3️⃣ Order Table (order.csv)
Stores order transaction data.

order_id (Primary Key)
customer_id (Foreign Key)
book_id (Foreign Key)
order_date
quantity
total_amount

🔗 Database Relationships

One customer can place multiple orders.
One book can be included in multiple orders.
The order table connects customers and books using foreign keys.

Foreign Key Relationships:

order.customer_id → customer.customer_id
order.book_id → book.book_id

🛠️ SQL Concepts Used

Database and Table Creation
Primary Key & Foreign Key Constraints
Importing CSV files
Data Filtering (WHERE)
Sorting (ORDER BY)
Aggregate Functions (SUM, COUNT, AVG)
Grouping Data (GROUP BY, HAVING)
Table Joins (INNER JOIN)

📊 Key Queries & Analysis

Display all books and their details
Calculate total revenue generated from orders
Identify top-selling books
Find customers with the highest number of purchases
Analyze sales by month and year
Check available stock for books
Retrieve complete customer order history

🎯 Project Objectives

Practice PostgreSQL database design
Strengthen SQL querying skills using PGAdmin
Understand relational data modeling
Perform business-related data analysis

✅ Conclusion
This Bookstore SQL project showcases the effective use of PostgreSQL for managing and analyzing relational data. The project simulates a real-world bookstore scenario and enhances practical database and SQL analysis skills.
React
