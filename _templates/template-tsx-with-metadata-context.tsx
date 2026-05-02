/**
 * YourContext - React Context for State Management
 *
 * Context provider and hooks for managing application state.
 *
 * METADATA:
 *   title: YourContext State Management
 *   description: A brief description of what this file does
 *   author: Your Name
 *   filename: YourContext.tsx
 *   schema_version: "2.0.0"
 *   version: 0.1.0
 *   date: 2026-04-20
 *   lastmod: 2026-04-20
 *
 * CHANGELOG:
 *   Version 0.1.0 - 2026-04-20 - Your Name
 *     IMP: Initial context setup with metadata template
 *
 * NOTES:
 *   Use Context for global state that doesn't require Redux complexity
 *   Keep context focused on a single concern
 *   Reference: rules-change-codes.jsonc
 */

import React, { createContext, useContext, useReducer, ReactNode, Dispatch, SetStateAction } from "react";

// ============================================================
// Type Definitions
// ============================================================

interface YourContextState {
  /** Current data stored in context */
  data: string;
  /** Loading state */
  isLoading: boolean;
  /** Any error message */
  error: string | null;
  /** Additional user preferences */
  preferences: {
    darkMode: boolean;
    fontSize: "small" | "medium" | "large";
    language: string;
  };
}

interface YourContextValue extends YourContextState {
  /** Update the data */
  updateData: (data: string) => void;
  /** Set loading state */
  setLoading: (loading: boolean) => void;
  /** Set error message */
  setError: (error: string | null) => void;
  /** Update preferences */
  updatePreferences: (preferences: Partial<YourContextState["preferences"]>) => void;
  /** Reset context to initial state */
  reset: () => void;
}

// ============================================================
// Initial State
// ============================================================

const initialState: YourContextState = {
  data: "",
  isLoading: false,
  error: null,
  preferences: {
    darkMode: false,
    fontSize: "medium",
    language: "en",
  },
};

// ============================================================
// Context Creation
// ============================================================

const YourContext = createContext<YourContextValue | undefined>(undefined);

// ============================================================
// Reducer
// ============================================================

type Action =
  | { type: "SET_DATA"; payload: string }
  | { type: "SET_LOADING"; payload: boolean }
  | { type: "SET_ERROR"; payload: string | null }
  | { type: "UPDATE_PREFERENCES"; payload: Partial<YourContextState["preferences"]> }
  | { type: "RESET" };

function reducer(state: YourContextState, action: Action): YourContextState {
  switch (action.type) {
    case "SET_DATA":
      return { ...state, data: action.payload };

    case "SET_LOADING":
      return { ...state, isLoading: action.payload };

    case "SET_ERROR":
      return { ...state, error: action.payload };

    case "UPDATE_PREFERENCES":
      return {
        ...state,
        preferences: { ...state.preferences, ...action.payload },
      };

    case "RESET":
      return initialState;

    default:
      return state;
  }
}

// ============================================================
// Provider Component
// ============================================================

interface YourProviderProps {
  children: ReactNode;
  /** Optional initial state override */
  initialStateOverride?: Partial<YourContextState>;
}

/**
 * YourProvider - Context provider component
 * Wrap your app or components with this provider to enable context access
 *
 * @example
 * <YourProvider>
 *   <YourComponent />
 * </YourProvider>
 */
export function YourProvider({
  children,
  initialStateOverride,
}: YourProviderProps): React.ReactElement {
  const [state, dispatch] = useReducer(
    reducer,
    initialStateOverride
      ? { ...initialState, ...initialStateOverride }
      : initialState
  );

  const value: YourContextValue = {
    ...state,
    updateData: (data: string) => dispatch({ type: "SET_DATA", payload: data }),
    setLoading: (loading: boolean) =>
      dispatch({ type: "SET_LOADING", payload: loading }),
    setError: (error: string | null) =>
      dispatch({ type: "SET_ERROR", payload: error }),
    updatePreferences: (prefs) =>
      dispatch({ type: "UPDATE_PREFERENCES", payload: prefs }),
    reset: () => dispatch({ type: "RESET" }),
  };

  return (
    <YourContext.Provider value={value}>{children}</YourContext.Provider>
  );
}

// ============================================================
// Custom Hooks
// ============================================================

/**
 * useYourContext - Hook to access context value
 * Must be used within YourProvider
 *
 * @returns {YourContextValue} Context value
 * @throws {Error} If used outside of YourProvider
 *
 * @example
 * const { data, updateData } = useYourContext();
 */
export function useYourContext(): YourContextValue {
  const context = useContext(YourContext);

  if (!context) {
    throw new Error("useYourContext must be used within YourProvider");
  }

  return context;
}

/**
 * useYourContextData - Hook to access only data
 */
export function useYourContextData(): string {
  const { data } = useYourContext();
  return data;
}

/**
 * useYourContextLoading - Hook to access only loading state
 */
export function useYourContextLoading(): [boolean, (loading: boolean) => void] {
  const { isLoading, setLoading } = useYourContext();
  return [isLoading, setLoading];
}

/**
 * useYourContextPreferences - Hook to access preferences
 */
export function useYourContextPreferences(): [
  YourContextState["preferences"],
  (prefs: Partial<YourContextState["preferences"]>) => void
] {
  const { preferences, updatePreferences } = useYourContext();
  return [preferences, updatePreferences];
}
