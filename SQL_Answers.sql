/*
============================================================
                    NovaCart SQL Lab
                  SQL Questions Worksheet
============================================================

Student Name : Ahmed Ali Elgohary
Section      : ______________________________
ID           : __________________________________

Platform: Microsoft SQL Server / SSMS

Instructions:
1. Complete the database design and implementation before solving
   these questions.
2. Do not modify the database structure just to make a question easier.
3. Write your SQL solution directly below each question.
4. Use meaningful aliases and readable formatting.
5. All queries must execute successfully on your completed NovaCartDB.
6. Use the separate Hints PDF only when you are genuinely stuck.
7. Do not hard-code results that should be calculated from the data.

Database:
    NovaCartDB

============================================================
*/

USE NovaCart;
GO


/*============================================================
                MISSION 1 — CUSTOMER & PRODUCT OVERVIEW
============================================================*/

-- M1-Q1
-- Display all customers.

-- Your query:

SELECT * FROM Customers

------------------------------------------------------------

-- M1-Q2
-- Display the product name, category, and current price
-- for every product.

-- Your query:

SELECT 
    P.Product_Name,
    C.Category_Name,
    P.Price
FROM Products P
JOIN Categories C ON P.Category_ID = C.Category_ID;

------------------------------------------------------------

-- M1-Q3
-- Display products whose current price is greater than 5000.

-- Your query:

SELECT Price FROM Products 
Where Price > 5000;

------------------------------------------------------------

-- M1-Q4
-- Display all customers ordered by join date, newest first.

-- Your query:

SELECT First_Name, Last_Name, Signup_Date FROM Customers
ORDER BY Signup_Date DESC;

------------------------------------------------------------

-- M1-Q5
-- Display the total number of customers.

-- Your query:

SELECT COUNT(*) AS Total_Customers
FROM Customers;

/*============================================================
             MISSION 2 — AGGREGATION & BUSINESS TOTALS
============================================================*/

-- M2-Q1
-- Calculate the average current product price.

-- Your query:

SELECT ROUND(AVG(Price),2) AS Average_Product_Price
FROM Products;

------------------------------------------------------------

-- M2-Q2
-- Display the highest and lowest current product prices.

-- Your query:

SELECT 
    MAX(Price) AS Highest_Price,
    MIN(Price) AS Lowest_Price
FROM Products;

------------------------------------------------------------

-- M2-Q3
-- Calculate the total available stock quantity.

-- Your query:

SELECT SUM(Stock_Quantity) AS Total_Available_Stock
FROM Products;

------------------------------------------------------------

-- M2-Q4
-- Calculate the total amount recorded in Payments.

-- Your query:

SELECT SUM(Amount) AS Total_Payments
FROM Payments;

------------------------------------------------------------

-- M2-Q5
-- Display the number of orders for each order status.

-- Your query:

SELECT 
    Status,
    COUNT(*) AS Order_Count
FROM Orders
GROUP BY Status
ORDER BY Order_Count DESC;

------------------------------------------------------------

-- M2-Q6
-- Display the total payment amount for each payment method.

-- Your query:

SELECT 
    Method,
    SUM(Amount) AS Total_Amount
FROM Payments
GROUP BY Method
ORDER BY Total_Amount DESC;

/*============================================================
               MISSION 3 — ORDER & SALES ANALYSIS
============================================================*/

-- M3-Q1
-- Calculate the total sales amount for each order.
-- Use quantity multiplied by the historical unit price.

-- Your query:

SELECT 
    Order_ID,
    SUM(Quantity * Unit_Price) AS Total_Sales
FROM Order_Items
GROUP BY Order_ID
ORDER BY Order_ID;

------------------------------------------------------------

-- M3-Q2
-- Display only orders whose total sales exceed 5000.

-- Your query:

SELECT 
    Order_ID,
    SUM(Quantity * Unit_Price) AS Total_Sales
FROM Order_Items
GROUP BY Order_ID
HAVING SUM(Quantity * Unit_Price) > 5000
ORDER BY Total_Sales DESC;

