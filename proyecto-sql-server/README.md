# 📚 Base de Datos: Udemy

<p align="center">
  <img src="https://img.shields.io/badge/SQL%20Server-Database-blue" />
  <img src="https://img.shields.io/badge/Proyecto-Udemy-orange" />
  <img src="https://img.shields.io/badge/Estado-Completado-brightgreen" />
</p>

---

## 📑 Tabla de Contenido
- [📌 Descripción](#-descripción)
- [👥 Equipo](#-equipo)
- [🎯 Objetivos](#-objetivos)
- [🧠 Contexto del negocio](#-contexto-del-negocio)
- [🔗 Diagrama](#-diagrama)
- [👥 Actores](#-actores)
- [⚙️ Funcionalidades](#-funcionalidades)
- [📏 Reglas de negocio](#-reglas-de-negocio)
- [📝 Consultas principales](#-consultas-principales)
- [💻 Scripts y datos](#-scripts-y-datos)

---

## 📌 Descripción
Base de datos para una plataforma de cursos en línea (tipo Udemy).  
💡 Enfoque: modelado relacional, SQL Server, reglas de negocio y consultas SQL prácticas.

---

## 👥 Equipo
<p align="center">
  <a href="https://github.com/SalinasCEdison">
    <img src="https://img.shields.io/badge/Edison_Salinas-GitHub-blue?logo=github" alt="Edison Salinas" />
  </a>
  &nbsp;&nbsp;
  <a href="https://github.com/jennyvaque01-spec">
    <img src="https://img.shields.io/badge/Jenny_Vaque-GitHub-pink?logo=github" alt="Jenny Vaque" />
  </a>
</p>

- **Jenny Vaque** – Análisis y diseño del diagrama junto con Edison, responsable del script DDL y de los ejercicios del 1 al 5.
- **Edison Salinas** – Análisis y diseño del diagrama junto con Jenny, responsable del script DML y de los ejercicios del 6 al 10.  

---

## 🎯 Objetivos
- Diseñar una base de datos desde cero.  
- Identificar entidades, atributos y relaciones.  
- Aplicar constraints y reglas de negocio.  
- Construir consultas SQL que respondan a escenarios reales.

---

## 🧠 Contexto del negocio
- Cursos online con secciones y lecciones.  
- Inscripciones gratuitas o pagadas.  
- Seguimiento de progreso y calificaciones.  
- Listas de deseos y categorías de cursos.

---

## 🔗 Diagrama
<div style="border:1px solid #ddd; padding:5px; border-radius:8px; background-color:#f9f9f9; text-align:center;">
  <h4 style="color:#007BFF; font-weight:bold;">📄 Diagrama de entidades</h4>
  <img src="diagrama-proyecto.svg" alt="Diagrama ER Udemy" width="600"/>
  <p style="color:black;">Visualiza todas las entidades y relaciones del proyecto.</p>
  <p>
    📥 <a href="./diagrama-proyecto.svg">Descargar SVG</a> | 🔗 <a href="https://excalidraw.com/#room=dd4605aba25230f90df6,30xbsPcO0cn59QCs0wY1Fw">Ver en Excalidraw</a>
  </p>
</div>

---

## 👥 Actores
| Actor       | Función |
|------------|------------|
| **Estudiante** | Se inscribe, consume contenido, deja reseñas y calificaciones, sigue su progreso. |
| **Instructor** | Crea cursos, administra contenido, puede colaborar en varios cursos. |
| **Curso**      | Contiene secciones y lecciones, tiene precio, categoría, idioma y nivel de dificultad. |

---

## ⚙️ Funcionalidades
- Cursos con múltiples instructores.  
- Jerarquía: Curso → Sección → Lección.  
- Registro de inscripción y precio pagado.  
- Seguimiento del progreso por lección.  
- Calificaciones y reseñas.  
- Lista de deseos.  
- Organización por categorías y subcategorías.

---

## 📏 Reglas de negocio
- Un estudiante no puede inscribirse dos veces en el mismo curso.  
- Calificación: 1 a 5.  
- Un estudiante solo puede calificar un curso una vez.  
- Cada lección pertenece a una sección y cada sección a un curso.  
- Orden de secciones y lecciones debe preservarse.  
- Curso debe tener al menos un instructor.  
- Progreso = lecciones completadas / total de lecciones.

---

## 📝 Consultas principales
1. Cursos con calificación promedio y total de reseñas.  
2. Progreso de un estudiante en todos sus cursos inscritos.  
3. Top 5 instructores por número de estudiantes inscritos.  
4. Cursos inscritos pero no iniciados.  
5. Ingresos totales por curso.  
6. Lecciones de un curso con sección y duración.  
7. Estudiantes que completaron 100% de un curso.  
8. Cursos en lista de deseos sin comprar.  
9. Duración total de cada curso.  
10. Cursos por categoría con precio promedio.

---

## 💻 Scripts y datos

<div style="border:1px solid #ddd; padding:10px; border-radius:8px; background-color:#f9f9f9;">
  <h4 style="color:#007BFF; font-weight:bold;">🗃 Script DDL</h4>
  
```sql
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
...
```

  <p style="color:black;">Se define la estructura de la base de datos.</p>
  📥 <a href="./Proyecto-Udemy-DDL.sql">Descargar Script DDL</a>
</div>

<br/>

<div style="border:1px solid #ddd; padding:10px; border-radius:8px; background-color:#f9f9f9;">
  <h4 style="color:#007BFF; font-weight:bold;">🥫 Script de Seed</h4>

```sql  
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
...
```

  <p style="color:black;">Se inserta datos de prueba.</p>
  📥 <a href="./Proyecto-Udemy-DML.sql">Descargar Script DML</a>
</div>

<br/>

<div style="border:1px solid #ddd; padding:10px; border-radius:8px; background-color:#f9f9f9;">
  <h4 style="color:#007BFF; font-weight:bold;">🔍 Script de Consultas</h4>

```sql    
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
...
```

  <p style="color:black;">Se desarrolla los ejercicios del proyecto.</p>
  📥 <a href="./Proyecto-Udemy-Ejercicios.sql">Descargar Script de consultas</a>
</div>