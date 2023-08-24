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
FROM sales_reps
JOIN region
	ON sales_reps.region_id = region.id
GROUP BY region.name
ORDER BY total_sales_reps



-- ##### GROUP BY Part II





-- For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT
	name,
	AVG(standard_qty) AS avg_quantity_standard,
	AVG(gloss_qty) AS avg_quantity_gloss,
	AVG(poster_qty) AS avg_quantity_poster
FROM orders
JOIN accounts
 ON orders.account_id = accounts.id
GROUP BY name

-- For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT
	name,
	AVG(standard_amt_usd) AS avg_amount_standard,
	AVG(gloss_amt_usd) AS avg_amount_gloss,
	AVG(poster_amt_usd) AS avg_amount_poster
FROM orders
JOIN accounts
 ON orders.account_id = accounts.id
GROUP BY name


-- Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT 
	sales_reps.name AS sales_rep_name,
	channel AS channle_name,
	COUNT(channel) AS total_occurrences
FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN web_events
	ON accounts.id = web_events.account_id
GROUP BY sales_rep_name, channle_name
ORDER BY total_occurrences DESC


-- Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT 
	region.name AS region_name,
	web_events.channel AS channel_name,
	COUNT(channel) AS number_of_occurence
FROM accounts
JOIN web_events
	ON accounts.id = web_events.account_id
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id
GROUP BY region_name, channel_name
ORDER BY number_of_occurence DESC




-- #### DISTINCT , HAVING


-- ## DISTINCT
-- Use DISTINCT to test if there are any accounts associated with more than one region.

SELECT DISTINCT 
	accounts.id,
	region.name
FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
JOIN region
	ON sales_reps.region_id = region.id


-- Have any sales reps worked on more than one account?

SELECT DISTINCT
	accounts.id,
	sales_reps.name
FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id


-- ## HAVING
-- How many of the sales reps have more than 5 accounts that they manage?

SELECT DISTINCT
	sales_reps.id AS sales_reps_id,
	COUNT(accounts.id) AS number_account_managed
FROM accounts
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
GROUP BY sales_reps.id
HAVING COUNT(accounts.id) > 5
ORDER BY number_account_managed DESC

-- How many accounts have more than 20 orders?

SELECT 
	accounts.id AS account,
	COUNT(orders.total) AS orders
	
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY account
HAVING COUNT(orders.total) > 20
ORDER BY orders

-- Which account has the most orders?

SELECT 
	accounts.id AS account,
	COUNT(orders.total) AS orders
	
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY account
HAVING COUNT(orders.total) > 20
ORDER BY orders DESC
LIMIT 1

-- Which accounts spent more than 30,000 usd total across all orders?

SELECT 
	accounts.id AS account,
	SUM(orders.total_amt_usd) AS orders_total_amt_usd
	
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY account
HAVING SUM(orders.total_amt_usd) > 30000
ORDER BY orders_total_amt_usd DESC

-- Which accounts spent less than 1,000 usd total across all orders?
SELECT 
	accounts.id AS account,
	SUM(orders.total_amt_usd) AS orders_total_amt_usd
	
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY account
HAVING SUM(orders.total_amt_usd) < 1000
ORDER BY orders_total_amt_usd

-- Which account has spent the most with us?
SELECT 
	accounts.id AS account,
	SUM(orders.total_amt_usd) AS orders_total_amt_usd
	
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY account
ORDER BY orders_total_amt_usd DESC
LIMIT 1

-- Which account has spent the least with us?
SELECT 
	accounts.id AS account,
	SUM(orders.total_amt_usd) AS orders_total_amt_usd
	
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY account
ORDER BY orders_total_amt_usd
LIMIT 1

-- Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT 
	account_id,
	COUNT(channel) AS contacted_times
FROM web_events
JOIN accounts
	ON web_events.account_id = accounts.id
WHERE channel = 'facebook'
GROUP BY account_id
HAVING COUNT(channel) > 6
ORDER BY contacted_times

-- Which account used facebook most as a channel?

SELECT 
	account_id,
	COUNT(channel) AS contacted_times
FROM web_events
JOIN accounts
	ON web_events.account_id = accounts.id
WHERE channel = 'facebook'
GROUP BY account_id
ORDER BY contacted_times DESC
LIMIT 1

-- Which channel was most frequently used by most accounts?

SELECT 
	accounts.id,
	accounts.name,
	channel,
	COUNT(channel) AS contacted_times
FROM web_events
JOIN accounts
	ON web_events.account_id = accounts.id
GROUP BY accounts.id,channel, accounts.name
ORDER BY contacted_times DESC
LIMIT 10




-- ## DATE Functions

-- Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?

SELECT
	DATE_TRUNC('year', occurred_at) AS time_frame_year,
	SUM(total_amt_usd) AS total_sale_usd
