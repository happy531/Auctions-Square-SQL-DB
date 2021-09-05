use master
use AuctionsSquare

CREATE OR ALTER PROCEDURE addUser
	@userLogin			VARCHAR(20),
	@userName			VARCHAR(20),
    @userLastName		VARCHAR(30),
	@homeAdress			VARCHAR(30),
	@email				VARCHAR(30),
	@deliveryAdress		VARCHAR(30)=NULL,
	@phoneNumber		INT=NULL,
	@bankAccountNumber	VARCHAR(26)=NULL
AS
BEGIN
	INSERT INTO Users(userLogin, userName, userLastName, homeAdress, email, deliveryAdress, phoneNumber, bankAccountNumber)
	VALUES
		(@userLogin, @userName, @userLastName, @homeAdress, @email, @deliveryAdress, @phoneNumber, @bankAccountNumber);
END