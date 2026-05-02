#!/usr/bin/env nu
# ============================================================
# Title: Your Nushell Script
# Description: A brief description of what this script does
# ============================================================
#
# METADATA:
#   title: Your Nushell Script
#   description: A brief description of what this script does
#   author: Your Name
#   filename: your-script.nu
#   schema_version: "2.0.0"
#   version: 0.1.0
#   date: 2026-04-20
#   lastmod: 2026-04-21
#
# CHANGELOG:
#   Most recent entries first. Reference change codes from
#   rules-change-codes.jsonc for semantic versioning.
#
#   Version 0.1.0 - 2026-04-20 - Your Name
#     IMP: Initial Nushell script setup with metadata template
#
# CHANGE CODES:
#   Reference: rules-change-codes.jsonc
#
#   FIX  - Bug fixes (patch bump)
#   IMP  - New features (minor bump)
#   CHG  - Improvements/refactoring (minor bump)
#   REF  - Documentation/references (patch bump)
#   BRK  - Breaking changes (major bump)
#   SEC  - Security fixes (patch bump)
#   TST  - Tests/CI (patch bump)
#   DOC  - Documentation (patch bump)
#   CFG  - Configuration (minor bump)
#   DEP  - Dependencies (patch bump)
#   OPS  - Operations/deployment (patch bump)
#   WIP  - Work in progress (no version bump)
#
# USAGE:
#   nu your-script.nu
#   nu your-script.nu --key "example-key"
#   nu your-script.nu --verbose
#
# NOTES:
#   Requires: Nushell >= 0.100.0
#   For full code definitions, see rules-change-codes.jsonc
# ============================================================


# ============================================================
# Constants
# ============================================================

const VERSION = "0.1.0"


# ============================================================
# Main command (entry point with --help support)
# ============================================================

# Your Nushell Script — brief description here.
def main [
  --key: string = "default-key"  # Key to look up
  --verbose                      # Enable verbose output
] {
  if $verbose {
    print $"[verbose] Starting v($VERSION)"
  }

  let result = get-example-data $key

  if $verbose {
    print $"[verbose] Result: ($result | to json)"
  }

  $result | table
}


# ============================================================
# Functions
# ============================================================

# Retrieve example data for the given key.
def get-example-data [
  key: string  # The key to look up
] -> record {
  if ($key | is-empty) {
    error make { msg: "key must not be empty" }
  }

  {
    key:       $key
    value:     $"Data for key: ($key)"
    timestamp: (date now | format date "%Y-%m-%dT%H:%M:%S")
  }
}

# Set or update example data.
def set-example-data [
  key: string    # The key to set
  value: string  # The value to assign
] -> bool {
  if ($key | is-empty) {
    error make { msg: "key must not be empty" }
  }
  if ($value | is-empty) {
    error make { msg: "value must not be empty" }
  }

  print $"Setting key=($key) value=($value)"
  true
}

# Print a formatted table of all example records.
def list-example-data [] -> table {
  [
    { id: 1, key: "key-one", value: "Value One", status: "active"   }
    { id: 2, key: "key-two", value: "Value Two", status: "inactive" }
  ]
}
