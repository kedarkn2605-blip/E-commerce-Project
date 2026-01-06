-- ======================================== 
-- E-COMMERCE DATABASE - SQL QUERIES 
-- Student:  Sanskruti-333 
-- Student:  Nivrutti-332 
-- Student:  Kedar-323 
-- Project: E-Commerce Database Management System 
-- ========================================

/MULTIPLE TABLE JOIN OPERATIONS — 9 Queries/
--Q1. Write a SQL query to display customer name, product name, and order amount for all delivered orders.
SELECT c.FirstName, p.product_name, o.order_amount
FROM customer c, product p, cart ca, order_table o
WHERE c.customer_id = ca.customer_id
  AND ca.product_id = p.product_id
  AND ca.cart_id = o.cart_id
  AND o.order_status = 'delivery';
  
--Q2. Write a SQL query to list customer name, city, and order date.
SELECT c.FirstName, a.city, o.order_date
FROM customer c, address a, order_table o
WHERE c.customer_id = a.customer_id
  AND c.customer_id = o.customer_id;

--Q3. Write a SQL query to show product name, category name, and seller name.
SELECT p.product_name, cat.category_name, s.seller_name
FROM product p, category cat, seller s
WHERE p.category_id = cat.category_id
  AND p.seller_id = s.seller_id;

--Q4. Write a SQL query to display customer name, payment mode, and payment date.
SELECT c.FirstName, pay.paymentMode, pay.dateofpayment
FROM customer c, payment pay
WHERE c.customer_id = pay.customer_id;

--Q5. Write a SQL query to display product name, review rating, and customer name.
SELECT p.product_name, r.rating, c.FirstName
FROM product p, review r, customer c
WHERE p.product_id = r.product_id
  AND r.customer_id = c.customer_id;

--Q6. Write a SQL query to list seller name, product name, and stock.
SELECT s.seller_name, p.product_name, p.stock
FROM seller s, product p
WHERE s.seller_id = p.seller_id;

--Q7. Write a SQL query to display order id, customer name, and total amount.
SELECT o.order_id, c.FirstName, o.order_amount
FROM order_table o, customer c
WHERE o.customer_id = c.customer_id;

--Q8. Write a SQL query to show product name, order quantity, and order date.
SELECT p.product_name, oi.quantity, o.order_date
FROM product p, orderitem oi, order_table o
WHERE p.product_id = oi.product_id
  AND oi.order_id = o.order_id;

--Q9. Write a SQL query to list customer name, product name, and seller name.
SELECT c.FirstName, p.product_name, s.seller_name
FROM customer c, cart ca, product p, seller s
WHERE c.customer_id = ca.customer_id
  AND ca.product_id = p.product_id
  AND p.seller_id = s.seller_id;

/2) DIFFERENT OPERATORS — 9 Queries/

--Q10. Write a SQL query to find products priced greater than 5000.
SELECT product_name, MRP
FROM product
WHERE MRP > 5000;

--Q11. Write a SQL query to list customers whose age is not updated.
SELECT FirstName
FROM customer
WHERE age = 0;

--Q12. Write a SQL query to find products between 1000 and 3000.
SELECT product_name, MRP
FROM product
WHERE MRP BETWEEN 1000 AND 3000;

--Q13. Write a SQL query to find sellers with total sales above 60000.
SELECT seller_name
FROM seller
WHERE total_sales > 60000;

--Q14. Write a SQL query to find customers from Karnataka or Maharashtra.
SELECT FirstName
FROM customer c, address a
WHERE c.customer_id = a.customer_id
  AND a.state IN ('Karnataka','Maharashtra');

--Q15. Write a SQL query to find products whose name starts with ‘S’.
SELECT product_name
FROM product
WHERE product_name LIKE 'S%';

--Q16. Write a SQL query to find orders not delivered.
SELECT order_id
FROM order_table
WHERE order_status = 'not delivery';

--Q17. Write a SQL query to list reviews with rating > 4.
SELECT description
FROM review
WHERE rating > 4;

--Q18. Write a SQL query to find customers whose email contains '.com'.
SELECT FirstName
FROM customer
WHERE Email LIKE '%.com%';


/3) GROUP BY & HAVING — 12 Queries/

--Q19. Write a SQL query to find number of products in each category.
SELECT category_id, COUNT(*) 
FROM product
GROUP BY category_id;

--Q20. Write a SQL query to find average product price per seller.
SELECT seller_id, AVG(MRP)
FROM product
GROUP BY seller_id;

--Q21. Write a SQL query to find customers who placed more than one order.
SELECT customer_id, COUNT(order_id)
FROM order_table
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

--Q22. Write a SQL query to find total sales per seller having sales above 50000.
SELECT seller_name, total_sales
FROM seller
GROUP BY seller_name, total_sales
HAVING total_sales > 50000;

--Q23. Write a SQL query to find number of reviews per product.
SELECT product_id, COUNT(review_id)
FROM review
GROUP BY product_id;

--Q24. Write a SQL query to find average rating per product having average rating above 4.
SELECT product_id, AVG(rating)
FROM review
GROUP BY product_id
HAVING AVG(rating) > 4;

--Q25. Write a SQL query to find total order amount per customer.
SELECT customer_id, SUM(order_amount)
FROM order_table
GROUP BY customer_id;

