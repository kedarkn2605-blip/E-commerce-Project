-- ========================================
-- E-COMMERCE DATABASE - SQL QUERIES
-- Student:  Sanskruti-316
-- Project: E-Commerce Database Management System
-- ========================================

USE e_commerce;

-- ========================================
-- SECTION 1: MULTIPLE TABLE JOIN OPERATIONS (6 Queries)
-- ========================================

-- Query 1: Get customer name, product name, and order details
SELECT c.FirstName, c. LastName, p.product_name, o.order_date, o.order_amount
FROM customer c
JOIN order_table o ON c.customer_id = o.customer_id
JOIN cart ct ON o.cart_id = ct.cart_id
JOIN product p ON ct.product_id = p.product_id;

-- Query 2: Get seller name, product name, and category for all products
SELECT s.seller_name, p.product_name, cat.category_name, p.MRP
FROM seller s
JOIN product p ON s.seller_id = p.seller_id
JOIN category cat ON p.category_id = cat.category_id;

-- Query 3: Get customer name, address, and their orders
SELECT c.FirstName, c.LastName, a.city, a.state, o.order_id, o.order_amount
FROM customer c
JOIN address a ON c.customer_id = a.customer_id
JOIN order_table o ON c.customer_id = o.customer_id;

-- Query 4: Get product reviews with customer and product details
SELECT c.FirstName, c.LastName, p.product_name, r.rating, r.description
FROM customer c
JOIN review r ON c.customer_id = r.customer_id
JOIN product p ON r.product_id = p.product_id;

-- Query 5: Get payment details with customer and order information
SELECT c.FirstName, c.LastName, o.order_id, o.order_amount, 
       pay.paymentMode, pay.dateofpayment
FROM customer c
JOIN order_table o ON c.customer_id = o.customer_id
JOIN payment pay ON o.order_id = pay.order_id;

-- Query 6: Get complete order details with all related information (4-table join)
SELECT c.FirstName, c.LastName, p.product_name, s.seller_name, 
       o.order_amount, o.order_status, pay.paymentMode
FROM customer c
JOIN order_table o ON c.customer_id = o.customer_id
JOIN cart ct ON o.cart_id = ct.cart_id
JOIN product p ON ct.product_id = p.product_id
JOIN seller s ON p.seller_id = s.seller_id
JOIN payment pay ON o.order_id = pay.order_id;


-- ========================================
-- SECTION 2: DIFFERENT OPERATORS (7 Queries)
-- ========================================

-- Query 1: Products with MRP greater than 1000 (Comparison Operator:  >)
SELECT product_name, MRP, brand 
FROM product 
WHERE MRP > 1000;

-- Query 2: Customers born between 2003 and 2005 (BETWEEN Operator)
SELECT FirstName, LastName, DateOfBirth 
FROM customer 
WHERE DateOfBirth BETWEEN '2003-01-01' AND '2005-12-31';

-- Query 3: Products from specific brands (IN Operator)
SELECT product_name, brand, MRP 
FROM product 
WHERE brand IN ('Apple', 'Samsung', 'Dell', 'HP');

-- Query 4: Products with names containing 'phone' or 'laptop' (LIKE Operator)
SELECT product_name, MRP, brand 
FROM product 
WHERE product_name LIKE '%phone%' OR product_name LIKE '%laptop%';

-- Query 5: Orders that are not delivered (NOT Operator / != Operator)
SELECT order_id, customer_id, order_amount, order_status 
FROM order_table 
WHERE order_status != 'delivery';

-- Query 6: Products with stock available (IS NOT NULL and Logical AND)
SELECT product_name, stock, MRP 
FROM product 
WHERE stock IS NOT NULL AND stock > 0;

-- Query 7: Customers from Mumbai (Logical AND Operator)
SELECT c.FirstName, c.LastName, a.city, a.state 
FROM customer c
JOIN address a ON c.customer_id = a. customer_id
WHERE a.city = 'mumbai' AND a.state = 'maharashtra';


-- ========================================
-- SECTION 3: GROUP BY AND HAVING (13 Queries)
-- ========================================

-- Query 1: Count of products per category
SELECT cat.category_name, COUNT(p.product_id) as product_count
FROM category cat
LEFT JOIN product p ON cat.category_id = p.category_id
GROUP BY cat.category_name;

-- Query 2: Average MRP per category
SELECT cat.category_name, AVG(p.MRP) as avg_price
FROM category cat
JOIN product p ON cat.category_id = p.category_id
GROUP BY cat.category_name;

