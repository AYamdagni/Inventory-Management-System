USE BUDT703_Project_0507_14;

--Time Seed

INSERT INTO [AuraCosmetics.TimeSeed] 
	SELECT MAX(inventoryDate) 
	FROM [AuraCosmetics.Inventory];


--Time Period

INSERT INTO [AuraCosmetics.TimePeriod]  

	SELECT 1,DATENAME(month,t.timeSeedDate) , 'Rolling 6 Months', DATEFROMPARTS(YEAR(t.timeSeedDate),MONTH(t.timeSeedDate),'01'),
	EOMONTH(t.timeSeedDate)
	FROM (
		SELECT timeSeedDate  
		FROM [AuraCosmetics.TimeSeed] 
		WHERE timeSeedId = 1) t

	UNION

	SELECT 
	2,DATENAME(month,t1.timeSeedDate) , 'Rolling 6 Months', DATEFROMPARTS(YEAR(t1.timeSeedDate),MONTH(t1.timeSeedDate),'01'),
	EOMONTH(t1.timeSeedDate)
	FROM (
		SELECT DATEFROMPARTS(YEAR(timeSeedDate),MONTH(timeSeedDate)-1,DAY(timeSeedDate))  AS 'timeSeedDate'
		FROM [AuraCosmetics.TimeSeed] 
		WHERE timeSeedId = 1) t1

	UNION

	SELECT 
	3,DATENAME(month,t2.timeSeedDate) , 'Rolling 6 Months', DATEFROMPARTS(YEAR(t2.timeSeedDate),MONTH(t2.timeSeedDate),'01'),
	EOMONTH(t2.timeSeedDate)
	FROM (
		SELECT DATEFROMPARTS(YEAR(timeSeedDate),MONTH(timeSeedDate)-2,DAY(timeSeedDate))  AS 'timeSeedDate'
		FROM [AuraCosmetics.TimeSeed] 
		WHERE timeSeedId = 1) t2

	UNION

	SELECT 
	4,DATENAME(month,t3.timeSeedDate) , 'Rolling 6 Months',DATEFROMPARTS(YEAR(t3.timeSeedDate),MONTH(t3.timeSeedDate),'01'),
	EOMONTH(t3.timeSeedDate)
	FROM (
		SELECT DATEFROMPARTS(YEAR(timeSeedDate),MONTH(timeSeedDate)-3,DAY(timeSeedDate))  AS 'timeSeedDate'
		FROM [AuraCosmetics.TimeSeed] 
		WHERE timeSeedId = 1) t3

	UNION

	SELECT 
	5,DATENAME(month,t4.timeSeedDate) ,'Rolling 6 Months',DATEFROMPARTS(YEAR(t4.timeSeedDate),MONTH(t4.timeSeedDate),'01'),
	EOMONTH(t4.timeSeedDate)
	FROM (
		SELECT DATEFROMPARTS(YEAR(timeSeedDate),MONTH(timeSeedDate)-4,DAY(timeSeedDate))  AS 'timeSeedDate'
		FROM [AuraCosmetics.TimeSeed] 
		WHERE timeSeedId = 1) t4

	UNION

	SELECT 
	6,DATENAME(month,t5.timeSeedDate) ,'Rolling 6 Months',DATEFROMPARTS(YEAR(t5.timeSeedDate),MONTH(t5.timeSeedDate),'01'),
	EOMONTH(t5.timeSeedDate)
	FROM (
		SELECT DATEFROMPARTS(YEAR(timeSeedDate),MONTH(timeSeedDate)-5,DAY(timeSeedDate))  AS 'timeSeedDate'
		FROM [AuraCosmetics.TimeSeed] 
		WHERE timeSeedId = 1) t5

	UNION

	SELECT 
	7,'Q' + DATENAME(QUARTER,t6.timeSeedDate) ,'Quater Till Date', 
	DATEFROMPARTS(YEAR(t6.timeSeedDate), t6.quarterStartMonth ,	'01'),
	t6.timeSeedDate

	FROM (
		SELECT timeSeedDate  AS 'timeSeedDate' , 
		CASE WHEN MONTH(timeSeedDate) >= 1 AND MONTH(timeSeedDate) < = 3
			 THEN 1
			 WHEN MONTH(timeSeedDate) >= 4 AND MONTH(timeSeedDate) < = 6
			 THEN 4
			 WHEN MONTH(timeSeedDate) >= 7 AND MONTH(timeSeedDate) < = 9
			 THEN 7
			 ELSE 10 END AS 'quarterStartMonth'
		FROM [AuraCosmetics.TimeSeed] 
		WHERE timeSeedId = 1) t6;



