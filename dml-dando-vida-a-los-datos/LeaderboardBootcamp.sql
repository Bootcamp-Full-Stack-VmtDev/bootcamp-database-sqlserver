CREATE DATABASE LeaderboardBootcamp;
GO

USE LeaderboardBootcamp;
GO

-- DDL

-- ============================================================
--  TABLA: UsuarioTipos
-- ============================================================
CREATE TABLE UsuarioTipos (
	UsuarioTipoId	INT IDENTITY(1,1) NOT NULL,
	Descripcion		NVARCHAR(20) NOT NULL,
	CreateAt		DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

	CONSTRAINT PK_UsuarioTipo PRIMARY KEY (UsuarioTipoId)
);
GO

-- ============================================================
--  TABLA: ModuloTipos
-- ============================================================
CREATE TABLE ModuloTipos (
	ModuloTipoId	INT IDENTITY(1,1) NOT NULL,
	Especificidad	NVARCHAR(100) NOT NULL,
	Tecnologia		NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_ModuloTipo PRIMARY KEY (ModuloTipoId),
	-- CONSTRAINT CK_ModuloTipo_Especificidad CHECK (Especificidad IN ('Engine', 'Framework')),
	-- CONSTRAINT CK_ModuloTipo_Tecnologia CHECK (Tecnologia IN ('NodeJS', 'Angular', 'SQL Server', '.NET'))
);
GO

-- ============================================================
--  TABLA: Usuarios
-- ============================================================
CREATE TABLE Usuarios (
	UsuarioId		UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	TipoId			INT NOT NULL,
	Nombre			NVARCHAR(100) NOT NULL,
	Edad			INT NOT NULL,
	Correo			NVARCHAR(100) NOT NULL,
	NumeroTelefono	NVARCHAR(32) NOT NULL,
	Cedula			NVARCHAR(10) NOT NULL,
	CreatedAt		DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

	CONSTRAINT UQ_Usuario_Cedula UNIQUE (Cedula),

	CONSTRAINT PK_Usuario PRIMARY KEY (UsuarioId),
	CONSTRAINT FK_Usuario_UsuarioTipo FOREIGN KEY (TipoId) REFERENCES UsuarioTipos (UsuarioTipoId)
);
GO

-- ============================================================
--  TABLA: Modulos
-- ============================================================
CREATE TABLE Modulos (
	ModuloId	INT IDENTITY(1,1) NOT NULL,
	ProfesorId	UNIQUEIDENTIFIER NOT NULL,
	TipoId		INT NOT NULL,
	CreatedAt	DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
	
	CONSTRAINT PK_Modulo PRIMARY KEY (ModuloId),
	CONSTRAINT FK_Modulo_Usuario FOREIGN KEY (ProfesorId) REFERENCES Usuarios (UsuarioId),
	CONSTRAINT FK_Modulo_ModuloTipo FOREIGN KEY (TipoId) REFERENCES ModuloTipos (ModuloTipoId)
);
GO

-- ============================================================
--  TABLA: Participaciones
-- ============================================================
CREATE TABLE Participaciones (
	ParticipacionId	INT IDENTITY(1,1) NOT NULL,
	EstudianteId	UNIQUEIDENTIFIER NOT NULL,
	ModuloId		INT NOT NULL,
	Puntos			DECIMAL NOT NULL,
	CreatedAt		DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

	CONSTRAINT PK_Participaciones PRIMARY KEY (ParticipacionId),
	CONSTRAINT FK_Participaciones_Usuario FOREIGN KEY (EstudianteId) REFERENCES Usuarios (UsuarioId),
	CONSTRAINT FK_Participaciones_Modulo FOREIGN KEY (ModuloId) REFERENCES Modulos (ModuloId)
);
GO*/

-- DML

-- ============================================================
--  TABLA: UsuarioTipos
-- ============================================================
INSERT INTO UsuarioTipos (Descripcion)
VALUES
('Profesor'),
('Estdiante');
GO

-- ============================================================
--  TABLA: ModuloTipos
-- ============================================================
INSERT INTO ModuloTipos (Especificidad, Tecnologia)
VALUES
('Motor de base de datos', 'SQL Server'),
('Framework', 'Angular'),
('Framework', '.NET'),
('Entorno de Ejecucion', 'NodeJS');
GO

-- ============================================================
--  TABLA: Usuarios
-- ============================================================

DELETE FROM Usuarios;

DECLARE @JohnDoeUsuarioId UNIQUEIDENTIFIER = NEWID();
DECLARE @JohnDoeSegundoUsuarioId UNIQUEIDENTIFIER = NEWID();
DECLARE @JohnDoeTerceroUsuarioId UNIQUEIDENTIFIER = NEWID();

INSERT INTO Usuarios (UsuarioId, TipoId, Nombre, Edad, Correo, NumeroTelefono, Cedula)
VALUES
(@JohnDoeUsuarioId, 1, 'John Doe', 78, 'john1@doe.com', '01234745471', '0925413671'),
(@JohnDoeSegundoUsuarioId, 1, 'John Doe', 78, 'john2@doe.com', '01234745471', '0925483671'),
(@JohnDoeTerceroUsuarioId, 1, 'John Doe', 78, 'john3@doe.com', '01234745471', '0925493671');

-- ============================================================
--  TABLA: Modulos
-- ============================================================
DECLARE @SQLServerModuloTipo INT = (SELECT ModuloTipoId FROM ModuloTipos WHERE Tecnologia = 'SQL Server');
DECLARE @AngularModuloTipo INT = (SELECT ModuloTipoId FROM ModuloTipos WHERE Tecnologia = 'Angular');
DECLARE @DotNetModuloTipo INT = (SELECT ModuloTipoId FROM ModuloTipos WHERE Tecnologia = '.NET');
DECLARE @NodeJSModuloTipo INT = (SELECT ModuloTipoId FROM ModuloTipos WHERE Tecnologia = 'NodeJS');

INSERT INTO Modulos (TipoId, ProfesorId)
VALUES
(@SQLServerModuloTipo, @JohnDoeUsuarioId),
(@DotNetModuloTipo, @JohnDoeUsuarioId),
(@AngularModuloTipo, @JohnDoeSegundoUsuarioId),
(@NodeJSModuloTipo, @JohnDoeTerceroUsuarioId);

SELECT * FROM Modulos;

-- ============================================================
--  TABLA: Participaciones
-- ============================================================



-- RESTRICCIONES

ALTER TABLE Usuarios
ADD CONSTRAINT UQ_Usuario_Correo UNIQUE (Correo);
GO

SELECT * FROM Usuarios;

UPDATE Usuarios
SET Correo = 'john3@doe.com', NumeroTelefono = '0215417458'
WHERE UsuarioId = '1FFDE986-3B47-427A-950C-FDA38907475B';
GO

ALTER TABLE Usuarios
ADD CONSTRAINT UQ_Usuario_NumeroTelefono UNIQUE (NumeroTelefono);
GO
