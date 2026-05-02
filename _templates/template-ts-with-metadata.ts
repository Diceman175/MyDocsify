/**
 * Your Project Title
 *
 * A brief description of what this module does and its purpose in your project.
 *
 * METADATA:
 *   title: Your Project Title
 *   description: A brief description of what this file does
 *   author: Your Name
 *   filename: your-project-file.ts
 *   schema_version: "2.0.0"
 *   version: 0.1.0
 *   date: 2026-04-20
 *   lastmod: 2026-04-21
 *
 * CHANGELOG:
 *   Most recent entries first. Reference change codes from rules-change-codes.jsonc
 *   for semantic versioning.
 *
 *   Version 0.1.0 - 2026-04-20 - Your Name
 *     IMP: Initial TypeScript module setup with metadata template
 *
 * CHANGE CODES:
 *   Reference: rules-change-codes.jsonc
 *
 *   FIX  - Bug fixes (patch bump)
 *   IMP  - New features (minor bump)
 *   CHG  - Improvements/refactoring (minor bump)
 *   REF  - Documentation/references (patch bump)
 *   BRK  - Breaking changes (major bump)
 *   SEC  - Security fixes (patch bump)
 *   TST  - Tests/CI (patch bump)
 *   DOC  - Documentation (patch bump)
 *   CFG  - Configuration (minor bump)
 *   DEP  - Dependencies (patch bump)
 *   OPS  - Operations/deployment (patch bump)
 *   WIP  - Work in progress (no version bump)
 *
 * NOTES:
 *   For full code definitions, see rules-change-codes.jsonc
 */

// ============================================================
// Configuration
// ============================================================

const SCRIPT_VERSION = "0.1.0";
const SCRIPT_AUTHOR = "Your Name";
const DEBUG = false;

// ============================================================
// Type Definitions
// ============================================================

interface ExampleData {
  id: number;
  name: string;
  status: "active" | "inactive";
}

interface ConfigOptions {
  timeout: number;
  retries: number;
  debugMode: boolean;
}

// ============================================================
// Functions
// ============================================================

/**
 * Retrieves example data.
 *
 * @returns {ExampleData} An object containing example data.
 */
function getExampleData(): ExampleData {
  return {
    id: 1,
    name: "Item One",
    status: "active",
  };
}

/**
 * Prints an informational message.
 *
 * @param {string} message - The message to print.
 */
function printMessage(message: string): void {
  console.log(`[INFO] ${message}`);
}

/**
 * Prints an error message.
 *
 * @param {string} message - The error message to print.
 */
function printError(message: string): void {
  console.error(`[ERROR] ${message}`);
}

// ============================================================
// Classes
// ============================================================

/**
 * Example class for managing application state.
 */
class ExampleManager {
  private version: string;
  private author: string;
  private config: ConfigOptions;

  constructor(config?: Partial<ConfigOptions>) {
    this.version = SCRIPT_VERSION;
    this.author = SCRIPT_AUTHOR;
    this.config = {
      timeout: config?.timeout ?? 30,
      retries: config?.retries ?? 3,
      debugMode: config?.debugMode ?? DEBUG,
    };
  }

  /**
   * Initializes the manager.
   */
  public initialize(): void {
    printMessage("Manager initialized");
    if (this.config.debugMode) {
      console.log(`Configuration: ${JSON.stringify(this.config)}`);
    }
  }

  /**
   * Gets the current version.
   */
  public getVersion(): string {
    return this.version;
  }

  /**
   * Gets example data.
   */
  public getExampleData(): ExampleData {
    return getExampleData();
  }
}

// ============================================================
// Main Execution
// ============================================================

async function main(): Promise<void> {
  console.log("");
  console.log("Your Project Title");
  console.log(`Version: ${SCRIPT_VERSION}`);
  console.log(`Author: ${SCRIPT_AUTHOR}`);
  console.log("");

  try {
    printMessage("Script started");

    const manager = new ExampleManager({ debugMode: DEBUG });
    manager.initialize();

    const exampleData = manager.getExampleData();
    printMessage(`Retrieved data: ${JSON.stringify(exampleData)}`);

    printMessage("Script completed successfully");
  } catch (error) {
    if (error instanceof Error) {
      printError(error.message);
    } else {
      printError("An unknown error occurred");
    }
    process.exit(1);
  }
}

// ============================================================
// Exports
// ============================================================

export { ExampleManager, getExampleData, ExampleData, ConfigOptions };

// Execute main function
main().catch((error) => {
  printError(String(error));
  process.exit(1);
});
