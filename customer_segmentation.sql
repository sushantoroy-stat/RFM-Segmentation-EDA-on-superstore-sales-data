--- 1.Create a database 
CREATE DATABASE SuperstoreDB;
USE SuperstoreDB;
/*---2. Create a table under this database 
CREATE TABLE Superstore_Sales (
    Row ID INT PRIMARY KEY,
    Order Priority VARCHAR(50),
    Discount DECIMAL(5,2),
    Unit Price DECIMAL(10,2),
    Shipping Cost DECIMAL(10,2),
    Customer ID INT,
    Customer Name VARCHAR(255),
    Ship Mode VARCHAR(50),
    Customer Segment VARCHAR(50),
    Product Category VARCHAR(50),
    Product Sub-Category VARCHAR(50),
    Product Name VARCHAR(255),
    Product Container VARCHAR(50),
    Product Base Margin DECIMAL(5,2),
    Region VARCHAR(50),
    State Province VARCHAR(100),
    City VARCHAR(100),
    Postal Code VARCHAR(20),
    Order Date DATE,
    Ship Date DATE,
    Profit DECIMAL(15,4),
    Quantity Ordered INT,
    Sales DECIMAL(15,2),
    Order ID INT,
    Return Status VARCHAR(50)
);
--- 3. INSERT THE ATTACH DATA THERE (PREFERABLY BULK INSERTION) 
LOAD DATA INFILE "E:/Data Science/Data with MySQL/Super Store Sales Data Project/Superstore_Sales_Data.csv" 
INTO TABLE superstore_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS; 
 */
---- Rename all columns name 
ALTER TABLE superstore_sales_data
RENAME COLUMN `Row ID` TO Row_ID,
RENAME COLUMN `Order Priority` TO Order_Priority,
RENAME COLUMN `Discount` TO Discount,
RENAME COLUMN `Unit Price` TO Unit_Price,
RENAME COLUMN `Shipping Cost` TO Shipping_Cost,
RENAME COLUMN `Customer ID` TO Customer_ID,
RENAME COLUMN `Customer Name` TO Customer_Name,
RENAME COLUMN `Ship Mode` TO Ship_Mode,
RENAME COLUMN `Customer Segment` TO Customer_Segment,
RENAME COLUMN `Product Category` TO Product_Category,
RENAME COLUMN `Product Sub-Category` TO Product_Sub_Category,
RENAME COLUMN `Product Container` TO Product_Container,
RENAME COLUMN `Product Name` TO Product_Name,
RENAME COLUMN `Product Base Margin` TO Product_Base_Margin,
RENAME COLUMN `Region` TO Region,
RENAME COLUMN `Manager` TO Manager,
RENAME COLUMN `State or Province` TO State_or_Province,
RENAME COLUMN `City` TO City,
RENAME COLUMN `Postal Code` TO Postal_Code,
RENAME COLUMN `Order Date` TO Order_Date,
RENAME COLUMN `Ship Date` TO Ship_Date,
RENAME COLUMN `Profit` TO Profit,
RENAME COLUMN `Quantity ordered new` TO Quantity_ordered_new,
RENAME COLUMN `Sales` TO Sales,
RENAME COLUMN `Order ID` TO Order_ID,
RENAME COLUMN `Return Status` TO Return_Status;

--- 4. EXPLORE THE DATA AND CHECK IF ALL THE DATA IS IN THE PROPER FORMAT

SELECT order_date, Ship_Date
FROM superstore_sales_data
LIMIT 10; 


--- 5. DO THE NECESSARY CLEANING AND UPDATE THE TABLE SCHEMA IF REQUIRED
---- SHIP DATE AND ORDER DATE FORMATE IS NOT IN PROPER WAY, SO WE NEED TO UPDATE THIS DATASET TO SET THE FORMATE 
SET SQL_SAFE_UPDATES = 0;

UPDATE SUPERSTORE_SALES_DATA 
SET ORDER_DATE = STR_TO_DATE(ORDER_DATE, '%m/%d/%Y');

UPDATE SUPERSTORE_SALES_DATA
SET SHIP_DATE = STR_TO_DATE(SHIP_DATE, '%m/%d/%Y');

---- 6.PERFORM EXPLORATORY DATA ANALYSIS

-- Top 10 Best-Selling Products
SELECT PRODUCT_NAME,
SUM(SALES) AS TOTAL_SALES
FROM SUPERSTORE_SALES_DATA
GROUP BY PRODUCT_NAME
ORDER BY TOTAL_SALES DESC
LIMIT 10; 

