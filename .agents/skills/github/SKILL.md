---
name: github
description: >
  Manage GitHub issues, pull requests, and Actions workflows using the gh CLI.
  Use when the user asks to create, triage, inspect, review, merge, rerun, or
  debug GitHub work across issues, PRs, CI failures, workflow runs, or related
  repository automation.
---

# GitHub

## Quick Start

Use this skill when the task is about GitHub repository work through `gh`.

- For issues, follow [ISSUES.md](ISSUES.md).
- For pull requests and reviews, follow [PULL_REQUESTS.md](PULL_REQUESTS.md).
- For GitHub Actions runs and workflow debugging, follow [ACTIONS.md](ACTIONS.md).

## Instructions

1. Identify the GitHub surface area:
   - Issue lifecycle or triage: use [ISSUES.md](ISSUES.md)
   - Pull request lifecycle, review, or merge: use [PULL_REQUESTS.md](PULL_REQUESTS.md)
   - CI failure, workflow run, artifact, or rerun: use [ACTIONS.md](ACTIONS.md)
2. Prefer `gh` CLI commands over browser instructions.
3. When reading structured data, use `--json` and extract only the fields needed.
4. Use `-R owner/repo` when the target repo is not the current checkout.
5. If a command needs project scope and fails, run `gh auth refresh -s project`.
6. Ask for confirmation before irreversible or user-visible actions:
   - deleting an issue
   - merging a pull request
   - rerunning workflows or jobs
7. If the task spans multiple areas, start from the user’s immediate goal and only load the relevant sibling file.

## Rules and Constraints

- Default to non-destructive inspection first.
- Use HEREDOC-style multi-line bodies when creating long issue or PR content.
- Read the diff before submitting a PR review.
- Read workflow YAML before proposing CI fixes.
- Do not force-push or delete remote state without explicit approval.

## Examples

### Example: issue triage

User request:
```text
Create a GitHub issue for the flaky auth spec and assign it to me.
```

Action:
- Follow [ISSUES.md](ISSUES.md) to create the issue with `gh issue create`.

### Example: PR review

User request:
```text
Review PR 128 and leave inline comments on the auth changes.
```

Action:
- Follow [PULL_REQUESTS.md](PULL_REQUESTS.md), inspect the diff, then use the REST review endpoint for inline comments.

### Example: CI debugging

User request:
```text
Figure out why the latest main branch workflow failed.
```

Action:
- Follow [ACTIONS.md](ACTIONS.md), inspect recent failed runs, read failed logs, and open the workflow YAML.

## Bundled Resources

- [ISSUES.md](ISSUES.md): issue creation, triage, editing, comments, filters, and issue API patterns.
- [PULL_REQUESTS.md](PULL_REQUESTS.md): PR creation, review, merge, checks, and inline review comment API usage.
- [ACTIONS.md](ACTIONS.md): Actions run inspection, logs, workflow YAML debugging, reruns, and artifacts.
