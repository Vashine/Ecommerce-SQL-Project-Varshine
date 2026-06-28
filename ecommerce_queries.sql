-- E-commerce Sales Analytics SQL Project
-- Author: Varshine
-- Date: June 2026

-- ==========================================
-- QUERY 1: TOP 5 BEST SELLING PRODUCTS
-- ==========================================
SELECT 
    p.product_name AS "Product Name",
    SUM(oi.quantity) AS "Total Units Sold",
    SUM(oi.quantity * oi.price) AS "Total Revenue"
FROM products p 
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name 
ORDER BY "Total Units Sold" DESC 
LIMIT 5;


-- ==========================================
-- QUERY 2: CUSTOMER LIFETIME VALUE
-- ==========================================
SELECT 
    c.customer_name AS "Customer Name",
    c.city AS "City",
    COUNT(DISTINCT o.order_id) AS "Total Orders",
    SUM(oi.quantity * p.price) AS "Total Spent"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY "Total Spent" DESC;


-- ==========================================
-- QUERY 3: MONTHLY SALES REPORT
-- ==========================================
SELECT 
    strftime('%Y-%m', o.order_date) AS "Month",
    COUNT(o.order_id) AS "Total Orders",
    SUM(o.total_amount) AS "Monthly Revenue",
    COUNT(DISTINCT o.customer_id) AS "Unique Customers"
FROM orders o 
WHERE o.status = 'Delivered'
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY "Month" DESC;