-- Query 3: Total sales amount per seller
SELECT s.seller_name, SUM(s.total_sales) as total_revenue
FROM seller s
GROUP BY s.seller_name;

-- Query 4: Count of orders per customer
SELECT c.FirstName, c.LastName, COUNT(o. order_id) as order_count
FROM customer c
LEFT JOIN order_table o ON c. customer_id = o.customer_id
GROUP BY c.customer_id, c.FirstName, c.LastName;

-- Query 5: Categories with more than 2 products (HAVING clause)
SELECT cat.category_name, COUNT(p.product_id) as product_count
FROM category cat
JOIN product p ON cat.category_id = p.category_id
GROUP BY cat.category_name
HAVING COUNT(p.product_id) > 2;

-- Query 6: Average rating per product
SELECT p.product_name, AVG(CAST(r.rating AS DECIMAL(3,2))) as avg_rating
FROM product p
LEFT JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

-- Query 7: Products with average rating above 4 (HAVING with aggregate)
SELECT p.product_name, AVG(CAST(r. rating AS DECIMAL(3,2))) as avg_rating
FROM product p
JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(CAST(r.rating AS DECIMAL(3,2))) > 4;

-- Query 8: Total order amount per customer
SELECT c.FirstName, c.LastName, SUM(o.order_amount) as total_spent
FROM customer c
JOIN order_table o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.FirstName, c. LastName;

-- Query 9:  Customers who spent more than 10000 (HAVING with SUM)
SELECT c.FirstName, c.LastName, SUM(o.order_amount) as total_spent
FROM customer c
JOIN order_table o ON c. customer_id = o.customer_id
GROUP BY c.customer_id, c.FirstName, c.LastName
HAVING SUM(o.order_amount) > 10000;

-- Query 10: Count of orders by payment mode
SELECT paymentMode, COUNT(*) as payment_count
FROM payment
GROUP BY paymentMode;

-- Query 11: City-wise customer count
SELECT a.city, COUNT(DISTINCT a.customer_id) as customer_count
FROM address a
GROUP BY a.city;

-- Query 12: Sellers with total sales greater than 10000 (HAVING with WHERE-like condition)
SELECT seller_name, total_sales
FROM seller
GROUP BY seller_id, seller_name, total_sales
HAVING total_sales > 10000;

-- Query 13: Maximum order amount per customer
SELECT c. FirstName, c.LastName, MAX(o.order_amount) as highest_order
FROM customer c
JOIN order_table o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.FirstName, c.LastName;


-- ========================================
-- SECTION 4: SUB-QUERIES & CORRELATED NESTED QUERIES (20 Queries)
-- ========================================

-- Query 1: Customers who placed orders above average order amount (Simple Subquery)
SELECT FirstName, LastName 
FROM customer 
WHERE customer_id IN (
    SELECT customer_id 
    FROM order_table 
    WHERE order_amount > (SELECT AVG(order_amount) FROM order_table)
);

-- Query 2: Products with MRP higher than average MRP (Simple Subquery with comparison)
SELECT product_name, MRP 
FROM product 
WHERE MRP > (SELECT AVG(MRP) FROM product);

-- Query 3: Find the most expensive product (Subquery with MAX)
SELECT product_name, MRP 
FROM product 
WHERE MRP = (SELECT MAX(MRP) FROM product);

-- Query 4: Customers who have never placed an order (NOT IN Subquery)
SELECT FirstName, LastName 
FROM customer 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM order_table WHERE customer_id IS NOT NULL);

-- Query 5: Products that have never been reviewed (NOT IN Subquery)
SELECT product_name 
FROM product 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM review WHERE product_id IS NOT NULL);

-- Query 6: Sellers whose products have been ordered (IN with nested joins)
SELECT seller_name 
FROM seller 
WHERE seller_id IN (
    SELECT DISTINCT p.seller_id 
    FROM product p 
    JOIN cart c ON p.product_id = c.product_id
);

-- Query 7: Categories with products priced above 5000 (Subquery with WHERE)
SELECT category_name 
FROM category 
WHERE category_id IN (
    SELECT category_id 
    FROM product 
    WHERE MRP > 5000
);

