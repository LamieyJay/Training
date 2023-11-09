--PRACTICE 1 - 34
--CASE, AGGREGATE FUNCTIONS, DISTINCTS, etc 

SELECT * FROM PurchaseTrans

SELECT Supplier, AccountNumber 
FROM PurchaseTrans

SELECT DISTINCT AccountNumber, Supplier 
FROM PurchaseTrans
WHERE Country = 'Canada'

SELECT * FROM PurchaseTrans
WHERE UnitPrice > 100 AND City ='Burnaby' AND Country ='Canada'

SELECT * FROM PurchaseTRans 
WHERE Country = 'Canada' AND CarrierTrackingNumBer LIKE '4B%'

SELECT OrderID, ProductID, UnitPrice*OrderQty AS PurchaseAmount, SpecialOfferID,
CASE SpecialOfferID
	WHEN 1 THEN 'Black Friday'
	WHEN 2 THEN 'HallowDay Promotion'
	WHEN 3 THEN 'WinterOFFER'
	WHEN 4 THEN 'Back to School'
	WHEN 6 THEN 'Liberty Anniversary'
	WHEN 7 THEN 'Summer Sales'
	WHEN 9 THEN 'Canada 150th Years'
	WHEN 13 THEN 'Civil Holiday' 
	WHEN 14 THEN 'Good Friday'
	ELSE 'Unknown'
END as SpecialOfferID 
FROM PurchaseTrans

/* Derive Purchase Key Performance Indicator using CASE statement expression on UnitPrice and Order Quantity*/
SELECT OrderID, TransID, Supplier, UnitPrice*OrderQty AS PurchaseAmount, 
CASE 
	 WHEN UnitPrice*OrderQty < 1000 THEN 'Low'
	 WHEN UnitPrice*OrderQty >= 1000 AND UnitPrice*OrderQty < 1500 THEN 'Medium'
	 ELSE 'High'
	 END AS KeyPerformanceIndicator
FROM PurchaseTrans
ORDER BY KeyPerformanceIndicator

/* Derive Purchase Key Performance Indicator using CASE statement expression on UnitPrice and Order Quantity based on
Country*/
SELECT OrderID,TransID, Country, sUPPLIER, UnitPrice*OrderQty AS PurchaseAmount,
CASE Country
	WHEN 'Canada' THEN
		CASE 
			WHEN UnitPrice*OrderQty < 500 THEN 'Low'
			WHEN UnitPrice*OrderQty >= 500 AND UnitPrice*OrderQty < 1000 THEN 'Medium'
			ELSE 'High'
		END
	WHEN 'United States' THEN
		CASE
			WHEN UnitPrice*OrderQty < 1000 THEN 'Low'
			WHEN UnitPrice*OrderQty >= 1000 AND UnitPrice*OrderQty < 1500 THEN 'Medium'
			ELSE 'High'
		END
END AS KeyPerformanceIndicator
FROM PurchaseTrans

/* Count total number of UNIQUE employee in the
PuchaseTrans dataset*/
SELECT COUNT(DISTINCT Employee) FROM PurchaseTrans

/* Return the average of the total order quantity of the PurchaseTrans dataset*/
SELECT AVG(OrderQty) AS AverageOrderQuantity
FROM PurchaseTrans

/* Return the SUM of the unique order quantity value GROUP BY Country in the PurchaseTrans dataset*/
SELECT Country, SUM(DISTINCT OrderQty) from PurchaseTrans
group by Country

/* Return the rollup of subtotal and total quantity by Country and class of
purchaseTrans dataset*/
SELECT Country, SUM(OrderQty) from PurchaseTrans
GROUP BY Country
SELECT Country, Class, SUM(OrderQty) from PurchaseTrans
GROUP BY ROLLUP (Country, Class)
SELECT Country, Class, SUM(OrderQty) from PurchaseTrans
GROUP BY ROLLUP (Class, Country)

/* Return the dataset group by country and class of
purchaseTrans dataset*/
SELECT Country, Class, SUM(OrderQty)
from PurchaseTrans
GROUP BY GROUPING SETS (Country, Class)

/* 28 - Return the SUM of DISTINCT order quantity value Having Sum of order quantity greater than 100, GROUP BY Country in the
PurchaseTrans dataset*/
SELECT Country, SUM(DISTINCT OrderQty)
from PurchaseTrans
GROUP BY Country HAVING SUM(OrderQty) > 100

/*Practice 30
 Return the SUM of DISTINCT order quantity value, count of order quantity and sum of order quantity multiplies by unit pr
ice ,
Having Count of Distinct (order quantity multiplied by Unit price) greater than 10 AND sum of order quantity multiples by unit p ric e
greater than 2000 GROUP BY Country in the PurchaseTrans dataset*/
SELECT SUM(DISTINCT OrderQty) SumOfDistinctOrderQuantities, 
	COUNT(OrderQty) NumberofOrders, 
	SUM(OrderQty*UnitPrice)TotalPurchaseAmount, 
	Country
from PurchaseTrans
group by Country HAVING COUNT(DISTINCT OrderQty*UnitPrice)>10 AND SUM (OrderQty*UnitPrice)>2000

/* 33 - Return the SUM of DISTINCT order quantity value, count of dataset, Purchase amount( sum of order quantity multiplies by
unit
price), Having count of Distinct order quantity multiples by unit price greater than 10 AND sum of order quantity multiples by unit
price greater than 2000 GROUP BY Country and city and Order by Country in the PurchaseTrans dataset*/
SELECT Country, City, SUM(DISTINCT OrderQty), Count(*), SUM(OrderQty*UnitPrice) PurchaseAmount
FROM PurchaseTrans
GROUP BY Country, City HAVING COUNT(DISTINCT OrderQty*UnitPrice)>10 AND SUM(OrderQty*UnitPrice)>2000
ORDER BY Country

/* 34 - Return the SUM of DISTINCT order quantity value, count of dataset, Purchase amount( sum of order quantity multiplies by
uni t
price), Having count of Distinct order quantity multiples by quantity greater than 10 AND sum of order quantity multiples b y u nit
price greater than 2000 GROUP BY Country and city and Order by Country in the PurchaseTrans dataset for Country =‘Canada’*/

SELECT Country, 
	City, 
	SUM(DISTINCT OrderQty)SumOfDistinctOrderQuantities, 
	COUNT(*), 
	SUM(OrderQty*UnitPrice) PurchaseAmount
FROM PurchaseTrans
GROUP BY Country, City
HAVING COUNT(DISTINCT OrderQty*UnitPrice)>10 AND SUM (OrderQty*UnitPrice)>2000 AND Country='Canada'
ORDER BY Country