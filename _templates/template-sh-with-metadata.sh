#!/bin/bash
# ============================================================
# Title: Your Project Title
# Description: A brief description of what this script does
# ============================================================
#
# METADATA:
#   title: Your Project Title
#   description: A brief description of what this script does
#   author: Your Name
#   filename: your-project-file.sh
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
#     IMP: Initial shell script setup with metadata template
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
# NOTES:
#   For full code definitions, see rules-change-codes.jsonc
#
# ============================================================

set -euo pipefail

# ============================================================
# Configuration
# ============================================================

SCRIPT_VERSION="0.1.0"
SCRIPT_AUTHOR="Your Name"
SCRIPT_NAME="$(basename "$0")"
DEBUG="${DEBUG:-0}"

# ============================================================
# Functions
# ============================================================

print_message() {
    local message="$1"
    echo "[INFO] $message"
}

print_error() {
    local message="$1"
    echo "[ERROR] $message" >&2
}

get_example_data() {
    echo "Item One"
}

# ============================================================
# Main Script Logic
# ============================================================

main() {
    echo ""
    echo "Your Project Title"
    echo "Version: $SCRIPT_VERSION"
    echo "Author: $SCRIPT_AUTHOR"
    echo ""

    print_message "Script started"
    
    local example_data
    example_data=$(get_example_data)
    print_message "Retrieved data: $example_data"
    
    print_message "Script completed successfully"
    return 0
}

# ============================================================
# Execution
# ============================================================

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if ! main "$@"; then
        print_error "Script failed"
        exit 1
    fi
fi
