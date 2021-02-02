
DROP TABLE Borrower
DROP TABLE Student
DROP TABLE Staff
DROP TABLE Resource
DROP TABLE Loan 
DROP TABLE Movable
DROP TABLE Immovable
DROP TABLE Reservation
DROP TABLE Acquisition


-- SCS DATABASE SCRIPT

CREATE TABLE Borrower(
borrowerId          CHAR(6) NOT NULL,
firstName           VARCHAR(100),
lastName            VARCHAR(100),
telNo               VARCHAR(10),
email               VARCHAR(100),
PRIMARY KEY(borrowerId));


CREATE TABLE Student(
borrowerId          CHAR(6) NOT NULL,
courseEnrolment     CHAR(8),
maxLoanItems        INT,
FOREIGN KEY(borrowerId) REFERENCES Borrower ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE Staff(
borrowerId          CHAR(6) NOT NULL,
FOREIGN KEY(borrowerId) REFERENCES Borrower ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE Resource(
resourceId          CHAR(6) NOT NULL,
resourceName        VARCHAR(100),
category            VARCHAR(100),
PRIMARY KEY(resourceId));


CREATE TABLE Loan(
loanId              CHAR(6) NOT NULL,
borrowerId          CHAR(6) NOT NULL,
resourceId          CHAR(6) NOT NULL,
loanDate            DATE DEFAULT GETDATE(),
PRIMARY KEY(loanId),
FOREIGN KEY(borrowerId) REFERENCES Borrower ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(resourceId) REFERENCES Resource ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE Movable(
resourceId          CHAR(6) NOT NULL,
modelNo             CHAR(8),
year                CHAR(4),
manufacturer        VARCHAR(100),
FOREIGN KEY(resourceId) REFERENCES Resource ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE Immovable(
resourceId          CHAR(6) NOT NULL,
FOREIGN KEY(resourceId) REFERENCES Resource ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE Reservation(
reservationId       CHAR(6) NOT NULL,
borrowerId          CHAR(6) NOT NULL,
resourceId          CHAR(6) NOT NULL,
submissionDate      DATE DEFAULT GETDATE(),
reservationDate     DATE NOT NULL,
PRIMARY KEY(reservationId),
FOREIGN KEY(borrowerId) REFERENCES Borrower ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(resourceId) REFERENCES Resource ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE Acquisition(
acquisitionId       CHAR(6) NOT NULL,
borrowerId          CHAR(6) NOT NULL,
resourceId          CHAR(6) NOT NULL,
suggestionDate      DATE DEFAULT GETDATE(),
PRIMARY KEY(acquisitionId),
FOREIGN KEY(borrowerId) REFERENCES Borrower ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(resourceId) REFERENCES Resource ON UPDATE CASCADE ON DELETE CASCADE);


-- LOADING SAMPLE DATA

INSERT INTO Borrower VALUES ('STU001', 'John', 'Smith', '0412341245', 'STU001@scs.edu.au');
INSERT INTO Borrower VALUES ('STU002', 'Abby', 'Anderson', NULL, 'STU002@scs.edu.au');
INSERT INTO Borrower VALUES ('STU003', 'Bob', 'Butcher', '0412341223', 'STU003@scs.edu.au');
INSERT INTO Borrower VALUES ('STA001', 'Alan', 'Andrews', '0458341245', 'STA001@scs.edu.au');
INSERT INTO Borrower VALUES ('STA002', 'Beth', 'Bilson', NULL, 'STA002@scs.edu.au');
INSERT INTO Borrower VALUES ('STA003', 'Cameron', 'Cooper', '0437341238', 'STA003@scs.edu.au');


INSERT INTO Student VALUES ('STU001', 'COMP6140', 6);
INSERT INTO Student VALUES ('STU001', 'INFT6020', 6);
INSERT INTO Student VALUES ('STU001', 'COMP6300', 6);
INSERT INTO Student VALUES ('STU002', 'COMP6140', 6);
INSERT INTO Student VALUES ('STU002', 'COMP6300', 6);
INSERT INTO Student VALUES ('STU002', 'SENG6010', 6);
INSERT INTO Student VALUES ('STU003', 'COMP6140', 6);
INSERT INTO Student VALUES ('STU003', 'INFT6020', 6);



INSERT INTO Staff VALUES ('STA001');
INSERT INTO Staff VALUES ('STA002');
INSERT INTO Staff VALUES ('STA003');


INSERT INTO Resource VALUES ('RES001', 'Laptop', 'Laptop');
INSERT INTO Resource VALUES ('RES002', 'Room101', 'Room101');
INSERT INTO Resource VALUES ('RES003', 'Camera', 'Camera');
INSERT INTO Resource VALUES ('RES004', 'Speaker', 'Speaker');
INSERT INTO Resource VALUES ('RES005', 'Camera', 'Camera');
INSERT INTO Resource VALUES ('RES006', 'Camera', 'Camera');
INSERT INTO Resource VALUES ('RES007', 'Laptop', 'Laptop');
INSERT INTO Resource VALUES ('RES008', 'Speaker', 'Speaker');
INSERT INTO Resource VALUES ('RES009', 'Room201', 'Room201');
INSERT INTO Resource VALUES ('RES010', 'Room301', 'Room301');
INSERT INTO Resource VALUES ('RES011', 'Room401', 'Room401');
INSERT INTO Resource VALUES ('RES012', 'Macbook', 'Macbook');
INSERT INTO Resource VALUES ('RES013', 'Camera', 'Camera'); 
INSERT INTO Resource VALUES ('RES014', 'Macbook', 'Macbook'); 
INSERT INTO Resource VALUES ('RES015', 'Speaker', 'Speaker');



INSERT INTO Loan VALUES ('LOA001', 'STU001', 'RES001', '2020-11-1');
INSERT INTO Loan VALUES ('LOA002', 'STA001', 'RES003', '2020-11-1');
INSERT INTO Loan VALUES ('LOA003', 'STU001', 'RES004', '2020-11-1');
INSERT INTO Loan VALUES ('LOA004', 'STA001', 'RES005', '2020-11-1');
INSERT INTO Loan VALUES ('LOA005', 'STU002', 'RES006', '2020-11-1');
INSERT INTO Loan VALUES ('LOA006', 'STU003', 'RES006', '2020-11-1');
INSERT INTO Loan VALUES ('LOA007', 'STA002', 'RES005', '2020-11-1'); 
INSERT INTO Loan VALUES ('LOA008', 'STU002', 'RES006', '2020-11-1'); 
INSERT INTO Loan VALUES ('LOA009', 'STU003', 'RES001', '2020-11-1'); 
INSERT INTO Loan VALUES ('LOA010', 'STU003', 'RES004', DEFAULT); 



INSERT INTO Movable Values('RES001', '18.1', '2018', 'ASUS');
INSERT INTO Movable Values('RES003', '20.1', '2020', 'Canon'); 
INSERT INTO Movable Values('RES004', '18.2', '2018', 'Sony');
INSERT INTO Movable Values('RES005', '20.1', '2020', 'Canon'); 
INSERT INTO Movable Values('RES006', '20.1', '2020', 'Canon'); 
INSERT INTO Movable Values('RES007', '19.1', '2019', 'Asus');
INSERT INTO Movable Values('RES008', '18.2', '2018', 'Sony');


INSERT INTO Immovable Values('RES002');
INSERT INTO Immovable Values('RES009');
INSERT INTO Immovable Values('RES010');
INSERT INTO Immovable Values('RES011');


INSERT INTO Reservation VALUES ('RSV001', 'STA001', 'RES002', '2019-4-20', '2019-5-1');
INSERT INTO Reservation VALUES ('RSV002', 'STA001', 'RES009', '2019-4-20', '2019-5-1');
INSERT INTO Reservation VALUES ('RSV003', 'STU002', 'RES011', '2019-4-20', '2019-5-1');
INSERT INTO Reservation VALUES ('RSV004', 'STA001', 'RES009', '2019-4-20', '2019-5-1');
INSERT INTO Reservation VALUES ('RSV005', 'STA001', 'RES002', '2020-4-20', '2020-5-1');
INSERT INTO Reservation VALUES ('RSV006', 'STU001', 'RES002', '2020-4-20', '2020-5-1');
INSERT INTO Reservation VALUES ('RSV007', 'STU003', 'RES009', '2020-5-10', '2020-6-5'); 
INSERT INTO Reservation VALUES ('RSV008', 'STA001', 'RES009', NULL, '2020-6-5');
INSERT INTO Reservation VALUES ('RSV009', 'STU002', 'RES010', '2020-5-10', '2020-6-5');
INSERT INTO Reservation VALUES ('RSV010', 'STU003', 'RES009', '2020-5-10', '2020-6-20');
INSERT INTO Reservation VALUES ('RSV011', 'STU001', 'RES011', '2020-5-10', '2020-7-15');
INSERT INTO Reservation VALUES ('RSV012', 'STA002', 'RES009', '2020-5-10', '2020-8-25');
INSERT INTO Reservation VALUES ('RSV013', 'STA001', 'RES002', '2020-5-10', '2020-9-19');
INSERT INTO Reservation VALUES ('RSV014', 'STA002', 'RES011', '2020-5-10', '2020-9-19');
INSERT INTO Reservation VALUES ('RSV015', 'STA002', 'RES009', '2020-5-10', '2020-9-19');
INSERT INTO Reservation VALUES ('RSV016', 'STA002', 'RES009', '2020-5-10', '2020-9-19');
INSERT INTO Reservation VALUES ('RSV017', 'STA003', 'RES002', '2020-5-10', '2020-9-19');
INSERT INTO Reservation VALUES ('RSV018', 'STA003', 'RES009', DEFAULT, '2020-10-21');
INSERT INTO Reservation VALUES ('RSV019', 'STA003', 'RES011', DEFAULT, '2020-11-22');



INSERT INTO Acquisition VALUES ('ACQ001', 'STA001', 'RES012', '2019-10-9');
INSERT INTO Acquisition VALUES ('ACQ002', 'STA001', 'RES013', '2019-11-20'); 
INSERT INTO Acquisition VALUES ('ACQ003', 'STU002', 'RES014', '2020-3-15');
INSERT INTO Acquisition VALUES ('ACQ004', 'STA001', 'RES015', '2020-4-9');


