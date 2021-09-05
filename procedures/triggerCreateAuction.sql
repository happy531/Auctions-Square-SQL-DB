use master
use AuctionsSquare

CREATE OR ALTER TRIGGER triggerCreateAuction
ON Items
AFTER INSERT
AS
	DECLARE @auctionID AS INT 
	SET @auctionID = (select max(auctionID) from Auctions) + 1
	DECLARE @itemNumber AS INT 
	SET @itemNumber = (select max(itemNumber) from Items)
	INSERT INTO Auctions VALUES
	(@auctionID, @itemNumber, GETDATE(), NULL, 'not finished', NULL)