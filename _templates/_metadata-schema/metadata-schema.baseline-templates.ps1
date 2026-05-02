#Requires -Version 7.0

<#
.SYNOPSIS
Baselines template payloads across sibling repositories.

.DESCRIPTION
Copies flattened template files from the source `_templates` library into every
repository directly under the configured GitHub root. By default this script is
non-destructive and skips existing files.

The flattened payload includes only files named `template-*` and excludes
archives, readmes, changelogs, and historical snapshot folders.

.METADATA
title: Metadata Schema Baseline Templates Script
description: Pushes a flattened set of canonical template files to sibling repositories with non-destructive safety defaults
author: Steven Paradise
filename: metadata-schema.baseline-templates.ps1
schema_version: 2.0.0
version: 0.1.0
date: 2026-05-02
lastmod: 2026-05-02

.NOTES
Run with -WhatIf first to review planned operations.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SourceTemplatesPath = "C:\Data\GitHub\Diceman175\My-Engineering-Cockpit\_templates",

    [string]$GitHubRoot = "C:\Data\GitHub\Diceman175",

    [string]$DestinationSubFolder = "_templates",

    [string[]]$ExcludeRepos = @("My-Engineering-Cockpit"),

    [switch]$Force,

    [switch]$IncludeFilesWithoutTemplatePrefix,

    [switch]$IncludeNonGitDirectories
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $SourceTemplatesPath)) {
    throw "Source templates path not found: $SourceTemplatesPath"
}

if (-not (Test-Path -LiteralPath $GitHubRoot)) {
    throw "GitHub root path not found: $GitHubRoot"
}

$sourceFiles = Get-ChildItem -LiteralPath $SourceTemplatesPath -Recurse -File | Where-Object {
    $fullName = $_.FullName

    if ($fullName -match "[\\/](archive|versions|research|\.tmp)[\\/]") {
        return $false
    }

    if ($_.Name -in @('README.md', 'CHANGELOG.md')) {
        return $false
    }

    if ($_.Name -match '(?i)readme') {
        return $false
    }

    if ($_.Name -like '*.zip' -or $_.Name -like '*.tar' -or $_.Name -like '*.tar.gz') {
        return $false
    }

    if (-not $IncludeFilesWithoutTemplatePrefix -and $_.Name -notlike 'template-*') {
        return $false
    }

    return $true
}

if (-not $sourceFiles) {
    throw "No source template files were found after filters."
}

$candidateRepos = Get-ChildItem -LiteralPath $GitHubRoot -Directory | Where-Object {
    $_.Name -notin $ExcludeRepos
}

$repos = $candidateRepos | Where-Object {
    $gitPath = Join-Path -Path $_.FullName -ChildPath ".git"
    $IncludeNonGitDirectories -or (Test-Path -LiteralPath $gitPath)
}

if (-not $IncludeNonGitDirectories) {
    $excludedNonGit = $candidateRepos | Where-Object {
        -not (Test-Path -LiteralPath (Join-Path -Path $_.FullName -ChildPath ".git"))
    }

    foreach ($nonGit in $excludedNonGit) {
        Write-Verbose "Skipping non-git directory: $($nonGit.Name)"
    }
}

if (-not $repos) {
    Write-Warning "No target repositories found under: $GitHubRoot"
    return
}

$results = New-Object System.Collections.Generic.List[object]

foreach ($repo in $repos) {
    $targetRoot = Join-Path -Path $repo.FullName -ChildPath $DestinationSubFolder

    if (-not (Test-Path -LiteralPath $targetRoot)) {
        if ($PSCmdlet.ShouldProcess($targetRoot, "Create destination folder")) {
            New-Item -ItemType Directory -Path $targetRoot -Force | Out-Null
        }
    }

    $copied = 0
    $skipped = 0
    $conflicts = 0

    foreach ($src in $sourceFiles) {
        $dest = Join-Path -Path $targetRoot -ChildPath $src.Name

        if ((Test-Path -LiteralPath $dest) -and -not $Force) {
            $conflicts++
            $skipped++
            continue
        }

        if ($PSCmdlet.ShouldProcess($dest, "Copy '$($src.FullName)'")) {
            Copy-Item -LiteralPath $src.FullName -Destination $dest -Force:$Force
            $copied++
        }
    }

    $results.Add([pscustomobject]@{
        Repository = $repo.Name
        Destination = $targetRoot
        Copied = $copied
        Skipped = $skipped
        Conflicts = $conflicts
    }) | Out-Null
}

$results | Sort-Object Repository | Format-Table -AutoSize
