USE BUDT703_Project_0507_14;

--Within
INSERT INTO [AuraCosmetics.Within] 
	SELECT orderId, timePeriodId
	FROM [AuraCosmetics.Order] o, [AuraCosmetics.TimePeriod] t
	WHERE o.orderDate >= t.timePeriodStartDate AND o.orderDate <= t.timePeriodEndDate;