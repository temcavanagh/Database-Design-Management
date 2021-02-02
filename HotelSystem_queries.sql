
-- COMP6140 Module 6 ##############################################################

-- HotelSystem.sql

-- i - List details of hotels

SELECT * FROM Hotel;

-- ii - List details of Newcastle hotels
SELECT * FROM Hotel
Where city='Newcastle';

-- iii - List names and addresses of guests living at 'Street', alphabetically by name

SELECT * FROM Guest
WHERE guestaddress LIKE '%Street%'                 -- searches for word 'street'
ORDER BY guestname DESC;

-- iv. List all double or family rooms with a price above $80 per night, in ascending order of price

SELECT * FROM Room 
WHERE type='typeD'
OR type='typeF'
AND price >= 80
ORDER by price ASC;

-- v. List the bookings for which no dateTo has been specified

SELECT * FROM Booking 
WHERE dateTo IS NULL;

-- vi. How many hotels are there?

SELECT COUNT(hotelname) FROM Hotel;

-- vii. What is the average price per room?

SELECT AVG(price) FROM Room;

-- viii. What is the total revenue per night from all double rooms?

SELECT SUM(price) FROM Room
WHERE type='typeD';

-- ix. How many different guests have made bookings for room number RoomNo1?

SELECT COUNT (DISTINCT guestno) FROM Booking 
WHERE roomno='RoomNo1';

-- x. List the number of rooms in each hotel

SELECT hotelNo, COUNT(roomNo) AS count
FROM room
GROUP BY hotelNo;


--   Module 7 #########################################################################
-- HotelSystem.sql Part II

-- i. List the price and type of all rooms at the Grosvenor Hotel

SELECT price, type
FROM room	
WHERE hotelNo =
    (SELECT hotelNo	
    FROM hotel	
    WHERE hotelname	= 'Grosvenor')
;

--ii. List all guests currently staying at the Grosvenor Hotel.

SELECT * FROM guest	
WHERE guestNo =
    (SELECT guestNo	FROM booking
    WHERE dateFrom	<= (select
        convert(datetime2,SYSDATETIME())) AND
        dateTo >= (select
            convert(datetime2,SYSDATETIME())) AND
            hotelNo	=
            (SELECT hotelNo FROM hotel
            WHERE hotelname	= 'Grosvenor'))
;

--iii. What is the total income from bookings for the Grosvenor Hotel today?

SELECT SUM(price)
FROM booking b, room r, hotel h
WHERE (b.dateFrom <= (select convert(datetime2,SYSDATETIME()))AND
        b.dateTo >= (select convert(datetime2,SYSDATETIME())) AND
        r.hotelNo = h.hotelNo and r.roomNo = b.roomNo and b.hotelNo	= r.hotelNo and h.Hotelname = 'Grosvenor')
;

--iv. List the number of rooms in each hotel with more than 1 room and located in Newcastle.

SELECT h.hotelNo, COUNT(roomNo) AS count 
FROM room r, hotel h
WHERE r.hotelNo = h.hotelNo AND 
h.hotelNo IN (SELECT hotelNo
    FROM hotel
    WHERE city = 'Newcastle')
GROUP BY h.hotelNo 
HAVING COUNT(roomNo) > 1 ;

--v. What is the most commonly booked room type for every hotel with booking? Print the hotelNo, type and the number of the booked room.

Select r.hotelNo,type, count(*)
from booking b, room r
where r.roomNo = b.roomNo And r.hotelNo= b.hotelNo Group by r.hotelNo, type
--Having count(r.roomNo) >= 2
Having count(r.roomNo) >= all (select count (*)
from booking b2, room r2
where r2.roomNo = b2.roomNo And r2.hotelNo= b2.hotelNo And r.hotelNo=r2.hotelNo --to match a fixed hotelNo in r
Group by r2.hotelNo, type) ;




-- Module 6 #########################################################################

-- RegSystem.sql

-- i. How many course registrations are there in the database?

SELECT COUNT(courseID) FROM Register;  

-- A: 4


-- ii. List the student number of all students who have completed a course. 
--     A student who has not completed a course has a NULL value for the grade column.

SELECT DISTINCT stdNo FROM Register
    WHERE grade IS NOT NULL
;

-- iii. How many students have scored a B+ or above for INFT2040? 

SELECT COUNT(stdNo) 
FROM Register
WHERE courseID = 'INFT2040'
AND (grade = 'B+' or grade = 'A-' or grade = 'A')
;

-- A: 1


-- iv. Print the number of students in each program

SELECT programCode, COUNT(stdNo) FROM Student
    GROUP BY programCode
;


