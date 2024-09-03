--Concepts--
-- 1. Sales Analysis by Product Category:

SELECT c.CategoryName, SUM(oi.Quantity * oi.Price) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY c.CategoryName
ORDER BY TotalSales DESC;

-- 2. Customer Lifetime Value(CLV):
SELECT u.UserID, u.Username, SUM(o.TotalAmount) AS LifetimeValue
FROM Users u
JOIN Orders o ON u.UserID = o.UserID
GROUP BY u.UserID, u.Username
ORDER BY LifetimeValue DESC;


-- 3. Product Performance Analysis:
SELECT p.ProductName, 
       SUM(oi.Quantity) AS TotalQuantitySold, 
       SUM(oi.Quantity * oi.Price) AS TotalRevenue,
       AVG(r.Rating) AS AverageRating
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
LEFT JOIN Reviews r ON p.ProductID = r.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC;


-- 4. Customer Segmentation by Purchase Frequency:
SELECT 
    CASE 
        WHEN OrderCount > 10 THEN 'High Frequency'
        WHEN OrderCount BETWEEN 5 AND 10 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS CustomerSegment,
    COUNT(*) AS CustomerCount
FROM (
    SELECT UserID, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY UserID
) AS UserOrderCounts
GROUP BY CustomerSegment;


-- 5. Seasonal Sales Trends:
SELECT 
    EXTRACT(MONTH FROM OrderDate) AS Month,
    EXTRACT(YEAR FROM OrderDate) AS Year,
    SUM(TotalAmount) AS MonthlySales
FROM Orders
GROUP BY EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate)
ORDER BY Year, Month;

-- 6. Cart Abandonment Analysis:
SELECT 
    u.UserID, 
    u.Username, 
    COUNT(*) AS AbandonedCartItems,
    SUM(p.Price * c.Quantity) AS PotentialRevenue
FROM Cart c
JOIN Users u ON c.UserID = u.UserID
JOIN Products p ON c.ProductID = p.ProductID
LEFT JOIN Orders o ON u.UserID = o.UserID AND o.OrderDate > c.CreatedAt
WHERE o.OrderID IS NULL
GROUP BY u.UserID, u.Username
ORDER BY PotentialRevenue DESC;

-- 7. Product Affinity Analysis
SELECT 
    p1.ProductName AS Product1, 
    p2.ProductName AS Product2, 
    COUNT(*) AS CoOccurrences
FROM OrderItems oi1
JOIN OrderItems oi2 ON oi1.OrderID = oi2.OrderID AND oi1.ProductID < oi2.ProductID
JOIN Products p1 ON oi1.ProductID = p1.ProductID
JOIN Products p2 ON oi2.ProductID = p2.ProductID
GROUP BY p1.ProductName, p2.ProductName
ORDER BY CoOccurrences DESC
LIMIT 10;

-- 8. Customer Review Sentiment Analysis
SELECT 
    p.ProductName,
    AVG(r.Rating) AS AverageRating,
    COUNT(*) AS TotalReviews,
    SUM(CASE WHEN r.Rating >= 4 THEN 1 ELSE 0 END) AS PositiveReviews,
    SUM(CASE WHEN r.Rating <= 2 THEN 1 ELSE 0 END) AS NegativeReviews
FROM Products p
LEFT JOIN Reviews r ON p.ProductID = r.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY AverageRating DESC;


-- 9. Inventory Turnover Rate:
SELECT 
    p.ProductName,
    p.StockQuantity AS CurrentStock,
    COALESCE(SUM(oi.Quantity), 0) AS TotalSold,
    CASE 
        WHEN p.StockQuantity > 0 THEN COALESCE(SUM(oi.Quantity), 0) / p.StockQuantity
        ELSE 0 
    END AS TurnoverRate
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName, p.StockQuantity
ORDER BY TurnoverRate DESC;



-- 10. Customer Acquistion Cost(assuming we have a Marketing table):
-- Assuming we have a Marketing table with campaigns and costs
CREATE TABLE Marketing (
    CampaignID INT PRIMARY KEY AUTO_INCREMENT,
    CampaignName VARCHAR(100),
    Cost DECIMAL(10, 2),
    StartDate DATE,
    EndDate DATE
);

INSERT INTO Marketing (CampaignName, Cost, StartDate, EndDate) VALUES
('Summer Sale', 1000.00, '2023-06-01', '2023-06-30'),
('Back to School', 1500.00, '2023-08-01', '2023-08-31');

-- Then we can calculate Customer Acquisition Cost
SELECT 
    m.CampaignName,
    m.Cost AS CampaignCost,
    COUNT(DISTINCT u.UserID) AS NewCustomers,
    m.Cost / COUNT(DISTINCT u.UserID) AS AcquisitionCostPerCustomer
FROM Marketing m
JOIN Users u ON u.CreatedAt BETWEEN m.StartDate AND m.EndDate
LEFT JOIN Orders o ON u.UserID = o.UserID AND o.OrderDate BETWEEN m.StartDate AND m.EndDate
WHERE o.OrderID IS NOT NULL
GROUP BY m.CampaignID, m.CampaignName, m.Cost;
