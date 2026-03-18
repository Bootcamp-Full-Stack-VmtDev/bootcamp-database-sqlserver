-- ========================================
-- Crear la base de datos
-- ========================================
CREATE DATABASE ClonDiscord;
GO

USE ClonDiscord;
GO

-- ========================================
-- Tabla Roles
-- ========================================
CREATE TABLE Roles (
    RoleId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    Code NVARCHAR(10) NOT NULL,
    ShowName NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- ========================================
-- Tabla UserStatusType
-- ========================================
CREATE TABLE UserStatusType (
    UserStatusTypeId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    Code NVARCHAR(12) NOT NULL,
    ShowName NVARCHAR(12) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- Insertar valores iniciales para los tipos de estado de usuario
INSERT INTO UserStatusType (Code, ShowName)
VALUES 
    ('online', 'En línea'),
    ('not_disturb', 'No molestar'),
    ('idle', 'Ausente'),
    ('ghost', 'Invisible');
GO

-- ========================================
-- Tabla Users
-- ========================================
CREATE TABLE Users (
    UserId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    UserName NVARCHAR(32) NOT NULL,
    DisplayName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL,
    StatusType INT NOT NULL DEFAULT 1 REFERENCES UserStatusType(UserStatusTypeId),
    StatusTime INT NULL,
    StatusContent NVARCHAR(50) NULL DEFAULT ('Hi, there!'),
    AvatarURL NVARCHAR(255) NULL,
    BannerURL NVARCHAR(255) NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- ========================================
-- Tabla Collections
-- ========================================
CREATE TABLE Collections (
    CollectionId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(100) NOT NULL DEFAULT('This is my collection!'),
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    DeleteAt DATETIME2 NULL
);
GO

-- ========================================
-- Tabla Items
-- ========================================
CREATE TABLE Items (
    ItemId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- Insertar items iniciales
INSERT INTO Items (Name)
VALUES 
    ('Hollow Knight'),
    ('osu');
GO

-- ========================================
-- Tabla intermedia CollectionsItems
-- ========================================
CREATE TABLE CollectionsItems (
    CollectionId UNIQUEIDENTIFIER NOT NULL REFERENCES Collections(CollectionId),
    ItemId INT NOT NULL REFERENCES Items(ItemId) ON DELETE CASCADE,
    CONSTRAINT PK_CollectionsItem_CollectionId_ItemId PRIMARY KEY (CollectionId, ItemId)
);
GO

-- Insertar colección inicial
INSERT INTO Collections (Name, Description)
VALUES
    ('Mis juegos', 'Juegos');
GO

-- ========================================
-- Consultas de prueba
-- ========================================

-- Seleccionar colecciones no eliminadas
SELECT * FROM Collections
WHERE DeleteAt IS NULL;
GO

-- Seleccionar todos los items
SELECT * FROM Items;
GO

-- Seleccionar todas las colecciones
SELECT * FROM Collections;
GO

-- Insertar items en la colección "Mis juegos"
DECLARE @CollectionId UNIQUEIDENTIFIER = '8AAB54EA-FD80-4CE7-8B9B-FC2F8F3441BF'; -- Cambiar según GUID real
DECLARE @ItemHollowKnightId INT = (SELECT ItemId FROM Items WHERE Name = 'Hollow Knight');
DECLARE @ItemOsuId INT = (SELECT ItemId FROM Items WHERE Name = 'osu');

INSERT INTO CollectionsItems (CollectionId, ItemId)
VALUES
    (@CollectionId, @ItemOsuId),
    (@CollectionId, @ItemHollowKnightId);
GO

-- Consultar items
SELECT * FROM Items;
GO

-- Buscar un item específico
DECLARE @ItemABuscar NVARCHAR(50) = 'Hollow Knight';
SELECT * FROM Items
WHERE Name = @ItemABuscar;
GO

-- ========================================
-- Índices
-- ========================================
CREATE INDEX IX_Items_Name ON Items (Name);
GO