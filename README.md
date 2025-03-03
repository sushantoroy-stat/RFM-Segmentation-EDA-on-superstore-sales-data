# RFM-Segmentation-EDA-on-superstore-sales-data
This project performs RFM Segmentation and Exploratory Data Analysis (EDA) on a Superstore Sales dataset using MySQL. The goal is to uncover key business insights, such as sales  recency, frequency, monetary, trends profitability, customer segmentation, and regional performance.

## Overview
This project performs customer segmentation using RFM (Recency, Frequency, and Monetary) analysis on a superstore sales dataset. The goal is to categorize customers based on their purchasing behavior and identify key customer groups such as loyal customers, new customers, and churned customers. The analysis is done using MySQL.

## 📌 Methodology  

The customer segmentation analysis was conducted using **RFM (Recency, Frequency, Monetary) analysis** in **MySQL**. The methodology follows a structured approach:

### 🔹 1. Data Preparation  
- Loaded the `superstore_sales_data` dataset into MySQL.  
- Explored the dataset to ensure proper formatting using SQL queries.  
- Converted **order date** and **ship date** columns into the correct date format using `STR_TO_DATE()`.  

### 🔹 2. Exploratory Data Analysis (EDA)  
- Identified **top-selling products** by aggregating total sales.  
- Determined **most profitable products** by calculating total profit.  
- Analyzed **sales and profit trends** by product categories.  
- Examined **customer purchase frequency** and **total spending** to understand customer behavior.  

### 🔹 3. RFM Calculation  
- **Recency:** Calculated days since the last purchase for each customer.  
- **Frequency:** Counted total purchases made by each customer.  
- **Monetary Value:** Summed total revenue generated by each customer.  

### 🔹 4. RFM Scoring  
- Ranked customers into **4 segments** for Recency, Frequency, and Monetary using `NTILE(4)`.  
- Assigned **R, F, and M scores** ranging from **1 (low) to 4 (high)**.  
- Created a **combined RFM score** (e.g., `444` for best customers, `111` for least engaged customers).  

### 🔹 5. Customer Segmentation  
- Mapped RFM score combinations to meaningful customer segments:  
  - **💎 Loyal Customers** (High RFM scores)  
  - **✨ New Customers** (Recent purchases, low frequency)  
  - **📈 Active Customers** (Moderate engagement)  
  - **⚠️ Potential Churners** (Declining engagement)  
  - **🚨 Churned Customers** (No recent purchases)  
- Used **SQL CASE statements** to categorize customers into these groups.  

### 🔹 6. Business Insights & Recommendations  
- Summarized **customer distribution** across RFM segments.  
- Provided **marketing recommendations** for each segment:  
  - 🎯 **Retention strategies** for loyal customers.  
  - 🔄 **Re-engagement strategies** for potential churners.  
  - 📢 **Acquisition strategies** for new customers.  

# EDA Analysis 
## Top 10 products:
### SQL Query
```sql
SELECT PRODUCT_NAME,
SUM(SALES) AS TOTAL_SALES
FROM SUPERSTORE_SALES_DATA
GROUP BY PRODUCT_NAME
ORDER BY TOTAL_SALES DESC
LIMIT 10;
```

| **Product Name** | **Total Sales ($)** |
|------------------|--------------------|
| **Global Troy™ Executive Leather Low-Back Tilter** | 194,025.64 |
| **Riverside Palais Royal Lawyers Bookcase, Royal...** | 190,195.15 |
| **Canon imageCLASS 2200 Advanced Copier** | 107,697.73 |
| **Canon PC1080F Personal Copier** | 102,932.77 |
| **Hewlett-Packard cp1700 [D, PS] Series Color In...** | 102,889.95 |
| **Fellowes PB500 Electric Punch Plastic Comb Binder** | 102,656.45 |
| **Bretford CR8500 Series Meeting Room Furniture** | 101,797.12 |
| **Polycom ViewStation™ ISDN Videoconferencing ...** | 92,916.02 |
| **Chromcraft Bull-Nose Wood 48" x 96" Rectang...** | 92,208.46 |
| **Sharp AL-1530CS Digital Copier** | 86,057.24 |



## Top 10 Most Profitable Products  

This SQL query retrieves the top 10 most profitable products from the `SUPERSTORE_SALES_DATA` table.  

### SQL Query  

```sql
SELECT Product_Name, SUM(Profit) AS Total_profit
FROM SUPERSTORE_SALES_DATA
GROUP BY Product_Name
ORDER BY Total_profit DESC
LIMIT 10; 
```
### Output  

