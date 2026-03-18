-------Consultas---------
USE UdemyClon;
GO

-- 1. Cursos con su calificación promedio y número de reseñas---
SELECT 
    c.Titulo, 
    AVG(CAST(r.Calificacion AS FLOAT)) AS PromedioCalificacion,
    COUNT(r.EstudianteId) AS TotalResenas
FROM Cursos c
LEFT JOIN Resenas r ON c.CursoId = r.CursoId
GROUP BY c.Titulo
ORDER BY PromedioCalificacion DESC;

---2.  Progreso de un estudiante en todos sus cursos inscritos ------
---Vamos a tomar a juan martinez como referencia -----
SELECT 
    c.Titulo,
    COUNT(DISTINCT p.LeccionId) AS LeccionesCompletadas,
    COUNT(DISTINCT l.LeccionId) AS TotalLecciones,
    (CAST(COUNT(DISTINCT p.LeccionId) AS FLOAT) / COUNT(DISTINCT l.LeccionId)) * 100 AS PorcentajeAvance
FROM Estudiantes e
JOIN Inscripciones i ON e.EstudianteId = i.EstudianteId
JOIN Cursos c ON i.CursoId = c.CursoId
JOIN Secciones s ON c.CursoId = s.CursoId
JOIN Lecciones l ON s.SeccionId = l.SeccionId
LEFT JOIN Progreso p ON e.EstudianteId = p.EstudianteId AND l.LeccionId = p.LeccionId
WHERE e.Email = 'juan.martinez@outlook.com'
GROUP BY c.Titulo;

----3. Top 5 instructores por número de estudiantes inscriptos-----
SELECT TOP 5
    ins.Nombre AS Instructor, 
    COUNT(DISTINCT i.EstudianteId) AS TotalEstudiantes
FROM Instructores ins
JOIN CursoInstructor ci ON ins.InstructorId = ci.InstructorId
JOIN Inscripciones i ON ci.CursoId = i.CursoId
GROUP BY ins.Nombre
ORDER BY TotalEstudiantes DESC;

----4.  Cursos a los que un estudiante está inscrito pero no ha iniciad0 o no se han inscriptos-------
SELECT 
    c.Titulo, 
    i.FechaInscripcion
FROM Estudiantes e
JOIN Inscripciones i ON e.EstudianteId = i.EstudianteId
JOIN Cursos c ON i.CursoId = c.CursoId
LEFT JOIN Progreso p ON e.EstudianteId = p.EstudianteId 
    AND p.LeccionId IN (SELECT LeccionId FROM Lecciones l JOIN Secciones s ON l.SeccionId = s.SeccionId WHERE s.CursoId = c.CursoId)
WHERE e.Email = 'marta.lopez@gmail.com'
AND p.LeccionId IS NULL;

------5.  Ingresos totales por curso es la suma de precios pagado---------
SELECT 
    c.Titulo, 
    SUM(i.PrecioPagado) AS IngresosTotales
FROM Cursos c
JOIN Inscripciones i ON c.CursoId = i.CursoId
GROUP BY c.Titulo
ORDER BY IngresosTotales DESC;