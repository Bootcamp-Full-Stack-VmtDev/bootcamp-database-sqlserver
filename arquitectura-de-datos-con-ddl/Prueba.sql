CREATE DATABASE Prueba;
GO

USE Prueba;
GO

CREATE TABLE Roles (
	RoleId INT IDENTITY(1, 1) NOT NULL,
	Code NVARCHAR(10) NOT NULL,
	ShowName NVARCHAR(100) NOT NULL,
	CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE UserStatusType (
	UserStatusTypeId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Code NVARCHAR(12) NOT NULL,
	ShowName NVARCHAR(12) NOT NULL,
	CreateAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

INSERT INTO UserStatusType (Code, ShowName)
VALUES ('online', 'En línea'),
('not_disturb', 'No molestar'),
('idle', 'Ausente'),
('ghost', 'Invisible')
;
GO

CREATE TABLE Users (
	UserId UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	UserName NVARCHAR(32) NOT NULL,
	DisplayName NVARCHAR(100) NOT NULL,
	Description NVARCHAR(255) NULL,
	StatusType INT NOT NULL REFERENCES UserStatusType(UserStatusTypeId) DEFAULT (1),
	StatusTime INT NULL,
	StatusContent NVARCHAR(50) NULL DEFAULT ('Hi, there!'),
	AvatarURL NVARCHAR(255),
	BannerUrl NVARCHAR(255),
	-- RoleId INT NOT NULL REFERENCES Roles (RoleId),
	CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
	-- CONSTRAINT FK_Roles_RoleId FOREIGN KEY (RoleId) REFERENCES Roles (RoleId)
);
GO

CREATE TABLE Collections (
	CollectionId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(100) NOT NULL DEFAULT('This is my collection!'),
	CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
	DeleteAt DATETIME2,
);
GO

CREATE TABLE Items (
	ItemId INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL UNIQUE,
	CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

INSERT INTO Items (Name)
VALUES 
('Hollow Knight'),
('osu');
GO

CREATE TABLE CollectionsItems (
	CollectionId UNIQUEIDENTIFIER NOT NULL REFERENCES Collections (CollectionId),
	ItemId INT NOT NULL REFERENCES Items (ItemId) ON DELETE CASCADE,
	CONSTRAINT PK_CollectionsItem_CollectionId_ItemId PRIMARY KEY (CollectionId, ItemId)
);
GO

INSERT INTO Collections (Name, Description)
VALUES
('Mis juegos', 'Juegos');
GO

SELECT * FROM Collections
WHERE DeleteAt IS NULL;
GO

SELECT * FROM Items;

SELECT * FROM Collections;

DECLARE @CollectionId UNIQUEIDENTIFIER = '8AAB54EA-FD80-4CE7-8B9B-FC2F8F3441BF'
DECLARE @ItemHollowKnightId INT = (SELECT ItemId FROM Items WHERE ItemId = 1);
DECLARE @ItemOsuId INT = (SELECT ItemId FROM Items WHERE ItemId = 2);

INSERT INTO CollectionsItems (CollectionId, ItemId)
VALUES
(@CollectionId, @ItemOsuId)
GO

SELECT * FROM Items;

SELECT * FROM Items
WHERE Name IN ('Hollow Knight', 'osu');
GO

DECLARE @ItemABuscar NVARCHAR(50) = 'Hollow Knight'

SELECT * FROM Items
WHERE Name = @ItemABuscar

CREATE INDEX IX_Items_Name ON Items (Name)