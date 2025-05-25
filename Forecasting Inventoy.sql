-- Forecasting Kebutuhan Stock
SELECT 
    Product_ID,
    Product_Name,
    Stock_Quantity,
    Sales_Volume,
    (Stock_Quantity / NULLIF(Sales_Volume, 0)) AS Days_Until_Stockout
FROM grocery_inventory_new_v1 ginv ;

-- Forecasting Reorder Quantity
SELECT 
    Product_Name,
    Reorder_Quantity,
    Inventory_Turnover_Rate,
    ROUND((Sales_Volume * 1.2) - Stock_Quantity, 0) AS Suggested_Reorder 
FROM grocery_inventory_new_v1 ginv ;

-- Case Flow Forecasting
SELECT 
    Supplier_ID,
    SUM(Reorder_Quantity * Unit_Price) AS Forecasted_Cost
FROM grocery_inventory_new_v1 ginv 
GROUP BY Supplier_ID;

-- Cohort Analys Untuk Product Baru
SELECT 
    MONTH(Date_Received) AS Cohort_Month,
    AVG(Sales_Volume) AS Avg_Sales,
    AVG(Inventory_Turnover_Rate) AS Avg_Turnover
FROM grocery_inventory_new_v1 ginv 
WHERE Date_Received >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY Cohort_Month;





