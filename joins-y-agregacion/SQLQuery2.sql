SELECT TOP (1000) [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[Color]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[Weight]
      ,[ProductCategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[ThumbNailPhoto]
      ,[ThumbnailPhotoFileName]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorksLT2022].[SalesLT].[Product]

SELECT DISTINCT Color AS product_color FROM [SalesLT].Product
WHERE Color IS NOT NULL;

/*  DECLARE @PAGE_NUMBER INT = 1;
DECLARE @ROWS_PER_PAGE INT = 10;

SELECT DISTINCT Color AS product_color FROM [SalesLT].Product
WHERE Color IS NOT NULL
ORDER BY Color
OFFSET 0 ROWS
FETCH NEXT 10 ROW ONLY;*/

/*DECLARE @PAGE_NUMBER INT = 2;
DECLARE @ROWS_PER_PAGE INT = 3;

SELECT DISTINCT Color AS product_color FROM [SalesLT].Product
WHERE Color IS NOT NULL
ORDER BY Color
OFFSET (@PAGE_NUMBER - 1) * @ROWS_PER_PAGE ROWS
FETCH NEXT @ROWS_PER_PAGE ROW ONLY;*/

/*DECLARE @PAGE_NUMBER INT = 3;
DECLARE @ROWS_PER_PAGE INT = 10;

SELECT * FROM [SalesLT].Customer
ORDER BY CustomerID
OFFSET (@PAGE_NUMBER - 1) * @ROWS_PER_PAGE ROWS
FETCH NEXT @ROWS_PER_PAGE ROW ONLY;*/

-- PRACTICA

SELECT * FROM SalesLT.ProductCategory;

/*DECLARE @PAGE_NUMBER INT = 3;
DECLARE @ROWS_PER_PAGE INT = 10;

SELECT * FROM SalesLT.ProductCategory
ORDER BY Name
OFFSET (@PAGE_NUMBER - 1) * @ROWS_PER_PAGE ROWS
FETCH NEXT @ROWS_PER_PAGE ROW ONLY;*/

SELECT * FROM SalesLT.Customer;

-- DECLARE @PAGE_NUMBER INT = 3;
-- DECLARE @ROWS_PER_PAGE INT = 10;

-- USO DE LIKE
SELECT * FROM SalesLT.Customer
WHERE FirstName LIKE '%Rob%';

SELECT * FROM SalesLT.Customer
WHERE FirstName = 'Robert';

-- BETWEEN
SELECT FirstName, LastName, ModifiedDate FROM SalesLT.Customer
WHERE ModifiedDate BETWEEN '2006-01-01' AND '2007-01-01';

SELECT * FROM SalesLT.Customer;

-- COUNT
SELECT COUNT(*) AS total_customer FROM SalesLT.Customer;

SELECT * FROM SalesLT.SalesOrderHeader;

-- SUM
SELECT SUM(TotalDue) AS total_ventas FROM SalesLT.SalesOrderHeader;

-- GROUP BY
SELECT ProductCategoryID AS category_id, COUNT(ProductCategoryID) AS total FROM SalesLT.Product
GROUP BY ProductCategoryID
ORDER BY total DESC;

-- JOIN
SELECT * FROM SalesLT.Product p
INNER JOIN SalesLT.ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID;

SELECT * FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
ON c.CustomerID = soh.CustomerID;

SELECT soh.SalesOrderID AS sales_order_id, c.FirstName AS customer_name FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
ON c.CustomerID = soh.CustomerID;

---------------------------------
-- EJERCICIOS DE PRACTICA 
---------------------------------
-- 1.- EJERCICIO

-- 1.1 TOTAL DE CLIENTES
SELECT COUNT(CustomerID) as total_clientes FROM SalesLT.Customer;

-- 1.2 TOTAL DE VENTAS EN MES DE OCTUBRE (USA VARIABLES)
SELECT * FROM SalesLT.SalesOrderDetail;
SELECT * FROM SalesLT.SalesOrderHeader;

SELECT MONTH(DueDate) AS mes FROM SalesLT.SalesOrderHeader;

-- OPCION POR FECHA
DECLARE @FECHA DATE = '2008-06-13';

SELECT SUM(TotalDue) total_ventas_por_mes FROM SalesLT.SalesOrderHeader
WHERE CAST(DueDate AS DATE) = @FECHA;

-- OPCION POR MES
DECLARE @MONTH INT = 6;

SELECT SUM(TotalDue) total_ventas_por_mes FROM SalesLT.SalesOrderHeader
WHERE MONTH(DueDate) = @MONTH;

-- 1.3 ORDENAR LAS CATEGORIAS POR NOMBRES
SELECT Name FROM SalesLT.ProductCategory
GROUP BY Name
ORDER BY Name;

-- 1.4 RELACIONE CABECERA Y DETALLE DE FACTURA
SELECT * FROM SalesLT.SalesOrderHeader;
SELECT * FROM SalesLT.SalesOrderDetail;

SELECT soh.SalesOrderID, soh.DueDate, sod.OrderQty, sod.ProductID, sod.UnitPrice, sod.UnitPriceDiscount, soh.SubTotal, soh.TotalDue FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.SalesOrderDetail sod
ON sod.SalesOrderID = soh.SalesOrderID;

-- 1.5 IMPLEMENTAR PAGINACION
DECLARE @PAGE_NUMBER INT = 3;
DECLARE @ROWS_PER_PAGE INT = 10;

SELECT * FROM SalesLT.ProductModel
ORDER BY Name
OFFSET (@PAGE_NUMBER - 1) * @ROWS_PER_PAGE ROWS
FETCH NEXT @ROWS_PER_PAGE ROW ONLY;