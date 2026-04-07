CREATE DATABASE UdemyClone;
GO

USE UdemyClone;
GO

-- ========================================
-- TABLE: Categories
-- ========================================
CREATE TABLE Categories (
    CategoryId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(100) NOT NULL,
    ParentCategoryId UNIQUEIDENTIFIER NULL,
    CONSTRAINT FK_Categories_Parent 
        FOREIGN KEY (ParentCategoryId) REFERENCES Categories(CategoryId)
);
GO

-- ========================================
-- TABLE: Instructors
-- ========================================
CREATE TABLE Instructors (
    InstructorId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- ========================================
-- TABLE: Students
-- ========================================
CREATE TABLE Students (
    StudentId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- ========================================
-- TABLE: LessonTypes
-- ========================================
CREATE TABLE LessonTypes (
    LessonTypeId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL
);
GO

-- ========================================
-- TABLE: Courses
-- ========================================
CREATE TABLE Courses (
    CourseId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Title NVARCHAR(250) NOT NULL,
    Description NVARCHAR(250) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Language NVARCHAR(50),
    Level NVARCHAR(50),
    CategoryId UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT FK_Courses_Category 
        FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
GO

-- ========================================
-- TABLE N:M: CourseInstructors
-- ========================================
CREATE TABLE CourseInstructors (
    CourseId UNIQUEIDENTIFIER NOT NULL,
    InstructorId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (CourseId, InstructorId),
    CONSTRAINT FK_CI_Course 
        FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
    CONSTRAINT FK_CI_Instructor 
        FOREIGN KEY (InstructorId) REFERENCES Instructors(InstructorId)
);
GO

-- ========================================
-- TABLE: Sections
-- ========================================
CREATE TABLE Sections (
    SectionId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CourseId UNIQUEIDENTIFIER NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    SortOrder INT NOT NULL,
    CONSTRAINT FK_Sections_Course 
        FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);
GO

-- ========================================
-- TABLE: Lessons
-- ========================================
CREATE TABLE Lessons (
    LessonId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    SectionId UNIQUEIDENTIFIER NOT NULL,
    LessonTypeId INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    DurationSeconds DECIMAL(10,2) NOT NULL,
    SortOrder INT NOT NULL,
    CONSTRAINT FK_Lessons_Section 
        FOREIGN KEY (SectionId) REFERENCES Sections(SectionId),
    CONSTRAINT FK_Lessons_Type 
        FOREIGN KEY (LessonTypeId) REFERENCES LessonTypes(LessonTypeId)
);
GO

-- ========================================
-- TABLE: Enrollments
-- ========================================
CREATE TABLE Enrollments (
    EnrollmentId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    StudentId UNIQUEIDENTIFIER NOT NULL,
    CourseId UNIQUEIDENTIFIER NOT NULL,
    EnrolledAt DATETIME2 DEFAULT SYSUTCDATETIME(),
    PricePaid DECIMAL(10,2) NOT NULL,
    CouponCode NVARCHAR(20) NULL,
    CONSTRAINT UQ_Student_Course UNIQUE (StudentId, CourseId),
    CONSTRAINT FK_Enrollments_Student 
        FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    CONSTRAINT FK_Enrollments_Course 
        FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);
GO

-- ========================================
-- TABLE: Reviews
-- ========================================
CREATE TABLE Reviews (
    StudentId UNIQUEIDENTIFIER NOT NULL,
    CourseId UNIQUEIDENTIFIER NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText NVARCHAR(250) NOT NULL,
    CreatedAt DATETIME2 DEFAULT SYSUTCDATETIME(),
    PRIMARY KEY (StudentId, CourseId),
    CONSTRAINT FK_Reviews_Student 
        FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    CONSTRAINT FK_Reviews_Course 
        FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);
GO

-- ========================================
-- TABLE: Wishlist
-- ========================================
CREATE TABLE Wishlist (
    CourseId UNIQUEIDENTIFIER NOT NULL,
    StudentId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (CourseId, StudentId),
    CONSTRAINT FK_Wishlist_Course 
        FOREIGN KEY (CourseId) REFERENCES Courses(CourseId),
    CONSTRAINT FK_Wishlist_Student 
        FOREIGN KEY (StudentId) REFERENCES Students(StudentId)
);
GO

-- ========================================
-- TABLE: Progress
-- ========================================
CREATE TABLE Progress (
    StudentId UNIQUEIDENTIFIER NOT NULL,
    LessonId UNIQUEIDENTIFIER NOT NULL,
    CompletedAt DATETIME2 DEFAULT SYSUTCDATETIME(),
    PRIMARY KEY (StudentId, LessonId),
    CONSTRAINT FK_Progress_Student 
        FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    CONSTRAINT FK_Progress_Lesson 
        FOREIGN KEY (LessonId) REFERENCES Lessons(LessonId)
);
GO