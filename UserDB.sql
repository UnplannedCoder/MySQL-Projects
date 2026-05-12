-- Database is an organised collection of data
-- It allows to access and manipulate the data

-- Creation of Database and use of DB to work in it 
CREATE DATABASE userDB;
USE userDB;

-- Creation of table
CREATE TABLE users( 
	user_id INT PRIMARY KEY AUTO_INCREMENT, 
    username VARCHAR(50) NOT NULL, 
    email VARCHAR(100) UNIQUE NOT NULL, 
    password VARCHAR(255) NOT NULL, 
    age TINYINT CHECK (age>=18), 
    status VARCHAR(10) DEFAULT 'active', 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP 
);

-- DESCRIBE the structure of table
DESCRIBE users;

-- Insertion of data into table
INSERT INTO users (username, email, password, age, status) VALUES
('rahul123', 'rahul123@gmail.com', 'rahul@123', 21, 'active'),
('priya_s', 'priya.s@gmail.com', 'priya@456', 22, 'active'),
('amitkumar', 'amitk@gmail.com', 'amit@789', 25, 'inactive'),
('neha_gupta', 'neha.gupta@gmail.com', 'neha@321', 19, 'active'),
('rohit_verma', 'rohitv@gmail.com', 'rohit@654', 28, 'active'),
('simran01', 'simran01@gmail.com', 'simran@987', 23, 'inactive'),
('deepak_s', 'deepak.s@gmail.com', 'deepak@111', 24, 'active'),
('kajal_mehta', 'kajal.m@gmail.com', 'kajal@222', 20, 'active'),
('vivek99', 'vivek99@gmail.com', 'vivek@333', 27, 'inactive'),
('ananya_sharma', 'ananya.s@gmail.com', 'ananya@444', 26, 'active'),
('manish007', 'manish007@gmail.com', 'manish@555', 22, 'active'),
('pooja_verma', 'pooja.verma@gmail.com', 'pooja@666', 24, 'inactive'),
('arjun_singh', 'arjun.s@gmail.com', 'arjun@777', 29, 'active'),
('nidhi_sharma', 'nidhi.sharma@gmail.com', 'nidhi@888', 21, 'active'),
('karan_meena', 'karan.meena@gmail.com', 'karan@999', 26, 'inactive');

-- SELECT command is used to fetch the data
SELECT * FROM users;

-- Use of ALTER Queries
ALTER TABLE users ADD COLUMN city VARCHAR(50); -- add new column in existing table 

ALTER TABLE users MODIFY username VARCHAR(100); -- Modifies the column data-type
ALTER TABLE users MODIFY user_id INT AUTO_INCREMENT;

ALTER TABLE users CHANGE COLUMN user_id user_ID INT; -- Changes the existing column name  

ALTER TABLE users DROP COLUMN city; -- Removes the column

ALTER TABLE users RENAME TO userData; -- Rename the table 
ALTER TABLE userData RENAME TO users;

-- UPDATE query 
UPDATE users SET status = NULL WHERE user_id IN (11,13);
UPDATE users SET city = 'Jaipur' WHERE user_id IN (1, 2, 3, 11);
UPDATE users SET city = 'Delhi' WHERE user_id IN (4, 5, 12);
UPDATE users SET city = 'Mumbai' WHERE user_id IN (6, 7, 13);
UPDATE users SET city = 'Pune' WHERE user_id IN (8, 9, 14);
UPDATE users SET city = 'Bangalore' WHERE user_id IN (10, 15);

-- Use of Select Query 
SELECT * FROM users; -- fetches the entire data 
SELECT username , email FROM users; -- fetches the specific column 

