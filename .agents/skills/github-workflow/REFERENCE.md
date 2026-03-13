# GitHub Actions Reference

Workflow YAML syntax, common failure patterns, API endpoints, and context/environment variable reference.

## Workflow YAML syntax

### Triggers (`on`)

```yaml
on:
  push:
    branches: [main, release/*]
    paths: ['src/**', '*.ts']
  pull_request:
    branches: [main]
    types: [opened, synchronize, reopened]
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        default: 'staging'
        type: choice
        options: [staging, production]
  schedule:
    - cron: '0 6 * * 1'  # Every Monday at 6am UTC
```

### Jobs

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 15
    permissions:
      contents: read
      pull-requests: write
    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm test

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    environment: production
    steps:
      - uses: actions/checkout@v4
      - run: ./deploy.sh
```

### Matrix strategy

```yaml
jobs:
  test:
    strategy:
      fail-fast: false
      matrix:
        os: [ubuntu-latest, macos-latest]
        node: [18, 20, 22]
        exclude:
          - os: macos-latest
            node: 18
        include:
          - os: ubuntu-latest
            node: 22
            coverage: true
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
```

### Services (sidecar containers)

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_PASSWORD: postgres
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
```

### Caching

```yaml
- uses: actions/cache@v4
  with:
    path: |
      ~/.npm
      node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

### Artifacts

```yaml
# Upload
- uses: actions/upload-artifact@v4
  with:
    name: test-results
    path: coverage/
    retention-days: 7

# Download (in a later job)
- uses: actions/download-artifact@v4
  with:
    name: test-results
```

### Reusable workflows

```yaml
# Caller
jobs:
  call-workflow:
    uses: ./.github/workflows/reusable.yml
    with:
      environment: production
    secrets: inherit

# Reusable workflow (reusable.yml)
on:
  workflow_call:
    inputs:
      environment:
        required: true
        type: string
```

## Common failure patterns and fixes

### Dependency resolution

**Symptoms:** `npm ERR! Could not resolve dependency`, `pip install failed`, lock file conflicts

**Fixes:**
- Use `npm ci` instead of `npm install` to use exact lock file
- Clear cache: add `actions/cache` with proper key invalidation
- Pin dependency versions explicitly in package.json

### Permission errors

**Symptoms:** `Resource not accessible by integration`, `403 Forbidden`, `Permission denied`

**Fixes:**
- Add explicit `permissions` block to the job:
  ```yaml
  permissions:
    contents: read
    pull-requests: write
    issues: write
  ```
- Check if `GITHUB_TOKEN` has sufficient scopes
- For cross-repo access, use a PAT or GitHub App token

### Timeout issues

**Symptoms:** `The job running on runner ... has exceeded the maximum execution time`

**Fixes:**
- Increase `timeout-minutes` on the job
- Add timeout to individual steps: `timeout-minutes: 10`
- Investigate slow steps (network downloads, large builds)
- Add caching to speed up repeated operations

### Checkout failures

**Symptoms:** `fatal: could not read Username`, `Repository not found`

**Fixes:**
- Ensure `actions/checkout@v4` is present and up to date
- For private repos, ensure token has repo access
- For submodules: `with: { submodules: recursive }`

### Node/Python version issues

**Symptoms:** `SyntaxError: Unexpected token`, `ModuleNotFoundError`

**Fixes:**
- Use `actions/setup-node@v4` or `actions/setup-python@v5` with explicit version
- Match the version to what's in `.node-version`, `.python-version`, or `engines` field

### Artifact and cache issues

**Symptoms:** `Cache not found`, `Artifact upload failed`, `No files were found`

**Fixes:**
- Verify the `path` glob matches actual output locations
- Ensure the cache key includes the lock file hash
- Check `retention-days` hasn't expired
- Verify the step that generates artifacts ran successfully

### Flaky tests

**Symptoms:** Test passes locally but fails intermittently in CI

**Fixes:**
- Add retry logic: `uses: nick-fields/retry@v3`
- Check for timing-dependent tests (add explicit waits or mocks)
- Check for environment differences (env vars, locale, timezone)
- Run with `--verbose` or `--bail` to get better error output

## Useful `gh api` endpoints for Actions

```bash
# List workflow runs with filters
gh api repos/{owner}/{repo}/actions/runs \
  --method GET \
  -f status=failure \
  -f branch=main \
  -F per_page=5

