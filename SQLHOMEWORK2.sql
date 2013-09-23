--Connor Loughlin
--SQL Homework 2
--  9/22/13


--1 Get the cities of agents booking an order for customer c002
Select city
From agents
Where aid in (
				Select aid 
				from orders
				where cid = 'c002'
				);

--2 Get the pids of products ordered through any agent who makes 
--  at least one order for a customer in Kyoto

Select pid
from orders
where aid in(
	          Select aid
	          from orders
	          where cid in(
		                    Select cid
		                    from Customers
		                    Where city = 'Kyoto'
		                    )
		);	

--3 Find the cids and names of customers who never placed an order through agent a03

Select cid, name
from customers
where cid not in(
			       Select cid
			       from orders
			       where aid = 'a03'
			);

--4 Get the cids and names of customers who ordered both product p01 and p07

Select cid, name
from customers
where cid in(
		     Select cid
		     from orders
		     where pid = 'p07'
	      )
		
INTERSECT 
Select cid, name
from customers
where cid in(
		      Select cid
		      from orders
		      where pid = 'p01'
		);


		
--5 Get the pids of products ordered by any customers who ever placed an order through agent a03
Select pid 
From products 
Where pid in (
		       Select pid 
		       From orders 
		      Where aid = 'a03'
		);
--6 Get the names and discounts of all customers who place orders through agents in Dallas or Duluth

Select name, discount 
From customers 
Where cid in (
		Select cid 
		From orders 
		Where aid in (
				       Select aid 
				       From agents 
				       Where city = 'Dallas'
				       or city = 'Duluth'
				)
		);

--7 Find all customers who have the same discount as that of any customers in Dallas or Kyoto


Select name, cid 
From customers 
Where discount in (
					Select discount 
					From customers 
					Where city = 'Dallas'
					or city = 'Kyoto'
					) 
INTERSECT 
Select name, cid 
From customers 
Where city not in(
					select city 
					from customers 
					where city = 'Dallas'
					or city = 'Kyoto'
					);