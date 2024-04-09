USE BUDT703_Project_0507_14;

--Which payment method is the most preferred by customers?
SELECT TOP 1 a.invoicePaymentMethod
FROM (
	SELECT COUNT(i.orderId) AS countpay,i.invoicePaymentMethod  
	FROM [AuraCosmetics.Invoice] i
	GROUP BY i.invoicePaymentMethod) a
ORDER BY countpay DESC;

--What number of customers are distributors and what number are direct customers?
SELECT c.customerType, COUNT(c.customerType)
FROM [AuraCosmetics.Customer] c
GROUP BY c.customerType;



--What is the total number of returns per product?
SELECT p.productName, SUM(inventoryReturns) AS 'Returned Items'
FROM [AuraCosmetics.Inventory] i,[AuraCosmetics.Product] p
WHERE i.productId = p.productId
GROUP BY p.productName;

--What is the number of customers in each state?
SELECT customerState ,COUNT(*) AS 'Number of Customers'
FROM [AuraCosmetics.Customer]
GROUP BY customerState;
 

--What is the best performing product by ranking products based on the number of orders for each product? 

SELECT o.productId,p.productName,p.productDesc,DENSE_RANK() OVER (ORDER BY orderCount DESC) AS 'Product Rank'
FROM
	(SELECT c.productId, COUNT(o.orderId) AS 'orderCount'
	FROM [AuraCosmetics.order] o ,
	[AuraCosmetics.Contain] c
	WHERE o.orderId = c.orderId
	GROUP BY c.productId
	) o , [AuraCosmetics.Product] p
WHERE o.productId = p.productId;

--What are the number of orders placed in the last 6 months(current month included)?

SELECT t.timePeriodBucketName,t.timePeriodId, t.timePeriodName, p.productDesc, SUM(o.orderQuantity) AS 'orderQuantity'
FROM [AuraCosmetics.Order] o ,[AuraCosmetics.Within] w,[AuraCosmetics.TimePeriod] t ,[AuraCosmetics.Contain] c, [AuraCosmetics.Product] p
WHERE o.orderId = w.orderId AND w.timePeriodId = t.timePeriodId AND o.orderId = c.orderId AND c.productId = p.productId
GROUP BY t.timePeriodId, t.timePeriodName,p.productDesc, t.timePeriodBucketName
HAVING t.timePeriodBucketName = 'Rolling 6 Months'
ORDER BY t.timePeriodId DESC;



--What is the increase/decrease in the number of orders that were placed between the dates '2022-10-16' & '2022-10-21' (a holiday deal week where discounts were higher) as compared to the same week in the previous month?
SELECT 'Discount Offers Week (2022-10-16 to 2022-10-21)' AS 'Week Type', COUNT(OrderId) AS 'Number of Orders'
FROM [AuraCosmetics.order] o
WHERE (orderDate BETWEEN '2022-10-16' AND '2022-10-21') 
UNION
SELECT 'Previous Month Same Week' , COUNT(OrderId) AS 'Number of Orders'
FROM [AuraCosmetics.order] o
WHERE DATEPART(WEEK,orderDATE) - DATEPART(WEEK,DATEFROMPARTS(year(orderDATE),MONTH(orderDate),'01')) = 
( SELECT DATEPART(week,'2022-10-16') - DATEPART(week,DATEFROMPARTS(year('2022-10-16'),MONTH('2022-10-16'),'01'))) AND 
MONTH(orderDate) = MONTH('2022-10-16') - 1 AND YEAR(orderDate) = YEAR('2022-10-16');