--Q26. Write a SQL query to find products ordered more than once.
SELECT product_id, COUNT(order_id)
FROM orderitem
GROUP BY product_id
HAVING COUNT(order_id) > 1;

--Q27. Write a SQL query to find payment mode usage count.
SELECT paymentMode, COUNT(*)
FROM payment
GROUP BY paymentMode;

--Q28. Write a SQL query to find cities having more than one customer.
SELECT city, COUNT(customer_id)
FROM address
GROUP BY city
HAVING COUNT(customer_id) > 1;

--Q29. Write a SQL query to find total quantity ordered per product.
SELECT product_id, SUM(quantity)
FROM orderitem
GROUP BY product_id;

--Q30. Write a SQL query to find sellers selling more than one product.
SELECT seller_id, COUNT(product_id)
FROM product
GROUP BY seller_id
HAVING COUNT(product_id) > 1;

/4) SUB-QUERIES & CORRELATED NESTED QUERIES — 18 Queries/


--Q31. Write a SQL query to find customers who placed orders.
SELECT FirstName
FROM customer
WHERE customer_id IN (SELECT customer_id FROM order_table);

--Q32. Write a SQL query to find products with price higher than average price.
SELECT product_name
FROM product
WHERE MRP > (SELECT AVG(MRP) FROM product);

--Q33. Write a SQL query to find customers who paid online.
SELECT FirstName
FROM customer
WHERE customer_id IN
 (SELECT customer_id FROM payment WHERE paymentMode='online');

--Q34. Write a SQL query to find sellers with products in cart.
SELECT seller_name
FROM seller
WHERE seller_id IN
 (SELECT seller_id FROM product WHERE product_id IN
   (SELECT product_id FROM cart));

--Q35. Write a SQL query to find customers who reviewed products.
SELECT FirstName
FROM customer
WHERE customer_id IN (SELECT customer_id FROM review);

--Q36. Write a SQL query to find highest priced product.
SELECT product_name
FROM product
WHERE MRP = (SELECT MAX(MRP) FROM product);

--Q37. Write a SQL query to find customers having more orders than average.
SELECT customer_id
FROM order_table
GROUP BY customer_id
HAVING COUNT(order_id) >
 (SELECT AVG(COUNT(order_id)) FROM order_table GROUP BY customer_id);

--Q38. Write a SQL query to find products not reviewed.
SELECT product_name
FROM product
WHERE product_id NOT IN (SELECT product_id FROM review);

--Q39. Write a SQL query to find customers from cities having more than one customer.
SELECT FirstName
FROM customer c, address a
WHERE c.customer_id = a.customer_id
  AND a.city IN (
    SELECT city FROM address GROUP BY city HAVING COUNT(*) > 1
  );

--Q40. Write a SQL query to find sellers whose total sales is above average.
SELECT seller_name
FROM seller
WHERE total_sales > (SELECT AVG(total_sales) FROM seller);

--Q41. Write a SQL query to find customers who ordered products costing more than the average product price.
SELECT DISTINCT c.FirstName
FROM customer c, cart ca, product p
WHERE c.customer_id = ca.customer_id
  AND ca.product_id = p.product_id
  AND p.MRP >
      (SELECT AVG(MRP) FROM product);
--Q42. Write a SQL query to find products whose stock is less than the average stock of all products.

SELECT product_name, stock
FROM product
WHERE stock <
      (SELECT AVG(stock) FROM product);
--Q43. Write a SQL query to find customers who have given the highest rating in reviews.

SELECT FirstName
FROM customer
WHERE customer_id IN
 (
   SELECT customer_id
   FROM review
   WHERE rating =
         (SELECT MAX(rating) FROM review)
 );
 
--Q44. Write a SQL query to find bottom 5 sellers who sell products ordered by one customer.

SELECT seller_name
FROM seller
WHERE seller_id IN
(
  SELECT p.seller_id
  FROM product p, cart c
  WHERE p.product_id = c.product_id
  GROUP BY p.seller_id
  HAVING COUNT(DISTINCT c.customer_id) = 1
) AND ROWNUM <= 5
ORDER BY seller_id desc;

--Q45. Write a SQL query to find customers whose total order amount is greater than the average total order amount of all customers.

SELECT customer_id
FROM order_table
GROUP BY customer_id
HAVING SUM(order_amount) >
(
  SELECT AVG(total_amt)
  FROM (
        SELECT SUM(order_amount) AS total_amt
        FROM order_table
        GROUP BY customer_id
       )
);

--Q46. Write a SQL query to find products that were ordered in quantities greater than the average quantity ordered.

SELECT product_id
FROM orderitem
GROUP BY product_id
HAVING SUM(quantity) >
(
  SELECT AVG(quantity)
  FROM orderitem
);
--Q47. Write a SQL query to find customers who live in the same city as the customer named 'Kedar'.

SELECT c.FirstName
FROM customer c, address a
WHERE c.customer_id = a.customer_id
  AND a.city =
      (
        SELECT a2.city
        FROM customer c2, address a2
        WHERE c2.customer_id = a2.customer_id
          AND c2.FirstName = 'Kedar'
      );
--Q48. Write a SQL query to find sellers whose products have received an average rating greater than 4.

SELECT seller_name
FROM seller
WHERE seller_id IN
(
  SELECT p.seller_id
  FROM product p, review r
  WHERE p.product_id = r.product_id
  GROUP BY p.seller_id
  HAVING AVG(r.rating) > 4
);
