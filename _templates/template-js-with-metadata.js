/**
 * ============================================================
 * Title: Your JavaScript Module
 * Purpose: A brief description of what this module does
 * ============================================================
 *
 * METADATA:
 *   filename: main.js
 *   title: Your JavaScript Module
 *   authorname: Your Name
 *   version: 2026-04-21
 *   created: 2026-04-20
 *   last_updated: 2026-04-21
 *
 * CHANGELOG:
 *   Version 2026-04-21 - Your Name
 *     OPS: Include rules-change-codes files and update metadata
 *   Version 2026-04-21 - Your Name
 *     CHG: Clean 1.0.2 baseline snapshot
 *   Most recent entries first. Reference change codes from
 *   rules-change-codes.jsonc for semantic versioning.
 *
 *   Version 0.1.0 - 2026-04-20 - Your Name
 *     IMP: Initial JS module setup with metadata template
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
 *   ES Module format (import/export). Node.js >= 18 or browser
 *   with <script type="module">. For CommonJS, replace
 *   import/export with require()/module.exports.
 *   For full code definitions, see rules-change-codes.jsonc
 * ============================================================
 */

// ============================================================
// Constants
// ============================================================

const VERSION = '0.1.0';

// ============================================================
// Imports
// ============================================================

// import { something } from './other-module.js';

// ============================================================
// Private helpers
// ============================================================

/**
 * Validates that a required value is not null/undefined/empty.
 * @param {*} value
 * @param {string} name
 * @returns {boolean}
 */
function isPresent(value, name) {
  if (value === null || value === undefined || value === '') {
    console.error(`[validation] Required value missing: ${name}`);
    return false;
  }
  return true;
}

// ============================================================
// Public API
// ============================================================

/**
 * Retrieves example data by key.
 * @param {string} key - The key to look up.
 * @returns {{ key: string, value: string, timestamp: string }}
 */
export function getExampleData(key) {
  if (!isPresent(key, 'key')) {
    throw new Error('key is required');
  }

  return {
    key,
    value:     `Data for key: ${key}`,
    timestamp: new Date().toISOString(),
  };
}

/**
 * Sets or updates example data.
 * @param {string} key - The key to set.
 * @param {string} value - The value to assign.
 * @returns {boolean} True on success.
 */
export function setExampleData(key, value) {
  if (!isPresent(key, 'key') || !isPresent(value, 'value')) {
    throw new Error('key and value are required');
  }

  console.log(`[setExampleData] Setting key="${key}" value="${value}"`);
  return true;
}

// ============================================================
// Initialisation (runs when module is loaded)
// ============================================================

(function init() {
  console.log(`[main.js] v${VERSION} loaded`);
})();

// ============================================================
// Entry point (browser: DOMContentLoaded / Node: top-level await)
// ============================================================

/**
 * Main function — wire up UI or run Node.js logic here.
 */
export async function main() {
  try {
    const result = getExampleData('example-key');
    console.log('[main] result:', result);
  } catch (err) {
    console.error('[main] Error:', err.message);
  }
}

// Auto-run if loaded as a script (not imported as a library)
// Browser:  <script type="module" src="main.js"></script>
// Node.js:  node --input-type=module main.js
if (typeof window !== 'undefined') {
  document.addEventListener('DOMContentLoaded', main);
}
