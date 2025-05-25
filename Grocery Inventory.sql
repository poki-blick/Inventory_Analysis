-- Identifikasi Barang Restock
select 
	Product_Name, 
	Stock_Quantity,
	Reorder_Level 
from grocery_inventory_new_v1 gi 
where 
	Stock_Quantity < Reorder_Quantity ;

-- Total Inventaris per Category
select Catagory, SUM(Stock_Quantity * Unit_Price) as Total_Value 
from grocery_inventory_new_v1
group by Catagory ;

-- Supplier dengan Jumlah Backorders
select Supplier_Name, COUNT(*) as Total_Backorders 
from grocery_inventory_new_v1 ginv  
where Status = 'Backordered' 
group by Supplier_Name 
order by Total_Backorders desc;

-- Supplier dengan Jumlah Discontinued
select Supplier_Name, COUNT(*) as Total_Discontinued
from grocery_inventory_new_v1 ginv  
where Status = 'Discontinued' 
group by Supplier_Name 
order by total_discontinued desc;

-- Category dengan jumlah inventory rate 
select Catagory, AVG(Inventory_Turnover_Rate) as Avg_Turnover 
from grocery_inventory_new_v1 ginv 
group by Catagory 
order by Avg_Turnover desc;

-- Margin Product Tertinggi
select distinct Product_Name, (Unit_Price * Sales_Volume) as Total_Profit_$
from grocery_inventory_new_v1 ginv 
order by total_profit_$  desc
limit 10;

-- Prediksi Kekurangan Stock Product
select Product_Name, 
       Stock_Quantity / (Sales_Volume / 30) as Days_Until_Stockout 
from grocery_inventory_new_v1 ginv;

-- Tren Penerimaan Product per bulan
select MONTH(Date_Received) as Month, COUNT(*) as Total_Received 
from grocery_inventory_new_v1 ginv  
group by MONTH(Date_Received) order by `month`;



