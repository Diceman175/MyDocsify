#Requires -Version 7.0
#Requires -Modules powershell-yaml

<#
.SYNOPSIS
Metadata Schema Validation

.DESCRIPTION
Validates metadata-schema package sidecar references, metadata-field compliance,
schema-version consistency, and governed family alignment.

.METADATA
title: Metadata Schema Validation Script
description: Validates schema sidecar references, portable path placeholders, metadata field compliance, and schema-version consistency across metadata-schema sidecars
author: Steven Paradise
filename: metadata-schema.validate.ps1
schema_version: 2.0.0
version: 2.0.0
date: 2026-05-01
lastmod: 2026-05-02

.NOTES
Requires PowerShell 7+ and the powershell-yaml module.
Install with: Install-Module powershell-yaml -Scope CurrentUser

#>

param(
    [string]$Path = $PSScriptRoot
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Path)) {
    Write-Error "Path not found: $Path"
    exit 2
}

$schemaFile = Join-Path -Path $Path -ChildPath "metadata-schema.yaml"

if (-not (Test-Path -LiteralPath $schemaFile)) {
    Write-Error "metadata-schema.yaml not found under: $Path"
    exit 2
}

$violations = New-Object System.Collections.Generic.List[string]

function Add-Violation {
    param([string]$Message)

    $violations.Add($Message) | Out-Null
}

function Test-ArrayEquality {
    param(
        [object[]]$Left,
        [object[]]$Right
    )

    if ($null -eq $Left -or $null -eq $Right) {
        return $false
    }

    if ($Left.Count -ne $Right.Count) {
        return $false
    }

    for ($index = 0; $index -lt $Left.Count; $index++) {
        if ($Left[$index] -ne $Right[$index]) {
            return $false
        }
    }

    return $true
}

function Get-ContainerKeys {
    param([object]$Object)

    if ($null -eq $Object) {
        return @()
    }

    if ($Object -is [System.Collections.IDictionary]) {
        return @($Object.Keys)
    }

    return @($Object.PSObject.Properties.Name)
}

function Get-ContainerValue {
    param(
        [object]$Object,
        [string]$Name
    )

    if ($null -eq $Object) {
        return $null
    }

    if ($Object -is [System.Collections.IDictionary]) {
        return $Object[$Name]
    }

    return $Object.$Name
}

function Get-MetadataFromMdFrontmatter {
    param([string]$Raw)

    if ($Raw -notmatch '(?ms)^---\s*\r?\n(.*?)\r?\n---') {
        return $null
    }

    return ($matches[1] | ConvertFrom-Yaml)
}

function Get-MetadataFromPsMetadataBlock {
    param([string]$Raw)

    if ($Raw -notmatch '(?ms)\.METADATA\s*\r?\n(.*?)(?:\r?\n\.(?:NOTES|CHANGELOG|EXAMPLE|LINK|PARAMETER|OUTPUTS|INPUTS)|\r?\n#>)') {
        return $null
    }

    $metaLines = $matches[1] -split "`r?`n"
    $meta = [ordered]@{}

    foreach ($line in $metaLines) {
        if ($line -match '^\s*([a-z_]+)\s*:\s*(.+?)\s*$') {
            $meta[$matches[1]] = $matches[2].Trim('"')
        }
    }

    if ($meta.Count -eq 0) {
        return $null
    }

    return [pscustomobject]$meta
}

