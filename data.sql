-- Populate Users table
INSERT INTO Users (Username, Email, Password, FirstName, LastName, Address, City, Country, PostalCode, Phone) VALUES
('john_doe', 'john@example.com', 'hashed_password_1', 'John', 'Doe', '123 Main St', 'New York', 'USA', '10001', '1234567890'),
('jane_smith', 'jane@example.com', 'hashed_password_2', 'Jane', 'Smith', '456 Elm St', 'Los Angeles', 'USA', '90001', '9876543210'),
('mike_johnson', 'mike@example.com', 'hashed_password_3', 'Mike', 'Johnson', '789 Oak St', 'Chicago', 'USA', '60601', '5555555555');

-- Populate Categories table
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Apparel and fashion items'),
('Books', 'Physical and digital books'),
('Home & Kitchen', 'Home appliances and kitchenware');

-- Populate Products table
INSERT INTO Products (ProductName, Description, Price, StockQuantity, CategoryID) VALUES
('Smartphone X', 'Latest model smartphone with advanced features', 699.99, 50, 1),
('Laptop Pro', 'High-performance laptop for professionals', 1299.99, 30, 1),
('Men''s T-Shirt', 'Comfortable cotton t-shirt', 19.99, 100, 2),
('Women''s Jeans', 'Stylish slim-fit jeans', 49.99, 75, 2),
('The Great Novel', 'Bestselling fiction book', 14.99, 200, 3),
('Cookbook Deluxe', 'Collection of gourmet recipes', 24.99, 50, 3),
('Coffee Maker', 'Programmable coffee maker with timer', 39.99, 40, 4),
('Blender', 'High-speed blender for smoothies and more', 79.99, 25, 4);

-- Populate Orders table
INSERT INTO Orders (UserID, TotalAmount, Status) VALUES
(1, 719.98, 'Delivered'),
(2, 64.98, 'Shipped'),
(3, 1339.98, 'Processing');

-- Populate OrderItems table
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 5, 1, 14.99),
(2, 6, 2, 24.99),
(3, 2, 1, 1299.99),
(3, 7, 1, 39.99);

-- Populate Reviews table
INSERT INTO Reviews (ProductID, UserID, Rating, Comment) VALUES
(1, 2, 5, 'Great smartphone, very happy with the purchase!'),
(2, 3, 4, 'Good laptop, but battery life could be better'),
(3, 1, 5, 'Very comfortable t-shirt, will buy more'),
(5, 2, 3, 'Interesting story, but not my favorite');

-- Populate Cart table
INSERT INTO Cart (UserID, ProductID, Quantity) VALUES
(1, 4, 2),
(1, 8, 1),
(3, 6, 1);

-- Populate Wishlist table
INSERT INTO Wishlist (UserID, ProductID) VALUES
(1, 2),
(2, 8),
(3, 3);
