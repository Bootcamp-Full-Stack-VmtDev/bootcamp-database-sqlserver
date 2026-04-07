USE UdemyClone;
GO

-- ========================================
-- 1. Courses with average rating and total reviews
-- ========================================
SELECT 
    c.Title, 
    ROUND(AVG(CAST(r.Rating AS FLOAT)), 2) AS AverageRating,
    COUNT(r.StudentId) AS TotalReviews
FROM Courses c
LEFT JOIN Reviews r ON c.CourseId = r.CourseId
GROUP BY c.Title
ORDER BY AverageRating DESC;
GO

-- ========================================
-- 2. Student progress in all enrolled courses
-- ========================================
SELECT 
    c.Title,
    COUNT(DISTINCT p.LessonId) AS CompletedLessons,
    COUNT(DISTINCT l.LessonId) AS TotalLessons,
    ROUND((CAST(COUNT(DISTINCT p.LessonId) AS FLOAT) / COUNT(DISTINCT l.LessonId)) * 100, 2) AS ProgressPercentage
FROM Students e
JOIN Enrollments i ON e.StudentId = i.StudentId
JOIN Courses c ON i.CourseId = c.CourseId
JOIN Sections s ON c.CourseId = s.CourseId
JOIN Lessons l ON s.SectionId = l.SectionId
LEFT JOIN Progress p ON e.StudentId = p.StudentId AND l.LessonId = p.LessonId
WHERE e.Email = 'juan.martinez@outlook.com'
GROUP BY c.Title;
GO

-- ========================================
-- 3. Top 5 instructors by number of enrolled students
-- ========================================
SELECT TOP 5
    ins.Name AS Instructor, 
    COUNT(DISTINCT i.StudentId) AS TotalStudents
FROM Instructors ins
JOIN CourseInstructors ci ON ins.InstructorId = ci.InstructorId
JOIN Enrollments i ON ci.CourseId = i.CourseId
GROUP BY ins.Name
ORDER BY TotalStudents DESC;
GO

-- ========================================
-- 4. Courses a student is enrolled in but has not started
-- ========================================
SELECT 
    c.Title, 
    CAST(i.EnrolledAt AS DATE) AS EnrollmentDate
FROM Students e
JOIN Enrollments i ON e.StudentId = i.StudentId
JOIN Courses c ON i.CourseId = c.CourseId
LEFT JOIN Progress p ON e.StudentId = p.StudentId 
    AND p.LessonId IN (
        SELECT l.LessonId 
        FROM Lessons l 
        JOIN Sections s ON l.SectionId = s.SectionId 
        WHERE s.CourseId = c.CourseId
    )
WHERE e.Email = 'marta.lopez@gmail.com'
AND p.LessonId IS NULL;
GO

-- ========================================
-- 5. Total revenue by course
-- ========================================
SELECT 
    c.Title, 
    SUM(i.PricePaid) AS TotalRevenue
FROM Courses c
JOIN Enrollments i ON c.CourseId = i.CourseId
GROUP BY c.Title
ORDER BY TotalRevenue DESC;
GO

-- ========================================
-- 6. Lessons of a course with section and duration
-- ========================================
SELECT 
    s.Title AS Section,
    l.Title AS Lesson,
    ROUND(CAST(l.DurationSeconds AS FLOAT) / 60, 2) AS DurationMinutes,
    lt.Name AS LessonType
FROM Courses c
JOIN Sections s ON c.CourseId = s.CourseId
JOIN Lessons l ON s.SectionId = l.SectionId
JOIN LessonTypes lt ON l.LessonTypeId = lt.LessonTypeId
WHERE c.Title = 'Introduction to Python Programming'
ORDER BY s.SortOrder, l.SortOrder;
GO

-- ========================================
-- 7. Students who completed 100% of at least one course
-- ========================================
SELECT 
    e.Name AS Student,
    c.Title AS Course
FROM Students e
JOIN Enrollments i ON e.StudentId = i.StudentId
JOIN Courses c ON i.CourseId = c.CourseId
JOIN Sections s ON c.CourseId = s.CourseId
JOIN Lessons l ON s.SectionId = l.SectionId
LEFT JOIN Progress p ON e.StudentId = p.StudentId AND l.LessonId = p.LessonId
GROUP BY e.Name, c.Title
HAVING COUNT(DISTINCT l.LessonId) = COUNT(DISTINCT p.LessonId);
GO

-- ========================================
-- 8. Wishlist courses not yet purchased
-- ========================================
SELECT 
    c.Title,
    c.Price
FROM Wishlist w
JOIN Students e ON w.StudentId = e.StudentId
JOIN Courses c ON w.CourseId = c.CourseId
LEFT JOIN Enrollments i 
    ON e.StudentId = i.StudentId 
    AND c.CourseId = i.CourseId
WHERE e.Email = 'paola.perez@gmail.com'
  AND i.EnrollmentId IS NULL;
GO

-- ========================================
-- 9. Total duration in hours of each course
-- ========================================
SELECT 
    c.Title, 
    ROUND(SUM(CAST(l.DurationSeconds AS FLOAT)) / 3600, 2) AS TotalHours
FROM Courses c
JOIN Sections s ON c.CourseId = s.CourseId
JOIN Lessons l ON s.SectionId = l.SectionId
GROUP BY c.Title
ORDER BY TotalHours DESC;
GO

-- ========================================
-- 10. Courses by category with average price
-- ========================================
SELECT 
    cat.Name AS Category, 
    COUNT(c.CourseId) AS TotalCourses,
    ROUND(AVG(CAST(c.Price AS FLOAT)), 2) AS AveragePrice
FROM Categories cat
JOIN Courses c ON cat.CategoryId = c.CategoryId
GROUP BY cat.Name
ORDER BY TotalCourses DESC;
GO