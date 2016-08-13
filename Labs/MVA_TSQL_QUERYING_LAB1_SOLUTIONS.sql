-- Author: Jacob S. Howarth
-- Description: Exercises for lab 1 of MVA T-SQL Querying course

-- 1) Retrieve all customer information
select * from [SalesLT].[Customer];

-- 2) Retrieve title, first, last, middle, suffix name from customers
select Title, FirstName, MiddleName, LastName, Suffix
from [SalesLT].[Customer];

-- 3) Retrieve a list of sales people associated with customers, phone number, and Title + Lastname greeting (CustomerName)
select SalesPerson, isnull(Title + ' ' + LastName, 'N/A') as CustomerName, Phone
from [SalesLT].[Customer];

-- 4) Retrieve customer id and company name in following format: <Customer ID>:<Company Name>
select cast(CustomerID as nvarchar(max)) + ':' + CompanyName as [CustomerID:CompanyName] 
from [SalesLT].[Customer];

-- 5) Retireve sales order data with sales order # and revision # in <OrderNumber>(<Revision>) format and order date in ANSI standard yyyy.mm.dd format)
select SalesOrderNumber  + '(' + cast(RevisionNumber as nvarchar(max)) + ')' as [SalesOrderNumber(RevisionNumber)], convert(nvarchar(12), OrderDate, 102) as [OrderDate]
from [SalesLT].[SalesOrderHeader];

-- 6) Retrieve customer names in the format <first> <last> if no middle name or <first> <middle> <last> if middled name is known
select FirstName + ' ' + isnull(MiddleName + ' ', '') + LastName as [FullName]
from [SalesLT].[Customer];

update [SalesLT].[Customer]
set EmailAddress = null
where CustomerID % 7 = 1;

-- 7) Retrieve customer id and email address if exists, if not phone number as primary contact
select CustomerID, isnull(EmailAddress, Phone) as [PrimaryContact]
from [SalesLT].[Customer];

update [SalesLT].[SalesOrderHeader]
set ShipDate = null
where SalesOrderID > 71899;

-- 8) List sales order id and shipp status of "shipped" if orders have and ship date or "awaiting shipment" if no ship date
select SalesOrderID,
	   case 
		when ShipDate is null then 'Awaiting Shipment'
		else 'Shipped' 
	   end as [ShippingStatus]
from [SalesLT].[SalesOrderHeader]