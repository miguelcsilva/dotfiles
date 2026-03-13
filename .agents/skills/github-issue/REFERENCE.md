# GitHub Issues Reference

JSON fields, filter combinations, and REST API patterns for `gh issue` commands.

## Issue JSON fields

All fields available with `gh issue view --json <fields>`:

| Field | Type | Description |
|-------|------|-------------|
| `assignees` | array | Assigned users (`login`, `name`) |
| `author` | object | Issue author (`login`, `name`) |
| `body` | string | Issue description |
| `closed` | bool | Whether the issue is closed |
| `closedAt` | string | Timestamp when closed |
| `comments` | array | All comments |
| `createdAt` | string | Creation timestamp |
| `id` | string | Node ID |
| `isPinned` | bool | Whether the issue is pinned |
| `labels` | array | Applied labels (`name`, `color`, `description`) |
| `milestone` | object | Associated milestone (`title`, `number`, `dueOn`) |
| `number` | int | Issue number |
| `projectCards` | array | Linked project cards |
| `reactionGroups` | array | Emoji reactions |
| `state` | string | `OPEN` or `CLOSED` |
| `stateReason` | string | `COMPLETED`, `NOT_PLANNED`, or `REOPENED` |
| `title` | string | Issue title |
| `updatedAt` | string | Last update timestamp |
| `url` | string | Web URL |

### Useful field combinations

```bash
# Issue summary
gh issue view 42 --json number,title,state,author,createdAt,labels,assignees

# Full detail including comments
gh issue view 42 --json title,body,state,labels,assignees,milestone,comments,url

# Just labels
gh issue view 42 --json labels --jq '.labels[].name'

# Comment count
gh issue view 42 --json comments --jq '.comments | length'
```

## Common `gh issue list` filters

```bash
# My open issues
gh issue list --assignee @me

# Unassigned bugs
gh issue list --label bug --search "is:open no:assignee"

# Issues in a milestone
gh issue list --milestone "v2.0"

# Recently updated issues
gh issue list --search "is:open sort:updated-desc"

# Issues mentioning me
gh issue list --search "is:open mentions:@me"

# Closed issues from this month
gh issue list --state closed --search "closed:>=2025-01-01"

# Issues with no labels
gh issue list --search "is:open no:label"

# Issues by multiple authors
gh issue list --search "is:open author:alice author:bob"

# High-priority issues
gh issue list --label "priority:high" --state open
```

## REST API patterns

### Bulk-update labels across multiple issues

```bash
# Add a label to issues 10, 11, 12
for n in 10 11 12; do
  gh api repos/{owner}/{repo}/issues/$n/labels \
    --method POST \
    --field 'labels[]=needs-triage'
done
```

### List all issues with a specific label (paginated)

```bash
gh api repos/{owner}/{repo}/issues \
  --method GET \
  -f labels=bug \
  -f state=open \
  -F per_page=100 \
  --paginate \
  --jq '.[].number'
```

### Lock / unlock an issue

```bash
# Lock
gh api repos/{owner}/{repo}/issues/42/lock \
  --method PUT \
  --field lock_reason=resolved

# Unlock
gh api repos/{owner}/{repo}/issues/42/lock --method DELETE
```

### Add a reaction to an issue

```bash
gh api repos/{owner}/{repo}/issues/42/reactions \
  --method POST \
  --field content="+1"
```

Available reactions: `+1`, `-1`, `laugh`, `confused`, `heart`, `hooray`, `rocket`, `eyes`

### List issue timeline events

```bash
gh api repos/{owner}/{repo}/issues/42/timeline
```

## Official references

- [gh issue documentation](https://cli.github.com/manual/gh_issue)
- [GitHub REST API - Issues](https://docs.github.com/en/rest/issues)
- [GitHub REST API - Issue Comments](https://docs.github.com/en/rest/issues/comments)
