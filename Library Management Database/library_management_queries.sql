-- COMP6140 Assignment 3 - Part II - 2.2.2


-- Q1. 
SELECT b.firstname, b.lastname, b.telNo, 
COUNT(DISTINCT r.reservationId) AS Reservations, 
COUNT(DISTINCT a.acquisitionid) AS Acquisitions
FROM Staff s, Borrower b, Acquisition a, Reservation r
WHERE s.borrowerId = b.borrowerid
AND a.borrowerId = b.borrowerId
AND r.borrowerId = b.borrowerId
AND s.borrowerId = 'STA001'
AND YEAR(r.reservationDate) = 2019
AND YEAR(a.suggestionDate) = 2019
GROUP BY b.firstname, b.lastname, b.telNo;


-- Q2.
SELECT s.courseEnrolment, b.firstName, b.lastname
FROM Student s, Borrower b 
WHERE s.borrowerId = b.borrowerId
AND s.courseEnrolment = 'COMP6140';


-- Q3.
SELECT DISTINCT b.firstName, b.lastName, r.category, m.manufacturer, m.modelNo 
FROM Student s, Borrower b, Loan l, Resource r, Movable m 
WHERE l.borrowerId = b.borrowerId
AND s.borrowerId = b.borrowerId
AND l.resourceId = r.resourceId
AND m.resourceId = r.resourceId
AND r.category = 'Camera'
AND m.modelNo = '20.1';


-- Q4.
SELECT DISTINCT s.courseEnrolment, s.maxLoanItems
FROM Student s, Resource r 
WHERE s.courseEnrolment = 'COMP6140'
AND r.category = 'Speaker';


-- Q5.
SELECT TOP 1 m.resourceId, r.resourceName, COUNT(l.loanId) AS Total
FROM Movable m, Resource r, Loan l 
WHERE m.resourceId = r.resourceId
AND l.resourceId = r.resourceId
AND MONTH(l.loanDate) = 11 AND YEAR(l.loanDate) = 2020
GROUP BY m.resourceId, r.resourceName
ORDER BY Total DESC;


-- Q6.
SELECT res.reservationDate, r.category, COUNT(res.reservationId) AS Reservations
FROM Reservation res, Resource r, Immovable i  
WHERE res.resourceId = r.resourceId 
AND i.resourceId = r.resourceId 
AND (res.reservationDate = '2020-5-1'
     OR res.reservationDate = '2020-6-5'
     OR res.reservationDate = '2020-9-19')
GROUP BY res.reservationDate, r.category;

