CREATE DATABASE UdemyDatabase;

USE UdemyDatabase;

--------------------------------------------------------
-- DDL
-------------------------------------------------------

-- Tabla Categoría
CREATE TABLE Categoria (
    IdCategoria INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria VARCHAR(100) NOT NULL
);
GO

-- Tabla Instructor
CREATE TABLE Instructor (
    IdInstructor INT PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(100) NOT NULL,
    Ganancias DECIMAL(10,2) NOT NULL,
    CreatedAt DATETIME NOT NULL
);
GO

-- Tabla Estudiante
CREATE TABLE Estudiante (
    IdEstudiante INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Fecha DATE NOT NULL,
    Calificaciones VARCHAR(500),
    CreatedAt DATETIME NOT NULL
);
GO

-- Tabla Subcategoría
CREATE TABLE Subcategoria (
    IdSubcategoria INT PRIMARY KEY IDENTITY(1,1),
    IdCategoria INT NOT NULL,
    NombreSubcategoria VARCHAR(100) NOT NULL,
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);
GO

-- Tabla CursoInstructor
CREATE TABLE CursoInstructor (
    IdCursoInstructor INT PRIMARY KEY IDENTITY(1,1),
    IdInstructor INT NOT NULL,
    IdCurso INT NOT NULL,
    FOREIGN KEY (IdInstructor) REFERENCES Instructor(IdInstructor)
);
GO

-- Tabla ListaDeseo
CREATE TABLE ListaDeseo (
    IdListaDeseo INT PRIMARY KEY IDENTITY(1,1),
    IdCurso INT NOT NULL,
    IdEstudiante INT NOT NULL,
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso),
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante)
);
GO

-- Tabla Reseñas
CREATE TABLE Reseñas (
    IdReseña INT PRIMARY KEY IDENTITY(1,1),
    IdEstudiante INT NOT NULL,
    IdCurso INT NOT NULL,
    Calificacion INT NOT NULL,
    Comentario TEXT,
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
);
GO

-- Tabla Cursos
CREATE TABLE Cursos (
    IdCurso INT PRIMARY KEY IDENTITY(1,1),
    IdSubcategoria INT NOT NULL,
    IdSeccion INT NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10,2) NOT NULL,
    Idioma VARCHAR(50),
    Nivel VARCHAR(50),
    FOREIGN KEY (IdSubcategoria) REFERENCES Subcategoria(IdSubcategoria)
);
GO

-- Tabla CursoEstudiante
CREATE TABLE CursoEstudiante (
    IdCursoEstudiante INT PRIMARY KEY IDENTITY(1,1),
    IdEstudiante INT NOT NULL,
    IdCurso INT NOT NULL,
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
);
GO

-- Tabla Inscripciones
CREATE TABLE Inscripciones (
    IdInscripciones INT PRIMARY KEY IDENTITY(1,1),
    FechaInscripcion DATE NOT NULL,
    PrecioPagado DECIMAL(10,2) NOT NULL,
    IdEstudiante INT NOT NULL,
    IdCurso INT NOT NULL,
    Cupon VARCHAR(50),
    Descuento DECIMAL(5,2),
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante),
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
);
GO

-- Tabla Secciones
CREATE TABLE Secciones (
    IdSeccion INT PRIMARY KEY IDENTITY(1,1),
    IdCurso INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso)
);
GO

-- Tabla Lecciones
CREATE TABLE Lecciones (
    IdLeccion INT PRIMARY KEY IDENTITY(1,1),
    IdSeccion INT NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Duracion INT NOT NULL,  -- duración en minutos
    FOREIGN KEY (IdSeccion) REFERENCES Secciones(IdSeccion)
);
GO

-- Tabla Progreso
CREATE TABLE Progreso (
    IdProgreso INT PRIMARY KEY IDENTITY(1,1),
    IdLeccion INT NOT NULL,
    Completada BIT NOT NULL, -- 0: No completada, 1: Completada
    FechaTerminado DATETIME,
    FOREIGN KEY (IdLeccion) REFERENCES Lecciones(IdLeccion)
);
GO

-- Tabla TipoLeccion
CREATE TABLE TipoLeccion (
    IdTipoLeccion INT PRIMARY KEY IDENTITY(1,1),
    Tipo VARCHAR(50) NOT NULL
);
GO

-- DML

-- Insertar en Categoría
INSERT INTO Categoria (NombreCategoria)
VALUES ('Programación'), ('Diseño Gráfico'), ('Marketing Digital');

-- Insertar en Instructor
INSERT INTO Instructor (Email, Ganancias, CreatedAt)
VALUES ('juan@dominio.com', 1200.50, GETDATE()), 
       ('maria@dominio.com', 1500.75, GETDATE());

-- Insertar en Estudiante
INSERT INTO Estudiante (Nombre, Email, Fecha, Calificaciones, CreatedAt)
VALUES ('Carlos Perez', 'carlos@dominio.com', '2023-05-10', 'A,B', GETDATE()),
       ('Ana Gomez', 'ana@dominio.com', '2023-06-14', 'B,A', GETDATE());

-- Insertar en Subcategoría
INSERT INTO Subcategoria (IdCategoria, NombreSubcategoria)
VALUES (1, 'Desarrollo Web'), 
       (2, 'Photoshop'), 
       (3, 'Publicidad en Google');

-- Insertar en Cursos
INSERT INTO Cursos (IdSubcategoria, IdSeccion, Titulo, Descripcion, Precio, Idioma, Nivel)
VALUES (1, 1, 'Curso de Frontend', 'Curso de desarrollo web con HTML, CSS, y JavaScript', 150.00, 'Español', 'Intermedio'),
       (2, 2, 'Photoshop Básico', 'Curso de diseño gráfico usando Photoshop', 120.00, 'Español', 'Básico');