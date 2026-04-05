# GitHub Actions

Workflow run inspection, CI debugging, rerun, and artifact guidance for `gh run` and `gh workflow`.

## Quick Start

```bash
gh run list --branch main --status failure --limit 5
gh run view 123456 --log-failed
gh workflow view "CI" --yaml
```

## Instructions

### List runs and inspect details

```bash
gh run list --limit 10
gh run list --branch main --status failure --limit 5
gh run list --workflow ci.yml --limit 10
gh run list --user alice --limit 10
gh run list --status completed --limit 10
gh run list --json databaseId,name,status,conclusion,headBranch,event --limit 10
```

Run details:

```bash
gh run view 123456 --verbose
gh run view 123456 --json jobs,status,conclusion,name,headBranch
gh run view 123456 --job 789012
```

### Read failure logs

Start with failed output to reduce noise:

```bash
gh run view 123456 --log-failed
gh run view 123456 --log
gh run view 123456 --log --job 789012
```

### Read workflow definitions

```bash
gh workflow list
gh workflow view "CI" --yaml
```

Also inspect `.github/workflows/*.yml` directly when the repo is checked out.

When debugging, read the workflow YAML before proposing fixes so you understand triggers, job dependencies, permissions, caching, and environment setup.

### Debug CI failures

Use this loop:

1. Find the failed run.
```bash
gh run list --branch <branch> --status failure --limit 5
```
2. Identify the failed job or step.
```bash
gh run view <run-id> --verbose
```
3. Read the error output.
```bash
gh run view <run-id> --log-failed
```
4. Read the workflow definition.
```bash
gh workflow view <workflow-name> --yaml
```
5. Diagnose the failure category:
   - dependency resolution
   - test failures or flakiness
   - misconfiguration or missing secrets
   - permission problems
   - timeout or infrastructure issues
6. Fix the workflow YAML or source code as appropriate.

### Watch, rerun, and download artifacts

Watch:

```bash
gh run watch <run-id>
gh run watch <run-id> --exit-status
```

Confirm with the user before rerunning because it consumes CI resources:

```bash
gh run rerun <run-id>
gh run rerun <run-id> --failed
gh run rerun <run-id> --debug
```

Artifacts:

```bash
gh run download <run-id>
gh run download <run-id> --name "test-results"
gh run download <run-id> --pattern "coverage-*"
gh run download <run-id> --dir ./artifacts
```

Useful API endpoints:

```bash
gh api repos/{owner}/{repo}/actions/runs \
  --method GET \
  -f status=failure \
  -f branch=main \
  -F per_page=5
gh api repos/{owner}/{repo}/actions/runs/{run_id}
gh api repos/{owner}/{repo}/actions/runs/{run_id}/jobs
gh api repos/{owner}/{repo}/actions/runs/{run_id}/logs > logs.zip
gh api repos/{owner}/{repo}/actions/runs/{run_id}/rerun-failed-jobs --method POST
gh api repos/{owner}/{repo}/actions/runs/{run_id}/cancel --method POST
gh api repos/{owner}/{repo}/actions/runs/{run_id}/rerun \
  --method POST \
  --field enable_debug_logging=true
gh api repos/{owner}/{repo}/actions/workflows
gh api repos/{owner}/{repo}/actions/workflows/{workflow_id}/timing
```

Useful workflow concepts to check while debugging:
- trigger configuration in `on`
- job `permissions`
- cache keys and artifact paths
- reusable workflows and composite actions
- contexts such as `github.ref`, `github.event_name`, `runner.os`, and `needs.<job>.result`

## Rules and Constraints

- Check `--log-failed` before reading full logs.
- Read workflow YAML before proposing a CI fix.
- Confirm before rerunning workflows or jobs.
- Validate workflow YAML changes carefully.
- If the workflow references reusable workflows or composite actions, read those too before diagnosing.

## Bundled Resources

- Official CLI docs: `gh run`, `gh workflow`, GitHub Actions workflow syntax, and GitHub Actions contexts.

## Examples

User request:
```text
Find the last failed CI run on main and explain the root cause.
```

Commands:
```bash
gh run list --branch main --status failure --limit 1
gh run view <run-id> --log-failed
gh workflow view <workflow-name> --yaml
```

User request:
```text
Download the artifacts from run 123456.
```

Command:
```bash
gh run download 123456
```
