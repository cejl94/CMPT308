Connor Loughlin 
SQL Homework 1
9/15/13


-- 1 List all data for all customers
select *
from customers

--2 List the name and city of agents named Smith
SELECT name, city 
FROM Agents 
WHERE name = 'Smith';

--3 List pid, name, and quantity of products costing more than us$1.25
SELECT pid, name, quantity
FROM products
WHERE priceUSD > 1.25;

--4 List the ordno and aid of all orders

SELECT ordno, aid
FROM orders

--5 List the names and cities of customers not in Dallas

SELECT name, city
FROM customers
WHERE city != 'Dallas'

--6 List the name of agents in New York or Newark
SELECT name
FROM Agents
WHERE city = 'New York' 
OR city = 'Newark';

--7 List all data for products not in New York or Newark that cost us$1 or less

SELECT *
FROM Products
WHERE city != 'New York'
AND city != 'Newark'
AND priceUSD <= 1.00;

--8 List all data for orders in January or March

SELECT *
FROM Orders
WHERE mon = 'jan'
OR mon = 'mar';

--9 List all data for orders in February less than us$100

SELECT *
FROM Orders
WHERE mon ='feb'
AND dollars < 100;

--10 List all orders from the customer whose cid is C005

Select *
FROM orders
WHERE cid ='c005';