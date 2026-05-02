// ============================================================
// METADATA
// ============================================================
// filename: template-jsx-with-metadata-hook.jsx
// title: React Custom Hook Template with Metadata
// description: Standardized React hook template with built-in metadata, changelog, and versioning
// author: Your Name
// schema_version: "2.0.0"
// version: 0.1.0
// date: 2026-04-22
// lastmod: 2026-04-22
//
// ============================================================
// CHANGELOG
// ============================================================
// Version 0.1.0 - 2026-04-22 - Your Name
// IMP: Initial setup with metadata template
//
// ============================================================
// CHANGE CODES REFERENCE
// ============================================================
// FIX - Bug fix (patch)
// IMP - New feature, backward-compatible (minor)
// CHG - Improvement or refactor (minor)
// REF - Documentation or references (patch)
// BRK - Breaking change (major)
// SEC - Security fix (patch)
// TST - Tests or CI changes (patch)
// DOC - Documentation updates (patch)
// CFG - Configuration changes (minor)
// DEP - Dependency updates (patch)
// OPS - Operations or deployment (patch)
// WIP - Work in progress (no semantic bump)
// ============================================================

import { useCallback, useEffect, useState } from "react";

/**
 * useDebouncedValue
 * -----------------
 * Returns a debounced version of a changing value.
 *
 * @param {*} value    - Value to debounce
 * @param {number} delay - Delay in milliseconds
 * @returns {*} Debounced value
 */
export default function useDebouncedValue(value, delay = 300) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  const updateValue = useCallback(() => {
    setDebouncedValue(value);
  }, [value]);

  useEffect(() => {
    const timeoutId = window.setTimeout(updateValue, delay);

    return () => {
      window.clearTimeout(timeoutId);
    };
  }, [updateValue, delay]);

  return debouncedValue;
}
``