-- v. List the student numbers and number of courses completed by students. Do not print the student number of students who have not completed any course.

SELECT COUNT(courseID), courseID FROM Register
    WHERE mark IS NOT NULL
    GROUP BY courseID
;


-- vi. For students who have completed courses, print the student number and total number of distinct courses completed

SELECT stdNo, COUNT(stdNo) FROM Register
    WHERE mark IS NOT NULL
    GROUP BY stdNo
;


-- vii. For all programs with more than 0 students in them, print the program code and number of students

SELECT programCode, COUNT(*)
FROM Student
GROUP BY programCode
;

-- viii. For all students who have completed more than or equal to two courses, print the student number and average marks scored for the courses

SELECT stdNo, AVG(mark)
FROM Register
WHERE grade	IS NOT NULL
GROUP BY stdNo
HAVING COUNT(*) >= 2;


-- Module 7 #########################################################################

-- RegSystem.sql Part II

-- i. Find the student number of students who have registered to the same courses as “Robert Kent”.

SELECT DISTINCT s1.stdNo
FROM Student s1, Register r1 
WHERE s1.stdNo = r1.stdNo 
AND r1.courseID IN
	(SELECT r.courseID
	FROM Student s, Register r
	WHERE s.givenNames = 'Robert' 
 	AND s.lastname = 'Kent'
	AND s.stdNo = r.stdNo)
;

-- ii. For semesters with 2 or more students registered, find the total number of students registered in them. 
--     Print the semester, year and total number of registered students.

SELECT s.semester, s.year, COUNT(stdNo) as NumStudents
FROM Semester s, Register r
WHERE s.semesterID = r.semesterID
GROUP BY s.semester, s.year
HAVING COUNT(*) >= 2
;

-- iii. Print the number of students registered to each course. Note that some courses may have no students. 
--      Print the course id, course name and number of students registered.

SELECT c.courseID, c.cName, COUNT(stdNo) as NumStudents
FROM Course c LEFT JOIN Register r 
ON (c.courseID = r.courseID)
GROUP BY c.courseID, c.cName
;

-- iv. Find the most popular course(s). The most popular course contains the highest number of students registered to it. Print the course id and course name.

SELECT c.courseID, c.cName
FROM Course c, Register r 
WHERE c.courseID = r.courseID
GROUP BY c.courseID, c.cName
HAVING COUNT(*) >= ALL
    (SELECT COUNT(*)
    FROM Course c, Register r
    WHERE c.courseID = r.courseID
    GROUP BY c.courseID)
;

-- v. Find the most unpopular course. Print the course id and course name.

SELECT c.courseID, c.cName
FROM Course c LEFT JOIN Register r 
ON c.courseID = r.courseID
GROUP BY c.courseID, c.cName
HAVING COUNT(r.stdNo) <= ALL
    (SELECT COUNT(r.stdNo)
    FROM Course c LEFT JOIN Register r
    ON c.courseID = r.courseID
    GROUP BY c.courseID)
;

-- vi. Find the student number of students who have done a course with student “Robert Kent” in semester 2, 2014. 

SELECT DISTINCT r1.stdNo
FROM Register r1 
WHERE EXISTS (
    SELECT *
    FROM Student s1, Register r2, Semester s2
    WHERE s1.stdNo = r2.stdNo                   -- Join student & register relations
    AND s2.semesterID = r2.semesterID           -- Join semester & register relations
    AND s2.semester = 2                         -- Specify semester
    AND s2.year = 2014                          -- Specify year
    AND s1.givenNames = 'Robert'                -- Specify enrolments of Robert Kent
    AND s1.lastname = 'Kent'                    -- Specify enrolments of Robert Kent
    AND s1.stdNo <> r1.stdNo                    -- Specify students who are not Robert Kent
    AND r1.semesterID = r2.semesterID           -- Specify same semester as Robert Kent
    AND r1.courseID = r2.courseID               -- Specifiy same course as Robert Kent
) 
;

'Print the total number of customers having accounts in branch 1. Note that a customer can have many accounts in a single branch. (1 mark)
Print branch numbers (i.e. branchNo) of all branches with a loan liability of over 1500000. Loan liability is calculated as the total loan amount lent by the branch to its customers (i.e. total amount of all loans given by the branch). (2 marks)
Print the names of all customers who have an account in branch Newcastle. Note, one customer may have several accounts in a branch. (2 marks)
List loanNo, and the name(s) of the customer(s) who has(have) loan(s) currently. (2 marks)
List the total number of accounts and the total number of loans of each branch (including the branch with zero counts) along with the branchNo and the branchName in ascending order of the branch number. (3 marks)'