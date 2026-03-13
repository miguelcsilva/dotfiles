---
name: github-issue
description: >
  Manage GitHub issues using the gh CLI. Create, view, edit, close, reopen,
  delete, and comment on issues. Use when the user asks about creating or
  triaging issues, bug reports, feature requests, or issue tracking.
---

# GitHub Issues

Manage the full issue lifecycle via the `gh` CLI. Supports creating, viewing,
editing, closing, reopening, deleting, and commenting on issues.

## Quick Start

```bash
# Create an issue
gh issue create --title "Login fails on Safari" --body "Steps to reproduce..." --label bug

# View an issue
gh issue view 42 --json title,state,labels,assignees,comments

# List open issues
gh issue list --label bug --assignee @me
```

## Instructions

### Creating issues

```bash
# Basic issue
gh issue create --title "Fix auth bug" --body "Session times out after 10 minutes"

# Issue with options
gh issue create --title "Add dark mode" --label "enhancement" --assignee @me --milestone "v2.0"

# Multi-line body via HEREDOC
gh issue create --title "Refactor auth module" --body "$(cat <<'EOF'
## Problem
The current auth module mixes concerns.

## Proposed solution
Extract token validation into a shared utility.

## Acceptance criteria
- [ ] Unit tests pass
- [ ] No breaking changes to the public API
EOF
)"
```

Flags reference:
- `--title` / `--body`: Issue title and description
- `--label`: Add labels (comma-separated)
- `--assignee`: Assign users (comma-separated, `@me` for self)
- `--milestone`: Add to a milestone by name
- `--project`: Add to a project by title

### Viewing issues

```bash
# Human-readable view
gh issue view 42

# Structured JSON output
gh issue view 42 --json number,title,body,state,labels,assignees,milestone,comments,createdAt,url

# View with comments
gh issue view 42 --comments

# Open in browser
gh issue view 42 --web
```

See [REFERENCE.md](REFERENCE.md) for the full list of `--json` fields.

### Listing issues

```bash
# List open issues
gh issue list

# Filter by label, assignee, and state
gh issue list --label bug --assignee @me --state open --limit 20

# Search with advanced queries
gh issue list --search "is:open label:bug no:assignee"

# JSON output for parsing
gh issue list --json number,title,state,labels,assignees --limit 20

# My issue status across the repo
gh issue status
```

### Editing issues

```bash
# Edit title and body
gh issue edit 42 --title "New title" --body "Updated description"

# Manage labels
gh issue edit 42 --add-label "bug,urgent"
gh issue edit 42 --remove-label "wip"

# Manage assignees
gh issue edit 42 --add-assignee @me
gh issue edit 42 --remove-assignee alice

# Manage milestone
gh issue edit 42 --milestone "v2.0"
gh issue edit 42 --remove-milestone
```

### Closing, reopening, and deleting

```bash
# Close with a reason
gh issue close 42 --comment "Fixed in #55" --reason completed
gh issue close 42 --reason "not planned"
gh issue close 42 --reason duplicate

# Reopen
gh issue reopen 42 --comment "Still reproducible on v2.1"

# Delete (irreversible — confirm with user first)
gh issue delete 42 --yes
```

Reason values: `completed`, `not planned`, `duplicate`

### Commenting

```bash
# Add a comment
gh issue comment 42 --body "Confirmed, this also affects v1.8"

# Comment from a file
gh issue comment 42 --body-file comment.md

# Multi-line comment via HEREDOC
gh issue comment 42 --body "$(cat <<'EOF'
Investigated this further.

Root cause: the session cookie isn't being renewed on activity.
Fix: update the middleware to reset expiry on each request.
EOF
)"
```

### Transferring and pinning

```bash
# Transfer to another repo
gh issue transfer 42 OWNER/other-repo

# Pin / unpin
gh issue pin 42
gh issue unpin 42
```

## Rules and Constraints

- Always use `--json` when fetching issue data for parsing or analysis.
- Use HEREDOC syntax for multi-line issue bodies and comments.
- Confirm with the user before deleting issues — it is irreversible.
- Use `-R OWNER/REPO` when operating outside the current repo.
- If a command fails with a project scope error, run `gh auth refresh -s project`.

## Bundled Resources

- **[REFERENCE.md](REFERENCE.md)**: All `gh issue view --json` fields, common `gh issue list` filters, and REST API patterns for bulk operations.
