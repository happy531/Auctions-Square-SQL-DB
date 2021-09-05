use master
use AuctionsSquare

CREATE OR ALTER PROCEDURE createOffer	   
    @userLogin			VARCHAR(20),
	@auctionID			INT,
    @amount				MONEY,
	@date				DATE = NULL,
	@hour				TIME = NULL,
	@offerID			INT=NULL
AS
BEGIN
	IF (@userLogin LIKE (SELECT owner FROM Items WHERE itemNumber = @auctionID)) 
	BEGIN 
		RAISERROR('You cannot bid on your item',1,1) with log
	END 

	ELSE IF ((SELECT purchasePrice FROM Items WHERE itemNumber = @auctionID) IS NOT NULL) 
	BEGIN
		RAISERROR('You cannot bid on a sold item',1,1)
	END

	ELSE IF (@amount < (SELECT startingPrice FROM Items WHERE itemNumber = @auctionID))
	BEGIN
		RAISERROR('your bid must be higher than the starting price',1,1) with log
	END

	ELSE IF (@amount <= (select MAX(amount) FROM SubmittedOffers WHERE auctionID = @auctionID))
	BEGIN
		RAISERROR('Your bid must be higher than the last bid',1,1) with log
	END

	ELSE
	BEGIN
		SET @offerID =
		(
		SELECT COUNT(*) FROM SubmittedOffers
		)
		SET @date = GETDATE()
		SET @hour = CONVERT(TIME, GETDATE())
		INSERT INTO SubmittedOffers(offerID, userLogin, auctionID, date, hour, amount)
		VALUES
			(@offerID+1, @userLogin, @auctionID, @date, @hour, @amount);
		END
END