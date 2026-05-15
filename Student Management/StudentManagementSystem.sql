CREATE DATABASE StudentManagement;
USE StudentManagement;

CREATE TABLE students (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    student_gender ENUM("M", "F", "Other"),
    student_contact VARCHAR(15),
    student_email VARCHAR(100)
);
DESC students;

INSERT INTO students 
(student_name, student_gender, student_contact, student_email)
VALUES
('Rahul Sharma', 'M', '9876543210', 'rahul@gmail.com'),
('Priya Verma', 'F', '9876543211', 'priya@gmail.com'),
('Amit Singh', 'M', '9876543212', 'amit@gmail.com'),
('Neha Gupta', 'F', '9876543213', 'neha@gmail.com'),
('Karan Mehta', 'M', '9876543214', 'karan@gmail.com'),
('Sneha Jain', 'F', '9876543215', 'sneha@gmail.com'),
('Rohit Yadav', 'M', '9876543216', 'rohit@gmail.com'),
('Anjali Sharma', 'F', '9876543217', 'anjali@gmail.com'),
('Vikas Kumar', 'M', '9876543218', 'vikas@gmail.com'),
('Pooja Saini', 'F', '9876543219', 'pooja@gmail.com'),
('Arjun Patel', 'M', '9876543220', 'arjun@gmail.com'),
('Kavya Singh', 'F', '9876543221', 'kavya@gmail.com'),
('Mohit Joshi', 'M', '9876543222', 'mohit@gmail.com'),
('Riya Kapoor', 'F', '9876543223', 'riya@gmail.com'),
('Yash Raj', 'M', '9876543224', 'yash@gmail.com'),
('Simran Kaur', 'F', '9876543225', 'simran@gmail.com'),
('Dev Malhotra', 'M', '9876543226', 'dev@gmail.com'),
('Nisha Sharma', 'F', '9876543227', 'nisha@gmail.com'),
('Aditya Roy', 'M', '9876543228', 'aditya@gmail.com'),
('Meera Das', 'F', '9876543229', 'meera@gmail.com');

CREATE TABLE subjects ( 
	subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50)
);
DESC subjects;

INSERT INTO subjects (subject_name)
VALUES
('Database Management System'),
('Operating System'),
('Computer Networks'),
('Data Structures'),
('Java Programming'),
('Python Programming'),
('Software Engineering'),
('Web Development');

CREATE TABLE marks (
	marks_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT, 
    subject_id INT,
    marks INT,
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
);
DESC marks;

INSERT INTO marks (student_id, subject_id, marks)
VALUES

-- DBMS
(1,1,85),
(2,1,78),
(3,1,92),
(4,1,88),

-- Operating System
(1,2,76),
(2,2,81),
(3,2,69),
(4,2,95),

-- Computer Networks
(5,3,73),
(6,3,84),
(7,3,90),
(8,3,67),

-- Data Structures
(9,4,79),
(10,4,91),
(11,4,87),
(12,4,72),

-- Java Programming
(13,5,80),
(14,5,94),

-- Python Programming
(15,6,77),
(16,6,89),

-- Software Engineering
(17,7,83),
(18,7,74),

-- Web Development
(19,8,86),
(20,8,93);

SELECT * FROM students;
SELECT * FROM subjects;
SELECT * FROM marks;

-- Find Male Students
SELECT * FROM students WHERE student_gender = "M";
-- Find Female Students
SELECT * FROM students WHERE student_gender = "F";
-- Find student id with 15 
SELECT * FROM students WHERE student_id = 15;

-- Find Students Whose Marks Are Greater Than 85
SELECT * FROM marks WHERE marks > 85;

-- First Highest Marks 
SELECT * FROM marks ORDER BY marks DESC LIMIT 1;

-- Student Name + Subject + Marks
SELECT students.student_name , subjects.subject_name , marks.marks 
FROM marks 
JOIN students 
ON marks.student_id = students.student_id 
JOIN subjects 
ON marks.subject_id = subjects.subject_id;

-- Student Report Card
SELECT students.student_name, subjects.subject_name, marks.marks,
    CASE
        WHEN marks.marks >= 90 THEN 'A+'
        WHEN marks.marks >= 80 THEN 'A'
        WHEN marks.marks >= 70 THEN 'B'
        WHEN marks.marks >= 60 THEN 'C'
        ELSE 'Fail'
    END AS Grade
