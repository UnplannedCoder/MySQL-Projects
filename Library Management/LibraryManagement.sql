CREATE DATABASE LibraryManagement;
USE LibraryManagement;

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(100) NOT NULL,
    author_name VARCHAR(100),
    category VARCHAR(50),
    available_copies INT
);
DESC books;

INSERT INTO books
(book_name, author_name, category, available_copies)
VALUES
('Database System Concepts', 'Korth', 'DBMS', 5),
('Operating System', 'Galvin', 'OS', 4),
('Computer Networks', 'Tanenbaum', 'Networking', 6),
('Data Structures in C', 'Schaum', 'Programming', 3),
('Java Complete Reference', 'Herbert Schildt', 'Java', 7),
('Python Crash Course', 'Eric Matthes', 'Python', 5),
('Software Engineering', 'Pressman', 'SE', 4),
('Web Development Basics', 'Jon Duckett', 'Web', 6);

CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    member_gender ENUM('M', 'F', 'Other'),
    member_contact VARCHAR(15),
    member_email VARCHAR(100)
);
DESC members;

INSERT INTO members (member_name, member_gender, member_contact, member_email)
VALUES
('Rahul Sharma', 'M', '9876543210', 'rahul@gmail.com'),
('Priya Verma', 'F', '9876543211', 'priya@gmail.com'),
('Amit Singh', 'M', '9876543212', 'amit@gmail.com'),
('Neha Gupta', 'F', '9876543213', 'neha@gmail.com'),
('Karan Mehta', 'M', '9876543214', 'karan@gmail.com'),
('Sneha Jain', 'F', '9876543215', 'sneha@gmail.com'),
('Rohit Yadav', 'M', '9876543216', 'rohit@gmail.com'),
('Anjali Sharma', 'F', '9876543217', 'anjali@gmail.com');

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    due_date DATE,
    status ENUM('Issued', 'Returned'),
    FOREIGN KEY(member_id) REFERENCES members(member_id),
    FOREIGN KEY(book_id) REFERENCES books(book_id)
);
DESC transactions;

INSERT INTO transactions (member_id, book_id, issue_date, return_date, due_date, status)
VALUES
(1,1,'2026-05-01',NULL,'2026-05-10','Issued'),
(2,2,'2026-05-02','2026-05-08','2026-05-12','Returned'),
(3,3,'2026-05-03',NULL,'2026-05-13','Issued'),
(4,4,'2026-05-04','2026-05-09','2026-05-14','Returned'),
(5,5,'2026-05-05',NULL,'2026-05-15','Issued'),
(6,6,'2026-05-06',NULL,'2026-05-16','Issued'),
(7,7,'2026-05-07','2026-05-11','2026-05-17','Returned'),
(8,8,'2026-05-08',NULL,'2026-05-18','Issued');

SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM transactions;

-- Find Available Books
SELECT * FROM books WHERE available_copies > 4;
-- Find Male Members
SELECT * FROM members WHERE member_gender = "M";
-- Find Female Members
SELECT * FROM members WHERE member_gender = "F";

-- Member Name + Book Issued
SELECT books.book_name, members.member_name, transactions.issue_date 
FROM transactions 
JOIN members
ON transactions.member_id = members.member_id
JOIN books 
ON transactions.book_id = books.book_id;

-- Currently Issued Books
SELECT books.book_name, members.member_name, transactions.issue_date 
FROM transactions 
JOIN members
ON transactions.member_id = members.member_id
JOIN books 
ON transactions.book_id = books.book_id
WHERE transactions.status = 'Issued';

-- Returned Books 
SELECT members.member_name, books.book_name, transactions.return_date
FROM transactions
JOIN members
ON transactions.member_id = members.member_id
JOIN books
ON transactions.book_id = books.book_id
WHERE transactions.status = 'Returned';

-- Find overdue books 
SELECT books.book_name, members.member_name, transactions.due_date
FROM transactions 
JOIN books 
ON transactions.book_id = books.book_id
JOIN members
ON transactions.member_id = members.member_id
WHERE due_date < CURDATE() AND status = 'Issued';

-- Days Remaining to Return Book
SELECT members.member_name, books.book_name, DATEDIFF(due_date, CURDATE())
FROM transactions
JOIN books 
ON transactions.book_id = books.book_id
JOIN members
ON transactions.member_id = members.member_id
WHERE status = 'Issued';

-- Total Books
SELECT COUNT(*) AS total_books 
FROM books;

-- Total Members
SELECT COUNT(*) AS total_members 
FROM members;

-- Total Issued Books
SELECT COUNT(*) AS issued_books
FROM transactions
WHERE status = 'Issued';

-- Total Returned Books
SELECT COUNT(*) AS returned_books
FROM transactions
WHERE status = 'Returned';

-- Books Category Wise Count
SELECT category , COUNT(*)
FROM books 
GROUP BY category;

-- Most issued books 
SELECT books.book_name, COUNT(transactions.book_id) AS total_issued
FROM transactions
JOIN books
ON transactions.book_id = books.book_id
GROUP BY books.book_name
ORDER BY total_issued DESC;

-- Latest Issued Books
SELECT books.book_name, transactions.issue_date
FROM transactions
JOIN books
ON transactions.book_id = books.book_id
ORDER BY issue_date DESC;

-- Create Library Report View
CREATE VIEW library_report AS
SELECT members.member_name, books.book_name, transactions.issue_date, transactions.return_date, transactions.status
FROM transactions
JOIN members
ON transactions.member_id = members.member_id
JOIN books
ON transactions.book_id = books.book_id;
SELECT * FROM library_report;

-- Get Books Issued by Member
DELIMITER $$
CREATE PROCEDURE GetMemberBooks(IN mid INT)
BEGIN
    SELECT
        members.member_name,
        books.book_name,
        transactions.issue_date,
        transactions.status
    FROM transactions
    JOIN members
    ON transactions.member_id = members.member_id
    JOIN books
    ON transactions.book_id = books.book_id
    WHERE members.member_id = mid;
END $$
DELIMITER ;
CALL GetMemberBooks(1);

-- Prevent Negative Copies
DELIMITER $$
CREATE TRIGGER check_book_copies
BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF NEW.available_copies < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Available copies cannot be negative';
    END IF;
END $$
DELIMITER ;

-- Members Who Did Not Return Books
SELECT
    members.member_name,
    books.book_name
FROM transactions
JOIN members
ON transactions.member_id = members.member_id
JOIN books
ON transactions.book_id = books.book_id
WHERE transactions.status = 'Issued';

-- Fine Calculation (₹10 per late day)
SELECT
    members.member_name,
    books.book_name,
    DATEDIFF(CURDATE(), due_date) * 10 AS fine
FROM transactions
JOIN members
ON transactions.member_id = members.member_id
JOIN books
ON transactions.book_id = books.book_id
WHERE due_date < CURDATE()
AND status = 'Issued';