function Get-MetadataObject {
    param([string]$FilePath)

    $raw = Get-Content -LiteralPath $FilePath -Raw
    $ext = [System.IO.Path]::GetExtension($FilePath).ToLowerInvariant()

    switch ($ext) {
        '.md' {
            return Get-MetadataFromMdFrontmatter -Raw $raw
        }
        '.yaml' {
            $obj = $raw | ConvertFrom-Yaml
            if ($null -ne $obj.title) { return $obj }
            if ($null -ne $obj.metadata) { return $obj.metadata }
            return $null
        }
        '.yml' {
            $obj = $raw | ConvertFrom-Yaml
            if ($null -ne $obj.title) { return $obj }
            if ($null -ne $obj.metadata) { return $obj.metadata }
            return $null
        }
        '.jsonc' {
            $clean = $raw -replace '(?ms)/\*.*?\*/', '' -replace '(?m)^\s*//.*$', ''
            $obj = $clean | ConvertFrom-Json -Depth 64
            if ($null -ne $obj.metadata) { return $obj.metadata }
            if ($null -ne $obj._metadata) { return $obj._metadata }
            return $null
        }
        '.json' {
            $obj = $raw | ConvertFrom-Json -Depth 64
            if ($null -ne $obj.metadata) { return $obj.metadata }
            if ($null -ne $obj._metadata) { return $obj._metadata }
            return $null
        }
        '.ps1' {
            return Get-MetadataFromPsMetadataBlock -Raw $raw
        }
        default {
            return $null
        }
    }
}

function Test-RequiredMetadataFields {
    param(
        [string]$FilePath,
        [object]$Metadata,
        [string[]]$RequiredOrder
    )

    if ($null -eq $Metadata) {
        Add-Violation "${FilePath}: unable to parse metadata object."
        return
    }

    $metaProps = Get-ContainerKeys -Object $Metadata

    foreach ($field in $RequiredOrder) {
        if (-not ($metaProps -contains $field)) {
            Add-Violation "${FilePath}: missing required metadata field '$field'."
        }
        else {
            $value = [string](Get-ContainerValue -Object $Metadata -Name $field)
            if ([string]::IsNullOrWhiteSpace($value)) {
                Add-Violation "${FilePath}: metadata field '$field' is empty."
            }
        }
    }
}

function Test-MetadataOrder {
    param(
        [string]$FilePath,
        [string]$Raw,
        [string[]]$RequiredOrder
    )

    $lastPosition = -1

    foreach ($field in $RequiredOrder) {
        $pattern = '(?im)^\s*[#;''"\-\/]*"?' + [regex]::Escape($field) + '"?\s*:'
        $match = [regex]::Match($Raw, $pattern)

        if (-not $match.Success) {
            return
        }

        if ($match.Index -lt $lastPosition) {
            Add-Violation "${FilePath}: metadata field order does not match required_order."
            return
        }

        $lastPosition = $match.Index
    }
}

function Test-YamlDualHeaderVersionSync {
    param(
        [string]$FilePath,
        [string]$Raw,
        [object]$Metadata
    )

    $commentVersionMatch = [regex]::Match($Raw, '(?im)^\s*#\s*version\s*:\s*([0-9]+\.[0-9]+\.[0-9]+)\s*$')

    if (-not $commentVersionMatch.Success) {
        return
    }

    $commentVersion = $commentVersionMatch.Groups[1].Value
    $nativeVersion = [string]$Metadata.version

    if ($commentVersion -ne $nativeVersion) {
        Add-Violation "${FilePath}: comment-block version '$commentVersion' does not match native metadata version '$nativeVersion'."
    }
}

$schema = Get-Content -LiteralPath $schemaFile -Raw | ConvertFrom-Yaml

$expectedWorkspace = '${WORKSPACE_ROOT}'
$expectedTemplatesDir = '${WORKSPACE_ROOT}/_templates'

if ($schema.project.workspace -ne $expectedWorkspace) {
    Add-Violation "project.workspace must be '${WORKSPACE_ROOT}' (found: '$($schema.project.workspace)')."
}

if ($schema.project.templates_dir -ne $expectedTemplatesDir) {
    Add-Violation "project.templates_dir must be '${WORKSPACE_ROOT}/_templates' (found: '$($schema.project.templates_dir)')."
}

if (-not $schema.project.current_schema_version) {
    Add-Violation "project.current_schema_version is required and must define the canonical schema_version baseline."
}

