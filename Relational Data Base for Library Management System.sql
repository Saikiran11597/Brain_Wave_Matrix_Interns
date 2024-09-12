-- Create the Authors table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE
);


-- Create the Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    PublicationYear Date,
    Genre VARCHAR(50),
    CopiesAvailable INT CHECK (CopiesAvailable >= 0),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);


-- Create the Members table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    MembershipDate DATE,
    Email VARCHAR(100),
    Phone VARCHAR(15)
);


-- Create the Transactions table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    CheckoutDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
);


-- Create the Categories table (if you want to categorize books)
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);


-- Create the BookCategories (Many-to-Many Relationship)
CREATE TABLE BookCategories (
    BookID INT,
    CategoryID INT,
    PRIMARY KEY (BookID, CategoryID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


-- Insert sample data into Authors
INSERT INTO Authors (AuthorID,FirstName, LastName, BirthDate)
VALUES (1,'George', 'Orwell', '1903-06-25'),
       (2,'Aldous', 'Huxley', '1894-07-26');

-- Insert sample data into Books
INSERT INTO Books (BookID,Title, AuthorID, PublicationYear, Genre, CopiesAvailable)
VALUES (1001,'1984', 1, '1949', 'Dystopian', 5),
       (1002,'Brave New World', 2, '1932', 'Science Fiction', 3);

-- Insert sample data into Members
INSERT INTO Members (MemberID,FirstName, LastName, MembershipDate, Email, Phone)
VALUES (2001,'Alice', 'Smith', '2024-01-15', 'alice.smith@example.com', '555-1234'),
       (2002,'Bob', 'Johnson', '2024-02-20', 'bob.johnson@example.com', '555-5678');

-- Insert sample data into Transactions
INSERT INTO Transactions (TransactionID,BookID, MemberID, CheckoutDate, ReturnDate)
VALUES (3001,1001, 2001, '2024-09-01', '2024-12-30'),  -- Alice checked out "1984" but hasn't returned it yet
       (3002,1002, 2002, '2024-09-10', '2024-09-15');  -- Bob checked out and returned "Brave New World"

-- Insert sample data into Categories
INSERT INTO Categories (CategoryID,CategoryName)
VALUES (20,'Dystopian'), (30,'Science Fiction');

-- Insert sample data into BookCategories
INSERT INTO BookCategories (BookID, CategoryID)
VALUES (1001, 20),  -- "1984" is a Dystopian book
       (1002, 30);  -- "Brave New World" is Science Fiction

--Fetching all the tables

--Fetching Authors Table

SELECT * FROM Authors;

--Fetching Books Table
SELECT * FROM Books;

--Fetching Members Table
SELECT * FROM Members;

--Fetching Transactions Table
SELECT * FROM Transactions;

--Fetching Categories Table
SELECT * FROM Categories;

--Fetching BookCategories Table

Select * From BookCategories;

--Fetching Books with Their Authors
--To get a list of books along with their authors' names:

SELECT b.Title, a.FirstName, a.LastName, b.PublicationYear, b.Genre, b.CopiesAvailable
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID;

-- Fetching Members with Their Borrowed Books
-- To get a list of members along with the books they have checked out and their return status:

SELECT m.FirstName AS MemberFirstName, m.LastName AS MemberLastName, b.Title AS BookTitle, t.CheckoutDate, t.ReturnDate
FROM Transactions t
JOIN Members m ON t.MemberID = m.MemberID
JOIN Books b ON t.BookID = b.BookID;

-- Fetching Books and Their Categories
-- To get a list of books along with their categories:

SELECT b.Title AS BookTitle, c.CategoryName
FROM Books b
JOIN BookCategories bc ON b.BookID = bc.BookID
JOIN Categories c ON bc.CategoryID = c.CategoryID;

-- Fetching Books That Are Currently Checked Out
-- To find books that are currently checked out (i.e., where the return date is NULL):

SELECT b.Title, m.FirstName AS MemberFirstName, m.LastName AS MemberLastName, t.CheckoutDate
FROM Transactions t
JOIN Books b ON t.BookID = b.BookID
JOIN Members m ON t.MemberID = m.MemberID

-- Fetching Books by Genre
-- To get a list of books filtered by a specific genre, for example, 'Dystopian':

SELECT Title, PublicationYear, CopiesAvailable
FROM Books
WHERE Genre = 'Dystopian';

-- Fetching Members Who Have Borrowed Books
-- To find members who have borrowed at least one book:

SELECT DISTINCT m.FirstName, m.LastName, m.Email
FROM Transactions t
JOIN Members m ON t.MemberID = m.MemberID;

-- Fetching Category-wise Book Count
-- To get the count of books in each category:

SELECT c.CategoryName, COUNT(bc.BookID) AS BookCount
FROM Categories c
JOIN BookCategories bc ON c.CategoryID = bc.CategoryID
GROUP BY c.CategoryName;