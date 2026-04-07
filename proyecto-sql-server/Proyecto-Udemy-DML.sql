USE UdemyClone;
GO

-- ========================================
-- INSERT: Categories with self-reference
-- ========================================
DECLARE 
    @CatProgramming UNIQUEIDENTIFIER = NEWID(),
    @CatWeb UNIQUEIDENTIFIER = NEWID(),
    @CatDB UNIQUEIDENTIFIER = NEWID(),
    @CatSecurity UNIQUEIDENTIFIER = NEWID(),
    @CatAI UNIQUEIDENTIFIER = NEWID(),
    @CatFrontend UNIQUEIDENTIFIER = NEWID(),
    @CatBackend UNIQUEIDENTIFIER = NEWID();

INSERT INTO Categories (CategoryId, Name, ParentCategoryId)
VALUES
    (@CatProgramming, 'Programming', NULL),
    (@CatWeb, 'Web Development', @CatProgramming),
    (@CatDB, 'Databases', @CatProgramming),
    (@CatSecurity, 'Cybersecurity', @CatProgramming),
    (@CatAI, 'Artificial Intelligence', @CatProgramming),
    (@CatFrontend, 'Frontend', @CatWeb),
    (@CatBackend, 'Backend', @CatWeb);

-- ========================================
-- INSERT: Instructors
-- ========================================
DECLARE 
    @InsCarlos UNIQUEIDENTIFIER = NEWID(),
    @InsAna UNIQUEIDENTIFIER = NEWID(),
    @InsJavier UNIQUEIDENTIFIER = NEWID(),
    @InsLaura UNIQUEIDENTIFIER = NEWID(),
    @InsEduardo UNIQUEIDENTIFIER = NEWID();

INSERT INTO Instructors (InstructorId, Name, Email)
VALUES
    (@InsCarlos, 'Carlos Perez', 'carlos.perez@gmail.com'),
    (@InsAna, 'Ana Sanchez', 'ana.sanchez@hotmail.com'),
    (@InsJavier, 'Javier Gomez', 'javier.gomez@outlook.com'),
    (@InsLaura, 'Laura Rodriguez', 'laura.rodriguez@yahoo.com'),
    (@InsEduardo, 'Eduardo Diaz', 'eduardo.diaz@gmail.com');

-- ========================================
-- INSERT: Students
-- ========================================
DECLARE 
    @StuJuan UNIQUEIDENTIFIER = NEWID(),
    @StuMarta UNIQUEIDENTIFIER = NEWID(),
    @StuAndres UNIQUEIDENTIFIER = NEWID(),
    @StuElena UNIQUEIDENTIFIER = NEWID(),
    @StuLuis UNIQUEIDENTIFIER = NEWID(),
    @StuPaola UNIQUEIDENTIFIER = NEWID(),
    @StuFelipe UNIQUEIDENTIFIER = NEWID(),
    @StuMaria UNIQUEIDENTIFIER = NEWID(),
    @StuRicardo UNIQUEIDENTIFIER = NEWID(),
    @StuValeria UNIQUEIDENTIFIER = NEWID();

INSERT INTO Students (StudentId, Name, Email)
VALUES
    (@StuJuan, 'Juan Martinez', 'juan.martinez@outlook.com'),
    (@StuMarta, 'Marta Lopez', 'marta.lopez@gmail.com'),
    (@StuAndres, 'Andres Gonzalez', 'andres.gonzalez@hotmail.com'),
    (@StuElena, 'Elena Ruiz', 'elena.ruiz@outlook.com'),
    (@StuLuis, 'Luis Garcia', 'luis.garcia@gmail.com'),
    (@StuPaola, 'Paola Perez', 'paola.perez@gmail.com'),
    (@StuFelipe, 'Felipe Fernandez', 'felipe.fernandez@hotmail.com'),
    (@StuMaria, 'Maria Rodriguez', 'maria.rodriguez@gmail.com'),
    (@StuRicardo, 'Ricardo Torres', 'ricardo.torres@yahoo.com'),
    (@StuValeria, 'Valeria Martinez', 'valeria.martinez@outlook.com');

