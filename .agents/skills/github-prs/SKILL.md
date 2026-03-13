---
name: github-prs
description: >
  Manages GitHub pull requests using the gh CLI. Use when creating, listing,
  viewing, editing, merging, closing, reviewing, or commenting on pull requests.
  Triggers: "create PR", "open pull request", "list PRs", "merge PR", "review PR",
  "edit PR", "close PR", "reopen PR", "PR checks", "PR diff", "PR status",
  "request review", "approve PR", "update branch".
---

Use `gh pr` commands to manage pull requests. Always prefer non-interactive
flags to avoid prompts. Use `-R OWNER/REPO` when operating outside the current repo.

## Create

Before creating a PR, check for a pull request template in the repo:

```sh
# Common template locations
.github/pull_request_template.md
.github/PULL_REQUEST_TEMPLATE.md
docs/pull_request_template.md
```

If a template exists, read it and use its structure for the PR body.

```sh
# Autofill title/body from commits
gh pr create --fill

# Explicit title and body (use template structure if one exists)
gh pr create --title "Title" --body "Description" [--base main] [--draft] [--reviewer handle] [--label bug]

# Use a repo template file directly
gh pr create --title "Title" --template ".github/pull_request_template.md"

# Link to an issue (auto-closes on merge)
gh pr create --title "Fix login bug" --body "Closes #42"
```

## Read / List

```sh
# List open PRs
gh pr list

# Filter by state, author, label, base branch
gh pr list --state open --author @me --label bug --base main

# View a PR (current branch or by number)
gh pr view
gh pr view 123
gh pr view 123 --json number,title,body,state,reviews,commits,labels,assignees

# Show CI check statuses
gh pr checks 123

# Show diff
gh pr diff 123
```

## Edit

```sh
gh pr edit 123 --title "New title" --body "New body"
gh pr edit 123 --add-label "needs review" --remove-label wip
gh pr edit 123 --add-reviewer monalisa --remove-reviewer hubot
gh pr edit 123 --base develop
```

## Review

```sh
gh pr review 123 --approve [--body "LGTM"]
gh pr review 123 --request-changes --body "Please fix X"
gh pr review 123 --comment --body "Question about Y"
```

## Merge

```sh
gh pr merge 123 --merge          # merge commit
gh pr merge 123 --squash         # squash and merge
gh pr merge 123 --rebase         # rebase and merge
gh pr merge 123 --squash --delete-branch
```

## Close / Reopen

```sh
gh pr close 123 [--comment "Closing because..."] [--delete-branch]
gh pr reopen 123 [--comment "Resuming work"]
```

## Comment

```sh
gh pr comment 123 --body "Comment text"
gh pr comment 123 --body-file comment.md
```

## Other

```sh
# Mark draft as ready
gh pr ready 123

# Update PR branch with latest base
gh pr update-branch 123

# Check out a PR locally
gh pr checkout 123
```

## Diagnose failures

If a command fails, check:
1. Auth: `gh auth status`
2. Repo scope: add `-R OWNER/REPO` or run from inside the repo
3. Project scope errors: run `gh auth refresh -s project`
4. No commits pushed: ensure branch is pushed before creating PR
