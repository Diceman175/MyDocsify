#
# ============================================================
# PowerShell Module Manifest
# ============================================================
#
# METADATA:
#   filename: YourModule.psd1
#   title: YourModule PowerShell Module Manifest
#   authorname: Your Name
#   version: 2026-04-21
#   created: 2026-04-20
#   last_updated: 2026-04-21
#
# CHANGELOG:
#   Version 2026-04-21 - Your Name
#     OPS: Include rules-change-codes files and update metadata
#   Version 2026-04-21 - Your Name
#     CHG: Clean 1.0.2 baseline snapshot
#   Most recent entries first. Reference change codes from
#   rules-change-codes.jsonc for semantic versioning.
#
#   Version 0.1.0 - 2026-04-20 - Your Name
#     IMP: Initial module manifest setup with metadata template
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
#   Generate a new GUID with: [System.Guid]::NewGuid().ToString()
#   For full code definitions, see rules-change-codes.jsonc
#
# ============================================================

@{
    # ============================================================
    # Required Fields
    # ============================================================

    # Root module or script file associated with this manifest
    RootModule        = 'YourModule.psm1'

    # Module version (must match metadata version above)
    ModuleVersion     = '0.1.0'

    # Supported PSEditions: 'Desktop', 'Core'
    CompatiblePSEditions = @('Desktop', 'Core')

    # Unique identifier for this module
    # Generate with: [System.Guid]::NewGuid().ToString()
    GUID              = '00000000-0000-0000-0000-000000000000'

    # Author of this module
    Author            = 'Your Name'

    # Company or vendor of this module
    CompanyName       = 'Your Company'

    # Copyright statement for this module
    Copyright         = '(c) 2026 Your Name. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'A brief description of what this module does'

    # ============================================================
    # PowerShell Version Requirements
    # ============================================================

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'

    # ============================================================
    # Module Dependencies
    # ============================================================

    # Modules that must be imported into the global environment
    # prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # ============================================================
    # Exported Members
    # ============================================================

    # Functions to export from this module
    FunctionsToExport = @(
        'Get-ExampleData',
        'Set-ExampleData'
    )

    # Cmdlets to export from this module
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport   = @()

    # ============================================================
    # Module Metadata
    # ============================================================

    # Private data to pass to the module specified in RootModule
    PrivateData = @{
        PSData = @{
            # Tags applied to this module (for PowerShell Gallery)
            Tags         = @('YourTag', 'Automation', 'Windows')

            # A URL to the license for this module
            # LicenseUri = 'https://example.com/license'

            # A URL to the main website for this project
            # ProjectUri = 'https://github.com/yourname/yourmodule'

            # Release notes for this version
            ReleaseNotes = 'Initial release with metadata template'
        }
    }
}