-- Query 8: Correlated Subquery - Find customers who spent more than their city's average
SELECT c.FirstName, c. LastName, a.city
FROM customer c
JOIN address a ON c.customer_id = a. customer_id
WHERE (
    SELECT COALESCE(SUM(o.order_amount), 0)
    FROM order_table o
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(o2.order_amount)
    FROM order_table o2
    JOIN customer c2 ON o2.customer_id = c2.customer_id
    JOIN address a2 ON c2.customer_id = a2.customer_id
    WHERE a2.city = a. city
);

-- Query 9: Find products sold by the seller with highest total sales (Nested subquery)
SELECT product_name, MRP 
FROM product 
WHERE seller_id = (
    SELECT seller_id 
    FROM seller 
    WHERE total_sales = (SELECT MAX(total_sales) FROM seller)
);

-- Query 10:  Customers who ordered products from category 'Mobiles & Computer' (Multi-level nested)
SELECT FirstName, LastName 
FROM customer 
WHERE customer_id IN (
    SELECT o.customer_id 
    FROM order_table o
    JOIN cart c ON o.cart_id = c.cart_id
    JOIN product p ON c. product_id = p.product_id
    WHERE p.category_id = (
        SELECT category_id 
        FROM category 
        WHERE category_name = 'Mobiles & Computer'
    )
);

-- Query 11: Products with rating higher than average rating (Subquery with GROUP BY)
SELECT p.product_name 
FROM product p
WHERE p.product_id IN (
    SELECT r.product_id
    FROM review r
    GROUP BY r.product_id
    HAVING AVG(CAST(r.rating AS DECIMAL(3,2))) > (
        SELECT AVG(CAST(rating AS DECIMAL(3,2))) FROM review
    )
);

-- Query 12: Find the second highest priced product (Subquery for ranking)
SELECT product_name, MRP 
FROM product 
WHERE MRP = (
    SELECT MAX(MRP) 
    FROM product 
    WHERE MRP < (SELECT MAX(MRP) FROM product)
);

-- Query 13: Correlated - Products more expensive than avg in their category
SELECT p1.product_name, p1.MRP, c.category_name
FROM product p1
JOIN category c ON p1.category_id = c.category_id
WHERE p1.MRP > (
    SELECT AVG(p2.MRP)
    FROM product p2
    WHERE p2.category_id = p1.category_id
);

-- Query 14: Correlated - Orders with amount greater than customer's average order
SELECT o1.order_id, o1.order_amount, c.FirstName
FROM order_table o1
JOIN customer c ON o1.customer_id = c.customer_id
WHERE o1.order_amount > (
    SELECT AVG(o2.order_amount)
    FROM order_table o2
    WHERE o2.customer_id = o1.customer_id
);

-- Query 15: Find sellers who have products in more than one category (Subquery with HAVING)
SELECT seller_name 
FROM seller 
WHERE seller_id IN (
    SELECT seller_id 
    FROM product 
    GROUP BY seller_id 
    HAVING COUNT(DISTINCT category_id) > 1
);

-- Query 16: Customers who bought products reviewed with 5 stars (Nested IN subqueries)
SELECT DISTINCT c.FirstName, c. LastName
FROM customer c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM order_table o
    JOIN cart ct ON o.cart_id = ct.cart_id
    WHERE ct.product_id IN (
        SELECT product_id
        FROM review
        WHERE rating = '5'
    )
);

-- Query 17: Products cheaper than all Apple products (ALL operator)
SELECT product_name, MRP, brand
FROM product
WHERE MRP < ALL (
    SELECT MRP 
    FROM product 
    WHERE brand = 'Apple'
);

-- Query 18: EXISTS - Customers who have written at least one review
SELECT c.FirstName, c.LastName
FROM customer c
WHERE EXISTS (
    SELECT 1 
    FROM review r 
    WHERE r.customer_id = c.customer_id
);

-- Query 19: NOT EXISTS - Sellers with no products sold
SELECT s.seller_name
FROM seller s
WHERE NOT EXISTS (
    SELECT 1
    FROM product p
    JOIN cart c ON p.product_id = c.product_id
    WHERE p.seller_id = s.seller_id
);

-- Query 20: Find products in the same price range as iPhone (Range subquery)
SELECT p1.product_name, p1.MRP
FROM product p1
WHERE p1.MRP BETWEEN (
    SELECT MRP - 5000 FROM product WHERE product_name = 'i phone 15'
) AND (
    SELECT MRP + 5000 FROM product WHERE product_name = 'i phone 15'
)
AND p1.product_name != 'i phone 15';


-- ========================================
-- END OF QUERIES
-- Total Queries: 46 (exceeds all minimum requirements)
-- ========================================
