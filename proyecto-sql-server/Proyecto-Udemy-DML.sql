USE UdemyClon;
GO

-- ========================================
-- INSERT: Categorías con autoreferencia
-- ========================================
DECLARE 
    @CatProgramacion UNIQUEIDENTIFIER = NEWID(),
    @CatWeb UNIQUEIDENTIFIER = NEWID(),
    @CatBD UNIQUEIDENTIFIER = NEWID(),
    @CatSeguridad UNIQUEIDENTIFIER = NEWID(),
    @CatIA UNIQUEIDENTIFIER = NEWID(),
    @CatFrontend UNIQUEIDENTIFIER = NEWID(),
    @CatBackend UNIQUEIDENTIFIER = NEWID();

INSERT INTO Categoria (CategoriaId, Nombre, CategoriaPadreId)
VALUES
    (@CatProgramacion, 'Programación', NULL),
    (@CatWeb, 'Desarrollo Web', @CatProgramacion),
    (@CatBD, 'Bases de Datos', @CatProgramacion),
    (@CatSeguridad, 'Seguridad Informática', @CatProgramacion),
    (@CatIA, 'Inteligencia Artificial', @CatProgramacion),
    (@CatFrontend, 'Frontend', @CatWeb),
    (@CatBackend, 'Backend', @CatWeb);

-- ========================================
-- INSERT: Instructores
-- ========================================
DECLARE 
    @InsCarlos UNIQUEIDENTIFIER = NEWID(),
    @InsAna UNIQUEIDENTIFIER = NEWID(),
    @InsJavier UNIQUEIDENTIFIER = NEWID(),
    @InsLaura UNIQUEIDENTIFIER = NEWID(),
    @InsEduardo UNIQUEIDENTIFIER = NEWID();

INSERT INTO Instructores (InstructorId, Nombre, Email)
VALUES
    (@InsCarlos, 'Carlos Pérez', 'carlos.perez@gmail.com'),
    (@InsAna, 'Ana Sánchez', 'ana.sanchez@hotmail.com'),
    (@InsJavier, 'Javier Gómez', 'javier.gomez@outlook.com'),
    (@InsLaura, 'Laura Rodríguez', 'laura.rodriguez@yahoo.com'),
    (@InsEduardo, 'Eduardo Díaz', 'eduardo.diaz@gmail.com');

-- ========================================
-- INSERT: Estudiantes
-- ========================================
DECLARE 
    @EstJuan UNIQUEIDENTIFIER = NEWID(),
    @EstMarta UNIQUEIDENTIFIER = NEWID(),
    @EstAndres UNIQUEIDENTIFIER = NEWID(),
    @EstElena UNIQUEIDENTIFIER = NEWID(),
    @EstLuis UNIQUEIDENTIFIER = NEWID(),
    @EstPaola UNIQUEIDENTIFIER = NEWID(),
    @EstFelipe UNIQUEIDENTIFIER = NEWID(),
    @EstMaria UNIQUEIDENTIFIER = NEWID(),
    @EstRicardo UNIQUEIDENTIFIER = NEWID(),
    @EstValeria UNIQUEIDENTIFIER = NEWID();

INSERT INTO Estudiantes (EstudianteId, Nombre, Email)
VALUES
    (@EstJuan, 'Juan Martínez', 'juan.martinez@outlook.com'),
    (@EstMarta, 'Marta López', 'marta.lopez@gmail.com'),
    (@EstAndres, 'Andrés González', 'andres.gonzalez@hotmail.com'),
    (@EstElena, 'Elena Ruiz', 'elena.ruiz@outlook.com'),
    (@EstLuis, 'Luis García', 'luis.garcia@gmail.com'),
    (@EstPaola, 'Paola Pérez', 'paola.perez@gmail.com'),
    (@EstFelipe, 'Felipe Fernández', 'felipe.fernandez@hotmail.com'),
    (@EstMaria, 'María Rodríguez', 'maria.rodriguez@gmail.com'),
    (@EstRicardo, 'Ricardo Torres', 'ricardo.torres@yahoo.com'),
    (@EstValeria, 'Valeria Martínez', 'valeria.martinez@outlook.com');

-- ========================================
-- INSERT: TipoLeccion
-- ========================================
INSERT INTO TipoLeccion (Nombre)
VALUES
    ('Video'),
    ('Lectura'),
    ('Examen'),
    ('Práctica'),
    ('Foro');

-- ========================================
-- INSERT: Cursos
-- ========================================
DECLARE
    @CursoPython UNIQUEIDENTIFIER = NEWID(),
    @CursoWeb UNIQUEIDENTIFIER = NEWID(),
    @CursoMySQL UNIQUEIDENTIFIER = NEWID(),
    @CursoSeguridad UNIQUEIDENTIFIER = NEWID(),
    @CursoIA UNIQUEIDENTIFIER = NEWID();

