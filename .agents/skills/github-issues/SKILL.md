---
name: github-issues
description: >
  Manages GitHub issues using the gh CLI. Use when creating, reading, listing,
  editing, closing, reopening, deleting, or commenting on GitHub issues. Triggers:
  "create issue", "list issues", "close issue", "edit issue", "comment on issue",
  "assign issue", "label issue", "view issue", "delete issue", "reopen issue".
---

Use `gh issue` commands to manage issues. Always prefer non-interactive flags
to avoid prompts. Use `-R OWNER/REPO` when operating outside the current repo.

## Create

```sh
gh issue create --title "Title" --body "Description" [--label bug] [--assignee @me] [--milestone "v1.0"]
```

## Read / List

```sh
# List open issues (default)
gh issue list

# Filter by label, assignee, state, or limit
gh issue list --label bug --assignee @me --state open --limit 20

# View a specific issue
gh issue view 123
gh issue view 123 --json number,title,body,state,labels,assignees,comments
```

## Edit

```sh
gh issue edit 123 --title "New title" --body "New body"
gh issue edit 123 --add-label "help wanted" --remove-label bug
gh issue edit 123 --add-assignee @me --remove-assignee monalisa
gh issue edit 123 --milestone "v2.0" # or --remove-milestone
```

## Close / Reopen / Delete

```sh
gh issue close 123 [--comment "Closing because..."] [--reason "completed|not planned|duplicate"]
gh issue reopen 123 [--comment "Reopening because..."]
gh issue delete 123 --yes
```

## Comment

```sh
gh issue comment 123 --body "Comment text"
gh issue comment 123 --body-file comment.md
```

## Diagnose failures

If a command fails, check:
1. Auth: `gh auth status`
2. Repo scope: add `-R OWNER/REPO` or run from inside the repo
3. Project scope errors: run `gh auth refresh -s project`
