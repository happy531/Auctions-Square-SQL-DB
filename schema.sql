USE master;
DROP DATABASE IF EXISTS AuctionsSquare;
GO

CREATE DATABASE AuctionsSquare;
GO

USE AuctionsSquare;
GO

SET LANGUAGE british;
GO

-------- DELETE --------

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS DeliveryOptions;
DROP TABLE IF EXISTS ItemsDeliveries;
DROP TABLE IF EXISTS Auctions;
DROP TABLE IF EXISTS SubmittedOffers;

--------- CREATE --------

CREATE TABLE Users
(
    userLogin			VARCHAR(20) NOT NULL PRIMARY KEY,
	userName			VARCHAR(20) NOT NULL CONSTRAINT ck_userName CHECK (userName LIKE '[A-Z]%'),
    userLastName		VARCHAR(30) NOT NULL CONSTRAINT ck_userLastName CHECK (userLastName LIKE '[A-Z]%'),
	homeAdress			VARCHAR(30) NOT NULL,
	email				VARCHAR(30) NOT NULL,
	deliveryAdress		VARCHAR(30),
	phoneNumber			INT,
	bankAccountNumber	VARCHAR(26) CONSTRAINT ck_nr_konta CHECK (bankAccountNumber LIKE '[0-9]%'),
	CONSTRAINT ck_bankAccountNumber CHECK (len(bankAccountNumber)=26),
);

CREATE TABLE Items
(
    itemNumber			INT NOT NULL PRIMARY KEY,
    owner				VARCHAR(20) NOT NULL REFERENCES Users(userLogin),
    itemName			VARCHAR(20) NOT NULL,
    category			VARCHAR(20) NOT NULL,
    startingPrice		MONEY NOT NULL,
    itemDescription		VARCHAR(30),
    purchasePrice		MONEY
);

CREATE TABLE DeliveryOptions
(
    deliveryID			INT NOT NULL PRIMARY KEY,
    type				VARCHAR(20) NOT NULL UNIQUE,
    company				VARCHAR(20) NOT NULL UNIQUE,
    price				MONEY NOT NULL
);

CREATE TABLE ItemsDeliveries
(
    itemNumber			INT NOT NULL REFERENCES Items(itemNumber),
    deliveryID			INT NOT NULL REFERENCES DeliveryOptions(deliveryID),
    PRIMARY KEY (itemNumber, deliveryID)
);

CREATE TABLE Auctions
(
    auctionID			INT NOT NULL PRIMARY KEY,
    itemNumber			INT NOT NULL REFERENCES Items(itemNumber),
    startDate			DATE NOT NULL,
	endDate				DATE,
	status				VARCHAR(20) NOT NULL CONSTRAINT ck_status CHECK (status IN ('not finished', 'purchased', 'not purchased')),
	winner				VARCHAR(20) REFERENCES Users(userLogin)
);

CREATE TABLE SubmittedOffers
(
	offerID				INT NOT NULL PRIMARY KEY,
    userLogin			VARCHAR(20) NOT NULL REFERENCES Users(userLogin),
    auctionID			INT NOT NULL REFERENCES Auctions(auctionID),
	date				DATE NOT NULL,
	hour				TIME(0) NOT NULL,
	amount				MONEY NOT NULL,
);

GO

---------- INSERT --------

INSERT INTO Users VALUES
('happy', 'Andrew', 'Happy', 'Grove Street', 'happy@gmail.com', 'Grove Street', 123456789, 10000000000000000000000000),
('adam17', 'Adam', 'Smith', 'Times Square', 'adam123@gmail.com', 'Times Square', NULL, 20000000000000000000000000),
('monn33', 'Monn', 'Jones', 'Broadway', 'monn331@gmail.com', 'Broadway', 987654321, NULL);

INSERT INTO Items VALUES
(1, 'happy', 'keyboard', 'PC accessories', 150, 'in good condition', NULL),
(2, 'adam17', 'monitor', 'PC accessories', 1200, NULL, 1200),
(3, 'monn33', 'kitchen knife', 'kitchen', 12, NULL, NULL);

INSERT INTO DeliveryOptions VALUES
(1, 'Courier DHL', 'DHL', 15.99),
(2, 'Courier DPD', 'DPD', 15.99),
(3, 'Parcel locker', 'INPOST', 8.99);

INSERT INTO ItemsDeliveries VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 1);

INSERT INTO Auctions VALUES
(1, 1, '31-05-2021', NULL, 'not finished', NULL),
(2, 2, '31-05-2021', '11-06-2021', 'purchased', 'happy'),
(3, 3, '31-05-2021', '12-06-2021', 'not purchased', NULL);

INSERT INTO SubmittedOffers VALUES
(1, 'happy', 2, '11-06-2021', '8:00:00', 1200),
(2, 'adam17', 1, '15-06-2021', '11:43:00', 900),
(3, 'monn33', 2, '10-06-2021', '9:31:00', 700);

------------ SELECT --------

SELECT * FROM Users;
SELECT * FROM Items;
SELECT * FROM DeliveryOptions;
SELECT * FROM ItemsDeliveries;
SELECT * FROM Auctions;
SELECT * FROM SubmittedOffers;