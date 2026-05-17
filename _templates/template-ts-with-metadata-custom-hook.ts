/**
 * useYourHook - Custom React Hook
 *
 * A brief description of what this hook does and when to use it.
 *
 * METADATA:
 *   title: useYourHook Custom Hook
 *   description: A brief description of what this file does
 *   author: Your Name
 *   filename: useYourHook.ts
 *   schema_version: "2.0.0"
 *   version: 0.1.0
 *   date: 2026-04-20
 *   lastmod: 2026-04-21
 *
 * CHANGELOG:
 *   Version 0.1.0 - 2026-04-20 - Your Name
 *     IMP: Initial custom hook setup with metadata template
 *
 * NOTES:
 *   Reference: rules-change-codes.jsonc
 *   Keep hooks focused and single-purpose
 *   Use TypeScript for better type safety
 */

import { useState, useCallback, useRef, useEffect, DependencyList } from "react";

// ============================================================
// Type Definitions
// ============================================================

interface UseYourHookOptions {
  /** Delay before executing the action (in milliseconds) */
  delay?: number;
  /** Whether to log debug information */
  debug?: boolean;
  /** Optional initialization value */
  initialValue?: string;
}

interface UseYourHookReturn {
  /** Current state value */
  value: string;
  /** Set the value */
  setValue: (value: string) => void;
  /** Execute the hook's main action */
  execute: () => Promise<void>;
  /** Whether the hook is currently executing */
  isExecuting: boolean;
  /** Any error that occurred during execution */
  error: Error | null;
  /** Reset the hook to initial state */
  reset: () => void;
}

// ============================================================
// Custom Hook
// ============================================================

/**
 * useYourHook - A custom hook for managing state and side effects
 *
 * @param {UseYourHookOptions} options - Configuration options
 * @param {number} [options.delay=0] - Delay before executing (ms)
 * @param {boolean} [options.debug=false] - Enable debug logging
 * @param {string} [options.initialValue=""] - Initial value
 * @returns {UseYourHookReturn} Hook state and methods
 *
 * @example
 * const { value, setValue, execute, isExecuting, error } = useYourHook({
 *   delay: 500,
 *   initialValue: "default"
 * });
 *
 * // Use in component:
 * useEffect(() => {
 *   execute();
 * }, [value]);
 */
export function useYourHook(
  options: UseYourHookOptions = {}
): UseYourHookReturn {
  const { delay = 0, debug = false, initialValue = "" } = options;

  // ============================================================
  // State
  // ============================================================

  const [value, setValue] = useState<string>(initialValue);
  const [isExecuting, setIsExecuting] = useState<boolean>(false);
  const [error, setError] = useState<Error | null>(null);

  const timeoutRef = useRef<NodeJS.Timeout | null>(null);

  // ============================================================
  // Effects
  // ============================================================

  useEffect(() => {
    // Cleanup on unmount
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, []);

  // ============================================================
  // Methods
  // ============================================================

  /**
   * Execute the hook's main action
   */
  const execute = useCallback(async () => {
    if (debug) {
      console.log("[useYourHook] Executing with value:", value);
    }

    setIsExecuting(true);
    setError(null);

    try {
      // Simulate delayed operation
      if (delay > 0) {
        await new Promise((resolve) => {
          timeoutRef.current = setTimeout(resolve, delay);
        });
      }

      // Your async logic here
      if (!value.trim()) {
        throw new Error("Value cannot be empty");
      }

      // Simulate work
      const result = await performAction(value);

      if (debug) {
        console.log("[useYourHook] Action completed:", result);
      }
    } catch (err) {
      const error = err instanceof Error ? err : new Error(String(err));
      setError(error);

      if (debug) {
        console.error("[useYourHook] Error:", error);
      }
    } finally {
      setIsExecuting(false);
    }
  }, [value, delay, debug]);

  /**
   * Reset the hook to initial state
   */
  const reset = useCallback(() => {
    setValue(initialValue);
    setError(null);
    setIsExecuting(false);

    if (timeoutRef.current) {
      clearTimeout(timeoutRef.current);
    }

    if (debug) {
      console.log("[useYourHook] Reset to initial state");
    }
  }, [initialValue, debug]);

  // ============================================================
  // Return
  // ============================================================

  return {
    value,
    setValue,
    execute,
    isExecuting,
    error,
    reset,
  };
}

// ============================================================
// Helper Functions
// ============================================================

/**
 * Placeholder for the actual action to perform
 * Replace with your business logic
 */
async function performAction(value: string): Promise<string> {
  // Simulate async operation
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(`Processed: ${value}`);
    }, 100);
  });
}

// ============================================================
// Alternative Hook Pattern: useAsync
// ============================================================

interface UseAsyncState<T> {
  status: "idle" | "pending" | "success" | "error";
  data: T | null;
  error: Error | null;
}

/**
 * useAsync - A generic hook for handling async operations
 *
 * @param {() => Promise<T>} asyncFunction - The async function to execute
 * @param {DependencyList} dependencies - Dependency list
 * @returns {UseAsyncState<T>} Async state
 *
 * @example
 * const { status, data, error } = useAsync(fetchData, [id]);
 */
export function useAsync<T>(
  asyncFunction: () => Promise<T>,
  dependencies: DependencyList = []
): UseAsyncState<T> {
  const [state, setState] = useState<UseAsyncState<T>>({
    status: "idle",
    data: null,
    error: null,
  });

  useEffect(() => {
    let isMounted = true;

    const execute = async () => {
      setState({ status: "pending", data: null, error: null });

      try {
        const response = await asyncFunction();

        if (isMounted) {
          setState({ status: "success", data: response, error: null });
        }
      } catch (error) {
        if (isMounted) {
          setState({
            status: "error",
            data: null,
            error: error instanceof Error ? error : new Error(String(error)),
          });
        }
      }
    };

    execute();

    return () => {
      isMounted = false;
    };
  }, dependencies);

  return state;
}
