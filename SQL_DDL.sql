-- Creating NovaCart Database
CREATE DATABASE NovaCart;
USE NovaCart;

-- Creating The Customers Table
CREATE TABLE Customers (
    Customer_ID     INT IDENTITY(1,1) PRIMARY KEY,
    First_Name      VARCHAR(50) NOT NULL,
    Last_Name       VARCHAR(50) NOT NULL,
    Email           VARCHAR(100) UNIQUE NOT NULL,
    Phone           VARCHAR(20),
    City            VARCHAR(50),
    Country         VARCHAR(50),
    Signup_Date     DATE NOT NULL
);

-- Creating The Categories Table
CREATE TABLE Categories (
    Category_ID     INT IDENTITY(1,1) PRIMARY KEY,
    Category_Name   VARCHAR(50) NOT NULL UNIQUE
);

-- Creating The Products Table
CREATE TABLE Products (
    Product_ID      INT IDENTITY(1,1) PRIMARY KEY,
    Product_Name    VARCHAR(100) NOT NULL,
    Category_ID     INT,
    Price           DECIMAL(10,2) NOT NULL,
    Stock_Quantity  INT DEFAULT 0,
    FOREIGN KEY (Category_ID) REFERENCES categories(Category_ID)
);

-- Creating The Orders Table
CREATE TABLE Orders (
    Order_ID        INT IDENTITY(1,1) PRIMARY KEY,
    Customer_Id     INT NOT NULL,
    Order_Date      DATE NOT NULL,
    Status          VARCHAR(20) DEFAULT 'Pending',
    Total_Amount    DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
);

-- Creating The Order Items Table
CREATE TABLE Order_Items (
    Order_Item_ID   INT IDENTITY(1,1) PRIMARY KEY,
    Order_ID        INT NOT NULL,
    Product_ID      INT NOT NULL,
    Quantity        INT NOT NULL,
    Unit_Price      DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
);

-- Creating The Payments Table
CREATE TABLE Payments (
    Payment_ID      INT IDENTITY(1,1) PRIMARY KEY,
    Order_ID        INT NOT NULL,
    Payment_Date    DATE NOT NULL,
    Amount          DECIMAL(10,2) NOT NULL,
    Method          VARCHAR(30),
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID)
);

-- Creating The Reviews Table
CREATE TABLE Reviews (
    Review_ID       INT IDENTITY(1,1) PRIMARY KEY,
    Product_ID      INT NOT NULL,
    Customer_ID     INT NOT NULL,
    Rating          INT CHECK (Rating BETWEEN 1 AND 5),
    Comment         VARCHAR(500),
    Review_Date     DATE NOT NULL,
    FOREIGN KEY (Product_ID)  REFERENCES Products(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);