------------------------------------------------------------

-- M3-Q3
-- Display each order together with:
-- customer name, order date, and order status.

-- Your query:

SELECT 
O.Order_ID, 
C.First_Name + ' ' + Last_Name AS Customer_Name,
O.Order_Date,
O.Status
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
ORDER BY O.Order_ID;

------------------------------------------------------------

-- M3-Q4
-- Display each order with:
-- product name, purchased quantity, and historical unit price.

-- Your query:
SELECT
    OI.Order_ID,
    P.Product_Name,
    OI.Quantity,
    OI.Unit_Price
FROM Order_Items OI
JOIN Products P ON OI.Product_ID = P.Product_ID
ORDER BY OI.Order_ID, P.Product_Name;

------------------------------------------------------------

-- M3-Q5
-- Display the total amount spent by each customer.

-- Your query:

SELECT 
    C.Customer_ID,
    C.First_Name + ' ' + c.Last_Name AS Customer_Name,
    SUM(O.Total_Amount) AS Total_Spent
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name
ORDER BY Total_Spent DESC;

/*============================================================
              MISSION 4 — REVIEWS & RELATIONSHIPS
============================================================*/

-- M4-Q1
-- Display the number of reviews received by each product,
-- including products with no reviews.

-- Your query:

SELECT 
    P.Product_ID,
    P.Product_Name,
    COUNT(R.Review_ID) AS Review_Count
FROM Products P
LEFT JOIN Reviews R ON P.Product_ID = R.Product_ID
GROUP BY P.Product_ID, P.Product_Name
ORDER BY Review_Count DESC, P.Product_Name;

------------------------------------------------------------

-- M4-Q2
-- Display all reviews together with:
-- customer name and product name.

-- Your query:

SELECT 
    R.Review_ID,
    C.First_Name + ' ' + C.Last_Name AS Customer_Name,
    P.Product_Name,
    R.Rating,
    R.Comment,
    R.Review_Date
FROM Reviews R
JOIN Customers C ON R.Customer_ID = C.Customer_ID
JOIN Products P  ON R.Product_ID  = P.Product_ID
ORDER BY R.Review_ID;

------------------------------------------------------------

-- M4-Q3
-- Display customers who have placed at least one order.

-- Your query:

SELECT DISTINCT
    C.Customer_ID,
    C.First_Name + ' ' + C.Last_Name AS Customer_Name,
    C.Email,
    C.City,
    C.Country
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
ORDER BY C.Customer_ID;

------------------------------------------------------------

-- M4-Q4
-- Display products that have never been ordered.

-- Your query:

SELECT 
    P.Product_ID,
    P.Product_Name,
    C.Category_Name,
    P.Price,
    P.Stock_Quantity
FROM Products P
JOIN Categories C ON P.Category_ID = C.Category_ID
LEFT JOIN Order_Items OI ON P.Product_ID = OI.Product_ID
WHERE OI.Order_Item_ID IS NULL
ORDER BY P.Product_ID;

------------------------------------------------------------

-- M4-Q5
-- Display products that have never received a review.

-- Your query:

SELECT 
    P.Product_ID,
    P.Product_Name,
    C.Category_Name,
    P.Price,
    P.Stock_Quantity
FROM Products P
JOIN Categories C ON P.Category_ID = C.Category_ID
LEFT JOIN Reviews R ON P.Product_ID = R.Product_ID
WHERE R.Review_ID IS NULL
ORDER BY P.Product_ID;

------------------------------------------------------------

-- M4-Q6
-- Display all customers and their number of orders,
-- including customers who have never placed an order.

-- Your query:

SELECT 
    C.Customer_ID,
    C.First_Name + ' ' + c.Last_Name AS Customer_Name,
    C.Email,
    C.Country,
    COUNT(O.Order_ID) AS Order_Count
FROM Customers C
LEFT JOIN Orders O ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name, C.Email, C.Country
ORDER BY Order_Count DESC, C.Customer_ID;

