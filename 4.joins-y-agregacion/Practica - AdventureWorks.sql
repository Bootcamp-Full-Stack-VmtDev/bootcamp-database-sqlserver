USE AdventureWorksLT2022;
GO
-- ========================================
-- EJERCICIOS DE PRÁCTICA
-- ========================================

-- 1.1 Total de clientes
SELECT COUNT(CustomerID) AS total_clientes FROM SalesLT.Customer;
GO

-- 1.2 Total de ventas por fecha específica
DECLARE @FECHA DATE = '2008-06-13';
SELECT SUM(TotalDue) AS total_ventas_por_mes FROM SalesLT.SalesOrderHeader
WHERE CAST(DueDate AS DATE) = @FECHA;
GO

-- 1.2 Total de ventas por mes
DECLARE @MONTH INT = 6;
SELECT SUM(TotalDue) AS total_ventas_por_mes FROM SalesLT.SalesOrderHeader
WHERE MONTH(DueDate) = @MONTH;
GO

-- 1.3 Ordenar categorías por nombre
SELECT Name FROM SalesLT.ProductCategory
GROUP BY Name
ORDER BY Name;
GO

-- 1.4 Relacionar cabecera y detalle de facturas
SELECT soh.SalesOrderID, soh.DueDate, sod.OrderQty, sod.ProductID, 
       sod.UnitPrice, sod.UnitPriceDiscount, soh.SubTotal, soh.TotalDue
FROM SalesLT.SalesOrderHeader soh
INNER JOIN SalesLT.SalesOrderDetail sod
ON sod.SalesOrderID = soh.SalesOrderID;
GO

-- 1.5 Paginación de modelos de productos
DECLARE @PAGE_NUMBER_MODEL INT = 3;
DECLARE @ROWS_PER_PAGE_MODEL INT = 10;

SELECT * FROM SalesLT.ProductModel
ORDER BY Name
OFFSET (@PAGE_NUMBER_MODEL - 1) * @ROWS_PER_PAGE_MODEL ROWS
FETCH NEXT @ROWS_PER_PAGE_MODEL ROWS ONLY;
GO