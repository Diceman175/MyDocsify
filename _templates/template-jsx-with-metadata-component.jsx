// ============================================================
// METADATA
// ============================================================
// filename: template-jsx-with-metadata-component.jsx
// title: React Functional Component Template with Metadata
// description: Standardized JSX React component with enforced metadata, changelog, and versioning
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

import React from "react";
import PropTypes from "prop-types";

/**
 * UserCard
 * ----------
 * Displays a concise summary of a user with name, email,
 * and an optional action button.
 */
export default function UserCard({
  name,
  email,
  onSelect,
  isActive = false,
}) {
  return (
    <div
      className={`user-card${isActive ? " user-card--active" : ""}`}
      onClick={() => onSelect?.(email)}
      role="button"
      tabIndex={0}
      onKeyDown={(e) => e.key === "Enter" && onSelect?.(email)}
    >
      <h3 className="user-card__name">{name}</h3>
      <p className="user-card__email">{email}</p>
    </div>
  );
}

UserCard.propTypes = {
  /** Display name of the user */
  name: PropTypes.string.isRequired,

  /** User email address */
  email: PropTypes.string.isRequired,

  /** Optional callback when the card is selected */
  onSelect: PropTypes.func,

  /** Highlights the card when true */
  isActive: PropTypes.bool,
};
