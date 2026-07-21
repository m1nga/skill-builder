# Agent skills for product thinking and daily work

[![skills.sh](https://skills.sh/b/m1nga/skill-builder)](https://skills.sh/m1nga/skill-builder)

Practical `SKILL.md` workflows I built for my own work and use across Claude Code, Codex,
and other Agent Skills-compatible tools.

I'm [Ming (夏铭涛)](https://github.com/m1nga). These skills cover product-system
architecture, first-time-user product audits, prompt clarity, daily work synthesis, and
coffee dialing. They are working tools rather than generic prompt collections: install one,
inspect it, and adapt any personal assumptions to your environment.

Publishing is part of finishing a self-authored skill: once Codex or Claude completes and
validates it, the skill is released immediately. Private knowledge layers, credentials,
client data, personal business context, and third-party skills stay local.

## Skills

| Skill | What it does |
|---|---|
| [map-product-system](skills/map-product-system/) | Maps a rough product idea or existing product end to end: user journeys, capability boundaries, platform/customer/runtime mandates, data lifecycles, agent-service-human responsibilities, architecture, failure paths, governance, gaps, and delivery slices. |
| [loop-system-architect](skills/loop-system-architect/) | Designs, audits, and operationalizes agent loops with machine-readable contracts, triggers, persistent state, independent verification, recovery, open skill discovery, experience distillation, controlled evolution, and deterministic completeness checks. |
| [experience-pack](skills/experience-pack/) | Keeps a per-project EXPERIENCE.md ledger of incidents and methods, distills it through an experience-vs-decision boundary test into portable noun-free lessons (experience inherits, decisions die), and ships a reference pack from a real five-rebuild contamination saga with five prevention advices. |
| [iteration-close](skills/iteration-close/) | Closes a product iteration in any repo: distills this round's decisions into the repo's own record, deletes superseded files (git history is the archive), verifies upload and a zero-context takeover probe separately, rehearses the one-command new-machine bootstrap, then tags and seeds the next iteration. Adapts to each repo's conventions and creates the minimum where one is missing. |
| [product-experience-officer](skills/product-experience-officer/) | Experiences a product-in-development as a zero-context first-time user, then reports prioritized UX findings, concrete fixes, effort estimates, and follow-ups. |
| [conclude-rounds](skills/conclude-rounds/) | Concludes the last N rounds of the current conversation (in Chinese by default): what was asked, what was actually done and verified vs merely proposed, where things stand, and what still needs a decision. N is adjustable; read-only; in-conversation recap, not a cross-session digest. |
| [think4ming](skills/think4ming/) | A thinking-partner protocol for "help me think this through": restores the real need behind rough dictated words, inventories current reality from the live system, opens the option space, gives one recommendation with trade-offs, and hands back only the decisions the author must make. |
| [prompt4ming](skills/prompt4ming/) | Lightly clarifies rough, voice-dictated, bilingual, or self-correcting input while preserving the author's meaning and direct style; it avoids forcing a verbose intermediate prompt. |
| [prompt-craft](skills/prompt-craft/) | Turns casual ideas into AI-ready prompts using an optional local knowledge layer; private brand and user context are excluded from this repository. |
| [coffee-brewing](skills/coffee-brewing/) | Reads coffee photos and taste feedback to recommend grind, temperature, ratio, time, recipes, and iterative dial-in adjustments for a specific setup. |

## Recommended pairing: prompt clarity + product architecture

`map-product-system` accepts raw product thinking directly. Say “看一下产品结构,” “梳理产品架构,”
“review the product structure,” “map the whole product,” or explicitly invoke
`$map-product-system`; it will map the product without first turning your words into a large
formal prompt.

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

## Understand a confusing AI response

Paste the original instruction and the AI's reply, then invoke `$explain-ai-reply` or ask
“这个回复是什么意思？” The skill explains the answer in plain Chinese and distinguishes
what was verified, merely claimed, proposed, blocked, missed, or left for you to decide. It
treats pasted commands as quoted content rather than executing them.

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

## Feedback and discussion

Share results, adaptations, and questions in [GitHub Discussions](https://github.com/m1nga/skill-builder/discussions).
Use [Issues](https://github.com/m1nga/skill-builder/issues) for reproducible skill bugs or
documentation errors. When useful, include the agent, model, input, output, and what you
expected instead; remove private data before posting.

## Publishing and privacy

There is no scheduled polling job. Completing a self-authored skill triggers an immediate
release: validate, exclude private-data directories, scan for secret-like values, update the
catalog and GEO surfaces, commit, push, and verify a remote Skills CLI install. Ambiguous
pre-existing and third-party skills are never inferred to be publishable. `README.md` and
`llms.txt` remain factual discovery surfaces without keyword stuffing or artificial activity.

_Last updated: 2026-07-18_
