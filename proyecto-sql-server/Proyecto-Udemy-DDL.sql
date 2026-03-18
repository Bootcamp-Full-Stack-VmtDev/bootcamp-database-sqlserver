CREATE DATABASE UdemyClon
GO
 
USE Udemyclon
GO

--------- Tabla Independiente-----------
-----DDL-----
CREATE TABLE Categoria (
    CategoriaId INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    CategoriaPadreId INT NULL,                           --Para la autoreferencia para las subcategorias
    CONSTRAINT FK_Categoria_Padre FOREIGN KEY (CategoriaPadreId) REFERENCES Categoria(CategoriaId)
);

CREATE TABLE Instructores (
    InstructorId INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    FechaRegistro DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE Estudiantes (
    EstudianteId INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    FechaRegistro DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE TipoLeccion (
    TipoLeccionId INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL
);

-----Tabla dependiente------
CREATE TABLE Cursos (
    CursoId INT PRIMARY KEY IDENTITY(1,1),
    Titulo NVARCHAR(250) NOT NULL,
    Descripcion NVARCHAR(250) NOT NULL,
	Precio DECIMAL(10,2) NOT NULL,
	Idioma NVARCHAR(50),
	Nivel NVARCHAR(50),                                     ---Nivel el usuario principiante, intermedio, avanazado
    CategoriaId INT NOT NULL,
	CONSTRAINT FK_Cursos_Categoria FOREIGN KEY (CategoriaId) REFERENCES Categoria(CategoriaId)
);

------Relacion entre N:M (Curso y Instructores)------
CREATE TABLE CursoInstructor(
    CursoId INT NOT NULL,
    InstructorId INT NOT NULL,
    PRIMARY KEY (CursoId, InstructorId),
    CONSTRAINT FK_CI_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId),
    CONSTRAINT FK_CI_Instructor FOREIGN KEY (InstructorId) REFERENCES Instructores(InstructorId)
)

CREATE TABLE Secciones (
    SeccionId INT PRIMARY KEY IDENTITY(1,1),
    CursoId INT NOT NULL,
    Titulo NVARCHAR(255) NOT NULL,
    Orden INT NOT NULL, -- Para el orden de cada seccion
    CONSTRAINT FK_Secciones_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId)
);

CREATE TABLE Lecciones (
    LeccionId INT PRIMARY KEY IDENTITY(1,1),
    SeccionId INT NOT NULL,
    TipoLeccionId INT NOT NULL,
    Titulo NVARCHAR(255) NOT NULL,
    DuracionSegundos INT NOT NULL,
    Orden INT NOT NULL,
    CONSTRAINT FK_Lecciones_Seccion FOREIGN KEY (SeccionId) REFERENCES Secciones(SeccionId),
    CONSTRAINT FK_Lecciones_Tipo FOREIGN KEY (TipoLeccionId) REFERENCES TipoLeccion(TipoLeccionId)
);

CREATE TABLE Inscripciones (
    InscripcionId INT PRIMARY KEY IDENTITY(1,1),
    EstudianteId INT NOT NULL,
    CursoId INT NOT NULL,
    FechaInscripcion DATETIME2 DEFAULT SYSUTCDATETIME(),
    PrecioPagado DECIMAL(10,2) NOT NULL,                                  --Recibe el precio al momento de obtener el curso 
    CuponCodigo NVARCHAR(20) NULL,
    CONSTRAINT UC_Estudiante_Curso UNIQUE (EstudianteId, CursoId),        -- No se permite una inscripcion doble
    CONSTRAINT FK_Inscrip_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId),
    CONSTRAINT FK_Inscrip_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId)
);

CREATE TABLE Resenas (
    EstudianteId INT NOT NULL,
    CursoId INT NOT NULL,
    Calificacion INT CHECK (Calificacion BETWEEN 1 AND 5),            --califiacion de cada curso de 1 al 5
    Resena NVARCHAR(250) NOT NULL,
    Fecha DATETIME2 DEFAULT SYSUTCDATETIME(),
    PRIMARY KEY (EstudianteId, CursoId),                              --solo permite una reseña por curso
    CONSTRAINT FK_Resena_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId),
    CONSTRAINT FK_Resena_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId)
);

CREATE TABLE ListaDeseos (
    CursoId INT NOT NULL, 
    EstudianteId INT NOT NULL,
    PRIMARY KEY (CursoId, EstudianteId),
    CONSTRAINT FK_Wish_Curso FOREIGN KEY (CursoId) REFERENCES Cursos(CursoId),
    CONSTRAINT FK_Wish_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId)
);

CREATE TABLE Progreso (
    EstudianteId INT NOT NULL,
    LeccionId INT NOT NULL,
    FechaTerminada DATETIME2 DEFAULT SYSUTCDATETIME(),
    PRIMARY KEY (EstudianteId, LeccionId),
    CONSTRAINT FK_Prog_Estudiante FOREIGN KEY (EstudianteId) REFERENCES Estudiantes(EstudianteId),
    CONSTRAINT FK_Prog_Leccion FOREIGN KEY (LeccionId) REFERENCES Lecciones(LeccionId)
);