| **Product Name** | **Total Profit ($)** |
|------------------|--------------------|
| **Global Troy™ Executive Leather Low-Back Tilter** | 79,509.39 |
| **Fellowes PB500 Electric Punch Plastic Comb Binder** | 35,909.53 |
| **GBC DocuBind 200 Manual Binding Machine** | 33,892.33 |
| **Hewlett-Packard cp1700 [D, PS] Series Color Inkjet Printer** | 33,721.10 |
| **Hewlett-Packard LaserJet 3310 Copier** | 33,712.30 |
| **Canon PC940 Copier** | 28,307.56 |
| **GBC DocuBind TL300 Electric Binding System** | 25,033.90 |
| **Hewlett-Packard Deskjet 1220Cse Color Inkjet Printer** | 24,782.75 |
| **Ibico Hi-Tech Manual Binding System** | 23,080.57 |
| **Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerator** | 23,076.41 |

## 📌 Total Sales & Profit by Category  
This query calculates the total sales and total profit for each product category, helping in understanding revenue and profitability distribution.  
### 📜 SQL Query  

```sql
SELECT PRODUCT_CATEGORY, SUM(Sales) AS TOTAL_SALES, SUM(Profit) AS TOTAL_PROFIT
FROM SUPERSTORE_SALES_DATA
GROUP BY PRODUCT_CATEGORY
ORDER BY TOTAL_SALES DESC;
```
### Output
| **Product Category** | **Total Sales ($)** | **Total Profit ($)** |
|----------------------|--------------------|--------------------|
| **Technology** | 3,507,113.42 | 688,056.59 |
| **Furniture** | 2,997,619.10 | 1,216,151.00 |
| **Office Supplies** | 2,193,243.65 | 440,488.39 |

## Customer Segmentation Based on Orders
```sql
SELECT CUSTOMER_NAME, 
       COUNT(Order_ID) AS TOTAL_ORDERS, 
       SUM(Sales) AS TOTAL_SALES
FROM SUPERSTORE_SALES_DATA
GROUP BY CUSTOMER_NAME
ORDER BY TOTAL_SALES DESC
LIMIT 10;
```
### Output 
| **Customer Name** | **Total Orders** | **Total Sales ($)** |
|------------------|---------------|--------------------|
| **Gordon Brandt** | 16 | 123,745.62 |
| **Glen Caldwell** | 21 | 89,269.70 |
| **Rosemary O’Brien** | 13 | 86,540.75 |
| **Leigh Burnette Hurley** | 22 | 83,651.70 |
| **Kristine Connolly** | 16 | 81,296.39 |
| **Nina Horne Kelly** | 8 | 78,243.60 |
| **Neal Wolfe** | 16 | 69,118.00 |
| **Priscilla Kane** | 9 | 61,610.60 |
| **Dana Teague** | 10 | 61,298.98 |
| **Amanda Kay** | 7 | 55,793.40 |

# RFM SEGMENTATION
```sql
SELECT CUSTOMER_NAME,
       DATEDIFF(
           (SELECT MAX(ORDER_DATE) FROM SUPERSTORE_SALES_DATA), 
           MAX(ORDER_DATE)
       ) AS RECENCY_VALUE,
       COUNT(DISTINCT ORDER_ID) AS FREQUENCY_VALUE,
       ROUND(SUM(SALES), 0) AS MONETARY_VALUE
FROM SUPERSTORE_SALES_DATA
GROUP BY CUSTOMER_NAME;
```
| **Customer Name** | **Recency Value** | **Frequency Value** | **Monetary Value ($)** |
|------------------|----------------|----------------|--------------------|
| **Aaron Davies Bruce** | 698 | 1 | 2,390 |
| **Aaron Day** | 130 | 2 | 1,833 |
| **Aaron Dillon** | 207 | 3 | 2,396 |
| **Aaron Fuller Davidson** | 885 | 1 | 2,084 |
| **Aaron Riggs** | 316 | 3 | 3,582 |
| **Aaron Shaffer** | 500 | 3 | 2,400 |
| **Adam Barton** | 134 | 3 | 2,393 |
| **Adam G Sawyer** | 257 | 5 | 3,307 |
| **Adam McKinney** | 477 | 1 | 3,813 |
| **Adam Saunders Gray** | 312 | 2 | 3,538 |
| **Others ...................|

```sql
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
```
then add also score 

