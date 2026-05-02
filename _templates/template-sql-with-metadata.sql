/*
============================================================
Title: Your Project Title
Purpose: A brief description of what this script does
============================================================

METADATA:
  filename: your-project-file.sql
  title: Your Project Title
  authorname: Your Name
  version: 0.1.0
  created: 2026-04-20
  last_updated: 2026-04-20

CHANGELOG:
  Most recent entries first. Reference change codes from
  rules-change-codes.jsonc for semantic versioning.

  Version 0.1.0 - 2026-04-20 - Your Name
    IMP: Initial SQL script setup with metadata template

CHANGE CODES:
  Reference: rules-change-codes.jsonc

  FIX  - Bug fixes (patch bump)
  IMP  - New features (minor bump)
  CHG  - Improvements/refactoring (minor bump)
  REF  - Documentation/references (patch bump)
  BRK  - Breaking changes (major bump)
  SEC  - Security fixes (patch bump)
  TST  - Tests/CI (patch bump)
  DOC  - Documentation (patch bump)
  CFG  - Configuration (minor bump)
  DEP  - Dependencies (patch bump)
  OPS  - Operations/deployment (patch bump)
  WIP  - Work in progress (no version bump)

NOTES:
  For full code definitions, see rules-change-codes.jsonc

EXECUTION:
  Run this script in your SQL management tool (SSMS, MySQL Workbench, etc.)
  against the appropriate database.

============================================================
*/

-- ============================================================
-- Configuration
-- ============================================================

USE [YourDatabase]
GO

SET NOCOUNT ON
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- Example Table Creation
-- ============================================================

IF OBJECT_ID('[dbo].[ExampleTable]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ExampleTable]
    (
        [ID] INT PRIMARY KEY IDENTITY(1,1),
        [Name] NVARCHAR(100) NOT NULL,
        [Status] NVARCHAR(50) DEFAULT 'active',
        [CreatedDate] DATETIME DEFAULT GETDATE()
    )
    
    PRINT 'Table [dbo].[ExampleTable] created successfully.'
END
ELSE
BEGIN
    PRINT 'Table [dbo].[ExampleTable] already exists.'
END
GO

-- ============================================================
-- Sample Data Insertion
-- ============================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[ExampleTable] WHERE [Name] = 'Item One')
BEGIN
    INSERT INTO [dbo].[ExampleTable] ([Name], [Status])
    VALUES ('Item One', 'active')
    
    PRINT 'Sample data inserted.'
END
GO

-- ============================================================
-- Example Query
-- ============================================================

SELECT
    [ID],
    [Name],
    [Status],
    [CreatedDate]
FROM [dbo].[ExampleTable]
ORDER BY [CreatedDate] DESC
GO

-- ============================================================
-- Cleanup (Optional)
-- ============================================================

-- Uncomment to drop the table:
-- DROP TABLE [dbo].[ExampleTable]
-- GO

-- ============================================================
-- End of Script
-- ============================================================
