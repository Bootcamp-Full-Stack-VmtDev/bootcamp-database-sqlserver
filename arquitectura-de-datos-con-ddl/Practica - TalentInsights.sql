USE TalentInsights;
GO

-- Creen una tabla Tags y la tabla intermedia PostTags. Un Post puede tener muchos Tags, 
-- un Tag puede estar en muchos Post. Incluyan constraints correctos.

SELECT * FROM Posts;

CREATE TABLE Tags (
	TagId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	Description NVARCHAR(25) NOT NULL,
	Status NVARCHAR(15) NOT NULL,
	CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE PostTags (
	TagId UNIQUEIDENTIFIER NOT NULL,
	PostId UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT PK_PostTags PRIMARY KEY (TagId, PostId),
    CONSTRAINT FK_PostTags_Tag FOREIGN KEY (TagId) REFERENCES Tags (TagId),
    CONSTRAINT FK_PostTags_Post FOREIGN KEY (PostId) REFERENCES Posts (Id)
);
GO