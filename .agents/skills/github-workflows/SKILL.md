---
name: github-workflows
description: >
  Monitors and manages GitHub Actions workflows and runs using the gh CLI. Use when
  listing, viewing, watching, rerunning, or cancelling workflow runs, or when
  diagnosing CI failures by inspecting logs. Triggers: "workflow run", "CI failed",
  "check actions", "rerun workflow", "cancel run", "view logs", "failed steps",
  "workflow status", "fix CI", "GitHub Actions", "list workflows", "enable workflow".
---

Use `gh run` to manage runs and `gh workflow` to manage workflow definitions.
Use `-R OWNER/REPO` when operating outside the current repo.

## List runs

```sh
# Recent runs (default: last 20)
gh run list

# Filter by status, branch, workflow, or event
gh run list --status failure --branch main --workflow ci.yml --limit 10

# All status values: queued|completed|in_progress|requested|waiting|pending
#                   action_required|cancelled|failure|neutral|skipped|success|timed_out
```

## View a run

```sh
# Summary
gh run view 12345

# With job steps expanded
gh run view 12345 --verbose

# Full log (all steps)
gh run view 12345 --log

# Only failed steps — most useful for diagnosing CI failures
gh run view 12345 --log-failed

# Specific job within a run
gh run view 12345 --job 456789 --log
```

## Watch a run live

```sh
gh run watch 12345
```

## Rerun

```sh
# Rerun entire run
gh run rerun 12345

# Rerun only failed jobs
gh run rerun 12345 --failed

# Rerun with debug logging enabled
gh run rerun 12345 --failed --debug
```

## Cancel

```sh
gh run cancel 12345
```

## Workflow definitions

```sh
# List all workflows
gh workflow list

# View workflow details
gh workflow view ci.yml

# Enable / disable a workflow
gh workflow enable ci.yml
gh workflow disable ci.yml

# Trigger a workflow_dispatch event
gh workflow run ci.yml [--ref main] [-f key=value]
```

## Diagnosing CI failures — recommended approach

1. Find the failing run:
   ```sh
   gh run list --status failure --limit 5
   ```
2. View failed logs:
   ```sh
   gh run view <run-id> --log-failed
   ```
3. Identify the root cause from the log output.
4. Fix the code or workflow file, push, and watch the rerun:
   ```sh
   gh run watch <new-run-id>
   ```

## Diagnose auth failures

```sh
gh auth status
# If scopes are missing: gh auth refresh
```
