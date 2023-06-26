use sales;
select * from customers;
select * from dates;
select* from markets;
select * from products;
select * from transactions;

-- Total count of transaction
select count(*) from sales.transactions;

-- First five records by transactions :
SELECT * FROM sales.transactions limit 5;

-- Display records of "Mark001"
SELECT * from sales.transactions where market_code="Mark001";

-- Display count of transactions where market_code is Mark001
SELECT COUNT(*) from sales.transactions where market_code="Mark001";
  
-- Display how many transactions done in USD?
SELECT * FROM transactions WHERE currency="USD"; 

-- How many transactions happened in 2020 ?
SELECT *
FROM transactions AS t
INNER JOIN dates AS d ON t.order_date = d.date;

SELECT *
FROM transactions AS t
INNER JOIN dates AS d ON t.order_date = d.date
WHERE YEAR(d.date) = 2020;

-- Total sales_amount in 2020 :
SELECT SUM(t.sales_amount) AS total_sales_amount
FROM transactions AS t
INNER JOIN dates AS d ON t.order_date = d.date
WHERE YEAR(d.date) = 2020;

-- Total sales_amount in 2020 in chennai (mark001):
SELECT SUM(t.sales_amount) AS total_sales_amount
FROM transactions AS t
INNER JOIN dates AS d ON t.order_date = d.date
WHERE YEAR(d.date) = 2020 AND market_code="Mark001";


-- What is the total sales amount by currency?
 SELECT currency, SUM(sales_amount) AS total_sales_amount
FROM transactions
GROUP BY currency;

-- What is the total sales quantity by product type?
SELECT p.product_type, SUM(t.sales_qty) AS total_sales_quantity
FROM transactions t
JOIN products p ON t.product_code = p.product_code
GROUP BY p.product_type;

-- What is the total sales amount by customer type?
SELECT c.customer_type, SUM(t.sales_amount) AS total_sales_amount
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY c.customer_type;

-- Find the top 5 customers with the highest total sales amount:
SELECT 
    customer_code, 
    SUM(sales_amount) AS total_sales_amount
FROM 
    transactions
GROUP BY 
    customer_code
ORDER BY 
    total_sales_amount DESC
LIMIT 5;



-- Find the top 3 products with the highest sales quantity for each customer:
SELECT 
    customer_code, 
    product_code, 
    sales_qty,
    RANK() OVER (PARTITION BY customer_code ORDER BY sales_qty DESC) as ranked
FROM 
    transactions
ORDER BY 
    customer_code, 
    ranked
LIMIT 3;

-- What is the total sales amount by market name?
SELECT m.markets_name, SUM(t.sales_amount) AS total_sales_amount
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
GROUP BY m.markets_name;

-- What is the total sales quantity by month?
SELECT d.month_name, SUM(t.sales_qty) AS total_sales_quantity
FROM transactions t
JOIN dates d ON t.order_date = d.date
GROUP BY d.month_name;

-- Retrieve the total sales amount for each product:
SELECT product_code, SUM(sales_amount) AS total_sales_amount
FROM transactions
GROUP BY product_code ORDER BY total_sales_amount desc;

-- Retrieve the total sales amount for each market:
SELECT market_code, SUM(sales_amount) AS total_sales_amount
FROM transactions
GROUP BY market_code;

-- Retrieve the average sales amount per order:
SELECT AVG(sales_amount) AS avg_sales_amount
FROM transactions;




-- Retrieve the total sales amount and quantity for each customer and product:
SELECT customer_code, product_code, SUM(sales_qty) AS total_sales_qty, SUM(sales_amount) AS total_sales_amount
FROM transactions
GROUP BY customer_code, product_code;

-- Retrieve the number of transactions for each day of the week:
SELECT DAYOFWEEK(order_date) AS day_of_week, COUNT(*) AS transaction_count 
FROM transactions 
GROUP BY day_of_week;


-- Retrieve the total sales amount and quantity for each day
SELECT DATE_FORMAT(order_date, '%M') AS month, SUM(sales_amount) 
FROM transactions 
GROUP BY month;



-- Retrieve the total sales amount and quantity for each day:
SELECT DATE(order_date) AS days, SUM(sales_qty) AS total_sales_qty, SUM(sales_amount) AS total_sales_amount
FROM transactions
GROUP BY days ORDER BY total_sales_amount desc;


-- Find the total sales amount by product category .
SELECT  p.product_type, SUM(t.sales_amount) AS total_sales_amount
FROM transactions t
JOIN products p ON t.product_code = p.product_code
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY p.product_type;


