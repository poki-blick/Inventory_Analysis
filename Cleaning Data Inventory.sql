-- Membuat Table Duplikat
create table grocery_inventory_new_v2 as 
select * from grocery_Inventory_new_v1;

-- Cek Missing Value
select * 
from grocery_inventory_new_v1 ginv 
where 
	Catagory is null or 
	Product_Name is null or 
	status is null or 
	Warehouse_Location is null;

-- Standarisasi Date Value
update grocery_inventory_new_v1 ginv 
set
    Date_Received = STR_TO_DATE(Date_Received, '%m/%d/%Y'),
    Expiration_Date = STR_TO_DATE(Expiration_Date, '%m/%d/%Y');

-- Standarisasi Nama Category
update grocery_inventory_new_v1 ginv 
set Catagory = 
    case 
        when Catagory LIKE '%Fruit%' then 'Fruits & Vegetables'
        when Catagory = 'Dairy' then 'Dairy Products'
        else Catagory
   	end;

-- Hapus Data Duplikat
delete t1 
from grocery_inventory_new_v1  t1
inner join grocery_inventory_new_v1 t2 
where 
    t1.Product_ID = t2.Product_ID and
    t1.Date_Received < t2.Date_Received;  


-- Perbaiki stok negatif
UPDATE grocery_inventory_new_v1 ginv 
SET Stock_Quantity = ABS(Stock_Quantity)
WHERE Stock_Quantity < 0;

-- Standarisasi Nama supplier
update grocery_inventory_new_v1 ginv 
set Supplier_Name = trim(Supplier_Name); 

-- Validasi Nama dengan id Supplier
SELECT 
    Supplier_ID, 
    Supplier_Name, 
    COUNT(DISTINCT Supplier_Name) AS Name_Count
FROM grocery_inventory_new_v1 ginv 
GROUP BY Supplier_ID, Supplier_Name
HAVING Name_Count > 1;
 

