---
name: github-workflow
description: >
  Debug GitHub Actions CI/CD failures using the gh CLI. View workflow runs,
  read failure logs, inspect workflow YAML, rerun jobs, and download artifacts.
  Use when the user asks about CI failures, workflow runs, or Actions debugging.
---

# GitHub Actions

Debug CI/CD failures and manage GitHub Actions workflows via the `gh` CLI.
Supports viewing runs, reading logs, diagnosing failures, rerunning jobs,
and inspecting workflow definitions.

## Quick Start

```bash
# Find recent failures
gh run list --branch main --status failure --limit 5

# Read failure logs
gh run view 123456 --log-failed

# Check workflow definition
gh workflow view "CI" --yaml
```

## Instructions

### Listing workflow runs

```bash
# Recent runs
gh run list --limit 10

# Filter by branch and status
gh run list --branch main --status failure --limit 5

# Filter by workflow
gh run list --workflow ci.yml --limit 10

# Filter by user
gh run list --user alice --limit 10

# Completed runs only
gh run list --status completed --limit 10

# JSON output for parsing
gh run list --json databaseId,name,status,conclusion,headBranch,event --limit 10
```

Status values: `queued`, `in_progress`, `completed`
Conclusion values: `success`, `failure`, `cancelled`, `skipped`, `timed_out`

### Viewing run details

```bash
# Human-readable summary with step-by-step breakdown
gh run view 123456 --verbose

# Structured JSON output
gh run view 123456 --json jobs,status,conclusion,name,headBranch

# View a specific job within a run
gh run view 123456 --job 789012
```

### Reading failure logs

Start with `--log-failed` to reduce noise, then expand to `--log` if needed.

```bash
# Failed step output only (most useful for debugging)
gh run view 123456 --log-failed

# Full logs for all steps
gh run view 123456 --log

# Logs for a specific job
gh run view 123456 --log --job 789012
```

### Understanding workflows

```bash
# List all workflows in the repo
gh workflow list

# View workflow YAML source
gh workflow view "CI" --yaml

# Read workflow files directly
# Files are located in .github/workflows/*.yml
```

When debugging, always read the workflow YAML to understand the pipeline
structure, triggers, job dependencies, and environment configuration.

### Debugging CI failures

Follow this diagnostic loop for systematic debugging:

1. **Find the failure:**
   ```bash
   gh run list --branch <branch> --status failure --limit 5
   ```

2. **Identify which job/step failed:**
   ```bash
   gh run view <run-id> --verbose
   ```

3. **Read the error output:**
   ```bash
   gh run view <run-id> --log-failed
   ```

4. **Understand the pipeline:**
   ```bash
   gh workflow view <workflow-name> --yaml
   ```
   Or read the file directly from `.github/workflows/<file>.yml`.

5. **Diagnose the root cause.** Common categories:
   - **Dependency issues**: Package resolution failures, version conflicts
   - **Test failures**: Failing assertions, flaky tests, missing fixtures
   - **Configuration errors**: Bad environment variables, missing secrets
   - **Permission issues**: Token scopes, GITHUB_TOKEN permissions
   - **Timeout**: Jobs exceeding time limits
   - **Infrastructure**: Runner availability, disk space, network issues

6. **Fix the issue:**
   - If workflow YAML is the problem, edit `.github/workflows/<file>.yml`
   - If source code is the problem, fix the code directly

7. **Rerun the workflow:**
   ```bash
   # Rerun only failed jobs
   gh run rerun <run-id> --failed

   # Full rerun
   gh run rerun <run-id>
   ```

### Watching runs

```bash
# Monitor a run in real-time until it completes
gh run watch <run-id>

# Exit with non-zero if run fails
gh run watch <run-id> --exit-status
```

### Rerunning workflows

```bash
# Rerun all jobs
gh run rerun <run-id>

# Rerun only failed jobs (faster)
gh run rerun <run-id> --failed

# Rerun with debug logging enabled
gh run rerun <run-id> --debug
```

Always confirm with the user before rerunning workflows.

### Downloading artifacts

```bash
# Download all artifacts from a run
gh run download <run-id>

# Download specific artifact by name
gh run download <run-id> --name "test-results"

# Download artifacts matching a pattern
gh run download <run-id> --pattern "coverage-*"

# Download to a specific directory
gh run download <run-id> --dir ./artifacts
```

## Rules and Constraints

- Always check `--log-failed` before `--log` to minimize noise.
- Read the workflow YAML before proposing fixes to understand the full pipeline context.
- Confirm with the user before rerunning workflows (they consume CI minutes).
- When fixing workflow YAML, validate syntax before writing (correct indentation, valid action references, proper expression syntax).
- Use `--json` for structured output when parsing run data programmatically.
- When a workflow file references reusable workflows or composite actions, read those files too before diagnosing issues.

## Bundled Resources

- **[REFERENCE.md](REFERENCE.md)**: GitHub Actions workflow YAML syntax reference, common failure patterns and fixes, useful API endpoints, and environment variable/context reference.
