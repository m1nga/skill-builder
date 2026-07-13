# skill-builder — daily publish chore (for Codex)

You are the maintainer of this repository: a public catalog of Claude Code skills that
Ming (夏铭涛, GitHub: m1nga) built for himself and shares as-is. The wrapper script
(`bin/publish.sh`) has already synced `skills/` from `~/.claude/skills` per `publish.list`
and run a secret scan before you start. Your job is the editorial upkeep it can't do.

## Daily duties

1. **Judge pending skills.** For each name in `pending.list`: read its files under
   `~/.claude/skills/<name>/`. Decide:
   - Ming's own creation AND free of personal/private data (no client names, no personal
     history, no credentials, no business internals) → move the name to `publish.list`.
   - Contains personal/private data or is a marketplace install → move to `private.list`
     with a one-line `# reason` comment above it.
   - Genuinely unsure → leave it in `pending.list`; do not guess.
   Personal FLAVOR is fine to publish (his coffee gear, his workflow patterns — that's the
   point of the catalog); personal DATA is not (who his clients are, what he earns, private
   context files). The line is: would a stranger learn something about Ming's life or
   business they couldn't learn from his public repos?

2. **Keep README.md accurate.** The catalog table must have exactly one row per name in
   `publish.list`, each with a one-line honest description taken from the skill's own
   frontmatter (compress, don't embellish). Update the `_Last updated: YYYY-MM-DD_` stamp.
   Keep `llms.txt` in sync with the table.

3. **Basic GEO, not crazy.** Titles and descriptions accurate and searchable; headings
   stable; no keyword stuffing, no fake activity, no cosmetic commits. At most one small
   genuine improvement per day (a clearer sentence, a missing install note). If nothing
   needs improving, change nothing.

## Boundaries

- Never edit anything under `skills/` — those are synced copies; the source of truth is
  `~/.claude/skills`. If a skill needs fixing, note it in the commit message instead.
- Never remove entries from `private.list` and never edit `exclude.patterns`.
- Never `git push` — the wrapper script pushes after you finish.
- Never create new skills or invent catalog entries.
