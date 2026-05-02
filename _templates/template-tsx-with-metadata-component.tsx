/**
 * Your Component Name
 *
 * A brief description of what this component does.
 *
 * METADATA:
 *   title: Your Component Name
 *   author: Your Name
 *   filename: YourComponent.tsx
 *   schema_version: "2.0.0"
 *   version: 0.1.0
 *   date: 2026-04-20
 *   lastmod: 2026-04-20
 *
 * CHANGELOG:
 *   Most recent entries first. Reference change codes from rules-change-codes.jsonc
 *   for semantic versioning.
 *
 *   Version 0.1.0 - 2026-04-20 - Your Name
 *     IMP: Initial component setup with metadata template
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

import React, { useState, useCallback, ReactNode } from "react";
import "./YourComponent.module.css";

// ============================================================
// Type Definitions
// ============================================================

interface YourComponentProps {
  /** Title to display in the component */
  title: string;
  /** Optional description */
  description?: string;
  /** Optional callback when action is triggered */
  onAction?: (value: string) => void;
  /** Optional children */
  children?: ReactNode;
}

interface ComponentState {
  isLoading: boolean;
  error: string | null;
  data: string | null;
}

// ============================================================
// Component
// ============================================================

/**
 * YourComponent - A sample React component with metadata tracking
 *
 * @param {YourComponentProps} props - Component props
 * @returns {React.ReactElement} The rendered component
 *
 * @example
 * <YourComponent
 *   title="My Component"
 *   description="This is a sample component"
 *   onAction={(value) => console.log(value)}
 * />
 */
const YourComponent: React.FC<YourComponentProps> = ({
  title,
  description,
  onAction,
  children,
}) => {
  // ============================================================
  // State
  // ============================================================

  const [state, setState] = useState<ComponentState>({
    isLoading: false,
    error: null,
    data: null,
  });

  const [inputValue, setInputValue] = useState<string>("");

  // ============================================================
  // Handlers
  // ============================================================

  const handleAction = useCallback(() => {
    setState((prev) => ({ ...prev, isLoading: true, error: null }));

    try {
      // Simulate async operation
      setTimeout(() => {
        setState((prev) => ({
          ...prev,
          isLoading: false,
          data: inputValue,
        }));

        if (onAction) {
          onAction(inputValue);
        }
      }, 500);
    } catch (error) {
      setState((prev) => ({
        ...prev,
        isLoading: false,
        error: error instanceof Error ? error.message : "Unknown error",
      }));
    }
  }, [inputValue, onAction]);

  const handleClear = useCallback(() => {
    setInputValue("");
    setState({
      isLoading: false,
      error: null,
      data: null,
    });
  }, []);

  // ============================================================
  // Render
  // ============================================================

  return (
    <div className="component">
      <h1 className="component__title">{title}</h1>

      {description && (
        <p className="component__description">{description}</p>
      )}

      <div className="component__content">
        <input
          type="text"
          className="component__input"
          placeholder="Enter text..."
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          disabled={state.isLoading}
        />

        <div className="component__actions">
          <button
            className="component__button component__button--primary"
            onClick={handleAction}
            disabled={state.isLoading || !inputValue.trim()}
          >
            {state.isLoading ? "Loading..." : "Submit"}
          </button>

          <button
            className="component__button component__button--secondary"
            onClick={handleClear}
            disabled={state.isLoading}
          >
            Clear
          </button>
        </div>

        {state.error && (
          <div className="component__error">{state.error}</div>
        )}

        {state.data && (
          <div className="component__result">Result: {state.data}</div>
        )}
      </div>

      {children && <div className="component__footer">{children}</div>}
    </div>
  );
};

export default YourComponent;
