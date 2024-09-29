CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO Products (ProductID,Name, Description, Price, Stock) 
VALUES (20,'Bluetooth Headphones', 'Over-ear wireless headphones with noise cancellation.', 89.99, 50);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

INSERT INTO Customers (CustomerID,FirstName, LastName, Email, Phone, Address) 
VALUES (01,'Alice', 'Smith', 'alice.smith@example.com', '555-9876', '456 Oak St, Springfield, USA');


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    Total DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create a new order
INSERT INTO Orders (OrderID,CustomerID,OrderDate,Total,Status) 
VALUES (002,01,'01-01-2001', 179,'Available');


CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



-- Add items to the order
INSERT INTO OrderItems (OrderItemID,OrderID, ProductID, Quantity, Price) 
VALUES (10,002, 20, 2, 89.99); 


CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATETIME,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Payments (PaymentID,OrderID,PaymentDate, Amount, PaymentMethod) 
VALUES (1001,002,'02-02-2001', 179, 'Credit Card');

UPDATE Products 
SET Stock = Stock - 2 
WHERE ProductID = 20;

SELECT o.OrderID, o.OrderDate, o.Total, o.Status 
FROM Orders o 
JOIN Customers c ON o.CustomerID = c.CustomerID 
WHERE c.CustomerID = 01; -- Assuming CustomerID 01

SELECT oi.OrderItemID, p.Name, oi.Quantity, oi.Price 
FROM OrderItems oi 
JOIN Products p ON oi.ProductID = p.ProductID 
WHERE oi.OrderID = 002; -- Assuming OrderID 002

SELECT Name, Stock 
FROM Products 
WHERE ProductID = 20; -- Assuming ProductID 20

UPDATE Orders 
SET Status = 'Available' 
WHERE OrderID = 002; -- Assuming OrderID 002
