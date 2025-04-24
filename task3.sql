use chinook;
# 1. SELECT, WHERE, ORDER BY, GROUP BY
# To get the number of invoices per TOP 10 country, sorted from highest to lowest.
# Answer: Shows how many purchases (invoices) came from TOP 10 country.

select Billingcountry,
	count(*) as Total_Invoices
from invoice
group by BillingCountry
order by Total_invoices desc
LIMIT 10;
-------------------------
use chinook;
# 2. INNER JOIN, LEFT JOIN, RIGHT JOIN
# Question: Get the first name of customers and their invoice totals. Use INNER JOIN.
# Answer: Only customers who made at least one invoice are shown.

select c.firstname,
		i.Total as invoice_Total
from invoice i 
left join customer c 
	using(CustomerId)

-------------------------
use chinook;
# 3. SUBQUERIES
# Find customers who have spent more than $30 in total.
# Returns only those customers who have spent more than $30 total.

select firstname,
		lastname
from customer c
where CustomerId in (
	select CustomerId 
    from invoice
	group by CustomerId
	having sum(Total) > 30)

-------------------------
use chinook;
--  4. Aggregate Functions – SUM, AVG, COUNT.
# What is the average and total invoice value based on each country?
# Gives overall business revenue and average per country.

select BillingCountry,
		avg(total) as Average_Invoice,
		sum(total) as Total_Revenue
        
from invoice
group by BillingCountry

-------------------------
use chinook;
# 5. Create a view to show all Canadian customers.
# After creating view we can run (SELECT * FROM Canadian_Customers); like a real table.

create view Canadian_Customers as
select * from customer
where Country = 'canada';

create view Ind_Customers as
select * from customer
where Country = 'India';

select * from Canadian_Customers;
select * from ind_Customers;

-------------------------

use chinook;
# Handling NULL Values
# Replace null values in the State field with ‘Not Provided’.

-- For diplaying NULL values
select firstname,lastname,state
from customer
where State is null;

-- To delete NULL values
delete from	customers
where State IS NULL;

# How to Replace NULL Values with Custom Text
# Replace NULL values in the State column with "Unknown".
select firstname, lastname, coalesce(State, 'Unknown') as State
from customer;
# COALESCE() works in MySQL, PostgreSQL, and SQLite.)

-------------------------
use chinook;

#  Query Optimization with Indexes
# Add an index on the CustomerId column of the invoices table to optimize lookup.
# Speeds up queries using WHERE CustomerId = , or joins with customers.


SELECT * FROM invoice
WHERE CustomerId = 10;

create index id_cust on invoice(customerid);

SELECT * FROM invoice
WHERE CustomerId = 10;

SHOW INDEX FROM invoice;
drop index id_cust on invoice;
