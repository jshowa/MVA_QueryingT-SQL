-- 1) Return company name from customer records with sales order ID and totals
select C.CompanyName, SO.SalesOrderID, TotalDue
from SalesLT.Customer C
join
SalesLT.SalesOrderHeader SO
on C.CustomerID = SO.CustomerID;

-- 2) Extend query 1 to include the main office address for each customer with full street address, city, state/province, post code, country/region
select C.CompanyName,
	   isnull(A.AddressLine1, 'No Address') + isnull(', ' + A.AddressLine2 , '') FullStreetAddress,
	   A.City,
	   A.StateProvince,
	   A.PostalCode,
	   A.CountryRegion,  
	   SO.SalesOrderID, 
	   SO.TotalDue
from SalesLT.Customer C
join
SalesLT.SalesOrderHeader SO
on C.CustomerID = SO.CustomerID
join
SalesLT.CustomerAddress CA
on
C.CustomerID = CA.CustomerID and CA.AddressType = 'Main Office'
join
[SalesLT].[Address] A
on
CA.AddressID = A.AddressID;

-- 3) List all customer companies, first/last name contacts, sales order ID, and total due for each order with customers with no orders
--	  having null values and places at the lists bottom
select C.CompanyName, C.FirstName, C.LastName, SO.SalesOrderID, SO.TotalDue
from SalesLT.Customer C
left join
SalesLT.SalesOrderHeader SO
on C.CustomerID = SO.CustomerID
order by SO.TotalDue desc;

 
 -- 4) List of customer ID, company name, contact name, phone number of customers with no address info
select C.CustomerID, C.CompanyName, C.FirstName, C.LastName, C.Phone
from SalesLT.Customer C
left join
SalesLT.CustomerAddress CA
on
C.CustomerID = CA.CustomerID 
--left join
--[SalesLT].[Address] A
--on
--CA.AddressID = A.AddressID
where 
CA.AddressID is null;

-- 5) List of customers who've never placed orders and products that have never been ordered (row with each customer with a null product, each product with null customer)
select C.CustomerID, P.ProductID
from SalesLT.Customer C
left join
SalesLT.SalesOrderHeader SO
on C.CustomerID = SO.CustomerID
left join
SalesLT.SalesOrderDetail SOD
on SO.SalesOrderID = SOD.SalesOrderID
full join
SalesLT.Product P
on SOD.ProductID = P.ProductID
where SO.SalesOrderID is null
order by P.ProductID, C.CustomerID;