# Get a specific run
gh api repos/{owner}/{repo}/actions/runs/{run_id}

# List jobs for a run
gh api repos/{owner}/{repo}/actions/runs/{run_id}/jobs

# Download run logs (zip)
gh api repos/{owner}/{repo}/actions/runs/{run_id}/logs > logs.zip

# Cancel a run
gh api repos/{owner}/{repo}/actions/runs/{run_id}/cancel --method POST

# Re-run failed jobs
gh api repos/{owner}/{repo}/actions/runs/{run_id}/rerun-failed-jobs --method POST

# Re-run with debug logging
gh api repos/{owner}/{repo}/actions/runs/{run_id}/rerun \
  --method POST \
  --field enable_debug_logging=true

# List workflow files
gh api repos/{owner}/{repo}/actions/workflows

# Get workflow usage (billing)
gh api repos/{owner}/{repo}/actions/workflows/{workflow_id}/timing
```

## Contexts and environment variables

### `github` context

| Expression | Description |
|-----------|-------------|
| `github.actor` | User that triggered the workflow |
| `github.ref` | Branch or tag ref (`refs/heads/main`) |
| `github.ref_name` | Short ref name (`main`) |
| `github.sha` | Full commit SHA |
| `github.event_name` | Trigger event (`push`, `pull_request`, etc.) |
| `github.event` | Full event payload |
| `github.repository` | `owner/repo` |
| `github.repository_owner` | Repository owner |
| `github.run_id` | Unique run ID |
| `github.run_number` | Run number (increments per workflow) |
| `github.run_attempt` | Current retry attempt |
| `github.workflow` | Workflow name |
| `github.job` | Current job ID |
| `github.token` | Auto-generated `GITHUB_TOKEN` |
| `github.workspace` | Default working directory |

### `secrets` context

```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}
steps:
  - run: echo "Token length: ${#API_KEY}"
    env:
      API_KEY: ${{ secrets.API_KEY }}
```

Secrets are masked in logs. Access via `${{ secrets.NAME }}`. `GITHUB_TOKEN` is always available as `${{ secrets.GITHUB_TOKEN }}`.

### `env` context

```yaml
env:
  NODE_ENV: production    # Workflow-level

jobs:
  build:
    env:
      CI: true            # Job-level
    steps:
      - env:
          DEBUG: 1        # Step-level
        run: npm test
```

Precedence: step > job > workflow.

### `matrix` context

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest]
    node: [18, 20]
steps:
  - run: echo "Testing on ${{ matrix.os }} with Node ${{ matrix.node }}"
```

### Other useful contexts

| Context | Description |
|---------|-------------|
| `runner.os` | `Linux`, `macOS`, or `Windows` |
| `runner.arch` | `X86`, `X64`, or `ARM64` |
| `runner.temp` | Path to temp directory |
| `job.status` | `success`, `failure`, or `cancelled` |
| `steps.<id>.outputs.<key>` | Step output values |
| `steps.<id>.outcome` | Step result before `continue-on-error` |
| `needs.<job>.result` | Dependent job result |
| `needs.<job>.outputs.<key>` | Dependent job output values |

## Official references

- [gh run documentation](https://cli.github.com/manual/gh_run)
- [gh workflow documentation](https://cli.github.com/manual/gh_workflow)
- [GitHub Actions workflow syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [GitHub Actions contexts](https://docs.github.com/en/actions/learn-github-actions/contexts)
