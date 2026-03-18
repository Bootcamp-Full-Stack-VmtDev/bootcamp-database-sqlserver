USE AdventureWorksLT2022;
GO

-- ========================================
-- CONSULTAS SOBRE PRODUCTOS
-- ========================================

-- Seleccionar los primeros 1000 productos
SELECT TOP (1000) 
      ProductID,
      Name,
      ProductNumber,
      Color,
      StandardCost,
      ListPrice,
      Size,
      Weight,
      ProductCategoryID,
      ProductModelID,
      SellStartDate,
      SellEndDate,
      DiscontinuedDate,
      ThumbNailPhoto,
      ThumbnailPhotoFileName,
      rowguid,
      ModifiedDate
FROM SalesLT.Product;
GO

-- Seleccionar todos los colores únicos de productos
SELECT DISTINCT Color AS product_color FROM SalesLT.Product
WHERE Color IS NOT NULL;
GO

-- ========================================
-- PAGINACIÓN DE COLORES
-- ========================================

DECLARE @PAGE_NUMBER INT = 1;
DECLARE @ROWS_PER_PAGE INT = 10;

SELECT DISTINCT Color AS product_color FROM SalesLT.Product
WHERE Color IS NOT NULL
ORDER BY Color
OFFSET (@PAGE_NUMBER - 1) * @ROWS_PER_PAGE ROWS
FETCH NEXT @ROWS_PER_PAGE ROWS ONLY;
GO

-- Ejemplo de página 2 con 3 filas por página
DECLARE @PAGE_NUMBER2 INT = 2;
DECLARE @ROWS_PER_PAGE2 INT = 3;

SELECT DISTINCT Color AS product_color FROM SalesLT.Product
WHERE Color IS NOT NULL
ORDER BY Color
OFFSET (@PAGE_NUMBER2 - 1) * @ROWS_PER_PAGE2 ROWS
FETCH NEXT @ROWS_PER_PAGE2 ROWS ONLY;
GO

-- Paginación para clientes
DECLARE @PAGE_NUMBER_CUSTOMER INT = 3;
DECLARE @ROWS_PER_PAGE_CUSTOMER INT = 10;

SELECT * FROM SalesLT.Customer
ORDER BY CustomerID
OFFSET (@PAGE_NUMBER_CUSTOMER - 1) * @ROWS_PER_PAGE_CUSTOMER ROWS
FETCH NEXT @ROWS_PER_PAGE_CUSTOMER ROWS ONLY;
GO

-- ========================================
-- CONSULTAS DE PRÁCTICA
-- ========================================

-- Todas las categorías de producto
SELECT * FROM SalesLT.ProductCategory;
GO

-- Paginación de categorías
DECLARE @PAGE_NUMBER_CATEGORY INT = 3;
DECLARE @ROWS_PER_PAGE_CATEGORY INT = 10;

SELECT * FROM SalesLT.ProductCategory
ORDER BY Name
OFFSET (@PAGE_NUMBER_CATEGORY - 1) * @ROWS_PER_PAGE_CATEGORY ROWS
FETCH NEXT @ROWS_PER_PAGE_CATEGORY ROWS ONLY;
GO

-- ========================================
-- FILTROS Y BÚSQUEDAS
-- ========================================

-- Buscar clientes con nombre que contenga 'Rob'
SELECT * FROM SalesLT.Customer
WHERE FirstName LIKE '%Rob%';
GO

-- Buscar clientes con nombre exacto 'Robert'
SELECT * FROM SalesLT.Customer
WHERE FirstName = 'Robert';
GO

-- Selección por rango de fechas
SELECT FirstName, LastName, ModifiedDate FROM SalesLT.Customer
WHERE ModifiedDate BETWEEN '2006-01-01' AND '2007-01-01';
GO

-- ========================================
-- AGREGACIONES
-- ========================================

-- Contar total de clientes
SELECT COUNT(*) AS total_customer FROM SalesLT.Customer;
GO

-- Suma total de ventas
SELECT SUM(TotalDue) AS total_ventas FROM SalesLT.SalesOrderHeader;
GO

-- Total de productos por categoría
SELECT ProductCategoryID AS category_id, COUNT(*) AS total
FROM SalesLT.Product
GROUP BY ProductCategoryID
ORDER BY total DESC;
GO

-- ========================================
-- JOINs ENTRE TABLAS
-- ========================================

-- Productos con sus categorías
SELECT p.*, pc.Name AS CategoryName FROM SalesLT.Product p
INNER JOIN SalesLT.ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID;
GO

-- Ventas con información del cliente
SELECT soh.SalesOrderID AS sales_order_id, c.FirstName AS customer_name FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.Customer c
ON c.CustomerID = soh.CustomerID;
GO