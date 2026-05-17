@echo off
REM ============================================================
REM Title: Your Project Title
REM Description: A brief description of what this script does
REM ============================================================
REM
REM METADATA:
REM   title: Your Project Title
REM   description: A brief description of what this script does
REM   author: Your Name
REM   filename: your-project-file.bat
REM   schema_version: "2.0.0"
REM   version: 0.1.0
REM   date: 2026-04-20
REM   lastmod: 2026-04-21
REM
REM CHANGELOG:
REM   Most recent entries first. Reference change codes from
REM   rules-change-codes.jsonc for semantic versioning.
REM
REM   Version 0.1.0 - 2026-04-20 - Your Name
REM     IMP: Initial batch script setup with metadata template
REM
REM CHANGE CODES:
REM   Reference: rules-change-codes.jsonc
REM
REM   FIX  - Bug fixes (patch bump)
REM   IMP  - New features (minor bump)
REM   CHG  - Improvements/refactoring (minor bump)
REM   REF  - Documentation/references (patch bump)
REM   BRK  - Breaking changes (major bump)
REM   SEC  - Security fixes (patch bump)
REM   TST  - Tests/CI (patch bump)
REM   DOC  - Documentation (patch bump)
REM   CFG  - Configuration (minor bump)
REM   DEP  - Dependencies (patch bump)
REM   OPS  - Operations/deployment (patch bump)
REM   WIP  - Work in progress (no version bump)
REM
REM NOTES:
REM   For full code definitions, see rules-change-codes.jsonc
REM
REM ============================================================

setlocal enabledelayedexpansion

REM ============================================================
REM Configuration
REM ============================================================

set SCRIPT_VERSION=0.1.0
set SCRIPT_AUTHOR=Your Name
set DEBUG=0

REM ============================================================
REM Main Script Logic
REM ============================================================

cls
echo.
echo Your Project Title
echo Version: %SCRIPT_VERSION%
echo Author: %SCRIPT_AUTHOR%
echo.

goto :Main

REM ============================================================
REM Functions
REM ============================================================

:PrintMessage
    echo [INFO] %~1
    goto :EOF

:PrintError
    echo [ERROR] %~1
    goto :EOF

:GetExampleData
    setlocal enabledelayedexpansion
    set "data=Item One"
    endlocal & set "exampleData=%data%"
    goto :EOF

REM ============================================================
REM Main
REM ============================================================

:Main
    call :PrintMessage "Script started"
    
    call :GetExampleData
    call :PrintMessage "Retrieved data: %exampleData%"
    
    call :PrintMessage "Script completed successfully"
    exit /b 0

:Error
    call :PrintError "An error occurred"
    exit /b 1

endlocal
