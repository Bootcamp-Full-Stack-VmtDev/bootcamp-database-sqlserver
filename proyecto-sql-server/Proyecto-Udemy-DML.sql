USE UdemyClon
GO

----------- Tabla Categoria -----------
INSERT INTO Categoria (Nombre, CategoriaPadreId)
VALUES
    ('Programación', NULL),
    ('Desarrollo Web', 1),
    ('Bases de Datos', 1),
    ('Seguridad Informática', 1),
    ('Inteligencia Artificial', 1),
    ('Frontend', 2),  -- Subcategoría de Desarrollo Web
    ('Backend', 2);   -- Subcategoría de Desarrollo Web

----------- Tabla Instructores -----------
INSERT INTO Instructores (Nombre, Email)
VALUES
    ('Carlos Pérez', 'carlos.perez@gmail.com'),
    ('Ana Sánchez', 'ana.sanchez@hotmail.com'),
    ('Javier Gómez', 'javier.gomez@outlook.com'),
    ('Laura Rodríguez', 'laura.rodriguez@yahoo.com'),
    ('Eduardo Díaz', 'eduardo.diaz@gmail.com');

----------- Tabla Estudiantes -----------
INSERT INTO Estudiantes (Nombre, Email)
VALUES
    ('Juan Martínez', 'juan.martinez@outlook.com'),
    ('Marta López', 'marta.lopez@gmail.com'),
    ('Andrés González', 'andres.gonzalez@hotmail.com'),
    ('Elena Ruiz', 'elena.ruiz@outlook.com'),
    ('Luis García', 'luis.garcia@gmail.com'),
    ('Paola Pérez', 'paola.perez@gmail.com'),
    ('Felipe Fernández', 'felipe.fernandez@hotmail.com'),
    ('María Rodríguez', 'maria.rodriguez@gmail.com'),
    ('Ricardo Torres', 'ricardo.torres@yahoo.com'),
    ('Valeria Martínez', 'valeria.martinez@outlook.com');

----------- Tabla TipoLeccion -----------
INSERT INTO TipoLeccion (Nombre)
VALUES
    ('Video'),
    ('Lectura'),
    ('Examen'),
    ('Práctica'),
    ('Foro');

----------- Tabla Cursos -----------
INSERT INTO Cursos (Titulo, Descripcion, Precio, Idioma, Nivel, CategoriaId)
VALUES
    ('Introducción a la Programación en Python', 'Curso básico de programación en Python.', 50.00, 'Español', 'Principiante', 1),
    ('Desarrollo Web con HTML y CSS', 'Curso para aprender a crear páginas web estáticas.', 60.00, 'Español', 'Principiante', 2),
    ('Bases de Datos con MySQL', 'Curso completo de bases de datos relacionales utilizando MySQL.', 70.00, 'Español', 'Intermedio', 3),
    ('Seguridad Informática: Fundamentos', 'Aprende las bases de la seguridad en informática.', 80.00, 'Español', 'Avanzado', 4),
    ('Introducción a la Inteligencia Artificial con Python', 'Curso para introducirte en la inteligencia artificial usando Python.', 90.00, 'Español', 'Intermedio', 5);

----------- Tabla CursoInstructor -----------
INSERT INTO CursoInstructor (CursoId, InstructorId)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

----------- Tabla Secciones -----------
INSERT INTO Secciones (CursoId, Titulo, Orden)
VALUES
    (1, 'Introducción a la Programación', 1),
    (1, 'Variables y Tipos de Datos', 2),
    (1, 'Condicionales y Bucles', 3),
    (1, 'Funciones y Librerías', 4),
    (2, 'Introducción al Desarrollo Web', 1),
    (2, 'HTML Básico', 2),
    (2, 'CSS y Diseño Web', 3),
    (2, 'JavaScript para Principiantes', 4),
    (3, 'Conceptos Básicos de Bases de Datos', 1),
    (3, 'Modelado Relacional', 2),
    (3, 'Consultas SQL', 3),
    (3, 'Optimización de Consultas', 4),
    (4, 'Conceptos de Seguridad Informática', 1),
    (4, 'Criptografía Básica', 2),
    (4, 'Hacking Ético', 3),
    (5, 'Introducción a la Inteligencia Artificial', 1),
    (5, 'Redes Neuronales Básicas', 2),
    (5, 'Aplicaciones de IA', 3);

----------- Tabla Lecciones -----------
INSERT INTO Lecciones (SeccionId, TipoLeccionId, Titulo, DuracionSegundos, Orden)
VALUES
    (1, 1, 'Qué es la Programación', 600, 1),
    (1, 1, 'Primer Programa en Python', 900, 2),
    (2, 2, 'Tipos de Datos en Python', 600, 1),
    (3, 3, 'Estructuras Condicionales', 1200, 1),
    (3, 3, 'Bucles en Python', 1500, 2),
    (4, 4, 'Uso de Funciones en Python', 1800, 1),
    (5, 1, 'Qué es HTML', 600, 1),
    (5, 1, 'Estructura de una Página Web', 800, 2),
    (6, 2, 'CSS Básico', 1000, 1),
    (7, 3, 'Primer Examen de Seguridad', 900, 1),
    (8, 2, 'Modelo Relacional de Bases de Datos', 1200, 1),
    (9, 4, 'Prácticas de SQL', 1800, 1),
    (10, 3, 'Introducción a Criptografía', 1500, 1),
    (11, 1, 'Redes Neuronales en IA', 1000, 1),
    (12, 5, 'Prácticas en Seguridad Informática', 1200, 1);

----------- Tabla Inscripciones -----------
INSERT INTO Inscripciones (EstudianteId, CursoId, PrecioPagado, CuponCodigo)
VALUES
    (1, 1, 50.00, NULL),
    (2, 2, 60.00, 'DESCUENTO10'),
    (3, 3, 70.00, NULL),
    (4, 4, 80.00, 'OFERTA20'),
    (5, 5, 90.00, NULL),
    (6, 1, 50.00, 'DESCUENTO10'),
    (7, 2, 60.00, NULL),
    (8, 3, 70.00, NULL),
    (9, 4, 80.00, NULL),
    (10, 5, 90.00, 'OFERTA20');

----------- Tabla Resenas -----------
INSERT INTO Resenas (EstudianteId, CursoId, Calificacion, Resena)
VALUES
    (1, 1, 5, 'Excelente curso para empezar en programación.'),
    (2, 2, 4, 'Buen curso, aunque el tema de CSS podría ser más profundo.'),
    (3, 3, 5, 'Muy completo, aprendí mucho sobre bases de datos.'),
    (4, 4, 4, 'Interesante, pero hay mucho contenido teórico.'),
    (5, 5, 5, 'Impresionante curso de Inteligencia Artificial, muy recomendable.');

----------- Tabla ListaDeseos -----------
INSERT INTO ListaDeseos (CursoId, EstudianteId)
VALUES
    (1, 6),
    (2, 7),
    (3, 8),
    (4, 9),
    (5, 10),
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

----------- Tabla Progreso -----------
INSERT INTO Progreso (EstudianteId, LeccionId)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);