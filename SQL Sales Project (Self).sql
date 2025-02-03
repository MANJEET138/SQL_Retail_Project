-- Rename Columns:  
use second_project;
alter table sales_data rename column ï»¿transactions_id to transactions_id ;
alter table sales_data change transactions_id transaction_id int primary key;
alter table sales_data change cogs cogs float;

select count(*) from sales_data; -- show all data count 

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select*
from sales_data 
where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the 
				-- category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
                
select*
from sales_data 
where sale_date 
like '2022-11%' 
and quantiy>='4' 
and category='Clothing';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category:

select category,sum(total_sale)
 from sales_data 
 group by category ;
 
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2)as avg_age
from sales_data where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000:

select*from sales_data 
where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions 
												 -- (transaction_id) made by each gender in each category.

select gender,category,count(transaction_id) total_transactions 
from sales_data 
group by gender,category
order by gender asc;

-- Q.7 Write a SQL query to calculate the average sale for each month.
																-- Find out best selling month in each year:
                                                                
select extract(year from sale_date) as year,
extract(month from sale_date) as month ,round(avg(total_sale),2) avg_sale from sales_data 
group by 1,2 order by avg_sale desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales:

select customer_id,sum(total_sale) highest_sales from sales_data 
group by customer_id order by highest_sales desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category:

select category,count(DISTINCT customer_id)as total
 from sales_data group by category;
 
-- Q.10 Write a SQL query to create each shift and number of orders
										-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sales
as
(
select*,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
        END AS shift
from sales_data
)
select shift,count(*)as total_count from hourly_sales group by shift;



-- THANK YOU ALL  







