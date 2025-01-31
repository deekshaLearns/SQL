SELECT * FROM demo.dirty_cafe_sales;

-- clean the data
UPDATE dirty_cafe_sales
SET Total_Spent = Quantity * Price_Per_Unit
WHERE Total_Spent = 'ERROR';

-- Replace 'ERROR' in Price_Per_Unit with the average price for that item
UPDATE dirty_cafe_sales
SET Price_Per_Unit = (
    SELECT AVG(Price_Per_Unit)
    FROM dirty_cafe_sales AS dcs2
    WHERE dcs2.Item = dirty_cafe_sales.Item
    AND dcs2.Price_Per_Unit != 'ERROR'
)
WHERE Price_Per_Unit = 'ERROR';

-- Replace 'ERROR' in Quantity with the average quantity for that item
UPDATE dirty_cafe_sales
SET Quantity = (
    SELECT AVG(Quantity)
    FROM dirty_cafe_sales AS dcs2
    WHERE dcs2.Item = dirty_cafe_sales.Item
    AND dcs2.Quantity != 'ERROR'
)
WHERE Quantity = 'ERROR';

-- Replace missing Item values with 'Unknown'
UPDATE dirty_cafe_sales
SET Item = 'Unknown'
WHERE Item IS NULL OR Item = '';

--  Replace missing Payment Method values with 'Unknown'
UPDATE dirty_cafe_sales
SET Payment_Method = 'Unknown'
WHERE Payment_Method IS NULL OR Payment_Method = '';

-- Replace missing Location values with 'Unknown'
UPDATE dirty_cafe_sales
SET Location = 'Unknown'
WHERE Location IS NULL OR Location = '';

--  Replace missing Transaction Date values with a default date (e.g., '1900-01-01')
UPDATE dirty_cafe_sales
SET Transaction_Date = '1900-01-01'
WHERE Transaction_Date IS NULL OR Transaction_Date = '';

--  Ensure Quantity is a positive integer
UPDATE dirty_cafe_sales
SET Quantity = ABS(Quantity)
WHERE Quantity < 0;

-- Ensure Price_Per_Unit is a positive number
UPDATE dirty_cafe_sales
SET Price_Per_Unit = ABS(Price_Per_Unit)
WHERE Price_Per_Unit < 0;

-- Ensure Total_Spent is a positive number
UPDATE dirty_cafe_sales
SET Total_Spent = ABS(Total_Spent)
WHERE Total_Spent < 0;

-- Remove rows where Transaction_ID is missing
DELETE FROM dirty_cafe_sales
WHERE Transaction_ID IS NULL OR Transaction_ID = '';

-- Remove rows where Item is missing (after attempting to fill with 'Unknown')
DELETE FROM dirty_cafe_sales
WHERE Item = 'Unknown';