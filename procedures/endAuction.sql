use master
use AuctionsSquare

CREATE OR ALTER PROCEDURE endAuction
	@itemNumber				INT,
	@endDate	DATE=NULL,
	@status				VARCHAR(20)=NULL,
	@winner			VARCHAR(20)=NULL
AS
BEGIN
	IF((SELECT status FROM Auctions WHERE itemNumber = @itemNumber) != 'not finished')
	BEGIN
		RAISERROR('This auction is already ended', 1, 1)
	END

	ELSE IF (@itemNumber NOT IN (SELECT auctionID FROM SubmittedOffers))
	BEGIN
		SET @endDate = GETDATE()
		SET @status = 'not purchased'
		SET @winner = NULL
		UPDATE Auctions
		SET endDate = @endDate,
		status = @status,
		winner = @winner
		WHERE itemNumber = @itemNumber
	END
	ELSE
	BEGIN
		SET @endDate = GETDATE()
		SET @status = 'purchased'
		SET @winner = (SELECT userLogin FROM SubmittedOffers WHERE auctionID = @itemNumber AND amount = (SELECT MAX(amount) FROM SubmittedOffers WHERE auctionID=@itemNumber))
		UPDATE Auctions
		SET endDate = @endDate,
		status = @status,
		winner = @winner
		WHERE itemNumber = @itemNumber
		UPDATE Items
		SET purchasePrice = (SELECT MAX(amount) FROM SubmittedOffers WHERE auctionID=@itemNumber)
		WHERE itemNumber=@itemNumber
	END
END