INSERT INTO Cursos (CursoId, Titulo, Descripcion, Precio, Idioma, Nivel, CategoriaId)
VALUES
    (@CursoPython, 'Introducción a la Programación en Python', 'Curso básico de programación en Python.', 50.00, 'Español', 'Principiante', @CatProgramacion),
    (@CursoWeb, 'Desarrollo Web con HTML y CSS', 'Curso para aprender a crear páginas web estáticas.', 60.00, 'Español', 'Principiante', @CatWeb),
    (@CursoMySQL, 'Bases de Datos con MySQL', 'Curso completo de bases de datos relacionales utilizando MySQL.', 70.00, 'Español', 'Intermedio', @CatBD),
    (@CursoSeguridad, 'Seguridad Informática: Fundamentos', 'Aprende las bases de la seguridad en informática.', 80.00, 'Español', 'Avanzado', @CatSeguridad),
    (@CursoIA, 'Introducción a la Inteligencia Artificial con Python', 'Curso para introducirte en la inteligencia artificial usando Python.', 90.00, 'Español', 'Intermedio', @CatIA);

-- ========================================
-- INSERT: CursoInstructor (N:M)
-- ========================================
INSERT INTO CursoInstructor (CursoId, InstructorId)
VALUES
    (@CursoPython, @InsCarlos),
    (@CursoWeb, @InsAna),
    (@CursoMySQL, @InsJavier),
    (@CursoSeguridad, @InsLaura),
    (@CursoIA, @InsEduardo);

-- ========================================
-- INSERT: Secciones
-- ========================================
DECLARE
    @SecPython1 UNIQUEIDENTIFIER = NEWID(),
    @SecPython2 UNIQUEIDENTIFIER = NEWID(),
    @SecPython3 UNIQUEIDENTIFIER = NEWID(),
    @SecPython4 UNIQUEIDENTIFIER = NEWID(),
    @SecWeb1 UNIQUEIDENTIFIER = NEWID(),
    @SecWeb2 UNIQUEIDENTIFIER = NEWID(),
    @SecWeb3 UNIQUEIDENTIFIER = NEWID(),
    @SecWeb4 UNIQUEIDENTIFIER = NEWID(),
    @SecMySQL1 UNIQUEIDENTIFIER = NEWID(),
    @SecMySQL2 UNIQUEIDENTIFIER = NEWID(),
    @SecMySQL3 UNIQUEIDENTIFIER = NEWID(),
    @SecMySQL4 UNIQUEIDENTIFIER = NEWID(),
    @SecSeg1 UNIQUEIDENTIFIER = NEWID(),
    @SecSeg2 UNIQUEIDENTIFIER = NEWID(),
    @SecSeg3 UNIQUEIDENTIFIER = NEWID(),
    @SecIA1 UNIQUEIDENTIFIER = NEWID(),
    @SecIA2 UNIQUEIDENTIFIER = NEWID(),
    @SecIA3 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Secciones (SeccionId, CursoId, Titulo, Orden)
VALUES
    (@SecPython1, @CursoPython, 'Introducción a la Programación', 1),
    (@SecPython2, @CursoPython, 'Variables y Tipos de Datos', 2),
    (@SecPython3, @CursoPython, 'Condicionales y Bucles', 3),
    (@SecPython4, @CursoPython, 'Funciones y Librerías', 4),
    (@SecWeb1, @CursoWeb, 'Introducción al Desarrollo Web', 1),
    (@SecWeb2, @CursoWeb, 'HTML Básico', 2),
    (@SecWeb3, @CursoWeb, 'CSS y Diseño Web', 3),
    (@SecWeb4, @CursoWeb, 'JavaScript para Principiantes', 4),
    (@SecMySQL1, @CursoMySQL, 'Conceptos Básicos de Bases de Datos', 1),
    (@SecMySQL2, @CursoMySQL, 'Modelado Relacional', 2),
    (@SecMySQL3, @CursoMySQL, 'Consultas SQL', 3),
    (@SecMySQL4, @CursoMySQL, 'Optimización de Consultas', 4),
    (@SecSeg1, @CursoSeguridad, 'Conceptos de Seguridad Informática', 1),
    (@SecSeg2, @CursoSeguridad, 'Criptografía Básica', 2),
    (@SecSeg3, @CursoSeguridad, 'Hacking Ético', 3),
    (@SecIA1, @CursoIA, 'Introducción a la Inteligencia Artificial', 1),
    (@SecIA2, @CursoIA, 'Redes Neuronales Básicas', 2),
    (@SecIA3, @CursoIA, 'Aplicaciones de IA', 3);

-- ========================================
-- INSERT: Lecciones
-- ========================================
DECLARE
    @Lec1 UNIQUEIDENTIFIER = NEWID(),
    @Lec2 UNIQUEIDENTIFIER = NEWID(),
    @Lec3 UNIQUEIDENTIFIER = NEWID(),
    @Lec4 UNIQUEIDENTIFIER = NEWID(),
    @Lec5 UNIQUEIDENTIFIER = NEWID(),
    @Lec6 UNIQUEIDENTIFIER = NEWID(),
    @Lec7 UNIQUEIDENTIFIER = NEWID(),
    @Lec8 UNIQUEIDENTIFIER = NEWID(),
    @Lec9 UNIQUEIDENTIFIER = NEWID(),
    @Lec10 UNIQUEIDENTIFIER = NEWID(),
    @Lec11 UNIQUEIDENTIFIER = NEWID(),
    @Lec12 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Lecciones (LeccionId, SeccionId, TipoLeccionId, Titulo, DuracionSegundos, Orden)