-- WHERE Clause Operators(Comparison Operators) - = , != , > , < , >= , <= , BETWEEN...AND , IN , NOT IN , LIKE(Pattern Matching) , NOT LIKE 
-- Use of SELECT query with WHERE Clause
SELECT * FROM users WHERE age = 22;
SELECT * FROM users WHERE age != 22;
SELECT * FROM users WHERE age > 22;
SELECT * FROM users WHERE age < 22;
SELECT * FROM users WHERE age >= 22;
SELECT * FROM users WHERE age <= 22;
SELECT * FROM users WHERE age BETWEEN 22 AND 28;
SELECT * FROM users WHERE age IN (22,28,25); -- IN uses comma separated values
SELECT * FROM users WHERE age NOT IN (22,28,25);
SELECT * FROM users WHERE username LIKE 'r%'; -- fetches the data whose username starts with 'r'
SELECT * FROM users WHERE username LIKE '%a'; -- fetches the data whose username ends with 'a'
SELECT * FROM users WHERE username LIKE '_a%'; -- fetches the data whose username starts with any of the letter and 2nd letter is a and so on
SELECT * FROM users WHERE username LIKE '%a%'; -- fetches the data whose username contains 'a' letter in between
SELECT * FROM users WHERE username NOT LIKE 'r%';

-- WHERE Clause Operators(Logical & NULL Operators) - AND , OR , NOT , IS NULL , IS NOT NULL
SELECT * FROM users WHERE age > 20 AND status = 'active'; -- Both condition should be true 
SELECT * FROM users WHERE age > 20 OR status = 'active'; -- Any of the condition should be true 
SELECT * FROM users WHERE NOT status = 'active'; -- Negates condition
SELECT * FROM users WHERE status IS NULL; -- Checks for NULL value
SELECT * FROM users WHERE status IS NOT NULL; -- Checks for NOT NULL value 

-- Sorting data in either ascending or descending order using ORDER BY Clause
SELECT * FROM users ORDER BY city; -- Arrange the data in ascending order according to city 
SELECT * FROM users ORDER BY city DESC; -- Arrange the data in descending order according to city

-- Limiting Result using LIMIT 
SELECT * FROM users LIMIT 4; -- fetches the first 4 rows 
SELECT * FROM users ORDER BY city LIMIT 4; 
SELECT * FROM users ORDER BY city DESC LIMIT 4;
SELECT * FROM users LIMIT 2,3; -- (2,3) means skips first 2 rows and then fetches the next 3 rows 

-- String Functions - CHAR() , CONCAT() , UPPER() , LOWER() , SUBSTRING() , LENGTH() , TRIM() , LTRIM() , RTRIM() , INSTR() , LEFT() , RIGHT()
-- 1. CHAR() -> Returns character for ASCII value
SELECT CHAR(65, 66, 67) AS characters;

-- 2. CONCAT() -> Combine username and city
SELECT user_id, CONCAT(username, city) AS user_info
FROM users;

-- 3. UPPER() -> Convert username to uppercase
SELECT user_id, UPPER(username) AS uppercase_name
FROM users;

-- 4. LOWER() -> Convert city names to lowercase
SELECT user_id, LOWER(city) AS lowercase_city
FROM users;

-- 5. SUBSTRING() -> Extract first 4 characters from username
SELECT user_id, SUBSTRING(username, 1, 4) AS short_name
FROM users;

-- 6. LENGTH() -> Find length of email
SELECT user_id, email, LENGTH(email) AS email_length
FROM users;

-- 7. TRIM() -> Remove spaces from text
SELECT TRIM('   MySQL Database   ') AS trimmed_text;

-- 8. LTRIM() -> Remove left spaces
SELECT LTRIM('     Hello User') AS left_trimmed;

-- 9. RTRIM() -> Remove right spaces
SELECT RTRIM('Hello User     ') AS right_trimmed;

-- 10. INSTR() -> Find position of '@' in email
SELECT user_id, email, INSTR(email, '@') AS at_position
FROM users;

-- 11. LEFT() -> Extract first 3 characters of city
SELECT user_id, city, LEFT(city, 3) AS city_prefix
FROM users;

-- 12. RIGHT() -> Extract last 4 characters of email
SELECT user_id, email, RIGHT(email, 4) AS email_suffix
FROM users;

-- Numerics Functions - MOD() , ROUND() , TRUNCATE() , POWER() , SQRT() , SIGN() , ABS() , FLOOR() , CEILIING()
-- 1. MOD() -> Find remainder 
SELECT user_id, username, age,
MOD(age, 5) AS remainder
FROM users;

-- 2. ROUND() -> Round decimal values
SELECT user_id, username, age,
ROUND(age / 3, 2) AS rounded_value
FROM users;

-- 3. TRUNCATE() -> Remove decimal places without rounding
SELECT user_id, username, age,
TRUNCATE(age / 3, 2) AS truncated_value
FROM users;

