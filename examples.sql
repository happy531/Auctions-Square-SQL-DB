use master
use AuctionsSquare

SELECT * 
FROM sys.procedures

SELECT *
from sys.triggers

BEGIN TRAN Examples

--ADDING NEW USER
select * from Users
EXEC addUser 'new_user', 'New', 'User', 'Grove Street', 'newuser@gmail.com'
select * from Users

--ADDING AN ITEM AND CREATING NEW AUCTION
EXEC addItem 'new_user', 'book', 'science', 30
EXEC addItem 'monn33', 'e-book', 'entertainment', 50
select * from Items
select * from Auctions

--CREATING AN OFFER

--for yourself, this will cause an error
EXEC createOffer 'happy', 1, 910

--when your bid is less than starting price
EXEC createOffer 'new_user', 5, 49

--bidding for a sold item
EXEC createOffer 'new_user', 2, 1300

--normal bid, this will not cause an error
select * from Items
EXEC createOffer 'new_user', 5, 55
EXEC createOffer 'new_user', 5, 60
select * from SubmittedOffers

--ENDING AN AUCTION

--ending auction which is already ended
EXEC endAuction 2

--ending auction with purchase
EXEC endAuction 5
select * from Auctions
select * from Items
select * from SubmittedOffers

--ending auction without purchase
EXEC endAuction 4
select * from Auctions
select * from Items
select * from SubmittedOffers

ROLLBACK Examples;
