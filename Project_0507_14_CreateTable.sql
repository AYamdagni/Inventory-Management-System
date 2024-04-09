USE BUDT703_Project_0507_14;

CREATE TABLE [AuraCosmetics.Product] (
	productId VARCHAR(6) NOT NULL,
	productName VARCHAR(20),
	productDesc VARCHAR(70),
	productPrice DECIMAL(6,2),
		CONSTRAINT pk_Product_productId PRIMARY KEY(productId));

CREATE TABLE [AuraCosmetics.Customer] (
	customerId CHAR(11) NOT NULL,
	customerFirstName VARCHAR(20) NOT NULL,
	customerMiddleName VARCHAR(20),
	customerLastName VARCHAR(20) NOT NULL,
	customerType VARCHAR(15), 
	customerAddressLn1 VARCHAR(25) NOT NULL,
	customerAddressLn2 VARCHAR(25),
	customerCity VARCHAR(20),
	customerState VARCHAR(20),
	customerZip INT NOT NULL,
	customerPhNo CHAR(12) NOT NULL
		CONSTRAINT pk_Customer_customerId PRIMARY KEY(customerId));


CREATE TABLE [AuraCosmetics.Inventory] (
	productId VARCHAR(6) NOT NULL,
	inventoryDate DATE NOT NULL,
	inventoryBeginningQuantity INT,
	inventoryEndingQuantity INT,
	inventoryReturns INT

		CONSTRAINT pk_Inventory_productId_inventoryDate PRIMARY KEY(productId,inventoryDate),
		CONSTRAINT fk_Inventory_productId FOREIGN KEY (productId)
		REFERENCES [AuraCosmetics.Product] (productId)
		ON DELETE NO ACTION ON UPDATE CASCADE
		);

CREATE TABLE [AuraCosmetics.Order] (
	orderId VARCHAR (20) NOT NULL,
	orderDate DATE,
	orderQuantity INTEGER,
	customerId CHAR(11) NOT NULL,
		CONSTRAINT pk_order_orderId PRIMARY KEY (orderId), 
		CONSTRAINT fk_order_customerId FOREIGN KEY (customerId)
		REFERENCES [AuraCosmetics.Customer] (customerId)
		ON DELETE NO ACTION ON UPDATE CASCADE);

CREATE TABLE [AuraCosmetics.Invoice] (
	orderId VARCHAR (20) NOT NULL,
	invoiceNumber VARCHAR (20) NOT NULL,
	invoicePaymentMethod CHAR(10),
	invoiceDiscount DECIMAL(9,2),
	
		CONSTRAINT pk_Invoice_invoiceNumber PRIMARY KEY (invoiceNumber),
		CONSTRAINT fk_Invoice_orderId FOREIGN KEY (orderId)
		REFERENCES [AuraCosmetics.order] (orderId)
		ON DELETE NO ACTION ON UPDATE CASCADE);


CREATE TABLE [AuraCosmetics.TimeSeed] (
	timeSeedId int NOT NULL IDENTITY(1,1),
	timeSeedDate DATE ,
		CONSTRAINT pk_TimeSeed_timeSeedId PRIMARY KEY (timeSeedId)
		);

CREATE TABLE [AuraCosmetics.TimePeriod] (
	timePeriodId int NOT NULL ,
	timePeriodName VARCHAR(50),
	timePeriodBucketName VARCHAR(50),
	timePeriodStartDate Date,
	timePeriodEndDate Date,

		CONSTRAINT pk_TimePeriod_timePeriodId PRIMARY KEY (timePeriodId)
		);

CREATE TABLE [AuraCosmetics.Within] (
	orderId VARCHAR (20) NOT NULL,
	timePeriodId int NOT NULL,
		CONSTRAINT pk_Within_orderId_timePeriodId PRIMARY KEY (orderId, timePeriodId),
		CONSTRAINT fk_Within_orderId FOREIGN KEY (orderId)
		REFERENCES [AuraCosmetics.order] (orderId)
		ON DELETE NO ACTION ON UPDATE CASCADE,
		CONSTRAINT fk_Within_timePeriodId FOREIGN KEY (timePeriodId)
		REFERENCES [AuraCosmetics.TimePeriod] (timePeriodId)
		ON DELETE NO ACTION ON UPDATE CASCADE
		);

CREATE TABLE [AuraCosmetics.Between] (
	inventoryDate DATE NOT NULL,
	productId  VARCHAR(6) NOT NULL,
	timePeriodId int NOT NULL,
		CONSTRAINT pk_Between_inventoryDate_timePeriodId PRIMARY KEY (inventoryDate, productId, timePeriodId),
		CONSTRAINT fk_Between_inventoryDate_productId FOREIGN KEY (productId,inventoryDate )
		REFERENCES [AuraCosmetics.Inventory] (productId,inventoryDate)
		ON DELETE NO ACTION ON UPDATE CASCADE,
		CONSTRAINT fk_Between_timePeriodId FOREIGN KEY (timePeriodId)
		REFERENCES [AuraCosmetics.TimePeriod] (timePeriodId)
		ON DELETE NO ACTION ON UPDATE CASCADE
		);

CREATE TABLE [AuraCosmetics.Contain] (
	productId VARCHAR(6) NOT NULL,
	orderId VARCHAR (20) NOT NULL,
		CONSTRAINT pk_Contain_productId_orderId PRIMARY KEY (productId, orderId),
		CONSTRAINT fk_Contain_productId FOREIGN KEY (productId)
		REFERENCES [AuraCosmetics.Product] (productId)
		ON DELETE NO ACTION ON UPDATE CASCADE,
		CONSTRAINT fk_Contain_orderId FOREIGN KEY (orderId)
		REFERENCES [AuraCosmetics.order] (orderId)
		ON DELETE NO ACTION ON UPDATE CASCADE
		);