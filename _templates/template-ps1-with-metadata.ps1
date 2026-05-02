<#
.SYNOPSIS
Your Project Title

.DESCRIPTION
A brief description of what this script does and its purpose in your project.

.METADATA
filename: your-project-file.ps1
title: Your Project Title
authorname: Your Name
version: 2026-04-21
created: 2026-04-20
last_updated: 2026-04-21
.CHANGELOG
Version 2026-04-21 - Your Name
  OPS: Include rules-change-codes files and update metadata
Version 2026-04-21 - Your Name
  CHG: Clean 1.0.2 baseline snapshot
Most recent entries first. Reference change codes from rules-change-codes.jsonc for semantic versioning.

Version 0.1.0 - 2026-04-20 - Your Name
  IMP: Initial script setup with metadata template

.CHANGE_CODES
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

.EXAMPLE
PS> .\your-project-file.ps1

.NOTES
For full code definitions, see rules-change-codes.jsonc

#>

param(
    [Parameter(Mandatory = $false)]
    [string]$ExampleParam = "default_value"
)

# ============================================================
# Configuration Section
# ============================================================

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

# ============================================================
# Main Script Logic
# ============================================================

Write-Host "Script: Your Project Title"
Write-Host "Version: 0.1.0"
Write-Host "Author: Your Name"
Write-Host ""

# Add your script logic here

# ============================================================
# Functions
# ============================================================

function Get-ExampleData {
    <#
    .SYNOPSIS
    Retrieves example data.
    
    .DESCRIPTION
    A brief description of what this function does.
    
    .OUTPUTS
    PSCustomObject
    #>
    
    return @{
        id   = 1
        name = "Item One"
        status = "active"
    }
}

# ============================================================
# Script Execution
# ============================================================

try {
    $data = Get-ExampleData
    Write-Verbose "Retrieved data: $($data | ConvertTo-Json)"
}
catch {
    Write-Error "An error occurred: $_"
    exit 1
}

Write-Host "Script completed successfully."