/*============================================================
                       MISSION 5 — SUBQUERIES
============================================================*/

-- M5-Q1
-- Display customers who placed more orders than the average
-- number of orders among customers who placed at least one order.

-- Your query:

SELECT 
    C.Customer_ID,
    C.First_Name + ' ' + C.Last_Name AS Customer_Name,
    COUNT(O.Order_ID) AS Order_Count
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name
HAVING COUNT(O.Order_ID) > (
    SELECT AVG(Order_Count * 1.0)
    FROM (
        SELECT COUNT(Order_ID) AS Order_Count
        FROM Orders
        GROUP BY Customer_ID
    ) AS CustomerOrderCounts
)
ORDER BY Order_Count DESC;

------------------------------------------------------------

-- M5-Q2
-- Display products whose current price is above the average
-- current product price.

-- Your query:

SELECT 
    P.Product_ID,
    P.Product_Name,
    C.Category_Name,
    P.Price
FROM Products P
JOIN Categories C ON P.Category_ID = C.Category_ID
WHERE P.Price > (
    SELECT AVG(Price)
    FROM Products
)
ORDER BY P.Price DESC;

------------------------------------------------------------

-- M5-Q3
-- Display customers whose total spending is greater than
-- the average total spending among customers who have made
-- at least one payment.

-- Your query:

SELECT 
    C.Customer_ID,
    C.First_Name + ' ' + C.Last_Name AS Customer_Name,
    SUM(O.Total_Amount) AS Total_Spent
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
WHERE EXISTS (
    SELECT 1
    FROM Payments P
    WHERE P.Order_ID = O.Order_ID
)
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name
HAVING SUM(O.Total_Amount) > (
    SELECT AVG(Customer_Total * 1.0)
    FROM (
        SELECT O2.Customer_ID, SUM(O2.Total_Amount) AS Customer_Total
        FROM Orders O2
        WHERE EXISTS (
            SELECT 1 FROM Payments P2 WHERE P2.Order_ID = O2.Order_ID
        )
        GROUP BY O2.Customer_ID
    ) AS CustomerSpending
)
ORDER BY Total_Spent DESC;

/*============================================================
                MISSION 6 — COMMON TABLE EXPRESSIONS
============================================================*/

-- M6-Q1
-- Using a CTE, calculate total revenue by month.

-- Your query:

WITH MonthlyRevenue AS (
    SELECT 
        YEAR(Order_Date)  AS Order_Year,
        MONTH(Order_Date) AS Order_Month,
        SUM(Total_Amount) AS Revenue
    FROM Orders
    GROUP BY YEAR(Order_Date), MONTH(Order_Date)
)
SELECT 
    Order_Year,
    Order_Month,
    Revenue
FROM MonthlyRevenue
ORDER BY Order_Year, Order_Month;

------------------------------------------------------------

-- M6-Q2
-- Using a CTE, calculate total spending by customer.
-- Return only customers whose total spending exceeds 10000.

-- Your query:

WITH CustomerSpending AS (
    SELECT 
        C.Customer_ID,
        C.First_Name + ' ' + C.Last_Name AS Customer_Name,
        SUM(O.Total_Amount) AS Total_Spent
    FROM Customers C
    JOIN Orders O ON C.Customer_ID = O.Customer_ID
    GROUP BY C.Customer_ID, C.First_Name, C.Last_Name
)
SELECT 
    Customer_ID,
    Customer_Name,
    Total_Spent
FROM CustomerSpending
WHERE Total_Spent > 10000
ORDER BY Total_Spent DESC;

/*============================================================
                  MISSION 7 — WINDOW FUNCTIONS
============================================================*/

-- M7-Q1
-- Rank customers by total spending using RANK(),
-- with the highest spending ranked first.

-- Your query:

SELECT 
    C.Customer_ID,
    C.First_Name + ' ' + C.Last_Name AS Customer_Name,
    SUM(O.Total_Amount) AS Total_Spent,
    RANK() OVER (ORDER BY SUM(O.Total_Amount) DESC) AS Spending_Rank
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name
ORDER BY Spending_Rank;

