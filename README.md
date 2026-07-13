# skill-builder

Claude Code skills I built for my own daily work, published as-is.

I'm [Ming (夏铭涛)](https://github.com/m1nga) — I build products solo with Claude Code, and
these skills are the ones I actually use: agent skills for product UX audits, morning work
digests, prompt restructuring, and coffee dialing. They are personal by design — paths,
names, and hardware are mine — so treat each one as a working template: install it, then
adapt the frontmatter and any hardcoded context to yourself.

This repo auto-publishes daily from my local `~/.claude/skills`. What you see is what I run.

## Skills

| Skill | What it does |
|---|---|
| [product-experience-officer](skills/product-experience-officer/) | A senior product experience officer that experiences your product-in-development as a zero-experience first-time user — from screenshots or by actually driving the product (web/CLI/native) — then reports to the PM: prioritized findings (Blocker/Major/Minor/Polish), concrete fixes, effort estimates, follow-ups. |
| [morning-brief](skills/morning-brief/) | An overnight digest that fires after 3+ hours of sleep-idle past midnight: summarizes yesterday's work across ALL Claude Code sessions (tasks, conclusions, progress, open loops) and proposes five evidence-based ways to work more efficiently — waiting on the Desktop at wake-up. |
| [prompt4ming](skills/prompt4ming/) | Restructures messy voice-dictated, multi-task, bilingual prompts into atomic English specs without adding content — mid-thought corrections, buried intent, and rhetorical decisions handled. |
| [prompt-craft](skills/prompt-craft/) | Turns casual ideas into AI-ready prompts using a local knowledge layer (bring your own `knowledge/` — mine stays local). Fast by default, deep-audit mode for high-stakes prompts. |
| [coffee-brewing](skills/coffee-brewing/) | A personal barista that reads photos of beans/grounds/shots, infers roast and process, prescribes grind/temperature/ratio/time, and dials in beans over time from taste feedback. Hardware-specific by design (Mazzer Philos, V60, Linea Micra) — swap in your own gear. |

## Install

Copy any skill directory into your Claude Code skills folder:

```bash
git clone https://github.com/m1nga/skill-builder.git
cp -r skill-builder/skills/<skill-name> ~/.claude/skills/
```

Claude Code picks it up on the next session. Each skill is a single `SKILL.md` (plus
optional `references/`) following the [Agent Skills](https://docs.claude.com/en/docs/claude-code/skills)
format — readable, editable, yours to fork.

## How this repo maintains itself

A daily job syncs my local skills here, scans for secrets, and lets an agent do the
editorial upkeep (catalog accuracy, new-skill review). Skills with personal data layers
publish their mechanism but exclude the data (see `exclude.patterns`).

_Last updated: 2026-07-13_
