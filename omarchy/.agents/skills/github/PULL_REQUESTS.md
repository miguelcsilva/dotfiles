# GitHub Pull Requests

Pull request lifecycle, review workflow, and merge guidance for `gh pr`.

## Quick Start

```bash
gh pr create --title "Add login feature" --body "Implements OAuth login" --base main
gh pr view 42 --json title,state,reviews,mergeable
gh pr review 42 --approve --body "LGTM"
```

## Instructions

### Create pull requests

Before creating, check for a PR template:
- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `docs/pull_request_template.md`

If one exists, use its structure and replace all placeholders with real content.

```bash
gh pr create --title "Fix auth bug" --body "Resolves the session timeout issue"
gh pr create --title "Add caching layer" --base main --draft --reviewer alice,bob --label "enhancement"
gh pr create --fill
```

Use a multi-line body for substantive PRs:

```bash
gh pr create --title "Refactor auth module" --body "$(cat <<'EOF'
## Summary
- Extracted token validation into a shared utility
- Added refresh token rotation

## Test plan
- [x] Unit tests pass
- [ ] Manual testing on staging
EOF
)"
```

### View, list, and edit PRs

```bash
gh pr view 42
gh pr view 42 --json title,state,author,reviews,reviewRequests,mergeable,statusCheckRollup
gh pr view 42 --comments
gh pr diff 42
gh pr diff 42 --name-only
gh pr list --state open --limit 20
gh pr list --search "is:open review:required base:main"
gh pr status
```

Useful JSON fields:
- `title,state,author,baseRefName,headRefName,additions,deletions,changedFiles`
- `reviewDecision,reviews,reviewRequests,latestReviews`
- `statusCheckRollup,mergeStateStatus,mergeable`

Additional listing patterns:

```bash
gh pr list --author @me
gh pr list --search "is:open review-requested:@me"
gh pr list --label "bug" --state open
gh pr list --state merged --limit 10
gh pr list --draft
gh pr list --base release/v2
gh pr list --search "is:open status:failure"
gh pr list --search "is:open review:none"
gh pr list --search "is:open author:alice author:bob"
```

Editing:

```bash
gh pr edit 42 --title "New title" --body "Updated description"
gh pr edit 42 --add-label "bug,urgent"
gh pr edit 42 --remove-label "wip"
gh pr edit 42 --add-reviewer alice,bob
gh pr edit 42 --remove-reviewer charlie
gh pr edit 42 --add-assignee @me
gh pr edit 42 --remove-assignee dave
gh pr edit 42 --base develop
gh pr ready 42
```

### Review PRs

Use this sequence:

1. Inspect scope.
```bash
gh pr view 42 --json title,body,files,additions,deletions
```
2. Read the diff.
```bash
gh pr diff 42
```
3. Submit a review.
```bash
gh pr review 42 --approve --body "Looks good, nice refactor"
gh pr review 42 --request-changes --body "A few issues to address"
gh pr review 42 --comment --body "Some suggestions, non-blocking"
```
4. Leave a general comment if needed.
```bash
gh pr comment 42 --body "Have we considered caching here?"
```

For inline comments, use the REST API because `gh pr review` does not support them:

```bash
gh api repos/{owner}/{repo}/pulls/42/reviews \
  --method POST \
  --field event="COMMENT" \
  --field body="Review with inline comments" \
  --field 'comments=[{"path":"src/auth.ts","line":15,"body":"Consider using a constant here"},{"path":"src/auth.ts","line":42,"body":"This needs error handling"}]'
```

Useful follow-up API calls:

```bash
gh api repos/{owner}/{repo}/pulls/{number}/comments
gh api repos/{owner}/{repo}/pulls/{number}/comments/{comment_id}/replies \
  --method POST \
  --field body="Thanks, fixed in the latest commit"
```

### Merge PRs and inspect checks

Confirm with the user before any merge.

```bash
gh pr merge 42 --squash --delete-branch
gh pr merge 42 --merge --delete-branch
gh pr merge 42 --rebase --delete-branch
gh pr merge 42 --squash --auto
gh pr merge 42 --disable-auto
```

Check CI:

```bash
gh pr checks 42
gh pr checks 42 --watch
gh pr checks 42 --required
gh pr checks 42 --watch --fail-fast
```

## Rules and Constraints

- Use `--json` when PR data will be parsed or summarized.
- Read the diff before leaving a review.
- Confirm before merging.
- Do not force-push to a branch with an open PR without explicit approval.
- Use the REST review endpoint for inline comments.

## Bundled Resources

- Official CLI docs: `gh pr`, GitHub REST Pull Requests, and GitHub REST Pull Request Reviews.

## Examples

User request:
```text
Review PR 128 and tell me if checks are blocking merge.
```

Commands:
```bash
gh pr view 128 --json reviewDecision,mergeStateStatus,mergeable,statusCheckRollup
gh pr diff 128
```

User request:
```text
Create a draft PR from this branch and request Alice.
```

Command:
```bash
gh pr create --draft --reviewer alice
```