VALUES
    (@Lec1, @SecPython1, 1, 'Qué es la Programación', 600, 1),
    (@Lec2, @SecPython1, 1, 'Primer Programa en Python', 900, 2),
    (@Lec3, @SecPython2, 2, 'Tipos de Datos en Python', 600, 1),
    (@Lec4, @SecPython3, 3, 'Estructuras Condicionales', 1200, 1),
    (@Lec5, @SecPython3, 3, 'Bucles en Python', 1500, 2),
    (@Lec6, @SecPython4, 4, 'Uso de Funciones en Python', 1800, 1),
    (@Lec7, @SecWeb1, 1, 'Qué es HTML', 600, 1),
    (@Lec8, @SecWeb1, 1, 'Estructura de una Página Web', 800, 2),
    (@Lec9, @SecWeb2, 2, 'CSS Básico', 1000, 1),
    (@Lec10, @SecMySQL2, 3, 'Modelo Relacional de Bases de Datos', 1200, 1),
    (@Lec11, @SecIA2, 1, 'Redes Neuronales en IA', 1000, 1),
    (@Lec12, @SecSeg3, 5, 'Prácticas en Seguridad Informática', 1200, 1);

-- ========================================
-- INSERT: Inscripciones
-- ========================================
INSERT INTO Inscripciones (InscripcionId, EstudianteId, CursoId, PrecioPagado, CuponCodigo)
VALUES
    (NEWID(), @EstJuan, @CursoPython, 50.00, NULL),
    (NEWID(), @EstMarta, @CursoWeb, 60.00, 'DESCUENTO10'),
    (NEWID(), @EstAndres, @CursoMySQL, 70.00, NULL),
    (NEWID(), @EstElena, @CursoSeguridad, 80.00, 'OFERTA20'),
    (NEWID(), @EstLuis, @CursoIA, 90.00, NULL),
    (NEWID(), @EstPaola, @CursoPython, 50.00, 'DESCUENTO10'),
    (NEWID(), @EstFelipe, @CursoWeb, 60.00, NULL),
    (NEWID(), @EstMaria, @CursoMySQL, 70.00, NULL),
    (NEWID(), @EstRicardo, @CursoSeguridad, 80.00, NULL),
    (NEWID(), @EstValeria, @CursoIA, 90.00, 'OFERTA20');

-- ========================================
-- INSERT: Resenas
-- ========================================
INSERT INTO Resenas (EstudianteId, CursoId, Calificacion, Resena)
VALUES
    (@EstJuan, @CursoPython, 5, 'Excelente curso para empezar en programación.'),
    (@EstMarta, @CursoWeb, 4, 'Buen curso, aunque el tema de CSS podría ser más profundo.'),
    (@EstAndres, @CursoMySQL, 5, 'Muy completo, aprendí mucho sobre bases de datos.'),
    (@EstElena, @CursoSeguridad, 4, 'Interesante, pero hay mucho contenido teórico.'),
    (@EstLuis, @CursoIA, 5, 'Impresionante curso de Inteligencia Artificial, muy recomendable.');

-- ========================================
-- INSERT: ListaDeseos
-- ========================================
INSERT INTO ListaDeseos (CursoId, EstudianteId)
VALUES
    (@CursoPython, @EstPaola),
    (@CursoWeb, @EstPaola),
    (@CursoMySQL, @EstPaola),
    (@CursoSeguridad, @EstPaola),
    (@CursoWeb, @EstFelipe),
    (@CursoMySQL, @EstMaria),
    (@CursoSeguridad, @EstRicardo),
    (@CursoIA, @EstValeria),
    (@CursoPython, @EstJuan),
    (@CursoWeb, @EstMarta),
    (@CursoMySQL, @EstAndres),
    (@CursoSeguridad, @EstElena),
    (@CursoIA, @EstLuis);

-- ========================================
-- INSERT: Progreso
-- ========================================
INSERT INTO Progreso (EstudianteId, LeccionId)
VALUES
    (@EstJuan, @Lec1),
    (@EstJuan, @Lec2),
    (@EstJuan, @Lec3),
    (@EstJuan, @Lec4),
    (@EstJuan, @Lec5),
    (@EstJuan, @Lec6),
    (@EstMarta, @Lec2),
    (@EstAndres, @Lec3),
    (@EstElena, @Lec4),
    (@EstLuis, @Lec5),
    (@EstPaola, @Lec6),
    (@EstFelipe, @Lec7),
    (@EstMaria, @Lec8),
    (@EstRicardo, @Lec9),
    (@EstValeria, @Lec10);