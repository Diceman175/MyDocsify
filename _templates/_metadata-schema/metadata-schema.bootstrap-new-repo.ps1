#Requires -Version 7.0

<#
.SYNOPSIS
Bootstraps a new repository with a metadata-schema hydration kit.

.DESCRIPTION
Copies a governed subset of the source `_templates` library into a target
repository. The copy is non-destructive by default: existing files are skipped
unless `-Force` is supplied.

.METADATA
title: Metadata Schema Bootstrap New Repo Script
description: Hydration kit shim that copies the governed _templates payload into a target repository using safe non-destructive defaults
author: Steven Paradise
filename: metadata-schema.bootstrap-new-repo.ps1
schema_version: 2.0.0
version: 0.1.0
date: 2026-05-02
lastmod: 2026-05-02

.NOTES
Default behavior is safe and non-destructive. Use -WhatIf to preview.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetRepoPath,

    [string]$SourceTemplatesPath = "C:\Data\GitHub\Diceman175\My-Engineering-Cockpit\_templates",

    [string]$DestinationTemplatesFolderName = "_templates",

    [switch]$Force,

    [switch]$IncludeRootDocs,

    [switch]$ExcludeMetadataSchema
)

$ErrorActionPreference = "Stop"

function Resolve-NormalizedPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $resolved = Resolve-Path -LiteralPath $Path
    return $resolved.Path.TrimEnd('\\')
}

if (-not (Test-Path -LiteralPath $SourceTemplatesPath)) {
    throw "Source templates path not found: $SourceTemplatesPath"
}

if (-not (Test-Path -LiteralPath $TargetRepoPath)) {
    throw "Target repo path not found: $TargetRepoPath"
}

$sourceRoot = Resolve-NormalizedPath -Path $SourceTemplatesPath
$targetRoot = Resolve-NormalizedPath -Path $TargetRepoPath
$destinationTemplatesRoot = Join-Path -Path $targetRoot -ChildPath $DestinationTemplatesFolderName

if ($sourceRoot -eq $destinationTemplatesRoot.TrimEnd('\\')) {
    throw "Source and destination templates path resolve to the same location. Aborting to avoid self-copy."
}

if (-not (Test-Path -LiteralPath $destinationTemplatesRoot)) {
    if ($PSCmdlet.ShouldProcess($destinationTemplatesRoot, "Create destination templates root")) {
        New-Item -ItemType Directory -Path $destinationTemplatesRoot -Force | Out-Null
    }
}

$excludedDirectories = @('archive', 'versions', '.tmp', 'research')
$excludedFilePatterns = @('*.zip', '*.tar', '*.tar.gz')

if (-not $IncludeRootDocs) {
    $excludedFilePatterns += @('README.md', 'CHANGELOG.md')
}

if ($ExcludeMetadataSchema) {
    $excludedDirectories += '_metadata-schema'
}

$files = Get-ChildItem -LiteralPath $sourceRoot -Recurse -File | Where-Object {
    $fullName = $_.FullName
    $relative = [IO.Path]::GetRelativePath($sourceRoot, $fullName)

    foreach ($excludedDirectory in $excludedDirectories) {
        if ($fullName -match "[\\/]$([regex]::Escape($excludedDirectory))[\\/]") {
            return $false
        }
    }

    foreach ($pattern in $excludedFilePatterns) {
        if ($_.Name -like $pattern) {
            return $false
        }
    }

    if ($IncludeRootDocs -and $relative -in @('README.md', 'CHANGELOG.md')) {
        return $true
    }

    if ($relative -notmatch '^[\\/]?_metadata-schema[\\/]') {
        if ($_.Name -notlike 'template-*') {
            return $false
        }
    }
    else {
        if ($_.Name -notlike 'metadata-schema.*') {
            return $false
        }
    }

    return $true
}

$stats = [ordered]@{
    Copied   = 0
    Skipped  = 0
    Conflict = 0
}

foreach ($file in $files) {
    $relative = [IO.Path]::GetRelativePath($sourceRoot, $file.FullName)
    $target = Join-Path -Path $destinationTemplatesRoot -ChildPath $relative
    $targetDir = Split-Path -Path $target -Parent

    if (-not (Test-Path -LiteralPath $targetDir)) {
        if ($PSCmdlet.ShouldProcess($targetDir, "Create destination folder")) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
    }

    if ((Test-Path -LiteralPath $target) -and -not $Force) {
        $stats.Conflict++
        $stats.Skipped++
        Write-Warning "Skip existing file (use -Force to overwrite): $target"
        continue
    }

    if ($PSCmdlet.ShouldProcess($target, "Copy '$($file.FullName)'")) {
        Copy-Item -LiteralPath $file.FullName -Destination $target -Force:$Force
        $stats.Copied++
    }
}

Write-Host "Hydration complete."
Write-Host "  Source:      $sourceRoot"
Write-Host "  Destination: $destinationTemplatesRoot"
Write-Host "  Copied:      $($stats.Copied)"
Write-Host "  Skipped:     $($stats.Skipped)"
Write-Host "  Conflicts:   $($stats.Conflict)"
