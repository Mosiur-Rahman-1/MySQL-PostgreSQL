-- Try using LIMIT yourself below by writing a query that displays all the data in the occurred_at, account_id, and channel columns of the web_events table, and limits the output to only the first 15 rows.
SELECT channel, account_id, occurred_at
FROM web_events
LIMIT 15


-- ### ORDER BY




SELECT channel, account_id, occurred_at
FROM web_events
ORDER BY account_id DESC
LIMIT 1000

-- Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
SELECT  id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10

-- Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5


-- Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20


-- Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC
LIMIT 200

-- Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id
LIMIT 200

-- Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5

-- Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10

-- Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'

-- Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

SELECT 
	id, 
	account_id,
	standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10

-- Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also.

SELECT id, account_id, 
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

-- Use the accounts table to find
-- All the companies whose names start with 'C'.

SELECT name
FROM accounts
WHERE name LIKE 'C%';

-- All companies whose names contain the string 'one' somewhere in the name.
SELECT name
FROM accounts
WHERE name LIKE '%one%';

-- All companies whose names end with 's'.
SELECT name
FROM accounts
WHERE name LIKE '%s';

-- Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')

-- Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')

-- Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom')

-- Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')

-- All the companies whose names do not start with 'C'.
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%'

-- All companies whose names do not contain the string 'one' somewhere in the name.
SELECT *
FROM accounts
WHERE name NOT LIKE '%one%'

-- All companies whose names do not end with 's'.
SELECT *
FROM accounts
WHERE name NOT LIKE '%s'

-- Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0

-- Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name NOT LIKE '%s'

-- When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.

SELECT *
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29

-- Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') 
AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC

-- Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000

-- Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000)

-- Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
  AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
  AND primary_poc NOT LIKE '%eana%')





-- ##### SQL Joins



-- Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT *
FROM accounts
JOIN orders
	ON accounts.id = orders.account_id


-- Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
SELECT 
	website,
	primary_poc,
	standard_qty,
	gloss_qty,
	poster_qty
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id

--Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

SELECT 
	primary_poc,
	occurred_at AS time_of_the_event,
	channel,
	name
FROM web_events
JOIN accounts
	ON web_events.account_id = accounts.id
WHERE accounts.name = 'Walmart'


--Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

-- Here i use the alias as follows without the AS keywords.
	 r for region,
	 s for sales_reps,
	 a for accounts

SELECT 
	r.name AS region_name,
	s.name AS sales_rep_name,
	a.name AS accounts_name
FROM sales_reps s
JOIN region r
	ON s.region_id = r.id
JOIN accounts a
	ON s.id = a.sales_rep_id
ORDER BY a.name


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

--In this example i learned about how ERD model is so helpful for to conncet and find the data we need. With the help of ERD model we can easily see the connecting between the data tables and their FK and PK.

SELECT 
	region.name AS region_name,
	accounts.name AS account_name,
	orders.total_amt_usd/(orders.total + 0.01) AS unit_price
	
FROM region
JOIN sales_reps
	ON region.id = sales_reps.region_id
JOIN accounts
	ON sales_reps.id = accounts.sales_rep_id
JOIN orders
	ON accounts.id = orders.account_id





-- #### JOINs and Filtering





--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT 
	region.name AS region_name,
	sales_reps.name AS sales_rep_name,
	accounts.name AS account_name

FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
	AND region.name = 'Midwest'
ORDER BY accounts.name

-- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT
	region.name AS region_name,
	sales_reps.name AS sales_reps_name,
	accounts.name AS account_name
FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
	AND region.name = 'Midwest'
	AND sales_reps.name LIKE 'S%'
ORDER BY accounts.name

-- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT
	region.name AS region_name,
	sales_reps.name AS sales_reps_name,
	accounts.name AS account_name
FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
	AND region.name = 'Midwest'
	AND sales_reps.name LIKE '% K%'
ORDER BY accounts.name

-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

SELECT 
	region.name AS region_name,
	accounts.name AS account_name,
	orders.total_amt_usd / (orders.total + 0.01) AS unit_price
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
	AND orders.standard_qty > 100



-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT 
	region.name AS region_name,
	accounts.name AS account_name,
	orders.total_amt_usd / (orders.total + 0.01) AS unit_price
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
	AND orders.standard_qty > 100
	AND orders.poster_qty > 50


-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT 
	region.name AS region_name,
	accounts.name AS account_name,
	orders.total_amt_usd / (orders.total + 0.01) AS unit_price
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
	AND orders.standard_qty > 100
	AND orders.poster_qty > 50
ORDER BY unit_price DESC



-- What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.

SELECT DISTINCT
	accounts.name AS account_name,
	web_events.channel AS channel
FROM accounts
JOIN web_events
	ON accounts.id = web_events.account_id
	AND accounts.id = 1001


-- Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
-- #Important when work with date and BETWEEN keyword make sure the date is written as follows. Else the months last dates will be left out.
SELECT
	orders.occurred_at,
	accounts.name,
	orders.total,
	orders.total_amt_usd
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
	AND occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY orders.occurred_at



-- ##### SQL Aggregations




-- Find the total amount of poster_qty paper ordered in the orders table.
SELECT SUM(poster_qty)
FROM orders

-- Find the total amount of standard_qty paper ordered in the orders table.
SELECT SUM(standard_qty)
FROM orders

-- Find the total dollar amount of sales using the total_amt_usd in the orders table.
SELECT SUM(total_amt_usd)
FROM orders


-- Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;


-- Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

-- When was the earliest order ever placed? You only need to return the date.

SELECT MIN(occurred_at) AS earliest_date_order_place
FROM orders

-- Try performing the same query as in question 1 without using an aggregation function.
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1

-- When did the most recent (latest) web_event occur?
SELECT MAX(occurred_at) AS latest_event_occurred_at
FROM web_events

-- Try to perform the result of the previous query without using an aggregation function.

SELECT occurred_at AS latest_event_occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1

-- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
SELECT 
	AVG(standard_qty) AS mean_standard_qty,
	AVG(gloss_qty) AS mean_gloss_qty,
	AVG(poster_qty) AS mean_poster_qty,
	AVG(standard_amt_usd) AS mean_standard_amt_usd,
	AVG(gloss_amt_usd) AS mean_gloss_amt_usd,
	AVG(poster_amt_usd) AS mean_poster_amt_usd
FROM orders


-- Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?






-- #### Questions: GROUP BY

-- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

SELECT 
	name AS account_name,
	occurred_at AS date
FROM accounts
JOIN orders
	ON accounts.id = orders.account_id
ORDER BY orders.occurred_at
LIMIT 1

-- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

SELECT
	accounts.name,
	SUM(orders.total_amt_usd) AS total_sales_amt_usd
	
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY total_sales_amt_usd DESC

-- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

SELECT 
	occurred_at AS date,
	channel,
	name
FROM web_events
JOIN accounts
	ON web_events.account_id = accounts.id
ORDER BY occurred_at DESC
LIMIT 1

-- Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

SELECT 
	channel,
	COUNT(channel) AS number_of_time_used
FROM web_events
GROUP BY channel

-- Who was the primary contact associated with the earliest web_event?

SELECT 
	primary_poc,
	occurred_at
FROM web_events
JOIN accounts
	ON web_events.account_id = accounts.id
ORDER BY occurred_at
LIMIT 1

-- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

SELECT 
	name,
	MIN(total_amt_usd) AS total_usd
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY name
ORDER BY total_usd

-- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.

SELECT 
	region.name AS region_name,
	COUNT(sales_reps.id) AS total_sales_reps
FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
GROUP BY region.name
ORDER BY total_sales_reps