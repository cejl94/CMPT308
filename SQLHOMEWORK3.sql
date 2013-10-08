-- Connor Loughlin
-- SQL Homework 3
-- 10/5/13
 
-- 1. Get the cities of agents booking an order for customer c002. Use a subquery.
SELECT city
FROM agents
WHERE aid IN
              (
                SELECT aid
                FROM orders
                WHERE cid = 'c002'
                )
ORDER BY city ASC;
 
-- 2. Get the cities of agents booking an order for customer c002. Use joins.
SELECT DISTINCT city
FROM agents INNER JOIN orders
ON orders.aid = agents.aid
WHERE cid = 'c002'
ORDER BY city ASC;
 
-- 3. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use subqueries.
SELECT DISTINCT pid
FROM orders
WHERE aid IN
              ( 
                SELECT aid
                FROM orders
                WHERE cid IN
                              ( SELECT cid
                                FROM customers
                                WHERE city = 'Kyoto')
              )
ORDER BY pid ASC;
 
-- 4. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use joins.
SELECT DISTINCT o2.pid
FROM orders o
INNER JOIN customers c ON o.cid = c.cid
INNER JOIN orders o2 ON o.aid = o2.aid
WHERE c.city = 'Kyoto'
ORDER BY pid ASC;
 
-- 5. Get the names of customers who have never placed an order. Use a subquery.
SELECT name
FROM customers
WHERE cid NOT IN
                  (
                  SELECT cid
                  FROM orders
                  );
 
-- 6. Get the names of customers who have never placed an order. Use an outer join.
SELECT c.name
FROM customers c LEFT OUTER JOIN orders o
ON o.cid = c.cid
WHERE o.cid IS NULL
ORDER BY c.cid;
 
-- 7. Get the names of customers who placed at least one order through an agent in their city, along with those agent(s) names.
SELECT DISTINCT c.name, a.name, c.city, a.name
FROM customers c
INNER JOIN orders o on c.cid = o.cid
INNER JOIN agents a ON a.aid = o.aid
WHERE c.city = a.city
ORDER BY c.name ASC;
 
-- 8. Get the names of customers and agents in the same city, along with the name of the city, regardless of whether or not the customer has ever placed an order with that agent.
SELECT c.city AS "City", c.name AS "Customer Name", a.name AS "Agent Name"
FROM customers c
INNER JOIN agents a ON a.city = c.city
ORDER BY c.city ASC;
 
-- 9. Get the name and city of customers who live in the city where the least number of products are made.
SELECT c.name, c.city
FROM customers c
WHERE c.city = (
                  SELECT city
                  FROM products
                  WHERE quantity = (
                                    SELECT min(quantity)
                                    FROM products)
                )
ORDER BY c.city ASC;
 
-- 10. Get the name and city of customers who live in a city where the most number of products are made.
SELECT c.name, c.city
FROM customers c
WHERE c.city = (
                  SELECT city
                  FROM products
                  WHERE quantity = (
                                      SELECT max(quantity)
                                      FROM products)
               )
ORDER BY c.city ASC;
 
-- 11. Get the name and city of customers who live in any city where the most number of products are made.
SELECT c.name, c.city
FROM customers c
WHERE c.city = (
                  SELECT city
                  FROM products
                  WHERE quantity = (
                                      SELECT max(quantity)
                                      FROM products)
               )
ORDER BY c.city ASC;
 
-- 12. List the products whose priceUSD is above the average priceUSD.
SELECT name
FROM products
WHERE priceUSD > (SELECT avg(priceUSD)
                  FROM products
                  );
 
-- 13. Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low.
SELECT c.name, o.pid, o.dollars
FROM orders o
INNER JOIN customers c on c.cid = o.cid
ORDER BY dollars DESC;
 
-- 14. Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.
SELECT c.name, coalesce(sum(o.qty), 0)
FROM customers c
LEFT OUTER JOIN orders o ON o.cid = c.cid
ORDER BY c.name ASC;
 
-- 15. Show the names of all customers who bought products from agents based in NEw York along with the names of the products they ordered, and the names of the agents who sold it to them.
SELECT c.name, p.name, a.name
FROM customers c
INNER JOIN orders o ON c.cid = o.cid
INNER JOIN products p ON p.pid = o.pid
INNER JOIN agents a ON a.aid = o.aid
WHERE a.city = 'New York'
ORDER BY c.name;
 
-- 16. Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from other data in other tables and then comparing those values to the values in Orders.dollars.
SELECT o.ordno, o.dollars, ((p.priceUSD * o.qty) - ((c.discount / 100) * (p.priceUSD * o.qty)))
FROM orders o
INNER JOIN products p ON o.pid = p.pid
INNER JOIN customers c ON o.cid = c.cid
AND o.dollars = ((p.priceUSD * o.qty) - ((c.discount / 100) * (p.priceUSD * o.qty)));
 
--17. Create an error in the dollars column of the Orders table so that you can verify your accuracy checking query.
UPDATE orders
SET dollars = 550.00
WHERE ordno = 1011;