-- ========================================
-- INSERT: LessonTypes
-- ========================================
INSERT INTO LessonTypes (Name)
VALUES
    ('Video'),
    ('Reading'),
    ('Exam'),
    ('Practice'),
    ('Forum');

-- ========================================
-- INSERT: Courses
-- ========================================
DECLARE
    @CoursePython UNIQUEIDENTIFIER = NEWID(),
    @CourseWeb UNIQUEIDENTIFIER = NEWID(),
    @CourseMySQL UNIQUEIDENTIFIER = NEWID(),
    @CourseSecurity UNIQUEIDENTIFIER = NEWID(),
    @CourseAI UNIQUEIDENTIFIER = NEWID();

INSERT INTO Courses (CourseId, Title, Description, Price, Language, Level, CategoryId)
VALUES
    (@CoursePython, 'Introduction to Python Programming', 'Basic Python programming course.', 50.00, 'Spanish', 'Beginner', @CatProgramming),
    (@CourseWeb, 'Web Development with HTML and CSS', 'Course to learn how to create static web pages.', 60.00, 'Spanish', 'Beginner', @CatWeb),
    (@CourseMySQL, 'Databases with MySQL', 'Complete relational database course using MySQL.', 70.00, 'Spanish', 'Intermediate', @CatDB),
    (@CourseSecurity, 'Cybersecurity Fundamentals', 'Learn the basics of cybersecurity.', 80.00, 'Spanish', 'Advanced', @CatSecurity),
    (@CourseAI, 'Introduction to Artificial Intelligence with Python', 'Course to get started in artificial intelligence using Python.', 90.00, 'Spanish', 'Intermediate', @CatAI);

-- ========================================
-- INSERT: CourseInstructors (N:M)
-- ========================================
INSERT INTO CourseInstructors (CourseId, InstructorId)
VALUES
    (@CoursePython, @InsCarlos),
    (@CourseWeb, @InsAna),
    (@CourseMySQL, @InsJavier),
    (@CourseSecurity, @InsLaura),
    (@CourseAI, @InsEduardo);

-- ========================================
-- INSERT: Sections
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
    @SecAI1 UNIQUEIDENTIFIER = NEWID(),
    @SecAI2 UNIQUEIDENTIFIER = NEWID(),
    @SecAI3 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Sections (SectionId, CourseId, Title, SortOrder)
VALUES
    (@SecPython1, @CoursePython, 'Introduction to Programming', 1),
    (@SecPython2, @CoursePython, 'Variables and Data Types', 2),
    (@SecPython3, @CoursePython, 'Conditionals and Loops', 3),
    (@SecPython4, @CoursePython, 'Functions and Libraries', 4),
    (@SecWeb1, @CourseWeb, 'Introduction to Web Development', 1),
    (@SecWeb2, @CourseWeb, 'Basic HTML', 2),
    (@SecWeb3, @CourseWeb, 'CSS and Web Design', 3),
    (@SecWeb4, @CourseWeb, 'JavaScript for Beginners', 4),
    (@SecMySQL1, @CourseMySQL, 'Database Fundamentals', 1),
    (@SecMySQL2, @CourseMySQL, 'Relational Modeling', 2),
    (@SecMySQL3, @CourseMySQL, 'SQL Queries', 3),
    (@SecMySQL4, @CourseMySQL, 'Query Optimization', 4),
    (@SecSeg1, @CourseSecurity, 'Cybersecurity Concepts', 1),
    (@SecSeg2, @CourseSecurity, 'Basic Cryptography', 2),
    (@SecSeg3, @CourseSecurity, 'Ethical Hacking', 3),
    (@SecAI1, @CourseAI, 'Introduction to Artificial Intelligence', 1),
    (@SecAI2, @CourseAI, 'Basic Neural Networks', 2),
    (@SecAI3, @CourseAI, 'AI Applications', 3);

-- ========================================
-- INSERT: Lessons
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

