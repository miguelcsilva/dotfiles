---
allowed-tools: Bash(git branch:*), Bash(gh run list:*), Bash(gh run view:*), Bash(gh workflow view:*), Bash(gh workflow list:*), Read, Edit, Glob
description: Find the latest failing GitHub Actions workflow for the current branch, diagnose the failure, and fix it.
---

Find the latest failing GitHub Actions workflow for the current branch, diagnose the failure, and fix it.

Use the `github-workflows` skill for all workflow and run operations, including the debugging patterns and common failure categories documented in it.

## Instructions

Follow these steps autonomously. Only ask the user for input if you are genuinely unsure about the correct fix.

### 1. Find failing workflows

```bash
gh run list --branch $(git branch --show-current) --status failure --limit 5 --json databaseId,name,status,conclusion,headBranch,event,createdAt
```

- If no failures are found, check for in-progress runs and inform the user. Stop here.
- If multiple failures exist, focus on the most recent one.

### 2. Identify which job/step failed

```bash
gh run view <run-id> --verbose
```

Note which job(s) and step(s) failed.

### 3. Read the failure logs

```bash
gh run view <run-id> --log-failed
```

Read the failed step output carefully. If the error is truncated or unclear, get the full logs:

```bash
gh run view <run-id> --log --job <job-id>
```

### 4. Understand the workflow

Read the workflow definition to understand the full pipeline context:

```bash
gh workflow view "<workflow-name>" --yaml
```

Also read the workflow file directly from `.github/workflows/` if needed for the full unabridged YAML.

### 5. Diagnose the root cause

Based on the logs and workflow definition, determine the root cause. Refer to the `github-workflows` skill for common failure categories and resolution patterns:

- Dependency issues, test failures, build errors, configuration errors, workflow YAML issues, permissions, timeouts, infrastructure.

### 6. Fix the issue

- If the issue is in source code (test failures, build errors, type errors), fix the code directly.
- If the issue is in workflow YAML, edit `.github/workflows/<file>.yml`.
- If the issue is a flaky test or infrastructure problem that can't be fixed from code, inform the user with your diagnosis.

After fixing, verify your changes make sense by reading the modified files.

### 7. Report back

Provide a clear summary:
- Which workflow and job failed.
- What the root cause was.
- What you fixed and why.
- Remind the user to commit and push the changes so CI can re-run, or suggest rerunning the workflow if no code changes were needed.
