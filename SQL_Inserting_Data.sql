USE NovaCart;
GO

-- Inserting Data To Customers Table

INSERT INTO Customers (First_Name, Last_Name, Email, Phone, City, Country, Signup_Date) VALUES
('Ahmed',  'Hassan',  'ahmed.hassan@novacart.com',  '01001234567', 'Cairo',      'Egypt', '2024-01-15'),
('Sara',   'Ali',     'sara.ali@novacart.com',     '01102345678', 'Alexandria', 'Egypt', '2024-02-20'),
('John',   'Smith',   'john.smith@novacart.com',   '01203456789', 'London',     'UK',    '2024-03-05'),
('Mona',   'Ibrahim', 'mona.ibrahim@novacart.com', '01004567890', 'Giza',       'Egypt', '2024-03-18'),
('David',  'Brown',   'david.brown@novacart.com',  '01205678901', 'New York',   'USA',   '2024-04-02'),
('Layla',  'Mahmoud', 'layla.mahmoud@novacart.com','01006789012', 'Cairo',      'Egypt', '2024-04-10'),
('Omar',   'Khaled',  'omar.khaled@novacart.com',  '01107890123', 'Dubai',      'UAE',   '2024-04-22'),
('Emma',   'Wilson',  'emma.wilson@novacart.com',  '01208901234', 'Paris',      'France','2024-05-01');
GO

-- Inserting Data To Categories Table

INSERT INTO Categories (Category_Name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen'),
('Sports'),
('Beauty');
GO

-- Insering Data To Products Table

INSERT INTO Products (Product_Name, Category_ID, Price, Stock_Quantity) VALUES

-- Electronics
('Wireless Headphones',   1, 120.00, 50),
('Smartphone X',          1, 800.00, 30),
('Laptop Pro',            1, 1500.00, 15),
('Smart Watch',           1, 250.00, 40),
('Bluetooth Speaker',     1, 75.00, 60),
-- Clothing
('T-Shirt',               2, 25.00, 200),
('Jeans',                 2, 60.00, 100),
('Jacket',                2, 150.00, 45),
('Running Shoes',         2, 90.00, 70),
-- Books
('SQL Guide Book',        3, 40.00, 80),
('Python for Beginners',  3, 35.00, 90),
('Data Science Handbook', 3, 55.00, 50),
-- Home & Kitchen
('Coffee Maker',          4, 90.00, 40),
('Blender',               4, 55.00, 60),
('Air Fryer',             4, 130.00, 25),
-- Sports
('Yoga Mat',              5, 30.00, 100),
('Dumbbell Set',          5, 120.00, 35),
-- Beauty
('Face Cream',            6, 20.00, 150),
('Perfume',               6, 85.00, 80);
GO

-- Insering Data To Orders Table

INSERT INTO Orders (Customer_ID, Order_Date, Status, Total_Amount) VALUES
(1, '2024-05-01', 'Completed', 920.00),
(2, '2024-05-03', 'Completed', 85.00),
(3, '2024-05-10', 'Shipped',   1500.00),
(1, '2024-05-15', 'Completed', 240.00),
(4, '2024-05-20', 'Pending',   130.00),
(5, '2024-05-25', 'Completed', 145.00),
(6, '2024-06-01', 'Completed', 375.00),
(7, '2024-06-05', 'Shipped',   275.00),
(8, '2024-06-10', 'Completed', 60.00),
(2, '2024-06-15', 'Pending',   210.00),
(3, '2024-06-20', 'Completed', 130.00),
(1, '2024-06-25', 'Cancelled', 90.00);
GO

-- Insering Data To Order_Items Table

INSERT INTO Order_Items (Order_ID, Product_ID, Quantity, Unit_Price) VALUES
-- Order 1 (Ahmed - $920)
(1, 2, 1, 800.00),
(1, 1, 1, 120.00),
-- Order 2 (Sara - $85)
(2, 6, 2, 25.00),
(2, 11, 1, 35.00),
-- Order 3 (John - $1500)
(3, 3, 1, 1500.00),
-- Order 4 (Ahmed - $240)
(4, 1, 2, 120.00),
-- Order 5 (Mona - $130)
(5, 7, 1, 60.00),
(5, 11, 1, 35.00),
(5, 17, 1, 30.00),
-- Order 6 (David - $145)
(6, 13, 1, 90.00),
(6, 14, 1, 55.00),
-- Order 7 (Layla - $375)
(7, 4, 1, 250.00),
(7, 5, 1, 75.00),
(7, 18, 1, 20.00),
(7, 17, 1, 30.00),
-- Order 8 (Omar - $275)
(8, 8, 1, 150.00),
(8, 10, 1, 40.00),
(8, 12, 1, 55.00),
(8, 20, 1, 30.00),
-- Order 9 (Emma - $60)
(9, 7, 1, 60.00),
-- Order 10 (Sara - $210)
(10, 6, 2, 25.00),
(10, 7, 1, 60.00),
(10, 18, 2, 20.00),
(10, 19, 1, 80.00),
-- Order 11 (John - $130)
(11, 15, 1, 130.00),
-- Order 12 (Ahmed - $90, Cancelled)
(12, 13, 1, 90.00);
GO

-- Insering Data To Payments Table

INSERT INTO Payments (Order_ID, Payment_Date, Amount, Method) VALUES
(1,  '2024-05-01', 920.00,  'Credit Card'),
(2,  '2024-05-03', 85.00,   'PayPal'),
(3,  '2024-05-10', 1500.00, 'Credit Card'),
(4,  '2024-05-15', 240.00,  'Debit Card'),
(6,  '2024-05-25', 145.00,  'Cash'),
(7,  '2024-06-01', 375.00,  'Credit Card'),
(8,  '2024-06-05', 275.00,  'PayPal'),
(9,  '2024-06-10', 60.00,   'Debit Card'),
(11, '2024-06-20', 130.00,  'Credit Card');
GO

-- Insering Data To Reviews Table

INSERT INTO Reviews (Product_ID, Customer_ID, Rating, Comment, Review_Date) VALUES
(1, 1, 5, 'Excellent sound quality!',        '2024-05-10'),
(1, 3, 4, 'Good but a bit pricey.',          '2024-05-12'),
(1, 2, 5, 'Best headphones I ever bought.',  '2024-05-20'),
(2, 1, 4, 'Great phone, fast performance.',  '2024-05-08'),
(2, 5, 3, 'Battery could be better.',        '2024-05-15'),
(3, 3, 5, 'Perfect for development work.',   '2024-05-11'),
(3, 7, 5, 'Super fast and reliable.',        '2024-06-06'),
(6, 2, 4, 'Nice fabric, true to size.',      '2024-05-05'),
(6, 4, 5, 'Very comfortable!',               '2024-05-22'),
(7, 4, 4, 'Good fit, nice color.',           '2024-05-21'),
(10, 5, 5, 'Best SQL book for beginners.',   '2024-05-26'),
(10, 8, 4, 'Very helpful examples.',         '2024-06-12'),
(13, 5, 3, 'Works fine but noisy.',          '2024-05-27'),
(13, 6, 4, 'Good value for money.',          '2024-06-02'),
(18, 6, 5, 'Amazing scent!',                 '2024-06-03');
GO