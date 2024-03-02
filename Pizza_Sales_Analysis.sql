select * from pizza_sales_excel_file


SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales_excel_file

select sum(quantity) as Total_Pizzas_Sold from pizza_sales_excel_file

SELECT COUNT(DISTINCT(order_id)) AS Total_Orders_Placed FROM pizza_sales_excel_file

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST( COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order FROM pizza_sales_excel_file


SELECT DATEPART(HOUR, order_time) AS order_hour, SUM(quantity) as total_pizzas FROM pizza_sales_excel_file GROUP BY DATEPART(HOUR, order_time) ORDER BY DATEPART(HOUR, order_time);

SELECT DATEPART(ISO_WEEK, order_date) AS week_no, YEAR(order_date) AS order_year, COUNT(DISTINCT (order_id)) AS orders_per_week from pizza_sales_excel_file GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date) ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)

SELECT pizza_category , SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales_excel_file)  AS total_sales_per_category
FROM pizza_sales_excel_file
GROUP BY pizza_category

SELECT pizza_size ,SUM(total_price) AS total_sales, SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales_excel_file)  AS total_sales_per_size
FROM pizza_sales_excel_file
GROUP BY pizza_size
ORDER BY total_sales_per_size DESC

SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue 
FROM pizza_sales_excel_file 
GROUP BY pizza_name 
ORDER BY total_revenue DESC 

SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue 
FROM pizza_sales_excel_file 
GROUP BY pizza_name 
ORDER BY total_revenue  

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_revenue 
FROM pizza_sales_excel_file 
GROUP BY pizza_name 
ORDER BY total_revenue DESC 

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_revenue 
FROM pizza_sales_excel_file 
GROUP BY pizza_name 
ORDER BY total_revenue 

 