-- 4. POWER() -> Calculate age raised to power 2
SELECT user_id, username, age,
POWER(age, 2) AS age_square
FROM users;

-- 5. SQRT() -> Find square root of age
SELECT user_id, username, age,
SQRT(age) AS square_root
FROM users;

-- 6. SIGN() -> Returns sign of value
SELECT user_id, username, age,
SIGN(age - 25) AS sign_result
FROM users;

-- 7. ABS() -> Absolute value
SELECT user_id, username, age,
ABS(age - 30) AS absolute_difference
FROM users;

-- 8. FLOOR() -> Round down value
SELECT user_id, username, age,
FLOOR(age / 4) AS floor_value
FROM users;

-- 9. CEILING() -> Round up value
SELECT user_id, username, age,
CEILING(age / 4) AS ceiling_value
FROM users;

-- Aggregate Functions - SUM() , MIN() , MAX() , AVG() , COUNT()
-- 1. SUM() -> Total age of all users , Ignores NULL value
SELECT SUM(age) AS total_age
FROM users;

-- 2. MIN() -> Minimum age among users , Ignores NULL value
SELECT MIN(age) AS minimum_age
FROM users;

-- 3. MAX() -> Maximum age among users , Ignores NULL value
SELECT MAX(age) AS maximum_age
FROM users;	

-- 4. AVG() -> Average age of users , Ignores NULL value
SELECT AVG(age) AS average_age
FROM users;

-- 5. COUNT() -> Total number of users , Ignores NULL value
SELECT COUNT(*) AS total_users
FROM users;

-- COUNT() with condition -> Count active users , COUNT(*) doesn't ignores NULL value
SELECT COUNT(*) AS active_users
FROM users
WHERE status = 'active';

-- GROUP BY Clause - used to group rows that have same value so we can perform aggregate calculations on each group 
SELECT city AS CITY, SUM(age) FROM users GROUP BY city;
SELECT city AS CITY, COUNT(age) FROM users GROUP BY city;
SELECT status, COUNT(*) FROM users GROUP BY status;
SELECT city, status, COUNT(*) FROM users GROUP BY city, status;

-- HAVING Clause - Filter the grouped record created by GROUP BY 
SELECT city AS CITY, COUNT(age) FROM users GROUP BY city HAVING COUNT(age)>=3;
SELECT city, AVG(age) FROM users GROUP BY city HAVING AVG(age) > 23;
SELECT city, COUNT(*) FROM users WHERE status = 'active' GROUP BY city HAVING COUNT(*) > 1;