FROM orders
GROUP BY 1
ORDER BY 2 DESC

	-- ====> Yes, i can see that when from 2013 to 2016 the sales are continously increasing but for 2017 it's the lowest amount. To see that reason why the total sale is falling	we can can see if we breakdown by months 2017 it's just the first month sales and the rest 11 month is still to go.




-- Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
SELECT
	DATE_TRUNC('month', occurred_at) AS time_frame_month,
	SUM(total_amt_usd) AS total_sale_usd
FROM orders
GROUP BY 1
ORDER BY 2 DESC

	-- ====> December 2016 "2016-12-01 00:00:00" is the month which has the greated sales in terms of total dollars which is 1770282.62 USD. Yes, all months are evenly represented by the dataset.



-- Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

SELECT 
	DATE_TRUNC('year', occurred_at) AS time_period_year,
	SUM(total) AS total_order_qty
FROM orders
GROUP BY 1
ORDER BY 2 DESC

	-- ====> The year 2016 "2016-01-01 00:00:00" with total number of order quantity 2041600 has the greatest sales and Yes, all the years are eveenly represented by the dataset.


-- Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?

SELECT
	DATE_TRUNC('month', occurred_at) AS time_frame_month,
	SUM(total) AS total_sales_qty
FROM orders
GROUP BY 1
ORDER BY 2 DESC

-- ====> December 2016 "2016-12-01 00:00:00"	with the total amount of 271062 is the greatest sales that perch &posey have so far.


-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT 
	DATE_TRUNC('month', orders.occurred_at) AS order_time_frame,
	SUM(gloss_amt_usd) AS gloss_amt_usd
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
WHERE accounts.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC

	-- ====> In 2016, May (05) "2016-05-01 00:00:00" Walmart spent 9257.64 USD the most on gloss paper in terms of dollars.







-- ## CASE statement

-- Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.

SELECT
	CASE WHEN total_amt_usd >= 3000 THEN 'Large'
		 WHEN total_amt_usd <= 3000 THEN 'Small'
		 ELSE 'Other' END AS level_of_order,
	account_id,
	total_amt_usd
FROM orders



-- Write a query to display the number of orders in each of three categories, based on the 'total' amount of each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.

SELECT
	CASE WHEN total < 1000 THEN 'Less than 1000'
		 WHEN total >= 1000 AND total <= 2000 THEN 'Between 1000 and 2000'
		 WHEN total > 2000 THEN 'At Least 2000'
		 ELSE 'Un-specified' END AS order_categories,
	total AS number_of_orders
FROM orders

-- We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.

SELECT
	accounts.name,
	SUM(orders.total_amt_usd),
	CASE WHEN SUM(orders.total_amt_usd) > 200000 THEN 'Lifetime Value'
		 WHEN SUM(orders.total_amt_usd) >= 100000 AND SUM(orders.total_amt_usd) <= 200000 THEN 'Second level'
		 ELSE 'Lowest level' END AS the_level
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY 2 DESC

-- We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.

SELECT
	DATE_TRUNC('year', occurred_at) AS year_order_placed,
	accounts.name,
	SUM(orders.total_amt_usd),
	CASE WHEN SUM(orders.total_amt_usd) > 200000 THEN 'Lifetime Value'
		 WHEN SUM(orders.total_amt_usd) >= 100000 AND SUM(orders.total_amt_usd) <= 200000 THEN 'Second level'
		 ELSE 'Lowest level' END AS the_level
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
WHERE DATE_TRUNC('year', occurred_at) >= '2016-01-01' AND DATE_TRUNC('year', occurred_at) <= '2017-12-31'
GROUP BY accounts.name, year_order_placed
ORDER BY 3 DESC

-- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.


SELECT DISTINCT
	sales_reps.name,
	COUNT(orders.total) AS total_num_orders,
	CASE WHEN COUNT(orders.total) > 200 THEN 'Top sales rep'
		 ELSE 'Not top sales rep' END AS sales_rep_status
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
GROUP BY sales_reps.name
ORDER BY total_num_orders DESC

-- The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!

SELECT
	sales_reps.name,
	COUNT(orders.total) AS total_order_placed,
	SUM(orders.total_amt_usd) AS total_sales_usd,
	CASE WHEN COUNT(orders.total) > 200 AND SUM(orders.total_amt_usd) > 750000 THEN 'Top Group'
		 WHEN COUNT(orders.total) > 150 AND SUM(orders.total_amt_usd) > 500000 THEN 'Middle Group'
		 ELSE 'Low Group' END AS sales_rep_rank
FROM orders
JOIN accounts
	ON orders.account_id = accounts.id
JOIN sales_reps
	ON accounts.sales_rep_id = sales_reps.id
GROUP BY sales_reps.name
ORDER BY total_sales_usd DESC, total_order_placed DESC