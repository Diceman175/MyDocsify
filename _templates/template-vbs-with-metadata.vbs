'============================================================
' Title: Your Project Title
' Description: A brief description of what this script does
'============================================================
'
' METADATA:
'   title: Your Project Title
'   description: A brief description of what this script does
'   author: Your Name
'   filename: your-project-file.vbs
'   schema_version: "2.0.0"
'   version: 0.1.0
'   date: 2026-04-20
'   lastmod: 2026-04-21
'
' CHANGELOG:
'   Most recent entries first. Reference change codes from
'   rules-change-codes.jsonc for semantic versioning.
'
'   Version 0.1.0 - 2026-04-20 - Your Name
'     IMP: Initial VBS setup with metadata template
'
' CHANGE CODES:
'   Reference: rules-change-codes.jsonc
'
'   FIX  - Bug fixes (patch bump)
'   IMP  - New features (minor bump)
'   CHG  - Improvements/refactoring (minor bump)
'   REF  - Documentation/references (patch bump)
'   BRK  - Breaking changes (major bump)
'   SEC  - Security fixes (patch bump)
'   TST  - Tests/CI (patch bump)
'   DOC  - Documentation (patch bump)
'   CFG  - Configuration (minor bump)
'   DEP  - Dependencies (patch bump)
'   OPS  - Operations/deployment (patch bump)
'   WIP  - Work in progress (no version bump)
'
' NOTES:
'   For full code definitions, see rules-change-codes.jsonc
'
'============================================================

Option Explicit

Dim objShell, objFSO, scriptVersion, scriptAuthor

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

scriptVersion = "0.1.0"
scriptAuthor = "Your Name"

'============================================================
' Main Script Logic
'============================================================

WScript.Echo "Your Project Title"
WScript.Echo "Version: " & scriptVersion
WScript.Echo "Author: " & scriptAuthor
WScript.Echo ""

On Error Resume Next

Call Main()

If Err.Number <> 0 Then
    WScript.Echo "[ERROR] " & Err.Description
    WScript.Quit 1
End If

WScript.Quit 0

'============================================================
' Subroutines
'============================================================

Sub Main()
    Dim exampleData
    
    Call PrintMessage("Script started")
    
    exampleData = GetExampleData()
    Call PrintMessage("Retrieved data: " & exampleData)
    
    Call PrintMessage("Script completed successfully")
End Sub

Sub PrintMessage(message)
    WScript.Echo "[INFO] " & message
End Sub

Sub PrintError(message)
    WScript.Echo "[ERROR] " & message
End Sub

Function GetExampleData()
    GetExampleData = "Item One"
End Function

'============================================================
' End of Script
'============================================================
