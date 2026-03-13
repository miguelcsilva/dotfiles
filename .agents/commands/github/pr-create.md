---
allowed-tools: Bash(git branch:*), Bash(git log:*), Bash(git diff:*), Bash(git push:*), Bash(gh pr list:*), Bash(gh pr create:*), Read, Glob
description: Create a pull request for the current branch.
---

Create a pull request for the current branch.

Use the `github-prs` skill for all PR operations and the `gh` CLI reference within it.

## Instructions

Follow these steps autonomously. Do not ask the user for input unless critical information is missing.

### 1. Gather context

- Run `git branch --show-current` to get the current branch name.
- Run `git log --oneline main..HEAD` (or the appropriate base branch) to get the list of commits that will be in this PR.
- Run `gh pr list --head $(git branch --show-current) --state open --json number,title,url` to check if a PR already exists for this branch. If one does, inform the user and stop.
- Run `git diff main...HEAD --stat` to get a summary of files changed, and `git diff main...HEAD` to read the full diff.

### 2. Check for a PR template

Look for a pull request template in the repository:
- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `docs/pull_request_template.md`

If a template exists, use it as the structure for the PR body. Fill in all sections based on the actual changes from the diff and commit history. Replace all placeholder text with real content.

If no template exists, write a clear PR body with:
- A summary of what changed and why.
- Key implementation details worth calling out.

### 3. Determine the PR title

Derive a concise, descriptive PR title (under 70 characters) from the commit history and diff. The title should describe the overall change, not just repeat the branch name.

### 4. Push the branch

Ensure the branch is pushed to the remote:

```bash
git push -u origin $(git branch --show-current)
```

### 5. Create the PR

Use `gh pr create` with a HEREDOC for the body to preserve formatting:

```bash
gh pr create --title "<title>" --body "$(cat <<'EOF'
<body content here>
EOF
)"
```

### 6. Report back

Output the PR URL so the user can review it.
