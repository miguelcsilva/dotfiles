# GitHub PR Reference

JSON fields, REST API patterns, and filter combinations for `gh pr` commands.

## PR JSON fields

All fields available with `gh pr view --json <fields>`:

| Field | Type | Description |
|-------|------|-------------|
| `additions` | int | Lines added |
| `assignees` | array | Assigned users |
| `author` | object | PR author (`login`, `name`) |
| `autoMergeRequest` | object | Auto-merge configuration |
| `baseRefName` | string | Target branch name |
| `body` | string | PR description |
| `changedFiles` | int | Number of files changed |
| `closed` | bool | Whether the PR is closed |
| `closedAt` | string | Timestamp when closed |
| `comments` | array | General comments |
| `commits` | array | Commit objects |
| `createdAt` | string | Creation timestamp |
| `deletions` | int | Lines deleted |
| `files` | array | Changed files (`path`, `additions`, `deletions`) |
| `headRefName` | string | Source branch name |
| `headRefOid` | string | Head commit SHA |
| `headRepository` | object | Source repository |
| `headRepositoryOwner` | object | Source repo owner |
| `id` | string | Node ID |
| `isCrossRepository` | bool | Whether PR is from a fork |
| `isDraft` | bool | Whether PR is a draft |
| `labels` | array | Applied labels |
| `latestReviews` | array | Most recent review per reviewer |
| `maintainerCanModify` | bool | Whether maintainers can push |
| `mergeCommit` | object | Merge commit (if merged) |
| `mergeStateStatus` | string | Merge state (`CLEAN`, `DIRTY`, `BLOCKED`, etc.) |
| `mergeable` | string | Mergeability (`MERGEABLE`, `CONFLICTING`, `UNKNOWN`) |
| `mergedAt` | string | Merge timestamp |
| `mergedBy` | object | User who merged |
| `milestone` | object | Associated milestone |
| `number` | int | PR number |
| `potentialMergeCommit` | object | Potential merge commit |
| `projectCards` | array | Linked project cards |
| `reactionGroups` | array | Emoji reactions |
| `reviewDecision` | string | Overall review decision (`APPROVED`, `CHANGES_REQUESTED`, `REVIEW_REQUIRED`) |
| `reviewRequests` | array | Pending review requests |
| `reviews` | array | All reviews |
| `state` | string | PR state (`OPEN`, `CLOSED`, `MERGED`) |
| `statusCheckRollup` | array | CI check results |
| `title` | string | PR title |
| `updatedAt` | string | Last update timestamp |
| `url` | string | Web URL |

### Useful field combinations

```bash
# PR summary
gh pr view 42 --json title,state,author,baseRefName,headRefName,additions,deletions,changedFiles

# Review status
gh pr view 42 --json reviewDecision,reviews,reviewRequests,latestReviews

# CI status
gh pr view 42 --json statusCheckRollup,mergeStateStatus,mergeable

# Files changed
gh pr view 42 --json files --jq '.files[].path'
```

## Inline review comments (REST API)

The `gh pr review` command does not support inline (file-level) comments. Use the GitHub REST API to create a review with inline comments.

### Create a review with inline comments

```bash
gh api repos/{owner}/{repo}/pulls/{number}/reviews \
  --method POST \
  --field event="COMMENT" \
  --field body="Overall review summary" \
  --field 'comments=[
    {
      "path": "src/auth.ts",
      "line": 15,
      "body": "Consider extracting this into a constant"
    },
    {
      "path": "src/utils.ts",
      "line": 42,
      "side": "RIGHT",
      "body": "This function needs error handling"
    }
  ]'
```

### Comment fields

| Field | Required | Description |
|-------|----------|-------------|
| `path` | yes | File path relative to repo root |
| `line` | yes | Line number in the diff to comment on |
| `body` | yes | Comment text (supports markdown) |
| `side` | no | `LEFT` (deletion) or `RIGHT` (addition, default) |
| `start_line` | no | Start line for multi-line comments |
| `start_side` | no | Side for the start line |

### Event types

| Event | Description |
|-------|-------------|
| `APPROVE` | Approve the PR |
| `REQUEST_CHANGES` | Request changes |
| `COMMENT` | General comment (no approval or rejection) |

### Reply to an existing review comment

```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies \
  --method POST \
  --field body="Thanks, fixed in the latest commit"
```

### List review comments on a PR

```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments
```

## Common `gh pr list` filters

```bash
# My open PRs
gh pr list --author @me

# PRs needing my review
gh pr list --search "is:open review-requested:@me"

# PRs with specific label
gh pr list --label "bug" --state open

# Recently merged PRs
gh pr list --state merged --limit 10

# Draft PRs
gh pr list --draft

# PRs targeting a specific branch
gh pr list --base release/v2

# PRs with failing checks
gh pr list --search "is:open status:failure"

# PRs with no reviews yet
gh pr list --search "is:open review:none"

# PRs by multiple authors
gh pr list --search "is:open author:alice author:bob"
```

## PR state machine

```
  ┌─────────┐
  │  Draft   │
  └────┬─────┘
       │ gh pr ready
       v
  ┌─────────┐
  │  Open    │◄──────────────────────┐
  └────┬─────┘                       │
       │                             │
       ├── review requested          │
       v                             │
  ┌──────────────┐                   │
  │ In Review    │                   │
  └────┬────┬────┘                   │
       │    │                        │
       │    └── changes requested ───┘
       │         (push fixes, re-request review)
       │
       v
  ┌──────────┐
  │ Approved │
  └────┬─────┘
       │ gh pr merge
       v
  ┌──────────┐
  │ Merged   │
  └──────────┘
```

**States:** `OPEN` → `MERGED` or `OPEN` → `CLOSED`

**Review decisions:** `REVIEW_REQUIRED` → `APPROVED` or `CHANGES_REQUESTED`

## Official references

- [gh pr documentation](https://cli.github.com/manual/gh_pr)
- [GitHub REST API - Pull Requests](https://docs.github.com/en/rest/pulls)
- [GitHub REST API - Pull Request Reviews](https://docs.github.com/en/rest/pulls/reviews)
