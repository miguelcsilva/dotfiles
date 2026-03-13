---
name: creating-skills
description: >
  Create new agent skills following best practices. Use when the user asks to
  create, author, or scaffold a new skill, or when they ask about skill
  structure, metadata, file organisation, or where to place a skill.
---

# Creating Skills

A meta-skill for authoring new agent skills. Follow this guide to produce
well-structured, effective skills.

## Workflow

When asked to create a new skill:

1. **Gather requirements** — ask the user:
   - What task or domain should the skill cover?
   - Should it be **global** (available across all projects on this machine) or **local** (only for the current project)?
   - Does it need bundled scripts, templates, or reference files?

2. **Choose a location**:

   **Global** — lives in the dotfiles repo, symlinked to all agent tool directories via GNU stow:
   ```
   <dotfiles-repo>/.agents/skills/<skill-name>/
   ```
   Look for `.agents/skills/` in common locations (`~/dotfiles`, `~/personal/repositories/dotfiles`, etc.).

   **Local** — lives inside the current project:
   ```
   <project-root>/.agents/skills/<skill-name>/
   ```

3. **Choose a directory structure** based on complexity:

   **Simple** (single file):
   ```
   <skill-name>/
   └── SKILL.md
   ```

   **Standard** (instructions + references):
   ```
   <skill-name>/
   ├── SKILL.md
   ├── REFERENCE.md
   └── EXAMPLES.md
   ```

   **Advanced** (instructions + code + resources):
   ```
   <skill-name>/
   ├── SKILL.md
   ├── REFERENCE.md
   ├── EXAMPLES.md
   ├── scripts/
   │   └── helper.py
   └── templates/
       └── template.md
   ```

4. **Write the SKILL.md** following the structure below.
5. **Validate** against the checklist at the end of this document.

## SKILL.md Structure

Every SKILL.md must have YAML frontmatter followed by a markdown body.

### Frontmatter

```yaml
---
name: your-skill-name
description: What this skill does and when to use it. Include trigger phrases and scenarios.
---
```

**`name` rules:**
- Max 64 characters
- Lowercase letters, numbers, and hyphens only
- No XML tags
- Cannot contain reserved words ("anthropic", "claude")

**`description` rules:**
- Non-empty, max 1024 characters, no XML tags
- Must answer: (1) what does it do? (2) when should it be used?
- Lead with the capability, follow with trigger conditions
- Mention key file types, tools, or domains so the agent can match user intent

### Body

Keep the body under 5k tokens. Use this structure:

```markdown
# Skill Title

## Quick Start
[Minimal example showing the most common use case]

## Instructions
[Step-by-step guidance]

## Rules and Constraints
[Hard rules — formatting, naming, safety]

## Examples
[2–3 concrete input/output examples]

## Bundled Resources
[Describe any sibling files and when to read them]
```

### Sibling files (loaded on demand)

Reference additional files from the body using relative paths:

```markdown
For the full API reference, see [REFERENCE.md](REFERENCE.md).
```

Key principles:
- Keep references **one level deep** — never chain (SKILL.md → a.md → b.md)
- Push specialised content into sibling files; keep SKILL.md focused on the common path
- For files longer than 100 lines, add a table of contents at the top

## Writing Effective Instructions

**Be specific and procedural:**
```markdown
<!-- Bad -->
Make sure the code is good.

<!-- Good -->
1. Run the linter: `python -m flake8 src/`
2. If linting passes, run tests: `pytest tests/ -v`
3. If any test fails, read the traceback and fix the issue before proceeding.
```

**Use conditional logic for branching workflows:**
```markdown
- If the user provides a file path: read the file and proceed
- If the user provides raw text: save to a temp file first
- If neither: ask for input before continuing
```

**Define outputs explicitly** — specify format, file name, and location.

**Set the right degree of freedom:**
- High freedom (prose steps) — when multiple approaches are valid
- Medium freedom (pseudocode/templates) — when a preferred pattern exists
- Low freedom (exact commands) — for fragile or destructive operations

## Naming Conventions

Prefer gerund form: `processing-pdfs`, `analysing-spreadsheets`, `managing-databases`.
Noun phrases (`pdf-processing`) and action-oriented names (`process-pdfs`) are also fine.
Avoid vague names like `helper`, `utils`, `tools`.

## Validation Checklist

- [ ] `name` and `description` present and follow the rules
- [ ] Name: lowercase, hyphens only, under 64 chars, no reserved words
- [ ] Description: under 1024 chars, describes what + when, no XML tags
- [ ] Body: under 5k tokens
- [ ] Instructions: procedural, specific, numbered steps where appropriate
- [ ] At least one concrete example showing input and expected output
- [ ] Sibling files referenced from the body with relative paths
- [ ] Specialised content in sibling files, not the main body
- [ ] No time-sensitive statements that will rot
- [ ] Consistent terminology throughout (one word per concept)