---- Top 10 Most Profitable Products
SELECT Product_Name, SUM(Profit) AS Total_profit
FROM SUPERSTORE_SALES_DATA
GROUP BY Product_Name
ORDER BY Total_profit DESC
LIMIT 10;

-- Total Sales & Profit by Category
SELECT PRODUCT_CATEGORY, SUM(Sales) AS TOTAL_SALES, SUM(Profit) AS TOTAL_PROFIT
FROM SUPERSTORE_SALES_DATA
GROUP BY PRODUCT_CATEGORY
ORDER BY TOTAL_SALES DESC;

-- Customer Segmentation Based on Orders
SELECT CUSTOMER_NAME, COUNT(Order_ID) AS TOTAL_ORDERS, SUM(Sales) AS TOTAL_SALES
FROM SUPERSTORE_SALES_DATA
GROUP BY CUSTOMER_NAME
ORDER BY TOTAL_SALES DESC
LIMIT 10;

--- 7.SEGMENT THE CUSTOMER USING RFM SEGMENTATION

CREATE OR REPLACE VIEW RFM_SCORE_DATA AS 
WITH RFM_SEGMENTATION AS
(SELECT CUSTOMER_NAME,
    datediff(
    (SELECT MAX(ORDER_DATE) FROM SUPERSTORE_SALES_DATA), MAX(ORDER_DATE)) AS RECENCY_VALUE,
    COUNT(DISTINCT ORDER_ID) AS FREQUENCY_VALUE, 
    ROUND(SUM(SALES),0) AS MONETARY_VALUE
FROM SUPERSTORE_SALES_DATA
GROUP BY CUSTOMER_NAME), 
RFM_SCORE AS 
(SELECT
	RFM.*,
    NTILE(4) OVER (ORDER BY RECENCY_VALUE DESC) AS R_SCORE,
    NTILE(4) OVER (ORDER BY FREQUENCY_VALUE ASC) AS F_SCORE,
	NTILE(4) OVER (ORDER BY MONETARY_VALUE ASC) AS M_SCORE
	FROM RFM_SEGMENTATION AS RFM)

SELECT 
	R.CUSTOMER_NAME,
    R.RECENCY_VALUE,
    R_SCORE,
    R.FREQUENCY_VALUE,
    F_SCORE,
    R.MONETARY_VALUE,
    M_SCORE,
    (R_SCORE + F_SCORE + M_SCORE) AS TOTAL_RFM_SCORE, 
    CONCAT_WS('', R_SCORE, F_SCORE, M_SCORE) AS RFM_SCORE_COMBINATION 
    
    FROM RFM_SCORE AS R ; 


SELECT * FROM RFM_SCORE_DATA WHERE RFM_SCORE_COMBINATION = '111' ; 

SELECT RFM_SCORE_COMBINATION FROM RFM_SCORE_DATA; 


CREATE VIEW RFM_ANALYSIS AS 
SELECT 
    RFM_SCORE_DATA.*,
    CASE
        WHEN RFM_SCORE_COMBINATION IN (111, 112, 121, 132, 211, 211, 212, 114, 141) THEN 'CHURNED CUSTOMER'
        WHEN RFM_SCORE_COMBINATION IN (133, 134, 143, 224, 334, 343, 344, 144) THEN 'SLIPPING AWAY, CANNOT LOSE'
        WHEN RFM_SCORE_COMBINATION IN (311, 411, 331) THEN 'NEW CUSTOMERS'
        WHEN RFM_SCORE_COMBINATION IN (222, 231, 221,  223, 233, 322) THEN 'POTENTIAL CHURNERS'
        WHEN RFM_SCORE_COMBINATION IN (323, 333,321, 341, 422, 332, 432) THEN 'ACTIVE'
        WHEN RFM_SCORE_COMBINATION IN (433, 434, 443, 444) THEN 'LOYAL'
    ELSE 'Other'
    END AS CUSTOMER_SEGMENT
FROM RFM_SCORE_DATA;

SELECT 
	CUSTOMER_SEGMENT, 
    COUNT(*) AS NUMBER_OF_CUSTOMERS,
   ROUND(AVG(MONETARY_VALUE),0) AS AVERAGE_MONETARY_VALUE
FROM RFM_ANALYSIS 
GROUP BY CUSTOMER_SEGMENT; 





