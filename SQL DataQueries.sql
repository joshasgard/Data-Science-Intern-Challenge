/*
Querying dataset at link https://www.w3schools.com/SQL/TRYSQL.ASP?FILENAME=TRYSQL_SELECT_ALL
*/

--------------------------------------------------------------------------------------------------------------------------

-- How many orders were shipped by Speedy Express in total?

SELECT COUNT(Orders.OrderID) 
FROM [Orders] 

INNER JOIN [Shippers] 
  ON Orders.ShipperID = Shippers.ShipperID 
--WHERE Shippers.ShipperName = "Speedy Express"

 --------------------------------------------------------------------------------------------------------------------------

-- What is the last name of the employee with the most orders?

SELECT Employees.LastName, 
       Employees.EmployeeID 
FROM [Employees] 

INNER JOIN (
            SELECT MAX(OrderDetails.Quantity), 
                   Orders.EmployeeID 
            FROM [OrderDetails] 
    
            INNER JOIN [Orders] 
               ON OrderDetails.OrderID = Orders.OrderID) t1 
ON t1.EmployeeID = Employees.EmployeeID


--------------------------------------------------------------------------------------------------------------------------

-- What product was ordered the most by customers in Germany?

SELECT t2.Country,
       MAX(t2.Quantity) AS Most_Ordered,
                           Products.ProductName 
FROM [Products] 

INNER JOIN (
            SELECT Customers.Country, 
                   t1.ProductID, 
                   SUM(t1.Quantity) AS Quantity 
            FROM [Customers]
            
            INNER JOIN (
                        SELECT OrderDetails.OrderID, 
                               OrderDetails.ProductID, 
                               OrderDetails.Quantity, 
                               Orders.CustomerID 
                        FROM [OrderDetails]
                        
                        INNER JOIN [Orders] 
                        ON OrderDetails.OrderID = Orders.OrderID) t1 
            ON Customers.CustomerID = t1.CustomerID 
            --WHERE Customers.Country = "Germany" 
            GROUP BY t1.ProductID 
            ORDER BY Quantity) t2 
ON t2.ProductID = Products.ProductID
