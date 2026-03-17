# 📚 Base de Datos: Udemy

<p align="center">
  <img src="https://img.shields.io/badge/SQL%20Server-Database-blue" />
  <img src="https://img.shields.io/badge/Projecto-Udemy-orange" />
</p>

## 📌 Descripción

Este proyecto consiste en el diseño de una base de datos para una plataforma de cursos en línea similar a Udemy.

Se desarrolló como una práctica académica enfocada en el modelado relacional, la identificación de entidades, relaciones y reglas de negocio, así como la construcción de consultas SQL para resolver escenarios propuestos.


## 👥 Equipo

- [![GitHub](https://img.shields.io/badge/GitHub-Edison-salinas?logo=github)](https://github.com/SalinasCEdison)
- [![GitHub](https://img.shields.io/badge/GitHub-Jenny-vaque?logo=github)](https://github.com/jennyvaque01-spec)

## 🎯 Objetivo
-
- Diseñar una base de datos desde cero
- Aplicar principios de modelado relacional
- Identificar entidades, atributos y relaciones
- Definir reglas de negocio mediante constraints
- Construir consultas SQL para resolver requerimientos

## 🧠 Contexto del negocio

La plataforma permite a los usuarios:

- Crear y vender cursos
- Inscribirse en cursos gratuitos o pagos
- Consumir contenido organizado en secciones y lecciones
- Calificar cursos y dejar reseñas
- Llevar seguimiento de su progreso

## 🔗 Diagrama ER

Puedes ver el diagrama entidad-relación aquí:

👉 [Ver diagrama](https://excalidraw.com/#room=dd4605aba25230f90df6,30xbsPcO0cn59QCs0wY1Fw)

## 👥 Actores del sistema

| Actor       | Descripción |
|------------|------------|
| **Estudiante** | - Se inscribe en cursos<br>- Consume contenido<br>- Deja reseñas y calificaciones<br>- Lleva registro de su progreso |
| **Instructor** | - Crea y publica cursos<br>- Puede tener múltiples cursos<br>- Participa como colaborador en cursos |
| **Curso**      | - Unidad principal de contenido<br>- Contiene secciones y lecciones<br>- Tiene precio, categoría e idioma |

## ⚙️ Funcionalidades principales

- Creación de cursos con múltiples instructores
- Organización jerárquica (Curso → Sección → Lección)
- Inscripción de estudiantes con registro del precio pagado
- Seguimiento de progreso por lección
- Sistema de calificaciones y reseñas
- Lista de deseos
- Organización por categorías y subcategorías

## 📏 Reglas de negocio

- Un estudiante no puede inscribirse dos veces en el mismo curso
- La calificación debe estar entre 1 y 5
- Un estudiante solo puede calificar un curso una vez
- El precio pagado se guarda en el momento de la inscripción
- Cada lección pertenece a una única sección
- Cada sección pertenece a un único curso
- El orden de secciones y lecciones debe preservarse
- Un curso debe tener al menos un instructor
- El progreso se calcula como:
- lecciones completadas / total de lecciones
