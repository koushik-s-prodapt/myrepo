-- Create a table for customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);

-- Create a table for orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country)
VALUES 
(1, 'Cardinal', 'Tom B. Erichsen', 'Norway'),
(2, 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
(3, 'Island Trading', 'Helen Bennett', 'UK'),
(4, 'Königlich Essen', 'Philip Cramer', 'Germany');

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES 
(1, 1, '2023-01-15', 240.00),
(2, 2, '2023-02-19', 150.50),
(3, 3, '2023-03-22', 300.00),
(4, 1, '2023-04-11', 170.25);

-- Select all customers
SELECT * FROM Customers;

-- Select all orders
SELECT * FROM Orders;

-- Join Customers and Orders tables
SELECT 
    Customers.CustomerName, 
    Orders.OrderDate, 
    Orders.TotalAmount
FROM 
    Orders
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID;

-- Update a customer's contact name
UPDATE Customers
SET ContactName = 'Thomas B. Erichsen'
WHERE CustomerID = 1;

-- Delete an order
DELETE FROM Orders
WHERE OrderID = 2;

-- Select customers from Germany
SELECT * FROM Customers
WHERE Country = 'Germany';

-- Aggregate function example: total sales by country
SELECT 
    Country, 
    SUM(Orders.TotalAmount) AS TotalSales
FROM 
    Customers
INNER JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY 
    Country;

-- Subquery example: customers with orders over $200
SELECT 
    CustomerName
FROM 
    Customers
WHERE 
    CustomerID IN (SELECT CustomerID FROM Orders WHERE TotalAmount > 200.00);

-- Complex query: find customers with no orders
SELECT 
    CustomerName
FROM 
    Customers
WHERE 
    CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- Create a table for products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    UnitPrice DECIMAL(10, 2)
);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, UnitPrice)
VALUES 
(1, 'Chais', 1, 1, 18.00),
(2, 'Chang', 1, 1, 19.00),
(3, 'Aniseed Syrup', 1, 2, 10.00);

-- Select all products
SELECT * FROM Products;

-- Use a case statement
SELECT 
    CustomerID,
    TotalAmount,
    CASE 
        WHEN TotalAmount >= 300 THEN 'High'
        WHEN TotalAmount >= 150 THEN 'Medium'
        ELSE 'Low'
    END AS OrderValue
FROM Orders;

-- Use of a window function
SELECT 
    CustomerID,
    OrderDate,
    TotalAmount,
    SUM(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM Orders;
