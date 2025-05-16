CREATE DATABASE IF NOT EXISTS Case_Study_1_Dannys_Diner;
USE Case_Study_1_Dannys_Diner;

CREATE TABLE Sales (
    Customer_ID VARCHAR(1),
    Order_Date DATE,
    Product_ID INT
);
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('A', '2021-01-01', '1');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('A', '2021-01-01', '2');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('A', '2021-01-07', '2');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('A', '2021-01-10', '3');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('A', '2021-01-11', '3');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('A', '2021-01-11', '3');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('B', '2021-01-01', '2');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('B', '2021-01-02', '2');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('B', '2021-01-04', '1');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('B', '2021-01-11', '1');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('B', '2021-01-16', '3');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('B', '2021-02-01', '3');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('C', '2021-01-01', '3');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('C', '2021-01-01', '3');
INSERT INTO Sales (Customer_ID, Order_Date, Product_ID) VALUES ('C', '2021-01-07', '3');

CREATE TABLE Menu (
    Product_ID INT,
    Product_Name VARCHAR(5),
    Price INT
);
INSERT INTO Menu (Product_ID, Product_Name, Price) VALUES ('1', 'Sushi', '10');
INSERT INTO Menu (Product_ID, Product_Name, Price) VALUES ('2', 'Curry', '15');
INSERT INTO Menu (Product_ID, Product_Name, Price) VALUES ('3', 'Ramen', '12');

CREATE TABLE Members (
    Customer_ID VARCHAR(1),
    Join_Date DATE
);
INSERT INTO Members (Customer_ID, Join_Date) VALUES ('A', '2021-01-07');
INSERT INTO Members (Customer_ID, Join_Date) VALUES ('B', '2021-01-09');

# 1. What is the total amount each customer spent at the restaurant?
SELECT
    Sales.Customer_ID,
    sum(Price) as Total_Amount_Spent_By_Each_Customer
FROM
    Sales
INNER JOIN
    Menu
ON
    Sales.Product_ID = Menu.Product_ID
GROUP BY
    Customer_ID;
    
# 2. How many days has each customer visited the restaurant?
SELECT
    Customer_ID,
    count(DISTINCT Order_Date) as No_Of_Days_Customer_Visited_the_Restaurant
FROM
    Sales
GROUP BY
    Customer_ID;
    
# 3. What was the first item from the menu purchased by each customer?
SELECT
    Sales.Customer_ID,
    Sales.Order_Date,
    Menu.Product_Name
FROM
    Sales
INNER JOIN
    Menu
ON
    Sales.Product_ID = Menu.Product_ID
WHERE (
     Customer_ID,
    Order_Date

)
IN (
	SELECT
		Customer_ID,
		min(Order_Date)
	FROM
		Sales
	GROUP BY
        Customer_ID
);

# 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT
    Sales.Product_ID,
    Menu.Product_Name,
    count(Sales.Product_ID) as Purchased_Count
FROM
    Sales
INNER JOIN
    Menu
ON
    Sales.Product_ID = Menu.Product_ID
GROUP BY
    Sales.Product_ID,
    Menu.Product_Name
ORDER BY
    Purchased_Count DESC LIMIT 1;
    
# 5. Which item was the most popular for each customer?
WITH Ranked_Items as (
    SELECT 
        Sales.Customer_ID,
        Menu.Product_Name,
        count(Sales.Product_ID) as Purchase_Count,
        RANK() OVER (PARTITION BY Sales.Customer_ID ORDER BY count(Sales.Product_ID) DESC) as rnk
	FROM
        Sales
	INNER JOIN
        Menu
	ON
        Sales.Product_ID = Menu.Product_ID
	GROUP BY
        Sales.Customer_ID,
        Menu.Product_Name
)
SELECT
    Customer_ID,
    Product_Name,
    Purchase_Count
FROM
    Ranked_Items
WHERE
    rnk = 1;
    
# 6. Which item was purchased first by the customer after they became a member?
WITH First_Purchase as (
    SELECT
        Sales.Customer_ID,
        Menu.Product_Name,
        Sales.Order_Date,
        RANK() OVER (PARTITION BY Sales.Customer_ID ORDER BY Sales.Order_Date ASC) as rnk
	FROM
        Sales
	INNER JOIN
	    Menu
	ON
	    Sales.Product_ID = Menu.Product_ID
	INNER JOIN
	    Members
	ON
        Sales.Customer_ID = Members.Customer_ID
	WHERE
        Sales.Order_Date > 	Members.Join_Date
)
SELECT
    Customer_ID,
    Product_Name,
    Order_Date
FROM
    First_Purchase
WHERE
    rnk = 1;
    
# 7. Which item was purchased just before the customer became a member?
WITH Last_Purchase as (
    SELECT
        Sales.Customer_ID,
        Menu.Product_Name,
        Sales.Order_Date,
        RANK() OVER (PARTITION BY Sales.Customer_ID ORDER BY Sales.Order_Date DESC) as rnk
	FROM
	    Sales
	INNER JOIN
        Menu
	ON
        Sales.Product_ID = Menu.Product_ID
	INNER JOIN
        Members
	ON
        Sales.Customer_ID = Members.Customer_ID
	WHERE
        Sales.Order_Date < Members.Join_Date
)
SELECT 
    Customer_ID,
    Product_Name,
    Order_Date
FROM
    Last_Purchase
WHERE
    rnk = 1;

# 8. What is the total items and amount spent for each member before they became a member?
SELECT
    Sales.Customer_ID,
    count(Sales.Product_ID) as Total_Item,
    sum(Menu.Price) as Total_Amount_Spend
FROM
    Sales
INNER JOIN
    Menu
ON
    Sales.Product_ID = Menu.Product_ID
INNER JOIN
    Members
ON
    Sales.Customer_ID = Members.Customer_ID
WHERE
    Sales.Order_Date < 	Members.Join_Date
GROUP BY
    Sales.Customer_ID;
    
# 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT
    Sales.Customer_ID,
    sum(
        CASE
            WHEN
                Menu.Product_Name = 'Sushi' 
			THEN
                Menu.Price * 20 -- 2x points multiplier for sushi
			ELSE
                Menu.Price * 10 -- 10 points per $1 for other items
			END
    ) as Total_Points
FROM
    Sales
INNER JOIN
    Menu
ON
    Sales.Product_ID = Menu.product_ID
GROUP BY
    Sales.Customer_ID;
    
# 10. In the first week after a customer joins the program (including their join date)
# they earn 2x points on all items, not just sushi - 
# how many points do customer A and B have at the end of January?
SELECT
    Sales.Customer_ID,
    sum(
        CASE
            WHEN
                Sales.Order_Date BETWEEN Members.Join_Date
			AND
                date_add(Members.Join_Date, interval 6 day)
			THEN
                Menu.Price * 20  -- 2x multiplier for all items in the first week
			WHEN
                lower(Menu.Product_Name) = 'sushi'
			THEN
                Menu.Price * 20 -- 2x multiplier for sushi
			ELSE
                Menu.Price * 10 -- Normal Points
			END
    ) as Total_points
FROM
    Sales
INNER JOIN
    Menu
ON
    Sales.Product_ID = Menu.Product_ID
INNER JOIN
    Members
ON
    Sales.Customer_ID = Members.Customer_ID
WHERE
    Sales.Order_Date <= '2021-01-31'   -- Filter only for purchases up to the end of January
AND
    Sales.customer_ID IN ('A', 'B') -- only customers A and B
GROUP BY
    Sales.Customer_ID;
    

    
    
