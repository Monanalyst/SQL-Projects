-- What is the total number of orders placed?

SELECT COUNT(*) AS Total_Orders
FROM orders;

-- What is the total number of pizzas sold?

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM order_details;

-- What is the total cost of all the pizzas sold?

SELECT ROUND(SUM(pizzas.price),0) AS Total_Cost
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id;

-- How many orders were made each day?

SELECT Day_Of_Week, SUM(Num_Of_Orders) AS Day_Name
FROM
(SELECT DATENAME(weekday, orders.date) AS Day_Of_Week, COUNT(*) AS Num_Of_Orders 
FROM orders 
GROUP BY DATENAME(weekday, orders.date)) t1 
GROUP BY Day_Of_Week
ORDER BY CASE Day_Of_Week
            WHEN 'Sunday' THEN 1
            WHEN 'Monday' THEN 2
            WHEN 'Tuesday' THEN 3
            WHEN 'Wednesday' THEN 4
            WHEN 'Thursday' THEN 5
            WHEN 'Friday' THEN 6
            WHEN 'Saturday' THEN 7
        END;

-- How many number of orders were placed on each day of the week?

SELECT DATENAME(weekday, orders.date) AS Day_Of_Week, DATEPART(week, orders.date) AS Week_Number, COUNT(*) AS Num_Of_Orders  
FROM orders 
GROUP BY DATEPART(week, orders.date), DATENAME(weekday, orders.date) 
ORDER BY Week_Number ASC;

-- What is the average number of orders per day?

SELECT AVG(Order_Count) AS Avg_Day_Orders
FROM
(SELECT orders.date, COUNT(order_id) AS Order_Count
FROM orders
GROUP BY orders.date) t1;

-- How many orders were made each month?

SELECT MONTH(orders.date) AS Month, COUNT(order_id) AS Order_Count
FROM orders 
GROUP BY MONTH(orders.date)
ORDER BY MONTH(orders.date);

-- What is the average number of orders per month?

SELECT AVG(Order_Count) AS Avg_Monthly_Orders
FROM
(SELECT MONTH(orders.date) AS Month, COUNT(order_id) AS Order_Count
FROM orders 
GROUP BY MONTH(orders.date)) t1;

-- How many orders were made in each quarter?

SELECT DATEPART(QUARTER, orders.date) AS Quarter, COUNT(order_id) AS Order_Count
FROM orders
GROUP BY DATEPART(QUARTER, orders.date)
ORDER BY DATEPART(QUARTER, orders.date);

-- What is the average number of orders per quarter?

SELECT AVG(Order_Count) AS Avg_Quarter_Orders
FROM 
(SELECT DATEPART(QUARTER, orders.date) AS Quarter, COUNT(order_id) AS Order_Count
FROM orders
GROUP BY DATEPART(QUARTER, orders.date)) t1;

-- What is the most ordered pizza type?

SELECT pizza_types.name, COUNT(*) AS Order_Num
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.name 
ORDER BY COUNT(*) DESC;

-- What is the least ordered pizza type?

SELECT pizza_types.name, COUNT(*) AS Order_Num
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.name 
ORDER BY COUNT(*) ASC;

-- What pizza category had the most orders?

SELECT pizza_types.category, COUNT(*) AS Order_Num
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.category
ORDER BY COUNT(*) DESC;

-- What pizza category had the least orders?

SELECT pizza_types.category, COUNT(*) AS Order_Num
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.category
ORDER BY COUNT(*) ASC;

-- Which pizza made the most revenue?

SELECT pizza_types.name, ROUND(SUM(pizzas.price * order_details.quantity),2) AS total_revenue 
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.name 
ORDER BY total_revenue DESC;

-- Which pizza made the least revenue?

SELECT pizza_types.name, ROUND(SUM(pizzas.price * order_details.quantity),2) AS total_revenue 
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.name 
ORDER BY total_revenue ASC;

-- What pizza category made the most revenue?

