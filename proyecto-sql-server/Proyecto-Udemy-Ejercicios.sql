USE UdemyClon;
GO

-- ========================================
-- 1. Cursos con su calificación promedio y número de reseñas
-- ========================================
SELECT 
    c.Titulo, 
    ROUND(AVG(CAST(r.Calificacion AS FLOAT)), 2) AS PromedioCalificacion,
    COUNT(r.EstudianteId) AS TotalResenas
FROM Cursos c
LEFT JOIN Resenas r ON c.CursoId = r.CursoId
GROUP BY c.Titulo
ORDER BY PromedioCalificacion DESC;
GO

-- ========================================
-- 2. Progreso de un estudiante en todos sus cursos inscritos
-- ========================================
SELECT 
    c.Titulo,
    COUNT(DISTINCT p.LeccionId) AS LeccionesCompletadas,
    COUNT(DISTINCT l.LeccionId) AS TotalLecciones,
    ROUND((CAST(COUNT(DISTINCT p.LeccionId) AS FLOAT) / COUNT(DISTINCT l.LeccionId)) * 100, 2) AS PorcentajeAvance
FROM Estudiantes e
JOIN Inscripciones i ON e.EstudianteId = i.EstudianteId
JOIN Cursos c ON i.CursoId = c.CursoId
JOIN Secciones s ON c.CursoId = s.CursoId
JOIN Lecciones l ON s.SeccionId = l.SeccionId
LEFT JOIN Progreso p ON e.EstudianteId = p.EstudianteId AND l.LeccionId = p.LeccionId
WHERE e.Email = 'juan.martinez@outlook.com'
GROUP BY c.Titulo;
GO

-- ========================================
-- 3. Top 5 instructores por número de estudiantes inscritos
-- ========================================
SELECT TOP 5
    ins.Nombre AS Instructor, 
    COUNT(DISTINCT i.EstudianteId) AS TotalEstudiantes
FROM Instructores ins
JOIN CursoInstructor ci ON ins.InstructorId = ci.InstructorId
JOIN Inscripciones i ON ci.CursoId = i.CursoId
GROUP BY ins.Nombre
ORDER BY TotalEstudiantes DESC;
GO

-- ========================================
-- 4. Cursos a los que un estudiante está inscrito pero no ha iniciado
-- ========================================
SELECT 
    c.Titulo, 
    CAST(i.FechaInscripcion AS DATE) AS FechaInscripcion
FROM Estudiantes e
JOIN Inscripciones i ON e.EstudianteId = i.EstudianteId
JOIN Cursos c ON i.CursoId = c.CursoId
LEFT JOIN Progreso p ON e.EstudianteId = p.EstudianteId 
    AND p.LeccionId IN (
        SELECT l.LeccionId 
        FROM Lecciones l 
        JOIN Secciones s ON l.SeccionId = s.SeccionId 
        WHERE s.CursoId = c.CursoId
    )
WHERE e.Email = 'marta.lopez@gmail.com'
AND p.LeccionId IS NULL;
GO

-- ========================================
-- 5. Ingresos totales por curso
-- ========================================
SELECT 
    c.Titulo, 
    SUM(i.PrecioPagado) AS IngresosTotales
FROM Cursos c
JOIN Inscripciones i ON c.CursoId = i.CursoId
GROUP BY c.Titulo
ORDER BY IngresosTotales DESC;
GO

-- ========================================
-- 6. Lecciones de un curso con su sección y duración
-- ========================================
SELECT 
    s.Titulo AS Seccion,
    l.Titulo AS Leccion,
    ROUND(CAST(l.DuracionSegundos AS FLOAT) / 60, 2) AS DuracionMinutos,
    tl.Nombre AS TipoLeccion
FROM Cursos c
JOIN Secciones s ON c.CursoId = s.CursoId
JOIN Lecciones l ON s.SeccionId = l.SeccionId
JOIN TipoLeccion tl ON l.TipoLeccionId = tl.TipoLeccionId
WHERE c.Titulo = 'Introducción a la Programación en Python'
ORDER BY s.Orden, l.Orden;
GO

-- ========================================
-- 7. Estudiantes que han completado el 100% de al menos un curso
-- ========================================
SELECT 
    e.Nombre AS Estudiante,
    c.Titulo AS Curso
FROM Estudiantes e
JOIN Inscripciones i ON e.EstudianteId = i.EstudianteId
JOIN Cursos c ON i.CursoId = c.CursoId
JOIN Secciones s ON c.CursoId = s.CursoId
JOIN Lecciones l ON s.SeccionId = l.SeccionId
LEFT JOIN Progreso p ON e.EstudianteId = p.EstudianteId AND l.LeccionId = p.LeccionId
GROUP BY e.Nombre, c.Titulo
HAVING COUNT(DISTINCT l.LeccionId) = COUNT(DISTINCT p.LeccionId);
GO

-- ========================================
-- 8. Cursos en lista de deseos de un estudiante que aún no ha comprado
-- ========================================
SELECT 
    c.Titulo,
    c.Precio
FROM ListaDeseos ld
JOIN Estudiantes e ON ld.EstudianteId = e.EstudianteId
JOIN Cursos c ON ld.CursoId = c.CursoId
LEFT JOIN Inscripciones i 
    ON e.EstudianteId = i.EstudianteId 
    AND c.CursoId = i.CursoId
WHERE e.Email = 'paola.perez@gmail.com'
  AND i.InscripcionId IS NULL;
GO

-- ========================================
-- 9. Duración total en horas de cada curso
-- ========================================
SELECT 
    c.Titulo, 
    ROUND(SUM(CAST(l.DuracionSegundos AS FLOAT)) / 3600, 2) AS TotalHoras
FROM Cursos c
JOIN Secciones s ON c.CursoId = s.CursoId
JOIN Lecciones l ON s.SeccionId = l.SeccionId
GROUP BY c.Titulo
ORDER BY TotalHoras DESC;
GO

-- ========================================
-- 10. Cursos por categoría con su precio promedio
-- ========================================
SELECT 
    cat.Nombre AS Categoria, 
    COUNT(c.CursoId) AS TotalCursos,
    ROUND(AVG(CAST(c.Precio AS FLOAT)), 2) AS PrecioPromedio
FROM Categoria cat
JOIN Cursos c ON cat.CategoriaId = c.CategoriaId
GROUP BY cat.Nombre
ORDER BY TotalCursos DESC;
GO