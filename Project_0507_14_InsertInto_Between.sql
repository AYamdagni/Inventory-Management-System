USE BUDT703_Project_0507_14;

--Between
INSERT INTO [AuraCosmetics.Between] 
	SELECT i.inventoryDate, i.productId, t.timePeriodId
	FROM [AuraCosmetics.Inventory] i, [AuraCosmetics.TimePeriod] t
	WHERE i.inventoryDate >= t.timePeriodStartDate AND i.inventoryDate <= t.timePeriodEndDate;