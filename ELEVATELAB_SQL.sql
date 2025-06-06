--select * from INFORMATION_SCHEMA.TABLES
-- create database Revision

-- use Revision

select * from sales
select * from SalesOrder
select * from Products
select * from Returns
select * from People

-- Fetching Customer ID,Customer Name,City,Category,Sub-Category, Quantity,Sales,Discount,Profit
select [Customer ID],[Customer Name],City,Category,[Sub-Category], 
Quantity,Sales,Discount,Profit from SalesOrder

-- Fetching records where qunatity is grater than 5
select [Customer ID],[Customer Name],City,Category,[Sub-Category], 
Quantity,Sales,Discount,Profit from SalesOrder where Quantity > 5

-- Category wise total quantity, total sale, total profit
select Category, City,sum(Quantity) as Tot_quantity ,sum(sales) as Tot_sale, sum(profit) as Tot_profit 
from SalesOrder group by Category, City

select Category, City,sum(Quantity) as Tot_quantity ,sum(sales) as Tot_sale, sum(profit) as Tot_profit 
from SalesOrder where Profit > 1000 group by Category, City order by City asc

--Total count of Category
select distinct(category), count(Category) as category_count  from SalesOrder group by Category

--Category wise Average Profit
select distinct([Sub-Category]), count(Category) as category_count, avg(Profit) as Avg_Profit 
from SalesOrder group by [Sub-Category]

-- Sale start date , end date and today days count
select min([order date]) as start_date,max([order date]) as end_date, count(*) as days_count
from SalesOrder

-- Region wise total sale, Profit and count of order
SELECT REGION, SUM(SALES) AS TOTAL_SALES,
SUM(PROFIT) AS PROFITS,
COUNT(*) AS ORDER_COUNT
FROM SALESORDER GROUP BY REGION

--Region and category wise total
SELECT REGION, CATEGORY, SUM(SALES) AS TOT_SALES
FROM SALESORDER GROUP BY ROLLUP (REGION, CATEGORY)
ORDER BY REGION desc

--Category and sub category wise order count and max discount

SELECT CATEGORY,[SUB-CATEGORY] ,
COUNT(*) AS ORDER_COUNT, MAX(DISCOUNT) AS MAX_DISCOUNT 
FROM SALESORDER GROUP BY ROLLUP (CATEGORY, [SUB-CATEGORY])
ORDER BY CATEGORY ASC, [SUB-CATEGORY] desc

SELECT SALES,PROFIT,ABS(PROFIT) AS PO FROM SALESORDER

--- VIEW---
CREATE VIEW VIEW_01 AS 
select [Customer ID],[Customer Name],City,Category,[Sub-Category], 
Quantity,Sales,Discount,Profit from SalesOrder where Quantity > 5

SELECT * FROM VIEW_01



--- JOINTS--

-- IDENTIFY CUSTOMER NAMES OF THE ORDERS THAT ARE RETURNED 

SELECT SO.[Customer Name] FROM SALESORDER SO INNER JOIN RETURNS RT ON SO.[Order ID]=RT.[Order ID]

-- IDENTIFY NO OF CUSTOMERS OF THE ORDERS THAT ARE RETURNED 

SELECT COUNT(*) FROM SALESORDER SO INNER JOIN RETURNS RT ON SO.[Order ID]=RT.[Order ID]

-- GET YES IF ORDER ID IS RETURNED ELSE NO IF AN ORDER ID IS NOT RETURNED
SELECT SO.[Order ID],RT.Returned FROM SALESORDER SO LEFT JOIN RETURNS RT ON SO.[Order ID]=RT.[Order ID]


SELECT SO.[Order ID],COALESCE(RT.Returned,'No') AS Order_status FROM SALESORDER SO LEFT JOIN RETURNS RT 
ON SO.[Order ID]=RT.[Order ID]

