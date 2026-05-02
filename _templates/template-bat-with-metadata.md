# Canonical Skeleton for .bat Files  <!-- omit from toc -->

The document serves as a started template for batch file creation

## Summary Metadata <!-- omit from toc -->

- FileName: `Canonical-Skeleton-BAT-Files.md`
- LastUpdated: `2026-04-09`
- Author: `Steven Paradise`
- Scope: `Canonical skeleton for .BAT files.
- Version: `1.0`
  - 1.0: Initial document creation


## Canonical Skeleton for .bat Files

REM -------------------------------------------------------------------------
REM File:        MyScript.bat
REM Purpose:     One-line summary of what this batch file does.
REM Author:      Author Name
REM Company:     Organization (optional)
REM Version:     1.0.0        REM semantic versioning: major.minor.patch
REM Scope:       System/Local/User/Service (brief)
REM Created:     2026-04-09   REM YYYY-MM-DD
REM LastUpdated: 2026-04-09   REM YYYY-MM-DD
REM Dependencies: cmd.exe, other programs (list)
REM Compatibility: Windows 11, 10, Server 2019 (list OS versions)
REM InternalNotes: Short internal note or TODOs
REM -------------------------------------------------------------------------

REM Change Log (most recent first)
REM -------------------------------------------------------------------------
REM Version  Date        Author         Changes
REM 1.0.1    2026-04-09  Author Name    FIX: Corrected path handling; DOC: Updated examples
REM 1.0.0    2026-04-01  Author Name    IMP: Initial build
Change Codes
	-	BRK: Remove; deprecated functions
	- CFG: Configuration; changes to defaults or environment setup
	- CHG: Change; Non-breaking modification or improvement (refactor, optimization, UX tweak)
	- DEP: Dependency; updates or build tooling
	- DOC: Documentation; major updates to documentation
  - FIX: Bug fix; patching addressing a bug or defect.
  - IMP: Implemented; new feature or cabability
	- OPS: Operational; configuration changes like deployment, packaging or release
  - REF: Reference; updates to comments or references with no functional changes
	- SEC: Security; related fixes, hardening, or vulnerabiliity mitigation
	- TST: Test; add or updated tests, CI configuration or test data
	- WIP: Work in progress; incomplete work not intended for release
REM -------------------------------------------------------------------------

REM Invocation examples
REM -------------------------------------------------------------------------
REM 1) Run from same folder:
REM    MyScript.bat
REM 2) Full path with arguments:
REM    C:\Scripts\MyScript.bat "arg1" /flag
REM 3) Scheduled Task (action):
REM    Program/script: C:\Windows\System32\cmd.exe
REM    Add arguments: /c "C:\Scripts\MyScript.bat > C:\Logs\MyScript.log 2>&1"

REM Usage / Parameters (document switches and env vars)
REM -------------------------------------------------------------------------
REM -h, /?        Display help
REM /dryrun       Simulate actions without making changes
REM /target:

Target directory for operation REM ENV_VAR Describe any environment variables read by the script
REM Exit codes (conventional)
REM -------------------------------------------------------------------------
REM 0   Success
REM 1   General error
REM 2   Invalid usage / bad parameters
REM 3   Missing dependency / file not found
REM 4   Permission denied
REM (Add project-specific codes here)

REM Example body skeleton (minimal, safe defaults)
@echo off
setlocal enabledelayedexpansion

REM --- Metadata variables (kept in runtime for logging if desired) ---
set "META_FileName=%~nx0"
set "META_Author=Author Name"
set "META_Version=1.0.0"
set "META_LastUpdated=2026-04-09"
set "META_Scope=System"

REM --- Basic argument parsing ---
if "%~1"=="" goto :ShowUsage
if /I "%~1"=="/?" goto :ShowUsage
if /I "%~1"=="-h" goto :ShowUsage

REM --- Main script starts here ---
echo [%META_FileName% v%META_Version%] Starting at %date% %time%
REM Put main logic below
REM Example placeholder:
echo Running main logic with args: %*
REM Simulate work
REM exit with success
endlocal
exit /b 0

:ShowUsage
echo.
echo %META_FileName% - One-line description
echo.
echo Usage:
echo   %META_FileName% [options] [arguments]
echo.
echo Options:
echo   /dryrun        Simulate actions without changes
echo   /target:

Target directory echo /? or -h Show this help echo. echo Examples: echo %META_FileName% /dryrun echo %META_FileName% /target:C:\Temp echo. endlocal exit /b 2
REM -------------------------------------------------------------------------
REM Notes:
REM - Keep metadata header at top for easy discovery by tools/grep.
REM - Update Change Log and LastUpdated on each release.
REM - Use exit /b  to return standardized exit codes for automation.
REM -------------------------------------------------------------------------*