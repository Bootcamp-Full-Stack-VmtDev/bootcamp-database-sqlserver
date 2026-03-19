CREATE DATABASE UdemyClon;
GO

USE UdemyClon;
GO
-- ========================================
-- TABLA: Categoria
-- ========================================
CREATE TABLE Categoria (
    CategoriaId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Nombre NVARCHAR(100) NOT NULL,
    CategoriaPadreId UNIQUEIDENTIFIER NULL, -- FK a sí misma para subcategorías (autoreferencia)
    CONSTRAINT FK_Categoria_Padre FOREIGN KEY (CategoriaPadreId) REFERENCES Categoria(CategoriaId)
);
GO

-- ========================================
-- TABLA: Instructores
-- ========================================
CREATE TABLE Instructores (
    InstructorId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    FechaRegistro DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- ========================================
-- TABLA: Estudiantes
-- ========================================
CREATE TABLE Estudiantes (
    EstudianteId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    FechaRegistro DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- ========================================
-- TABLA: TipoLeccion
-- ========================================
CREATE TABLE TipoLeccion (
    TipoLeccionId INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL
);
GO

-- ========================================
-- TABLA: Cursos
-- ========================================
CREATE TABLE Cursos (
    CursoId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Titulo NVARCHAR(250) NOT NULL,
    Descripcion NVARCHAR(250) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Idioma NVARCHAR(50),
    Nivel NVARCHAR(50),
    CategoriaId UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_Cursos_Categoria FOREIGN KEY (CategoriaId) REFERENCES Categoria(CategoriaId)
);
GO

-- ========================================
-- TABLA N:M: CursoInstructor
-- ========================================
CREATE TABLE CursoInstructor(
    CursoId UNIQUEIDENTIFIER NOT NULL,
    InstructorId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (CursoId, InstructorId),
    CONSTRAINT FK_CI_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId),
    CONSTRAINT FK_CI_Instructor FOREIGN KEY (InstructorId) REFERENCES Instructores(InstructorId)
);
GO

-- ========================================
-- TABLA: Secciones
-- ========================================
CREATE TABLE Secciones (
    SeccionId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CursoId UNIQUEIDENTIFIER NOT NULL,
    Titulo NVARCHAR(255) NOT NULL,
    Orden INT NOT NULL,
    CONSTRAINT FK_Secciones_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId)
);
GO

-- ========================================
-- TABLA: Lecciones
-- ========================================
CREATE TABLE Lecciones (
    LeccionId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    SeccionId UNIQUEIDENTIFIER NOT NULL,
    TipoLeccionId INT NOT NULL,
    Titulo NVARCHAR(255) NOT NULL,
    DuracionSegundos DECIMAL(10,2) NOT NULL,
    Orden INT NOT NULL,
    CONSTRAINT FK_Lecciones_Seccion FOREIGN KEY (SeccionId) REFERENCES Secciones(SeccionId),
    CONSTRAINT FK_Lecciones_Tipo FOREIGN KEY (TipoLeccionId) REFERENCES TipoLeccion(TipoLeccionId)
);
GO

-- ========================================
-- TABLA N:M: Inscripciones
-- ========================================
CREATE TABLE Inscripciones (
    InscripcionId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    EstudianteId UNIQUEIDENTIFIER NOT NULL,
    CursoId UNIQUEIDENTIFIER NOT NULL,
    FechaInscripcion DATETIME2 DEFAULT SYSUTCDATETIME(),
    PrecioPagado DECIMAL(10,2) NOT NULL,
    CuponCodigo NVARCHAR(20) NULL,
    -- PK compuesta: evitar inscripciones duplicadas
    CONSTRAINT UC_Estudiante_Curso UNIQUE (EstudianteId, CursoId),
    CONSTRAINT FK_Inscrip_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId),
    CONSTRAINT FK_Inscrip_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId)
);
GO

-- ========================================
-- TABLA: Resenas
-- ========================================
CREATE TABLE Resenas (
    EstudianteId UNIQUEIDENTIFIER NOT NULL,
    CursoId UNIQUEIDENTIFIER NOT NULL,
    Calificacion INT CHECK (Calificacion BETWEEN 1 AND 5),
    Resena NVARCHAR(250) NOT NULL,
    Fecha DATETIME2 DEFAULT SYSUTCDATETIME(),
    -- PK compuesta: dar solo una reseña por estudiante a curso
    PRIMARY KEY (EstudianteId, CursoId),
    CONSTRAINT FK_Resena_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId),
    CONSTRAINT FK_Resena_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId)
);
GO

-- ========================================
-- TABLA N:M: ListaDeseos
-- ========================================
CREATE TABLE ListaDeseos (
    CursoId UNIQUEIDENTIFIER NOT NULL,
    EstudianteId UNIQUEIDENTIFIER NOT NULL,
    -- PK compuesta: evitar duplicados en lista de deseos
    PRIMARY KEY (CursoId, EstudianteId),
    CONSTRAINT FK_Wish_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId),
    CONSTRAINT FK_Wish_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId)
);
GO

-- ========================================
-- TABLA N:M: Progreso
-- ========================================
CREATE TABLE Progreso (
    EstudianteId UNIQUEIDENTIFIER NOT NULL,
    LeccionId UNIQUEIDENTIFIER NOT NULL,
    FechaTerminada DATETIME2 DEFAULT SYSUTCDATETIME(),
    -- PK compuesta: evitar progreso duplicado
    PRIMARY KEY (EstudianteId, LeccionId),
    CONSTRAINT FK_Prog_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId),
    CONSTRAINT FK_Prog_Leccion FOREIGN KEY (LeccionId) REFERENCES Lecciones(LeccionId)
);
GO