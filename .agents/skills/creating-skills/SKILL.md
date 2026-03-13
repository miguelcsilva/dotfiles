---
name: creating-skills
description: >
  Guides creating new agent skills. Use when the user asks to create, add, or
  write a new skill. Covers file structure, SKILL.md authoring, frontmatter
  rules, content guidelines, and where to place the skill (globally or
  locally for a specific project).
---

# Creating Skills

## First: ask scope

Before creating anything, ask the user:

> "Should this skill be **global** (available across all projects on this
> machine) or **local** (only for the current project)?"

---

## Global skills

Global skills live in the dotfiles repository, inside `.agents/skills/`.
That directory is symlinked to all agents' skill directories via GNU stow,
so every tool picks them up automatically across the whole machine.

Ask the user where their dotfiles repo is if you don't know, or look for
a `.agents/skills/` directory in common locations (`~/dotfiles`,
`~/personal/repositories/dotfiles`, etc.).

```
<dotfiles-repo>/.agents/skills/<skill-name>/
├── SKILL.md
└── <optional files>
```

---

## Local skills

Local skills live inside the current project directory:

```
<project-root>/.agents/skills/<skill-name>/
├── SKILL.md
└── <optional files>
```

---

## SKILL.md structure

Every skill needs a `SKILL.md` with YAML frontmatter followed by the body:

```yaml
---
name: kebab-case-name
description: >
  What it does and when to use it. Written in third person. Include key
  trigger words and "Use when..." context. Max 1024 characters, no XML tags.
---
```

**`name` rules:** max 64 chars, lowercase letters/numbers/hyphens only, no
reserved words ("anthropic", "claude"), no XML tags.

**`description` rules:** always third person ("Processes X files" not "I can
help with X"). Be specific — the description is the only thing used to decide
whether to activate the skill. Include file types, keywords, and use-case
triggers. Vague descriptions like "Helps with documents" cause the skill to be
ignored.

## Body content guidelines

**Be concise.** Only include context the agent doesn't already have. Every
token in SKILL.md competes with conversation history. Challenge each paragraph:
does this justify its cost?

**Set the right degree of freedom:**
- High freedom (prose steps) — when multiple approaches are valid
- Medium freedom (pseudocode/templates) — when a preferred pattern exists
- Low freedom (exact commands) — for fragile, destructive, or consistency-critical operations

**Use progressive disclosure.** Keep SKILL.md as an overview under 500 lines.
Put detailed reference material in sibling files and link to them:

```markdown
## Advanced usage
See [reference.md](reference.md) for the full API reference.
```

Sibling files are loaded on demand — they cost zero tokens until needed.

**Keep references one level deep.** Never chain references
(SKILL.md → a.md → b.md). All linked files must be referenced directly from
SKILL.md so the agent reads complete files rather than partial previews.

**For reference files longer than 100 lines,** add a table of contents at the
top so the agent can see the full scope even on a partial read.

**Use concrete examples**, not abstract descriptions. For output format or
style, provide input/output pairs. For workflows, provide a copyable checklist:

```
Progress:
- [ ] Step 1: ...
- [ ] Step 2: ...
```

**Other rules:**
- Consistent terminology throughout (pick one word per concept)
- No time-sensitive statements ("as of 2025..." will rot)
- Forward slashes in all paths — never backslashes
- Name files descriptively (`form_validation_rules.md` not `doc2.md`)
- Provide a default approach rather than listing many options

## Naming conventions

Prefer gerund form: `processing-pdfs`, `analyzing-spreadsheets`,
`managing-databases`. Noun phrases (`pdf-processing`) and action-oriented names
(`process-pdfs`) are also fine. Avoid vague names like `helper`, `utils`,
`tools`.

## Quick checklist before finishing

- Description is specific, third person, includes trigger keywords
- SKILL.md body under 500 lines
- File references are one level deep from SKILL.md
- No time-sensitive information
- Consistent terminology
- Concrete examples, not abstract descriptions
