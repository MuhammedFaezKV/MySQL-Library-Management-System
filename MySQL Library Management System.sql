-- Creating the library database
CREATE DATABASE library;

-- Use the library database
USE library;

-- Creating the Branch table
CREATE TABLE Branch (
	Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_addres VARCHAR(100),
    Contact_no VARCHAR(20)
);
-- inserting values in to the Branch
INSERT INTO Branch(Branch_no, Manager_Id, Branch_addres, Contact_no) VALUES
	(1, 101, 'Main Street', '746-629-4707'),
	(2, 102, 'Livonia Street', '366-756-7345'),
	(3, 103, 'Harbor Drive', '260-693-4610'),
	(4, 104, 'Sea Park Road', '520-496-1797'),
	(5, 105, 'Meadow Lane', '865-366-9849');

-- Creating the Employee table
CREATE TABLE Employee (
	Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(30),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Branch_no INT,
    CONSTRAINT frgn_key_one FOREIGN KEY(Branch_no) REFERENCES Branch(Branch_no)
);
-- inserting values in to the Employee
INSERT INTO Employee(Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
	(201, 'Frank Wilson', 'Manager', 61000.00, 1),
	(202, 'Jannifer Lane', 'Assistant Manager', 57000.00, 1),
	(203, 'Nicholas Petersen', 'Manager', 30000.00, 2),
	(204, 'Eva Davis', 'Assistant Manager', 25000.00, 2),
	(205, 'Rodriguez Lawis', 'Business Analyst', 55000.00, 2),
	(206, 'Bessie Hooper', 'Finance Manager', 43000.00, 3),
	(207, 'George Smith', 'Supervisor', 26000.00, 2),
	(208, 'Scottie Philips', 'Project Manager', 60000.00, 4),
	(209, 'Wiliam Raine', 'Accountant', 32000.00, 2),
	(210, 'John Fergerson', 'Product Manager', 40000.00, 4),
	(211, 'Monica Oconnor', 'Marketing Spacialist', 52000.00, 2),
	(212, 'Ruth lathan', 'Sales Representive', 28000.00, 5);

-- Creating the Customer table
CREATE TABLE Customer (
	Customer_Id INT PRIMARY KEY NOT NULL,
	Customer_name VARCHAR (30),
	Customer_address VARCHAR (100),
	Reg_date DATE
);
-- inserting values in to the Customer
INSERT INTO Customer(Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
	(1001,'Charlie Wilson', '480 Street','2020-08-17'),
	(1002,'Grace Taylor', '500 Valley','2021-04-29'),
	(1003,'Keith Robnson', '900 Road','2022-02-23'),
	(1004,'Hannah Wright', '100 Lane','2022-11-06'),
	(1005,'Jane Miller', '777 Avenue','2023-09-15'),
	(1006,'Emma Kate', '200 Lake','2021-07-13'),
	(1007,'Anna Leigh', '399 Ridge','2020-12-27');

-- Creating the IssueStatus table
CREATE TABLE IssueStatus (
	Issue_Id INT PRIMARY KEY,
	Issued_cust INT,
	Issued_book_name VARCHAR(50),
	Issue_date DATE,
	Isbn_book INT,
    CONSTRAINT frgn_key_two FOREIGN KEY(Issued_cust) REFERENCES Customer(Customer_Id),
    CONSTRAINT frgn_key_tree FOREIGN KEY(Isbn_book) REFERENCES Books(ISBN)
);
-- inserting values in to the IssueStatus
INSERT INTO IssueStatus(Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
	(401, 1001, 'Watchmen', '2021-05-13', 197864532),
	(402, 1002, 'Republic', '2022-09-25', 642957398),
	(403, 1003, 'Jane Eyre', '2020-01-19', 553872917),
	(404, 1004, 'Gone Girl', '2020-03-22', 374657398),
	(405, 1005, 'Redwall', '2023-06-17', 283645741);
    
-- Creating the ReturnStatus table
CREATE TABLE ReturnStatus (
	Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(50),
    Return_date DATE,
    Isbn_book2 INT,
	CONSTRAINT frgn_key_four FOREIGN KEY(Isbn_book2) REFERENCES Books(ISBN)
);
-- inserting values in to the ReturnStatus
INSERT INTO ReturnStatus(Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
	(701, 1002, 'Republic', '2022-10-19', 642957398),
	(702, 1003, 'Jane Eyre', '2020-01-08', 553872917),
	(703, 1005, 'Redwall', '2023-07-24', 283645741);

-- Creating the Books table
CREATE TABLE Books (
	ISBN INT PRIMARY KEY,
    Book_title VARCHAR(30),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(30),
    Publisher VARCHAR(50)
);
-- inserting values in to the Books
INSERT INTO Books(ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
	(197864532, 'Watchmen', 'Comics', 600.00, 'No', 'Alan Moore', 'DC Comics'),
	(283645741, 'Redwall', 'Fantasy', 450.00, 'Yes', 'Brian Jacques', 'Penguin Random House'),
	(374657398, 'Gone Girl', 'Thriller', 550.00, 'No', 'Gillian Flynn', 'Crown Publishing Group'),
	(461586426, 'Me Before You', 'Romance', 300.00, 'Yes', 'Jojo Moyes', 'Penguin Books'),
	(553872917, 'Jane Eyre', 'Classics', 650.00, 'Yes', 'Charlotte Bronte', 'Smith, Elder & Co'),
	(642957398, 'Republic', 'History', 500.00, 'Yes', 'Plato', 'Simon & Schuster'),
	(730482414, 'Rebecca', 'Mystery', 400.00, 'Yes', 'Daphne du Maurier', 'Victor Gollancz');

SELECT * FROM Branch;
SELECT * FROM Employee;
SELECT * FROM Customer;
SELECT * FROM Books;
SELECT * FROM IssueStatus;
SELECT * FROM ReturnStatus;


# Q1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';

# Q2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

# Q3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT i.Issued_book_name AS Book_Title, c.Customer_name AS Customer_Name
FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

# Q4. Display the total count of books in each category.			
SELECT Category, COUNT(*) AS Total_Categories
FROM Books
GROUP BY Category;

# Q5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

# Q6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name FROM Customer
WHERE Reg_date < '2022-01-01'
	AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

# Q7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

# Q8. Display the names of customers who have issued books in the month of June 2023.		
SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

# Q9. Retrieve book_title from book table containing history.			
SELECT Book_title
FROM Books
WHERE Category = 'History';

# Q10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees			
SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;


DROP TABLE Branch;
DROP TABLE Employee;
DROP TABLE Customer;
DROP TABLE Books;
DROP TABLE IssueStatus;
DROP TABLE ReturnStatus;
DROP DATABASE library;