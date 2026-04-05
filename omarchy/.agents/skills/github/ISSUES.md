# GitHub Issues

Issue lifecycle and triage guidance for `gh issue`.

## Quick Start

```bash
gh issue create --title "Login fails on Safari" --body "Steps to reproduce..." --label bug
gh issue view 42 --json title,state,labels,assignees,comments
gh issue list --label bug --assignee @me
```

## Instructions

### Create issues

```bash
gh issue create --title "Fix auth bug" --body "Session times out after 10 minutes"
gh issue create --title "Add dark mode" --label "enhancement" --assignee @me --milestone "v2.0"
```

Use a multi-line body for substantive reports:

```bash
gh issue create --title "Refactor auth module" --body "$(cat <<'EOF'
## Problem
The current auth module mixes concerns.

## Proposed solution
Extract token validation into a shared utility.

## Acceptance criteria
- [ ] Unit tests pass
- [ ] No breaking changes to the public API
EOF
)"
```

### View and list issues

```bash
gh issue view 42
gh issue view 42 --json number,title,body,state,labels,assignees,milestone,comments,createdAt,url
gh issue view 42 --comments
gh issue list --state open --limit 20
gh issue list --label bug --assignee @me --state open --limit 20
gh issue list --search "is:open label:bug no:assignee"
gh issue status
```

Useful JSON fields:
- `number,title,state,author,createdAt,labels,assignees`
- `title,body,state,labels,assignees,milestone,comments,url`

Additional listing patterns:

```bash
gh issue list --milestone "v2.0"
gh issue list --search "is:open sort:updated-desc"
gh issue list --search "is:open mentions:@me"
gh issue list --state closed --search "closed:>=2025-01-01"
gh issue list --search "is:open no:label"
gh issue list --search "is:open author:alice author:bob"
gh issue list --label "priority:high" --state open
```

### Edit issues

```bash
gh issue edit 42 --title "New title" --body "Updated description"
gh issue edit 42 --add-label "bug,urgent"
gh issue edit 42 --remove-label "wip"
gh issue edit 42 --add-assignee @me
gh issue edit 42 --remove-assignee alice
gh issue edit 42 --milestone "v2.0"
gh issue edit 42 --remove-milestone
```

### Close, reopen, delete, and comment

```bash
gh issue close 42 --comment "Fixed in #55" --reason completed
gh issue close 42 --reason "not planned"
gh issue close 42 --reason duplicate
gh issue reopen 42 --comment "Still reproducible on v2.1"
gh issue comment 42 --body "Confirmed, this also affects v1.8"
gh issue comment 42 --body-file comment.md
```

Delete only after explicit confirmation:

```bash
gh issue delete 42 --yes
```

### Transfer, pin, and advanced API usage

```bash
gh issue transfer 42 OWNER/other-repo
gh issue pin 42
gh issue unpin 42
```

Bulk label updates:

```bash
for n in 10 11 12; do
  gh api repos/{owner}/{repo}/issues/$n/labels \
    --method POST \
    --field 'labels[]=needs-triage'
done
```

Lock and unlock:

```bash
gh api repos/{owner}/{repo}/issues/42/lock \
  --method PUT \
  --field lock_reason=resolved

gh api repos/{owner}/{repo}/issues/42/lock --method DELETE
```

Other useful API commands:

```bash
gh api repos/{owner}/{repo}/issues \
  --method GET \
  -f labels=bug \
  -f state=open \
  -F per_page=100 \
  --paginate \
  --jq '.[].number'

gh api repos/{owner}/{repo}/issues/42/reactions \
  --method POST \
  --field content="+1"

gh api repos/{owner}/{repo}/issues/42/timeline
```

## Rules and Constraints

- Use `--json` when issue data will be parsed or summarized.
- Confirm before deletion because it is irreversible.
- Use `-R owner/repo` outside the current repository.
- If project commands fail on auth scope, refresh with `gh auth refresh -s project`.

## Bundled Resources

- Official CLI docs: `gh issue`, GitHub REST Issues, and GitHub REST Issue Comments.

## Examples

User request:
```text
List the open bugs that nobody owns.
```

Command:
```bash
gh issue list --label bug --search "is:open no:assignee"
```

User request:
```text
Close issue 42 as duplicate and point to #55.
```

Command:
```bash
gh issue close 42 --comment "Duplicate of #55" --reason duplicate
```