------------------------------------------------------------

-- M7-Q2
-- Rank products by total quantity sold using DENSE_RANK(),
-- with the highest quantity ranked first.

-- Your query:

SELECT 
    P.Product_ID,
    P.Product_Name,
    SUM(OI.Quantity) AS Total_Quantity_Sold,
    DENSE_RANK() OVER (ORDER BY SUM(OI.Quantity) DESC) AS Quantity_Rank
FROM Products P
JOIN Order_Items OI ON P.Product_ID = OI.Product_ID
GROUP BY P.Product_ID, P.Product_Name
ORDER BY Quantity_Rank, P.Product_Name;

------------------------------------------------------------

-- M7-Q3
-- Display each payment together with the previous payment amount
-- using LAG().
-- Order the sequence by payment date and payment ID.

-- Your query:

SELECT 
    Payment_ID,
    Order_ID,
    Payment_Date,
    Amount AS Current_Amount,
    LAG(Amount) OVER (ORDER BY Payment_Date, Payment_ID) AS Previous_Amount
FROM Payments
ORDER BY Payment_Date, Payment_ID;

------------------------------------------------------------

-- M7-Q4
-- Display a running total of payment amounts.
-- Order the sequence by payment date and payment ID.

-- Your query:

SELECT 
    Payment_ID,
    Order_ID,
    Payment_Date,
    Amount AS Current_Amount,
    SUM(Amount) OVER (ORDER BY Payment_Date, Payment_ID) AS Running_Total
FROM Payments
ORDER BY Payment_Date, Payment_ID;

/*============================================================
                         MISSION 8 — VIEWS
============================================================*/

-- M8-Q1
-- Create a view named vw_revenue_by_month
-- that displays monthly revenue.

-- Your query:

CREATE VIEW vw_revenue_by_month AS
SELECT 
    YEAR(Order_Date)  AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    FORMAT(Order_Date, 'yyyy-MM') AS Month_Label,
    COUNT(Order_ID)   AS Order_Count,
    SUM(Total_Amount) AS Revenue
FROM Orders
GROUP BY 
    YEAR(Order_Date),
    MONTH(Order_Date),
    FORMAT(Order_Date, 'yyyy-MM');


    SELECT * FROM vw_revenue_by_month
ORDER BY Order_Year, Order_Month;
------------------------------------------------------------

-- M8-Q2
-- Create a view named vw_best_selling_products
-- that displays:
--   Product Name
--   Total Quantity Sold
--   Total Revenue

-- Your query:

CREATE VIEW vw_best_selling_products AS
SELECT 
    P.Product_ID,
    P.Product_Name,
    SUM(OI.Quantity) AS Total_Quantity_Sold,
    SUM(OI.Quantity * OI.Unit_Price) AS Total_Revenue
FROM Products P
JOIN Order_Items OI ON P.Product_ID = OI.Product_ID
GROUP BY P.Product_ID, P.Product_Name;

SELECT * 
FROM vw_best_selling_products
ORDER BY Total_Quantity_Sold DESC, Total_Revenue DESC;

------------------------------------------------------------

-- M8-Q3
-- Create a view named vw_customer_summary
-- that displays:
--   Customer Name
--   Number of Orders
--   Total Amount Spent

-- Your query:

CREATE VIEW vw_customer_summary AS
SELECT 
    C.Customer_ID,
    C.First_Name + ' ' + C.Last_Name AS Customer_Name,
    COUNT(O.Order_ID) AS Number_of_Orders,
    ISNULL(SUM(O.Total_Amount), 0) AS Total_Amount_Spent
FROM Customers C
LEFT JOIN Orders O ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_ID, C.First_Name, C.Last_Name;

SELECT * 
FROM vw_customer_summary
ORDER BY Total_Amount_Spent DESC;

/*============================================================
                           END
============================================================*/
