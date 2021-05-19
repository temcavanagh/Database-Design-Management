-- COMP6140 SQL Test Semester 2, 2020
-- Bank-2020.sql


-- A.

SELECT COUNT(DISTINCT custNo)
FROM ACCOUNT 
WHERE branchNo = 1
;

-- B. 

SELECT branchNo
FROM LOAN
GROUP BY branchNo
HAVING SUM(amount) > 1500000
    (SELECT COUNT(*)
    FROM LOAN 
    GROUP BY branchNo)
;

-- C.

SELECT c.custName AS Name 
FROM ACCOUNT a, BRANCH b, CUSTOMER c  
WHERE a.branchNo = b.branchNo
AND a.custNo = c.custNo
AND b.branchName LIKE '%Newcastle%'
GROUP BY c.custName 
;

-- D. 

SELECT l.loanNo, c.custName AS Name
FROM CUSTOMER c, LOAN l 
WHERE c.custNo = l.custNo 
AND l.datePaidOff IS NULL
;

-- E.

SELECT b.branchNo, b.branchName, COUNT(DISTINCT a.accNo) AS Accounts, COUNT(DISTINCT l.loanNo) AS Loans
FROM BRANCH b 
LEFT JOIN ACCOUNT a
ON (b.branchNo = a.branchNo)
LEFT JOIN LOAN l 
ON (b.branchNo = l.branchNo)
GROUP BY b.branchNo, b.branchName 
ORDER BY b.branchNo
;