```sql
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
```
## Output:
| **Customer Name** | **Recency Value** | **R Score** | **Frequency Value** | **F Score** | **Monetary Value ($)** | **M Score** | **Total RFM Score** | **RFM Score Combination** | **Customer Segment** |
|------------------|----------------|----------|----------------|----------|--------------------|----------|----------------|----------------------|--------------------|
| **Christina Matthews** | 1358 | 1 | 1 | 1 | 3 | 1 | 3 | 111 | CHURNED CUSTOMER |
| **Harry Houston** | 509 | 2 | 1 | 1 | 3 | 1 | 4 | 211 | CHURNED CUSTOMER |
| **Melvin Hsu** | 320 | 2 | 2 | 2 | 3 | 1 | 5 | 221 | POTENTIAL CHURNERS |
| **Gretchen Zimmerman** | 82 | 4 | 1 | 1 | 4 | 2 | 7 | 421 | Other |
| **Angela Wooten** | 675 | 1 | 1 | 1 | 4 | 1 | 3 | 111 | CHURNED CUSTOMER |
| **Cameron Page** | 495 | 2 | 1 | 1 | 4 | 2 | 4 | 211 | CHURNED CUSTOMER |
| **Katie Oh** | 358 | 2 | 2 | 2 | 5 | 1 | 5 | 221 | POTENTIAL CHURNERS |
| **Samuel Smith Ryan** | 670 | 1 | 1 | 1 | 5 | 1 | 4 | 111 | CHURNED CUSTOMER |
| **Fred H Proctor** | 645 | 2 | 1 | 1 | 5 | 1 | 4 | 211 | CHURNED CUSTOMER |
| **Frances Grant** | 266 | 3 | 2 | 2 | 3 | 1 | 6 | 321 | ACTIVE |
| **Dwight Banks** | 1055 | 1 | 1 | 1 | 6 | 1 | 3 | 111 | CHURNED CUSTOMER |
| **Mary Knowles** | 871 | 1 | 1 | 1 | 6 | 1 | 3 | 111 | CHURNED CUSTOMER |
| **Ricky Hansen** | 676 | 1 | 1 | 1 | 6 | 1 | 3 | 111 | CHURNED CUSTOMER |
| **Beth Brennan** | 663 | 1 | 1 | 1 | 6 | 1 | 3 | 111 | CHURNED CUSTOMER |
| **Janice Fletcher** | 582 | 2 | 1 | 1 | 6 | 1 | 4 | 211 | CHURNED CUSTOMER |
| **Gary Kaufman** | 212 | 3 | 2 | 2 | 6 | 1 | 6 | 321 | ACTIVE |
| **Deborah Bradshaw** | 761 | 1 | 1 | 1 | 6 | 1 | 3 | 111 | CHURNED CUSTOMER |
| **Maxine Fletcher** | 529 | 2 | 1 | 1 | 6 | 1 | 4 | 211 | CHURNED CUSTOMER |
| **Lester Sykes** | 269 | 3 | 2 | 2 | 3 | 1 | 6 | 321 | ACTIVE |
| **Phillip Cochran Ashley** | 196 | 3 | 3 | 2 | 7 | 1 | 6 | 321 | ACTIVE |

# Total number of different categories customer
```sql
SELECT 
	CUSTOMER_SEGMENT, 
    COUNT(*) AS NUMBER_OF_CUSTOMERS,
   ROUND(AVG(MONETARY_VALUE),0) AS AVERAGE_MONETARY_VALUE
FROM RFM_ANALYSIS 
GROUP BY CUSTOMER_SEGMENT; 
```
## Output:
| **Customer Segment**               | **Number of Customers** | **Average Monetary Value ($)** |
|------------------------------------|------------------------|----------------------------|
| **CHURNED CUSTOMER**               | 613                    | 496                        |
| **POTENTIAL CHURNERS**             | 328                    | 1020                       |
| **Other**                          | 562                    | 3119                       |
| **ACTIVE**                         | 384                    | 947                        |
| **NEW CUSTOMERS**                  | 20                     | 180                        |
| **LOYAL**                          | 424                    | 8430                       |
| **SLIPPING AWAY, CANNOT LOSE**      | 337                    | 7016                       |

## Customer Segment Insights
- Churned Customers (613, $496) – Largest segment with low spending. Requires re-engagement strategies.
- Potential Churners (328, $1020) – At risk of leaving. Needs proactive retention efforts.
- Other (562, $3119) – Transitional customers with moderate spending. Potential for engagement.
- Active (384, $947) – Engaged but lower spenders. Needs nurturing.
- New Customers (20, $180) – Smallest segment with low spending. Focus on onboarding.
- Loyal Customers (424, $8430) – Highest revenue contributors. Must be retained and rewarded.
- Slipping Away (337, $7016) – High-value customers at risk. Critical for retention efforts.

