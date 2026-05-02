<#
.SYNOPSIS
YourModule - A PowerShell module description.

.DESCRIPTION
A longer description of what this module does and its purpose in your project.

.METADATA
title: YourModule PowerShell Module
description: A longer description of what this module does and its purpose in your project.
author: Your Name
filename: YourModule.psm1
schema_version: "2.0.0"
version: 0.1.0
date: 2026-04-20
lastmod: 2026-04-21
.CHANGELOG
Most recent entries first. Reference change codes from rules-change-codes.jsonc
for semantic versioning.

Version 0.1.0 - 2026-04-20 - Your Name
  IMP: Initial module setup with metadata template

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

.NOTES
Paired with YourModule.psd1 module manifest.
For full code definitions, see rules-change-codes.jsonc

#>

#Requires -Version 5.1

# ============================================================
# Module-Scoped Variables
# ============================================================

$script:ModuleVersion = '0.1.0'
$script:ModuleName    = 'YourModule'

# ============================================================
# Private Functions (not exported)
# ============================================================

function Invoke-InternalOperation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Input
    )

    # Internal logic not exposed to module consumers
    return $Input.Trim()
}

# ============================================================
# Public Functions (exported via psd1 FunctionsToExport)
# ============================================================

function Get-ExampleData {
    <#
    .SYNOPSIS
    Retrieves example data from the module.

    .DESCRIPTION
    Returns a PSCustomObject with sample data demonstrating
    the module's data retrieval pattern.

    .PARAMETER Name
    Optional filter by item name.

    .OUTPUTS
    PSCustomObject

    .EXAMPLE
    PS> Get-ExampleData

    .EXAMPLE
    PS> Get-ExampleData -Name "Item One"
    #>
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param(
        [Parameter(Mandatory = $false)]
        [string]$Name
    )

    $data = @(
        [PSCustomObject]@{ Id = 1; Name = 'Item One'; Status = 'active' }
        [PSCustomObject]@{ Id = 2; Name = 'Item Two'; Status = 'inactive' }
    )

    if ($Name) {
        $data = $data | Where-Object { $_.Name -like "*$Name*" }
    }

    return $data
}

function Set-ExampleData {
    <#
    .SYNOPSIS
    Sets or updates example data.

    .DESCRIPTION
    Accepts a name and status and updates or creates an example item.

    .PARAMETER Name
    The name of the item to set.

    .PARAMETER Status
    The status to assign. Accepts 'active' or 'inactive'.

    .EXAMPLE
    PS> Set-ExampleData -Name "Item Three" -Status "active"
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('active', 'inactive')]
        [string]$Status
    )

    if ($PSCmdlet.ShouldProcess($Name, "Set status to '$Status'")) {
        Write-Verbose "Setting '$Name' to '$Status'"
        # Add your implementation here
    }
}

# ============================================================
# Module Initialization
# ============================================================

Write-Verbose "[$script:ModuleName] v$script:ModuleVersion loaded."