SELECT pizza_types.category, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Total_Revenue 
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.category
ORDER BY total_revenue DESC;

-- What pizza category made the least revenue?

SELECT pizza_types.category, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Total_Revenue 
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
GROUP BY pizza_types.category
ORDER BY total_revenue ASC;

-- What is the total revenue generated from sales?

SELECT ROUND(SUM(pizzas.price * order_details.quantity),2) AS total_revenue 
FROM order_details 
JOIN pizzas 
ON pizzas.pizza_id = order_details.pizza_id;

-- What is the average price of a pizza?

SELECT ROUND(AVG(pizzas.price), 2) AS Avg_Price 
FROM pizzas;

-- What is the most expensive pizza?

SELECT name, MAX(pizzas.price) AS Max_Price
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY name
ORDER BY MAX(pizzas.price) DESC;

-- What is the least expensive pizza?

SELECT name, MIN(pizzas.price) AS Min_Price
FROM order_details 
JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY name
ORDER BY MIN(pizzas.price) ASC;

-- At what time did the most orders take place?

SELECT DATEPART(HOUR, orders.time) AS Hour, COUNT(*) AS Total_Orders
FROM orders
GROUP BY DATEPART(HOUR, orders.time)
ORDER BY Total_Orders DESC;

-- At what day of the week did the most orders take place?

SELECT DATENAME(WEEKDAY, orders.date) AS DayOfTheWeek, COUNT(*) AS Total_Orders 
FROM orders 
GROUP BY DATENAME(WEEKDAY, orders.date) 
ORDER BY Total_Orders DESC;

-- What is the total orders placed for each hour of each day of the week?

SELECT DATEPART(HOUR, orders.time) AS Hour, DATENAME(WEEKDAY, orders.date) AS DayOfTheWeek, COUNT(*) AS TotalNumberOfOrders 
FROM orders 
GROUP BY DATEPART(HOUR, orders.time), DATENAME(WEEKDAY, orders.date) 
ORDER BY TotalNumberOfOrders DESC;

-- What is the total revenue per month?

SELECT DATEPART(MONTH, orders.date) AS Month, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Monthly_Revenue 
FROM order_details 
JOIN pizzas 
ON pizzas.pizza_id = order_details.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY DATEPART(MONTH, orders.date)
ORDER BY DATEPART(MONTH, orders.date);

-- What is the average revenue per month?

SELECT AVG(Monthly_Revenue) AS Avg_Monthly_Revenue
FROM
(SELECT DATEPART(MONTH, orders.date) AS Month, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Monthly_Revenue 
FROM order_details 
JOIN pizzas 
ON pizzas.pizza_id = order_details.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY DATEPART(MONTH, orders.date)) t1;

-- What is the total revenue made in each quarter?

SELECT DATEPART(QUARTER, orders.date) AS Quarter, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Quarterly_Revenue 
FROM order_details 
JOIN pizzas 
ON pizzas.pizza_id = order_details.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY DATEPART(QUARTER, orders.date)
ORDER BY DATEPART(QUARTER, orders.date);

-- What is the average revenue per quarter?

SELECT AVG(Quarterly_Revenue ) AS Avg_Quarter_Revenue
FROM
(SELECT DATEPART(QUARTER, orders.date) AS Quarter, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Quarterly_Revenue 
FROM order_details 
JOIN pizzas 
ON pizzas.pizza_id = order_details.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY DATEPART(QUARTER, orders.date)) t1;

-- What is the total revenue per day?

SELECT orders.date, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Day_Revenue
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
JOIN pizzas
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY orders.date
ORDER BY orders.date;

-- What is the average revenue per day?

SELECT AVG(Day_Revenue) AS Avg_Day_Revenue
FROM
(SELECT orders.date, ROUND(SUM(pizzas.price * order_details.quantity),2) AS Day_Revenue
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
JOIN pizzas
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY orders.date) t1;