INSERT INTO Lessons (LessonId, SectionId, LessonTypeId, Title, DurationSeconds, SortOrder)
VALUES
    (@Lec1, @SecPython1, 1, 'What is Programming', 600, 1),
    (@Lec2, @SecPython1, 1, 'First Python Program', 900, 2),
    (@Lec3, @SecPython2, 2, 'Python Data Types', 600, 1),
    (@Lec4, @SecPython3, 3, 'Conditional Structures', 1200, 1),
    (@Lec5, @SecPython3, 3, 'Loops in Python', 1500, 2),
    (@Lec6, @SecPython4, 4, 'Using Functions in Python', 1800, 1),
    (@Lec7, @SecWeb1, 1, 'What is HTML', 600, 1),
    (@Lec8, @SecWeb1, 1, 'Web Page Structure', 800, 2),
    (@Lec9, @SecWeb2, 2, 'Basic CSS', 1000, 1),
    (@Lec10, @SecMySQL2, 3, 'Relational Database Model', 1200, 1),
    (@Lec11, @SecAI2, 1, 'Neural Networks in AI', 1000, 1),
    (@Lec12, @SecSeg3, 5, 'Cybersecurity Practices', 1200, 1);

-- ========================================
-- INSERT: Enrollments
-- ========================================
INSERT INTO Enrollments (EnrollmentId, StudentId, CourseId, PricePaid, CouponCode)
VALUES
    (NEWID(), @StuJuan, @CoursePython, 50.00, NULL),
    (NEWID(), @StuMarta, @CourseWeb, 60.00, 'DISCOUNT10'),
    (NEWID(), @StuAndres, @CourseMySQL, 70.00, NULL),
    (NEWID(), @StuElena, @CourseSecurity, 80.00, 'OFFER20'),
    (NEWID(), @StuLuis, @CourseAI, 90.00, NULL),
    (NEWID(), @StuPaola, @CoursePython, 50.00, 'DISCOUNT10'),
    (NEWID(), @StuFelipe, @CourseWeb, 60.00, NULL),
    (NEWID(), @StuMaria, @CourseMySQL, 70.00, NULL),
    (NEWID(), @StuRicardo, @CourseSecurity, 80.00, NULL),
    (NEWID(), @StuValeria, @CourseAI, 90.00, 'OFFER20');

-- ========================================
-- INSERT: Reviews
-- ========================================
INSERT INTO Reviews (StudentId, CourseId, Rating, ReviewText)
VALUES
    (@StuJuan, @CoursePython, 5, 'Excellent course to start programming.'),
    (@StuMarta, @CourseWeb, 4, 'Good course, although CSS could be more in-depth.'),
    (@StuAndres, @CourseMySQL, 5, 'Very complete, I learned a lot about databases.'),
    (@StuElena, @CourseSecurity, 4, 'Interesting, but there is a lot of theory.'),
    (@StuLuis, @CourseAI, 5, 'Amazing AI course, highly recommended.');

-- ========================================
-- INSERT: Wishlist
-- ========================================
INSERT INTO Wishlist (CourseId, StudentId)
VALUES
    (@CoursePython, @StuPaola),
    (@CourseWeb, @StuPaola),
    (@CourseMySQL, @StuPaola),
    (@CourseSecurity, @StuPaola),
    (@CourseWeb, @StuFelipe),
    (@CourseMySQL, @StuMaria),
    (@CourseSecurity, @StuRicardo),
    (@CourseAI, @StuValeria),
    (@CoursePython, @StuJuan),
    (@CourseWeb, @StuMarta),
    (@CourseMySQL, @StuAndres),
    (@CourseSecurity, @StuElena),
    (@CourseAI, @StuLuis);

-- ========================================
-- INSERT: Progress
-- ========================================
INSERT INTO Progress (StudentId, LessonId)
VALUES
    (@StuJuan, @Lec1),
    (@StuJuan, @Lec2),
    (@StuJuan, @Lec3),
    (@StuJuan, @Lec4),
    (@StuJuan, @Lec5),
    (@StuJuan, @Lec6),
    (@StuMarta, @Lec2),
    (@StuAndres, @Lec3),
    (@StuElena, @Lec4),
    (@StuLuis, @Lec5),
    (@StuPaola, @Lec6),
    (@StuFelipe, @Lec7),
    (@StuMaria, @Lec8),
    (@StuRicardo, @Lec9),
    (@StuValeria, @Lec10);