$refKeys = @(
    'metadata_schema_schema_ref',
    'existing_templates_ref',
    'existing_templates_schema_ref',
    'change_governance_ref',
    'change_rules_ref',
    'change_rules_yaml_ref',
    'change_rules_schema_ref',
    'encoding_governance_ref',
    'encoding_rules_ref',
    'encoding_rules_schema_ref',
    'naming_governance_ref',
    'naming_rules_ref',
    'naming_rules_schema_ref',
    'validate_ref'
)

$resolvedRefFiles = New-Object System.Collections.Generic.List[string]

foreach ($refKey in $refKeys) {
    if (-not ((Get-ContainerKeys -Object $schema) -contains $refKey)) {
        Add-Violation "Missing required reference key: $refKey"
        continue
    }

    $refFile = [string](Get-ContainerValue -Object $schema -Name $refKey)

    if ([string]::IsNullOrWhiteSpace($refFile)) {
        Add-Violation "$refKey is empty."
        continue
    }

    $resolved = Join-Path -Path $Path -ChildPath $refFile

    if (-not (Test-Path -LiteralPath $resolved)) {
        Add-Violation "$refKey points to missing file: $refFile"
        continue
    }

    $resolvedRefFiles.Add($resolved) | Out-Null
}

$requiredOrder = @($schema.metadata_fields.required_order)
$requiredMetadataFields = @($schema.lint_rules_common.required_metadata_fields)

if (-not (Test-ArrayEquality -Left $requiredOrder -Right $requiredMetadataFields)) {
    Add-Violation "metadata_fields.required_order and lint_rules_common.required_metadata_fields must match exactly."
}

$expectedSchemaVersion = [string]$schema.project.current_schema_version
$filesToValidate = @($resolvedRefFiles + $schemaFile) | Sort-Object -Unique

foreach ($file in $filesToValidate) {
    $metadata = Get-MetadataObject -FilePath $file
    Test-RequiredMetadataFields -FilePath $file -Metadata $metadata -RequiredOrder $requiredOrder

    $raw = Get-Content -LiteralPath $file -Raw
    Test-MetadataOrder -FilePath $file -Raw $raw -RequiredOrder $requiredOrder

    $ext = [System.IO.Path]::GetExtension($file).ToLowerInvariant()

    if ($ext -in @('.yaml', '.yml')) {
        Test-YamlDualHeaderVersionSync -FilePath $file -Raw $raw -Metadata $metadata
    }

    if ($null -ne $metadata -and (Get-ContainerKeys -Object $metadata) -contains 'schema_version') {
        $actualSchemaVersion = [string](Get-ContainerValue -Object $metadata -Name 'schema_version')

        if ($actualSchemaVersion -ne $expectedSchemaVersion) {
            Add-Violation "${file}: schema_version '$actualSchemaVersion' does not match project.current_schema_version '$expectedSchemaVersion'."
        }
    }
}

$namingRulesFile = Join-Path -Path $Path -ChildPath 'metadata-schema.naming-rules.yaml'
if (Test-Path -LiteralPath $namingRulesFile) {
    $namingRules = Get-Content -LiteralPath $namingRulesFile -Raw | ConvertFrom-Yaml
    $governed = $namingRules.governed_families.'metadata-schema'.allowed_files

    if ($null -eq $governed) {
        Add-Violation "metadata-schema.naming-rules.yaml: governed_families.metadata-schema.allowed_files is missing."
    }
    else {
        $actualFiles = Get-ChildItem -LiteralPath $Path -File | Select-Object -ExpandProperty Name

        foreach ($actual in $actualFiles) {
            if ($governed -notcontains $actual) {
                Add-Violation "metadata-schema.naming-rules.yaml: governed_families.metadata-schema.allowed_files missing '$actual'."
            }
        }
    }
}

if ($violations.Count -gt 0) {
    Write-Host "metadata-schema validation failed:" -ForegroundColor Red
    $violations | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    exit 1
}

Write-Host "metadata-schema validation passed." -ForegroundColor Green
exit 0
