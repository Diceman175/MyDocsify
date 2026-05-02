/**
 * YourComponent Test Suite
 *
 * Tests for YourComponent and related functionality.
 *
 * METADATA:
 *   title: YourComponent Test Suite
 *   author: Your Name
 *   filename: YourComponent.test.tsx
 *   schema_version: "2.0.0"
 *   version: 0.1.0
 *   date: 2026-04-20
 *   lastmod: 2026-04-20
 *
 * CHANGELOG:
 *   Version 0.1.0 - 2026-04-20 - Your Name
 *     IMP: Initial test setup with metadata template
 *
 * NOTES:
 *   Uses Jest and React Testing Library
 *   Reference: rules-change-codes.jsonc
 */

import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import YourComponent from "./YourComponent";

// ============================================================
// Test Suite: YourComponent
// ============================================================

describe("YourComponent", () => {
  const defaultProps = {
    title: "Test Component",
    description: "This is a test",
  };

  // ============================================================
  // Rendering Tests
  // ============================================================

  it("should render the component with title and description", () => {
    render(<YourComponent {...defaultProps} />);

    expect(screen.getByText("Test Component")).toBeInTheDocument();
    expect(screen.getByText("This is a test")).toBeInTheDocument();
  });

  it("should render input field and buttons", () => {
    render(<YourComponent {...defaultProps} />);

    expect(screen.getByPlaceholderText("Enter text...")).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /submit/i })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /clear/i })).toBeInTheDocument();
  });

  // ============================================================
  // User Interaction Tests
  // ============================================================

  it("should update input value when user types", async () => {
    const user = userEvent.setup();
    render(<YourComponent {...defaultProps} />);

    const input = screen.getByPlaceholderText(
      "Enter text..."
    ) as HTMLInputElement;
    await user.type(input, "test value");

    expect(input.value).toBe("test value");
  });

  it("should disable submit button when input is empty", () => {
    render(<YourComponent {...defaultProps} />);

    const submitButton = screen.getByRole("button", { name: /submit/i });
    expect(submitButton).toBeDisabled();
  });

  it("should enable submit button when input has text", async () => {
    const user = userEvent.setup();
    render(<YourComponent {...defaultProps} />);

    const input = screen.getByPlaceholderText("Enter text...");
    const submitButton = screen.getByRole("button", { name: /submit/i });

    await user.type(input, "test");

    expect(submitButton).not.toBeDisabled();
  });

  // ============================================================
  // Event Handler Tests
  // ============================================================

  it("should call onAction callback when submit button is clicked", async () => {
    const user = userEvent.setup();
    const mockOnAction = jest.fn();

    render(
      <YourComponent {...defaultProps} onAction={mockOnAction} />
    );

    const input = screen.getByPlaceholderText("Enter text...");
    const submitButton = screen.getByRole("button", { name: /submit/i });

    await user.type(input, "test value");
    await user.click(submitButton);

    await waitFor(() => {
      expect(mockOnAction).toHaveBeenCalledWith("test value");
    });
  });

  it("should clear input when clear button is clicked", async () => {
    const user = userEvent.setup();
    render(<YourComponent {...defaultProps} />);

    const input = screen.getByPlaceholderText(
      "Enter text..."
    ) as HTMLInputElement;
    const clearButton = screen.getByRole("button", { name: /clear/i });

    await user.type(input, "test value");
    expect(input.value).toBe("test value");

    await user.click(clearButton);
    expect(input.value).toBe("");
  });

  // ============================================================
  // Loading State Tests
  // ============================================================

  it("should show loading state when submit is clicked", async () => {
    const user = userEvent.setup();
    render(<YourComponent {...defaultProps} />);

    const input = screen.getByPlaceholderText("Enter text...");
    const submitButton = screen.getByRole("button", { name: /submit/i });

    await user.type(input, "test");
    await user.click(submitButton);

    expect(screen.getByRole("button", { name: /loading/i })).toBeInTheDocument();
  });

  // ============================================================
  // Props Tests
  // ============================================================

  it("should render children when provided", () => {
    render(
      <YourComponent {...defaultProps}>
        <div>Child content</div>
      </YourComponent>
    );

    expect(screen.getByText("Child content")).toBeInTheDocument();
  });

  it("should handle optional description", () => {
    const { rerender } = render(
      <YourComponent title="Test" />
    );

    expect(
      screen.queryByText("This is a test")
    ).not.toBeInTheDocument();

    rerender(
      <YourComponent title="Test" description="New description" />
    );

    expect(screen.getByText("New description")).toBeInTheDocument();
  });

  // ============================================================
  // Accessibility Tests
  // ============================================================

  it("should have proper button types", () => {
    render(<YourComponent {...defaultProps} />);

    const buttons = screen.getAllByRole("button");
    buttons.forEach((button) => {
      expect(button).toHaveTextContent(/submit|clear/i);
    });
  });

  it("should have accessible input field", () => {
    render(<YourComponent {...defaultProps} />);

    const input = screen.getByPlaceholderText("Enter text...");
    expect(input).toHaveAttribute("type", "text");
  });
});
