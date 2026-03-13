---
name: github-pr
description: >
  Manage GitHub pull requests using the gh CLI. Create, view, edit, review,
  merge, and list PRs. Handle inline review comments via the REST API.
  Use when the user asks about pull requests, code review, or merging.
---

# GitHub Pull Requests

Manage the full PR lifecycle via the `gh` CLI. Supports creating, viewing,
editing, reviewing, merging, and listing pull requests.

## Quick Start

```bash
# Create a PR
gh pr create --title "Add login feature" --body "Implements OAuth login" --base main

# View a PR
gh pr view 42 --json title,state,reviews,mergeable

# Review a PR
gh pr review 42 --approve --body "LGTM"
```

## Instructions

### Creating PRs

Before creating, check for a pull request template in the repository:
- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `docs/pull_request_template.md`

If a template exists, use its structure for the PR body and fill in all
sections with real content — no placeholder text.

```bash
# Basic PR
gh pr create --title "Fix auth bug" --body "Resolves the session timeout issue"

# PR with options
gh pr create --title "Add caching layer" --base main --draft --reviewer alice,bob --label "enhancement"

# Multi-line body via HEREDOC
gh pr create --title "Refactor auth module" --body "$(cat <<'EOF'
## Summary
- Extracted token validation into a shared utility
- Added refresh token rotation

## Test plan
- [x] Unit tests pass
- [ ] Manual testing on staging
EOF
)"

# Quick PR from commit messages
gh pr create --fill
```

Flags reference:
- `--title` / `--body`: PR title and description
- `--base`: Target branch (defaults to repo default branch)
- `--draft`: Create as draft PR
- `--reviewer`: Request reviewers (comma-separated)
- `--label`: Add labels (comma-separated)
- `--assignee`: Assign users (comma-separated, `@me` for self)
- `--fill`: Auto-fill title and body from commits
- `--web`: Open in browser after creation

### Viewing PRs

```bash
# Human-readable view
gh pr view 42

# Structured JSON output
gh pr view 42 --json title,state,author,reviews,reviewRequests,mergeable,statusCheckRollup

# View discussion
gh pr view 42 --comments

# View the diff
gh pr diff 42

# File list only
gh pr diff 42 --name-only
```

See [REFERENCE.md](REFERENCE.md) for the full list of `--json` fields.

### Editing PRs

```bash
# Edit title and body
gh pr edit 42 --title "New title" --body "Updated description"

# Manage labels
gh pr edit 42 --add-label "bug,urgent"
gh pr edit 42 --remove-label "wip"

# Manage reviewers
gh pr edit 42 --add-reviewer alice,bob
gh pr edit 42 --remove-reviewer charlie

# Manage assignees
gh pr edit 42 --add-assignee @me
gh pr edit 42 --remove-assignee dave

# Set base branch
gh pr edit 42 --base develop

# Mark as ready for review (remove draft)
gh pr ready 42
```

### Reviewing PRs

Follow this workflow for thorough code reviews:

1. **Understand the scope:**
   ```bash
   gh pr view 42 --json title,body,files,additions,deletions
   ```

2. **Read the changes:**
   ```bash
   gh pr diff 42
   ```

3. **Submit a review:**
   ```bash
   # Approve
   gh pr review 42 --approve --body "Looks good, nice refactor"

   # Request changes
   gh pr review 42 --request-changes --body "A few issues to address"

   # Comment only (no approval/rejection)
   gh pr review 42 --comment --body "Some suggestions, non-blocking"
   ```

4. **Leave general comments:**
   ```bash
   gh pr comment 42 --body "Have we considered caching here?"
   ```

5. **Leave inline review comments** (requires REST API):

   The `gh pr review` command does not support inline comments. Use the REST API:

   ```bash
   gh api repos/{owner}/{repo}/pulls/42/reviews \
     --method POST \
     --field event="COMMENT" \
     --field body="Review with inline comments" \
     --field 'comments=[{"path":"src/auth.ts","line":15,"body":"Consider using a constant here"},{"path":"src/auth.ts","line":42,"body":"This needs error handling"}]'
   ```

   See [REFERENCE.md](REFERENCE.md) for the full inline review comment API reference.

### Merging PRs

```bash
# Squash merge (most common)
gh pr merge 42 --squash --delete-branch

# Merge commit
gh pr merge 42 --merge --delete-branch

# Rebase merge
gh pr merge 42 --rebase --delete-branch

# Enable auto-merge (merges when checks pass)
gh pr merge 42 --squash --auto

# Disable auto-merge
gh pr merge 42 --disable-auto
```

Always confirm with the user before merging. Use `--delete-branch` to clean up.

### Listing and status

```bash
# List open PRs
gh pr list

# Filter by state, label, author
gh pr list --state merged --label "bug" --author @me --limit 20

# Search with advanced queries
gh pr list --search "is:open review:required base:main"

# Current user's PR status across the repo
gh pr status
```

### Checking CI on PRs

```bash
# View check status
gh pr checks 42

# Watch checks until they complete
gh pr checks 42 --watch

# Only required checks
gh pr checks 42 --required

# Fail fast on first failure
gh pr checks 42 --watch --fail-fast
```

## Rules and Constraints

- Always use `--json` when fetching PR data for parsing or analysis.
- Use HEREDOC syntax for multi-line PR bodies (see Creating PRs example).
- Confirm with the user before merging PRs.
- Never force-push to branches with open PRs without explicit user approval.
- When reviewing, always read the diff before submitting a review.
- Use `{owner}/{repo}` from the current repo context for API calls (`gh` infers this automatically for most commands).

## Bundled Resources

- **[REFERENCE.md](REFERENCE.md)**: All `gh pr view --json` fields, REST API pattern for inline review comments, common filter combinations, and PR state machine reference.
