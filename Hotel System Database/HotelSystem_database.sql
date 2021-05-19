 

drop table Booking 
drop table Room 
drop table Guest
drop table Hotel  


CREATE TABLE Hotel (
hotelNo		CHAR(10)		PRIMARY KEY,
hotelName	CHAR(10),
city		VARCHAR(25),
)
go

CREATE TABLE Room (
roomNo		CHAR(8),
hotelNo		CHAR(10),
type		CHAR(10),		
price		DECIMAL(5,2),
PRIMARY KEY (roomNo, hotelNo),
FOREIGN KEY(hotelNo) REFERENCES Hotel(hotelNo) ON UPDATE CASCADE ON DELETE CASCADE ,
)
go

CREATE TABLE Guest (
guestNo  	CHAR(10)		PRIMARY KEY,
guestName  	CHAR(10), 
guestAddress	CHAR(10),
)

CREATE TABLE Booking (

hotelNo		CHAR(10),
guestNo		CHAR(10),
roomNo		CHAR(8),
dateFrom	DATE, 
dateTo		DATE,

PRIMARY KEY (hotelNo, guestNo, dateFrom),
FOREIGN KEY(hotelNo) REFERENCES Hotel(hotelNo) ON UPDATE CASCADE ON DELETE CASCADE ,
FOREIGN KEY(guestNo) REFERENCES Guest(guestNo) ON UPDATE CASCADE ON DELETE CASCADE ,
FOREIGN KEY(roomNo,hotelNo) REFERENCES Room(roomNo,hotelNo) ON UPDATE NO ACTION ON DELETE NO ACTION,
)
go



--INSERT INTO  VALUES ('', '', '', '', );

INSERT INTO  Hotel VALUES ('HotelNo1', 'Grosvenor', 'Newcastle' );
INSERT INTO  Hotel VALUES ('HotelNo2', 'HotelName2', 'Newcastle' );
INSERT INTO  Hotel VALUES ('HotelNo3', 'HotelName3', 'London');
INSERT INTO  Hotel VALUES ('HotelNo4', 'HotelName4', 'London');


INSERT INTO  Room VALUES ('RoomNo1', 'HotelNo1', 'typeS',120);
INSERT INTO  Room VALUES ('RoomNo2', 'HotelNo1', 'typeF',210);
INSERT INTO  Room VALUES ('RoomNo2', 'HotelNo2', 'typeS',110);
INSERT INTO  Room VALUES ('RoomNo2', 'HotelNo3', 'typeD',180);
INSERT INTO  Room VALUES ('RoomNo2', 'HotelNo4', 'typeF',220);
INSERT INTO  Room VALUES ('RoomNo1', 'HotelNo3', 'typeF',320);

INSERT INTO  Guest VALUES ('guestNo1', 'guestName1', '1 Street');
INSERT INTO  Guest VALUES ('guestNo2', 'guestName2', '2 Street');
INSERT INTO  Guest VALUES ('guestNo3', 'guestName3', '3 Street');

INSERT INTO  Booking VALUES ('HotelNo1', 'guestNo1', 'RoomNo1','1/3/2019','3/7/2019');
INSERT INTO  Booking VALUES ('HotelNo1', 'guestNo3','RoomNo1', '9/9/2019','9/30/2019');
INSERT INTO  Booking VALUES ('HotelNo3', 'guestNo2','RoomNo1', '1/4/2019',NULL);

