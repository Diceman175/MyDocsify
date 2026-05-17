/**
 * yourFeature Redux Slice
 *
 * Redux Toolkit slice for managing feature state.
 *
 * METADATA:
 *   title: Your Feature Redux Slice
 *   description: A brief description of what this file does
 *   author: Your Name
 *   filename: yourFeatureSlice.ts
 *   schema_version: "2.0.0"
 *   version: 0.1.0
 *   date: 2026-04-20
 *   lastmod: 2026-04-21
 *
 * CHANGELOG:
 *   Version 0.1.0 - 2026-04-20 - Your Name
 *     IMP: Initial Redux slice setup with metadata template
 *
 * NOTES:
 *   Uses Redux Toolkit (@reduxjs/toolkit)
 *   Automatically generates action creators and reducer
 *   Use for complex state management
 *   Reference: rules-change-codes.jsonc
 */

import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";

// ============================================================
// Type Definitions
// ============================================================

interface YourFeatureItem {
  id: string;
  name: string;
  status: "active" | "inactive";
  createdAt: string;
}

interface YourFeatureState {
  /** List of items */
  items: YourFeatureItem[];
  /** Currently selected item */
  selectedId: string | null;
  /** Loading state */
  isLoading: boolean;
  /** Any error message */
  error: string | null;
  /** Pagination state */
  pagination: {
    page: number;
    pageSize: number;
    total: number;
  };
}

// ============================================================
// Initial State
// ============================================================

const initialState: YourFeatureState = {
  items: [],
  selectedId: null,
  isLoading: false,
  error: null,
  pagination: {
    page: 1,
    pageSize: 10,
    total: 0,
  },
};

// ============================================================
// Async Thunks
// ============================================================

/**
 * Fetch items from API
 */
export const fetchItems = createAsyncThunk<
  { items: YourFeatureItem[]; total: number },
  { page: number; pageSize: number },
  { rejectValue: string }
>("yourFeature/fetchItems", async (params, { rejectWithValue }) => {
  try {
    // Replace with actual API call
    const response = await fetch(
      `/api/items?page=${params.page}&pageSize=${params.pageSize}`
    );

    if (!response.ok) {
      return rejectWithValue("Failed to fetch items");
    }

    const data = await response.json();
    return data;
  } catch (error) {
    return rejectWithValue(
      error instanceof Error ? error.message : "Unknown error"
    );
  }
});

/**
 * Create a new item
 */
export const createItem = createAsyncThunk<
  YourFeatureItem,
  Omit<YourFeatureItem, "id" | "createdAt">,
  { rejectValue: string }
>("yourFeature/createItem", async (itemData, { rejectWithValue }) => {
  try {
    const response = await fetch("/api/items", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(itemData),
    });

    if (!response.ok) {
      return rejectWithValue("Failed to create item");
    }

    const data = await response.json();
    return data;
  } catch (error) {
    return rejectWithValue(
      error instanceof Error ? error.message : "Unknown error"
    );
  }
});

/**
 * Update an item
 */
export const updateItem = createAsyncThunk<
  YourFeatureItem,
  YourFeatureItem,
  { rejectValue: string }
>("yourFeature/updateItem", async (itemData, { rejectWithValue }) => {
  try {
    const response = await fetch(`/api/items/${itemData.id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(itemData),
    });

    if (!response.ok) {
      return rejectWithValue("Failed to update item");
    }

    const data = await response.json();
    return data;
  } catch (error) {
    return rejectWithValue(
      error instanceof Error ? error.message : "Unknown error"
    );
  }
});

/**
 * Delete an item
 */
export const deleteItem = createAsyncThunk<
  string,
  string,
  { rejectValue: string }
>("yourFeature/deleteItem", async (itemId, { rejectWithValue }) => {
  try {
    const response = await fetch(`/api/items/${itemId}`, {
      method: "DELETE",
    });

    if (!response.ok) {
      return rejectWithValue("Failed to delete item");
    }

    return itemId;
  } catch (error) {
    return rejectWithValue(
      error instanceof Error ? error.message : "Unknown error"
    );
  }
});

// ============================================================
// Slice
// ============================================================

const yourFeatureSlice = createSlice({
  name: "yourFeature",
  initialState,
  reducers: {
    // Synchronous actions
    selectItem: (state, action: PayloadAction<string | null>) => {
      state.selectedId = action.payload;
    },

    clearError: (state) => {
      state.error = null;
    },

    reset: () => {
      return initialState;
    },

    setPagination: (
      state,
      action: PayloadAction<{ page: number; pageSize: number }>
    ) => {
      state.pagination.page = action.payload.page;
      state.pagination.pageSize = action.payload.pageSize;
    },
  },

  extraReducers: (builder) => {
    // Fetch items
    builder
      .addCase(fetchItems.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(fetchItems.fulfilled, (state, action) => {
        state.isLoading = false;
        state.items = action.payload.items;
        state.pagination.total = action.payload.total;
      })
      .addCase(fetchItems.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload || "Failed to fetch items";
      });

    // Create item
    builder
      .addCase(createItem.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(createItem.fulfilled, (state, action) => {
        state.isLoading = false;
        state.items.unshift(action.payload);
        state.pagination.total += 1;
      })
      .addCase(createItem.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload || "Failed to create item";
      });

    // Update item
    builder
      .addCase(updateItem.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(updateItem.fulfilled, (state, action) => {
        state.isLoading = false;
        const index = state.items.findIndex((item) => item.id === action.payload.id);
        if (index !== -1) {
          state.items[index] = action.payload;
        }
      })
      .addCase(updateItem.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload || "Failed to update item";
      });

    // Delete item
    builder
      .addCase(deleteItem.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(deleteItem.fulfilled, (state, action) => {
        state.isLoading = false;
        state.items = state.items.filter((item) => item.id !== action.payload);
        state.pagination.total -= 1;
      })
      .addCase(deleteItem.rejected, (state, action) => {
        state.isLoading = false;
        state.error = action.payload || "Failed to delete item";
      });
  },
});

// ============================================================
// Exports
// ============================================================

export const { selectItem, clearError, reset, setPagination } = yourFeatureSlice.actions;
export default yourFeatureSlice.reducer;

// ============================================================
// Selectors
// ============================================================

/**
 * Select all items
 */
export const selectAllItems = (state: { yourFeature: YourFeatureState }) =>
  state.yourFeature.items;

/**
 * Select selected item
 */
export const selectSelectedItem = (state: { yourFeature: YourFeatureState }) => {
  if (!state.yourFeature.selectedId) return null;
  return state.yourFeature.items.find(
    (item) => item.id === state.yourFeature.selectedId
  );
};

/**
 * Select loading state
 */
export const selectIsLoading = (state: { yourFeature: YourFeatureState }) =>
  state.yourFeature.isLoading;

/**
 * Select error
 */
export const selectError = (state: { yourFeature: YourFeatureState }) =>
  state.yourFeature.error;

/**
 * Select pagination
 */
export const selectPagination = (state: { yourFeature: YourFeatureState }) =>
  state.yourFeature.pagination;
