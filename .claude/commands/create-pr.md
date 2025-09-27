---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(gh pr create:*), Read, Grep
description: Create a pull request using gh CLI following the repository's PR template
---

## Context

- Current git status: !`git status`
- Current git diff from main branch: !`git diff main...HEAD`
- Current branch: !`git branch --show-current`
- Recent commits on branch: !`git log --oneline main..HEAD`

## Your task

Read the `.github/PULL_REQUEST_TEMPLATE.md` file and create a pull request using `gh pr create` that follows the template structure and format.
