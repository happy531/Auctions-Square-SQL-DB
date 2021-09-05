use master
use AuctionsSquare

CREATE OR ALTER PROCEDURE addItem	
    @owner				VARCHAR(20),
    @itemName			VARCHAR(20),
    @category			VARCHAR(20),
    @startingPrice		MONEY,
    @itemDescription	VARCHAR(30)=NULL,
    @purchasePrice		MONEY=NULL,
	@itemNumber			INT=NULL
AS
BEGIN
	SET @itemNumber =
	(
    SELECT MAX(itemNumber) FROM Items
	)
	INSERT INTO Items(itemNumber, owner, itemName, category, startingPrice, itemDescription, purchasePrice)
	VALUES
		(@itemNumber+1, @owner, @itemName, @category, @startingPrice, @itemDescription, @purchasePrice);
END