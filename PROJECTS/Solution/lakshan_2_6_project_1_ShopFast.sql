create database ShopFast;

use ShopFast;


select * from CUSTOMERS;

select * from ORDER_ITEMS;

select * from ORDERS;

select * from PRODUCTS;


--1. Customer Sign-up Trend: New customers per month (last 12 months)
SELECT customer_id, name, signup_date FROM CUSTOMERS
WHERE signup_date >= DATEADD(MONTH, -12, GETDATE());

--2. Top 5 Customers by Revenue: Total orders, revenue, and avg order value
SELECT TOP 5 o.customer_id, c.name, o.total_amount FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
ORDER BY o.total_amount DESC;

--3. Order Status Distribution: Count of each status
SELECT status, COUNT(*) AS order_count FROM ORDERS
GROUP BY status;

--4. Revenue by Category: Total revenue by category
SELECT o.product_id, p.product_name, o.quantity, o.price_per_unit
FROM ORDER_ITEMS o
JOIN PRODUCTS p ON o.product_id = p.product_id;

--5. Best-Selling Products: Top 5 by quantity sold
SELECT o.product_id, p.product_name, o.quantity
FROM ORDER_ITEMS o
JOIN PRODUCTS p ON o.product_id = p.product_id
ORDER BY o.quantity DESC;

--6. Low-Stock Products: Products with <10% stock using CASE
SELECT product_name, stock_quantity, CASE WHEN stock_quantity < 10 THEN 'Low Stock' ELSE 'OK' END AS stock_status
FROM PRODUCTS;

--7. Avg Delivery Time per Month
SELECT FORMAT(order_date, 'yyyy-MM') AS order_month, AVG(DATEDIFF(DAY, order_date, delivery_date)) AS avg_delivery_days
FROM ORDERS
WHERE delivery_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY order_month;

--8. Orders with Delivery >7 days
SELECT order_id, order_date, delivery_date
FROM ORDERS
WHERE DATEDIFF(DAY, order_date, delivery_date) > 7;

--9. Repeat Customers: More than 1 order
SELECT customer_id FROM ORDERS GROUP BY customer_id
HAVING COUNT(*) > 1;

--10. Monthly Revenue Growth with LAG()
SELECT 
  FORMAT(order_date, 'yyyy-MM') AS order_month,
  SUM(total_amount) AS monthly_revenue,
  SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS revenue_growth
FROM ORDERS
WHERE total_amount IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY order_month;

--11. Cohort Analysis using CTE (signup year)
SELECT customer_id, name, YEAR(signup_date) AS signup_year
FROM CUSTOMERS;

--12. Cancelled/Returned Product Revenue Loss
SELECT order_id, status, total_amount FROM ORDERS
WHERE status = 'Cancelled' OR status = 'Returned';

--13. Customer City Heatmap
SELECT customer_id, city FROM CUSTOMERS;

--14. First & Last Order per Customer with ROW_NUMBER()
WITH RankedOrders AS (
  SELECT 
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS rn_asc,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn_desc
  FROM ORDERS
)
SELECT customer_id, order_id, order_date, 'First Order' AS order_type
FROM RankedOrders WHERE rn_asc = 1
UNION
SELECT customer_id, order_id, order_date, 'Last Order'
FROM RankedOrders WHERE rn_desc = 1;


--15. NULL Handling: Orders with missing delivery/amount
SELECT order_id, delivery_date, total_amount FROM ORDERS
WHERE delivery_date IS NULL OR total_amount IS NULL;
