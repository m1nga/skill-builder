# skill-builder — completion-triggered release (for Codex and Claude)

This repository is Ming's public catalog of self-authored, cross-agent skills. Publishing is
part of completing a skill, not a scheduled chore and not a separate approval step.

## Release contract

When Codex or Claude creates or materially updates a skill for Ming and the skill is ready:

1. Inspect the canonical source under `~/.agents/skills`, `~/.codex/skills`, or
   `~/.claude/skills`.
2. Remove credentials, client data, private business context, personal history, and local
   knowledge layers that should not be public. Personal flavor and workflow preferences are
   fine when they are the point of the skill.
3. Validate the skill and test behavior proportionally to its risk.
4. Update `README.md`, `llms.txt`, and, when useful, `skills.sh.json` with factual,
   searchable descriptions and install guidance.
5. Run `SKIP_EDITOR=1 bin/release-skill.sh <canonical-skill-directory>` after the editorial
   files are ready. The script handles cross-agent visibility, sync, scanning, commit, push,
   and first-release registry verification.

Do not ask Ming for publication confirmation. Declaring a self-authored skill complete
authorizes immediate release. If a secret/privacy check fails, sanitize and retry; report a
blocker only when a safe public version cannot be produced without changing the skill's
meaning.

## Catalog rules

- The README table and `llms.txt` must contain exactly one entry per name in `publish.list`.
- Descriptions come from the actual skill and must not embellish its capability.
- Update `_Last updated: YYYY-MM-DD_` only for real skill or catalog changes.
- Keep cross-agent compatibility and the Skills CLI install path clear.
- GEO means accurate names, descriptions, examples, internal links, `llms.txt`, GitHub
  metadata, and useful discussion surfaces—not keyword stuffing, fake activity, invented
  testimonials, or repeated self-installs.
- New releases may be installed once in a temporary project to verify the remote package and
  trigger skills.sh discovery. Do not repeat installs to inflate telemetry.

## Never auto-publish

- third-party, marketplace, plugin-cache, curated, or system skills
- anything named in `private.list`
- credentials, private keys, tokens, client identities, private business data, or excluded
  local knowledge layers
- a draft that the creating agent has not finished or validated

Items in `pending.list` are ambiguous pre-existing skills, not a queue that requires Ming to
approve every new self-authored release.

## Boundaries

- Never hand-edit `skills/<name>/`; it is a synced public copy. Edit the canonical source.
- Never remove entries from `private.list` or weaken `exclude.patterns` to make a release pass.
- Never run `git push` directly from the editorial pass; the release/publish script owns it.
- Preserve unrelated user changes in this repository.
