--PRACTICE QUESTIONS 35-55
-- Correlated and Uncorrelated Subqueries, Joins (All Kinds)

--UNCORRELATED SUBQUERY
--Subquery can be run independent of the main query. Returns a set of values that fit a criteria.
---Practice 35
/* Display dataset in PurchaseTransaction of productid in product dataset with productid less than 10*/
SELECT TransID, OrderID, UnitPrice*OrderQty AS PurchaseAmount, ProductID
FROM PurchaseTrans 
WHERE ProductID IN (SELECT ProductID FROM PurchaseTrans WHERE productID <  10)

--Practice 36
/* Display dataset in PurchaseTransaction of productid NOT IN product dataset with productid less than
10*/
SELECT TransID, OrderID, UnitPrice*OrderQty as PurchaseAmount, ProductID
FROM Purchasetrans where productid not in (SELECT ProductID FROM PurchaseTrans WHERE ProductID<10)
Order by ProductID


-- CORRELATED SUBQUERY 
--Subquery cannot be run independent of the main query. Can return a value from a table after finding a common
-- column between the two tables.
--Practice 37
/* Display dataset in PurchaseTransaction and derives ProductName in product dataset using ProductID as
Correlated column*/

SELECT * FROM Product
select * from PurchaseTrans
SELECT TransID, OrderID, UnitPrice*OrderQty as PurchaseAmount, Productid, (SELECT ProductName from Product where purchasetrans.productid = product.productid) as ProductName
from purchasetrans 

--Practice 38
--EXISTS returns a boolean result.
/* Display dataset in PurchaseTransaction and derives ProductName in product dataset Where the Special
OfferId exists in SpecialOffer dataset*/
select * from PurchaseTrans
select * from product
select * from SpecialOffer

select transid, orderid, unitprice*orderqty purchaseamount, SpecialOfferID,
	(select productname from product where product.productid = purchasetrans.productid) productname
from PurchaseTrans 
where exists 
	(select 1 from specialoffer where purchasetrans.SpecialOfferID=specialoffer.specialofferid) 


--Practice 39
/* Display dataset in PurchaseTransaction and derives ProductName in product dataset Where the Special
OfferId not exists in SpecialOffer dataset*/
SELECT TransID, OrderID, Unitprice*orderQty as PurchaseAmount, SpecialOfferid,
(SELECT ProductName from Product where product.productid = PurchaseTrans.Productid) ProductName 
from PurchaseTrans
WHERE Not exists (select 1 from SpecialOffer where specialoffer.specialofferid = purchasetrans.specialofferid)

SELECT * FROM Product
SELECT * FROM PurchaseTrans

Select OrderID, (SELECT ProductName from Product where product.productid = purchasetrans.productid)
FROM Purchasetrans


-- UNCORRELATED SUBQUERY USING ALL 
--Practice 40
/* Display dataset in PurchaseTransaction dataset Where ProductID is greater than ALL the product in the
sub query dataset*/
SELECT TransID, OrderID, ProductID
FROM Purchasetrans
WHERE ProductID > ALL (SELECT ProductID from product where productid<10)

--Practice 41 
/* Display dataset in PurchaseTransaction where Order Quantity multiples Unitprice is greater than Average
of Order Quantity multiples UnitPrice in the sub query dataset*/
SELECT * FROM PurchaseTrans
SELECT TransID, OrderID, ProductID
FROM PurchaseTrans
WHERE OrderQty * UnitPrice > (SELECT AVG(OrderQty * UnitPrice) FROM PurchaseTrans)

--JOINS
--INNER JOIN: Records common to both tables
--LEFT JOIN: All data in A and the common ones with B
--RIGHT JOIN: All data in B and the common ones with A 
--FULL JOIN: All data in A and all data in B 
--CROSS JOIN: Each row in A to all rows in B  
--UNION ALL: Combines the data from two tables with duplicate data. 
--UNION: Combines the data from two tables without duplicate data 

--Practice 43
SELECT * FROM PUrchaseTrans
SELECT * FROM Product 
SELECT * FROM SpecialOffer
SELECT OrderID, Supplier, p.ProductName, Address, City, StateProvince, Country, OrderQty
FROM PurchaseTrans pt
INNER JOIN Product p on pt.productid = p.ProductID

--Practice 44
/* Display dataset in PurchaseTransaction with the matching product and special offer dataset*/
SELECT OrderID, Supplier, p.ProductName, Address, City, StateProvince, Country, OrderQty, so.SpecialOffer
FROM PurchaseTrans pt
INNER JOIN Product p on pt.ProductID = p.productid 
inner join Specialoffer so on pt.specialofferid = so.SpecialOfferID

--Practice 45
/* Display dataset in PurchaseTransaction with the matching product and special offer on Back to School
dataset*/
SELECT OrderID, Supplier, p.ProductName, Address, City, StateProvince, Country, OrderQty, so.SpecialOffer
FROM PurchaseTrans pt
INNER JOIN Product p on pt.ProductID = p.productid 
inner join Specialoffer so on pt.specialofferid = so.SpecialOfferID
WHERE SO.SpecialOffer = 'Back to School'

SELECT * from ProductCategory
SELECT * FROM Product
SELECT * FROM Category
SELECT * FROM PurchaseTrans

--Practice 47
/* Display dataset in PurchaseTransaction with the matching Product, Category and special offer on Back to
School dataset*/
SELECT OrderID, Supplier, CategoryName, ProductName, ProductNumber, SpecialOffer, Address, City, StateProvince, Country, OrderQty
FROM PurchaseTrans pt
INNER JOIN (
			SELECT p.productid, c.CategoryName, ProductName, productnumber
			FROM Product p
			INNER JOIN ProductCategory pc on pc.productid = p.productid
			INNER JOIN Category c on c.categoryid = pc.categoryid
			) co
ON pt.productid = co.productid
INNER JOIN SpecialOffer so on so.SpecialOfferID = pt.SpecialOfferID

--FULL JOIN TEST
SELECT ProductCategoryID, ProductID, c.CategoryID, CategoryName
FROM ProductCategory pc 
FULL JOIN Category c on pc.CategoryID = c.CategoryID
ORDER BY CategoryID


--Practice 54 - UNION 
SELECT * FROM CustomerShipment
SELECT * FROM PurchaseTrans
SELECT OrderID,CarrierTrackingNumber, Employee, City, OrderDate FROM CustomerShipment
UNION
SELECT OrderID,CarrierTrackingNumber, Employee, City, ShipDate FROM PurchaseTrans 