CREATE TABLE employees(
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
	emp_name VARCHAR(50), 
    salary INT, 
    user_id INT, 
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

INSERT INTO employees(emp_id, emp_name, salary, user_id) VALUES 
(1, 'Amit', 50000, 1),
(2, 'Priya', 60000, 2),
(3, 'Rahul', 55000, 2),
(4, 'Sneha', 70000, 3),
(5, 'Rohit', 48000, NULL),
(6, 'Anjali', 52000, 1),
(7, 'Vikram', 58000, 2),
(8, 'Kavya', 49000, 3),
(9, 'Suresh', 61000, 2),
(10, 'Neha', 47000, NULL);

SELECT * FROM employees;
SELECT * FROM users;

-- This UPDATE Query is used here because salary is updated using stored procedure below 
UPDATE employees SET salary=50000 WHERE emp_id=1;
UPDATE employees SET salary=60000 WHERE emp_id=2;
UPDATE employees SET salary=55000 WHERE emp_id=3;
UPDATE employees SET salary=70000 WHERE emp_id=4;
UPDATE employees SET salary=48000 WHERE emp_id=5;
UPDATE employees SET salary=52000 WHERE emp_id=6;
UPDATE employees SET salary=58000 WHERE emp_id=7;
UPDATE employees SET salary=49000 WHERE emp_id=8;
UPDATE employees SET salary=61000 WHERE emp_id=9;
UPDATE employees SET salary=47000 WHERE emp_id=10;

-- JOIN - JOIN is used to combine the data from two or more tables using common column
-- 1. INNER JOIN - INNER JOIN is used to combine rows from two or more tables based on a related column between them.
	-- It returns only the matching records from both tables.
SELECT e.emp_id, e.emp_name, e.salary, u.user_id, u.username
FROM employees AS e 
INNER JOIN users AS u 
ON e.user_id = u.user_id ORDER BY emp_id;

-- 2. LEFT JOIN - LEFT JOIN returns:
	-- All records from the left table
	-- and the matching records from the right table
SELECT e.emp_id, e.emp_name, u.username, u.age 
FROM employees AS e 
LEFT JOIN users u
ON e.user_id = u.user_id;

-- 3. RIGHT JOIN - RIGHT JOIN returs:
	-- All records from right table
    -- and the matching records from the left table
SELECT e.emp_id, e.emp_name, u.username, u.age 
FROM employees AS e 
RIGHT JOIN users u
ON e.user_id = u.user_id;

-- UNION - Combine the result of two or more queries 
SELECT user_id, username FROM users WHERE user_id=1
UNION 
SELECT user_id, username FROM users WHERE user_id=2;

ALTER TABLE employees 
ADD COLUMN manager_id INT, 
ADD CONSTRAINT FOREIGN KEY(manager_id) REFERENCES employees(emp_id);

UPDATE employees SET manager_id=1 WHERE emp_id IN (2,3);
UPDATE employees SET manager_id=2 WHERE emp_id IN (4,5);

-- SELF JOIN - A table joins with itself
SELECT e.emp_name, em.emp_name
FROM employees e
LEFT JOIN employees em
ON e.manager_id = em.emp_id;

-- Subquery - A subquery is a query inside nested another query
SELECT MAX(salary) FROM employees
WHERE salary<(SELECT MAX(salary) FROM employees);

-- VIEW 
CREATE VIEW employee_salary_view AS
SELECT emp_id FROM employees 
WHERE salary>50000;

SELECT * FROM employee_salary_view;

CREATE VIEW employee_list_view AS 
SELECT * FROM employees
WHERE user_id IS NOT NULL;

SELECT * FROM employee_list_view;

-- INDEX - INDEX in SQL is like a shortcut that makes searhing data in a table faster
	-- Clustered INDEX - sorts and stores the rows physically in order
    -- Non Clustered INDEX - creates a separate structure pointing to the data
    -- Unique INDEX - ensures all values in a column are unique
    
-- CASE - it works like if-else condition 
SELECT emp_name, salary, (
	CASE 
		WHEN salary > 100000 THEN 'High'
		WHEN salary BETWEEN 50000 AND 100000 THEN 'Medium'
		ELSE 'Low'
	END 
) AS Salary_category FROM employees;

-- Function - A function is a stored program that returns a single value and can be used inside SQL statements 
-- a DELIMTER is a symbol or sequence of characters used to mark the end of a SQL statement. ByDefault DELIMETER used in SQL is ';'
DELIMITER $$
CREATE FUNCTION getAnnualSalary(monthSalary INT)
RETURNS INT 
DETERMINISTIC
BEGIN 
	RETURN monthSalary*12;
END $$
DELIMITER ;

SELECT emp_name , salary , getAnnualSalary(salary) FROM employees;

-- Stored Procedure - A stored procedure is a block of SQL statements saved in the database
DELIMITER $$
CREATE PROCEDURE getEmployeeByDept(userID INT)
BEGIN 
	SELECT emp_id, emp_name, salary
    FROM employees 
    WHERE user_id = userID;
END $$
DELIMITER ;
CALL getEmployeeByDept(2);

DELIMITER $$
CREATE PROCEDURE increaseSalary(
userID INT,
amount INT
)
BEGIN
	UPDATE employees SET salary = salary + amount
    WHERE user_id = userID;
END $$
DELIMITER ;
CALL increaseSalary(2,5000);

-- TRIGGER - A TRIGGER is a database object that automatically executes a specified SQL action before or after an INSERT, UPDATE, DELETE operation on table 
DELIMITER $$
CREATE TRIGGER before_insert_employees
BEFORE INSERT ON employees
FOR EACH ROW 
BEGIN 
	IF NEW.salary<0 or NEW.salary IS NULL THEN SET NEW.salary=0;
    END IF;
END $$
DELIMITER ; 
INSERT INTO employees(emp_name, salary, user_id) VALUES 
('Pradeep', -50000, 1);




