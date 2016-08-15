-- 1. Retrieve distinct city and state addresses from Address table
select distinct StateProvince, City
from [SalesLT].[Address];

-- 2. Retrieve the names of the top 10 percent of heaviest products by weight
select top 10 percent Name, isnull([Weight], 0) as [Weight]
from [SalesLT].[Product]
order by [Weight] desc; 

-- 3. Retrieve the top 100 heaviest product names by weight excluding first 10
select Name, isnull([Weight], 0) as [Weight]
from [SalesLT].[Product]
order by [Weight] desc
offset 10 rows
fetch next 100 rows only; 

-- 4. Find name, color, and sizes of products with model id 1
select Name, Color, Size
from [SalesLT].[Product]
where ProductModelID = 1;

-- 5. Retrieve product number and name of products with color black, red, white and size S, M
select ProductNumber, Name
from [SalesLT].[Product]
where (Color in ('Black', 'Red', 'White')) and (Size in ('S', 'M'));

-- 6. Retrieve product number, name, list price of products with product number beginning with BK-
select ProductNumber, Name, ListPrice
from [SalesLT].[Product]
where ProductNumber like 'BK-%';

-- 7.  Retrieve product number, name, list price of products with product number beginning with BK-, followed by any characters other than R, followed by - and two numbers
select ProductNumber, Name, ListPrice
from [SalesLT].[Product]
where ProductNumber like 'BK-[^R]%-[0-9][0-9]';