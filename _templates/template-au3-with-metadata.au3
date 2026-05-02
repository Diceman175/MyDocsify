#cs
============================================================
Title: Your AutoIt Script
Description: A brief description of what this script does
============================================================

METADATA:
  title: Your AutoIt Script
  description: A brief description of what this script does
  author: Your Name
  filename: your-script.au3
  schema_version: "2.0.0"
  version: 0.1.0
  date: 2026-04-20
  lastmod: 2026-04-20

CHANGELOG:
  Most recent entries first. Reference change codes from
  rules-change-codes.jsonc for semantic versioning.

  Version 0.1.0 - 2026-04-20 - Your Name
    IMP: Initial script setup with metadata template

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

============================================================
#ce

; ============================================================
; Directives
; ============================================================

#NoTrayIcon
; #RequireAdmin   ; Uncomment if admin rights needed

; ============================================================
; Includes
; ============================================================

#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

; ============================================================
; Configuration
; ============================================================

Global Const $SCRIPT_VERSION  = "0.1.0"
Global Const $SCRIPT_AUTHOR   = "Your Name"
Global Const $SCRIPT_TITLE    = "Your AutoIt Script"
Global Const $DEBUG           = False

; ============================================================
; Entry Point
; ============================================================

Main()

; ============================================================
; Functions
; ============================================================

Func Main()
    If $DEBUG Then ConsoleWrite("[DEBUG] " & $SCRIPT_TITLE & " v" & $SCRIPT_VERSION & @CRLF)

    Local $sMessage = GetExampleData()
    MsgBox($MB_OK, $SCRIPT_TITLE, $sMessage)
EndFunc

Func GetExampleData()
    ; Replace with your actual logic
    Return "Item One - active"
EndFunc

Func PrintMessage($sMessage)
    ConsoleWrite("[INFO] " & $sMessage & @CRLF)
EndFunc

Func PrintError($sMessage)
    ConsoleWrite("[ERROR] " & $sMessage & @CRLF)
EndFunc

; ============================================================
; End of Script
; ============================================================