FROM marks
JOIN students
ON marks.student_id = students.student_id
JOIN subjects
ON marks.subject_id = subjects.subject_id;

-- Students Scoring Above 90
SELECT students.student_name, subjects.subject_name, marks.marks 
FROM marks 
JOIN students
ON marks.student_id = students.student_id
JOIN subjects
ON marks.subject_id = subjects.subject_id
WHERE marks.marks >= 90;

-- Average Marks of All Students
SELECT AVG(marks) AS AverageMarks FROM marks;

-- Highest Marks
SELECT MAX(marks) AS MaximumMarks FROM marks;

-- Lowest Marks
SELECT MIN(marks) AS MinimumMarks FROM marks;

-- Total Number of Students
SELECT COUNT(*) AS TotalStudents FROM students;

-- Subject-wise Average Marks
SELECT subjects.subject_name, AVG(marks.marks) AS average_marks
FROM marks 
JOIN subjects 
ON marks.subject_id = subjects.subject_id
GROUP BY subjects.subject_name;

-- Subject-wise Highest Marks
SELECT subjects.subject_name, MAX(marks.marks) AS Maximum_marks
FROM marks 
JOIN subjects 
ON marks.subject_id = subjects.subject_id
GROUP BY subjects.subject_name;

-- Subject-wise Lowest Marks
SELECT subjects.subject_name, MIN(marks.marks) AS Minimum_marks
FROM marks 
JOIN subjects 
ON marks.subject_id = subjects.subject_id
GROUP BY subjects.subject_name;

-- Count Students in Each Subject
SELECT subjects.subject_name, COUNT(marks.student_id) AS total_students
FROM marks
JOIN subjects
ON marks.subject_id = subjects.subject_id
GROUP BY subjects.subject_name;

-- Students Sorted by Highest Marks
SELECT students.student_name, subjects.subject_name, marks.marks 
FROM marks 
JOIN students 
ON marks.student_id = students.student_id
JOIN subjects 
ON marks.subject_id = subjects.subject_id
ORDER BY marks.marks DESC;

-- Students Sorted by Lowest Marks
SELECT students.student_name, subjects.subject_name, marks.marks 
FROM marks 
JOIN students 
ON marks.student_id = students.student_id
JOIN subjects 
ON marks.subject_id = subjects.subject_id
ORDER BY marks.marks ASC;

-- Students Above Average Marks Using Subquery
SELECT students.student_name, marks.marks
FROM marks
JOIN students 
ON marks.student_id = students.student_id
WHERE marks.marks >
(SELECT AVG(marks) FROM marks);

-- Students Above Topper Marks Using Subquery
SELECT students.student_name, marks.marks
FROM marks
JOIN students 
ON marks.student_id = students.student_id
WHERE marks.marks = 
(SELECT Max(marks) FROM marks);

-- Create Student Report View
CREATE VIEW student_report AS
SELECT students.student_name, subjects.subject_name, marks.marks
FROM marks 
JOIN students 
ON marks.student_id = students.student_id
JOIN subjects 
ON marks.subject_id = subjects.subject_id;
SELECT * FROM student_report;

-- Get Result of Specific Student
DELIMITER $$
CREATE PROCEDURE getStudentResult(sid INT)
BEGIN 
	SELECT students.student_name, subjects.subject_name, marks.marks
    FROM marks 
    JOIN students
    ON marks.student_id = students.student_id
    JOIN subjects 
    ON marks.subject_id = subjects.subject_id
    WHERE students.student_id = sid;
END $$
DELIMITER ;
CALL getStudentResult(2);

-- Prevent Negative Marks
DELIMITER $$
CREATE TRIGGER check_marks
BEFORE INSERT ON marks 
FOR EACH ROW
BEGIN 
	IF NEW.marks < 0 THEN 
		SIGNAL SQLSTATE '45000'
        SET message_text = "Marks Cannot be Negative";
	END IF;
END $$
DELIMITER ;
INSERT INTO marks(student_id, subject_id, marks)
VALUES (1, 1, 85);
SELECT * FROM marks;