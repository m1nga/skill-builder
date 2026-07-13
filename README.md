# Agent skills for product thinking and daily work

[![skills.sh](https://skills.sh/b/m1nga/skill-builder)](https://skills.sh/m1nga/skill-builder)

Practical `SKILL.md` workflows I built for my own work and use across Claude Code, Codex,
and other Agent Skills-compatible tools.

I'm [Ming (夏铭涛)](https://github.com/m1nga). These skills cover product-system
architecture, first-time-user product audits, prompt clarity, daily work synthesis, and
coffee dialing. They are working tools rather than generic prompt collections: install one,
inspect it, and adapt any personal assumptions to your environment.

This repository auto-publishes only the skills I have explicitly approved. Private knowledge
layers, credentials, client data, and personal business context stay local.

## Skills

| Skill | What it does |
|---|---|
| [map-product-system](skills/map-product-system/) | Maps a rough product idea or existing product end to end: user journeys, capability boundaries, platform/customer/runtime mandates, data lifecycles, agent-service-human responsibilities, architecture, failure paths, governance, gaps, and delivery slices. |
| [product-experience-officer](skills/product-experience-officer/) | Experiences a product-in-development as a zero-context first-time user, then reports prioritized UX findings, concrete fixes, effort estimates, and follow-ups. |
| [morning-brief](skills/morning-brief/) | Produces an overnight cross-session work digest with yesterday's progress, open loops, and evidence-based ways to improve the next workday. |
| [prompt4ming](skills/prompt4ming/) | Lightly clarifies rough, voice-dictated, bilingual, or self-correcting input while preserving the author's meaning and direct style; it avoids forcing a verbose intermediate prompt. |
| [prompt-craft](skills/prompt-craft/) | Turns casual ideas into AI-ready prompts using an optional local knowledge layer; private brand and user context are excluded from this repository. |
| [coffee-brewing](skills/coffee-brewing/) | Reads coffee photos and taste feedback to recommend grind, temperature, ratio, time, recipes, and iterative dial-in adjustments for a specific setup. |

## Recommended pairing: prompt clarity + product architecture

`map-product-system` accepts raw product thinking directly. Say “review the product
structure,” “map the whole product,” or explicitly invoke `$map-product-system`; it will map
the product without first turning your words into a large formal prompt.

Use `prompt4ming` only when you want to reuse a cleaned-up prompt elsewhere. It extracts the
core objective and requirements with minimal rewriting. You can then pass that prompt to
`map-product-system`, but chaining them is optional.

### Why prompt4ming is intentionally lighter now

The original version always converted dictated input into an atomic English specification
and appended a Chinese verification summary. That structure was useful with older models but
often made a clear request longer and less natural. The current version:

- keeps the user's original language and voice by default;
- removes noise without forcing a fixed template or translation;
- performs a direct task without making the user approve an intermediate prompt; and
- activates for explicit prompt cleanup or real ambiguity, not merely because an input is long.

## Install with the Skills CLI

Install the repository or select one skill:

```bash
npx skills add m1nga/skill-builder
npx skills add https://github.com/m1nga/skill-builder --skill map-product-system
```

The Skills CLI supports Claude Code, Codex, Cursor, GitHub Copilot, and other compatible
agents. Start a new agent session after installation so it discovers the skill.

## Manual install

```bash
git clone https://github.com/m1nga/skill-builder.git

# Claude Code
cp -r skill-builder/skills/<skill-name> ~/.claude/skills/

# Codex
cp -r skill-builder/skills/<skill-name> ~/.codex/skills/
```

Every skill follows the Agent Skills structure: a `SKILL.md` file plus optional
`references/` and agent-specific metadata. The core instructions and references are portable;
agents safely ignore metadata they do not use.

## Publishing and privacy

A daily local job syncs approved skills, excludes known private-data directories, scans for
secret-like values, and publishes only real changes. Newly detected skills remain pending
until I explicitly approve public release. `README.md` and `llms.txt` are maintained as
factual discovery surfaces, without keyword stuffing or artificial activity.

_Last updated: 2026-07-13_
