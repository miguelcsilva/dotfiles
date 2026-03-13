---
allowed-tools: Bash(git branch:*), Bash(git log:*), Bash(git diff:*), Bash(git push:*), Bash(gh pr view:*), Bash(gh pr edit:*)
description: Update the pull request for the current branch with the latest changes.
---

Update the pull request for the current branch with the latest changes.

Use the `github-prs` skill for all PR operations and the `gh` CLI reference within it.

## Instructions

Follow these steps autonomously. Do not ask the user for input unless something is ambiguous.

### 1. Find the open PR for this branch

```bash
gh pr view --json number,title,body,baseRefName,headRefName,url,commits,files
```

If no PR exists for the current branch, inform the user and stop.

### 2. Read the current PR state

- Note the current title, body, and base branch.
- Run `git diff <base-branch>...HEAD` to get the full diff of all changes relative to the base branch.
- Run `git log --oneline <base-branch>..HEAD` to get the full commit list.
- Compare the diff and commits against the existing PR description to understand what has changed since the PR was last updated.

### 3. Push any local commits

If there are unpushed commits, push them:

```bash
git push
```

### 4. Update the PR

Based on the diff between the current state and the existing PR description, update the title and/or body using `gh pr edit`:

- If the scope of the PR has changed, update the title.
- Update the body to accurately reflect the current state of all changes. Preserve the existing structure/template but update the content. Do not remove sections — update or fill them in.

```bash
gh pr edit <number> --title "<new title>" --body "$(cat <<'EOF'
<updated body>
EOF
)"
```

Only update fields that actually need changing. If the existing description is already accurate, inform the user and skip the edit.

### 5. Report back

Provide a summary of what was updated and the PR URL.
