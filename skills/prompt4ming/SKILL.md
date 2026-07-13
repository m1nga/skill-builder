---
name: prompt4ming
description: Clarify Mingtao's intended outcome from rough, voice-dictated, mixed Chinese-English, or self-correcting input while preserving his meaning and direct style. Use when Ming explicitly asks to optimize, clean up, clarify, or turn his words into a reusable prompt, or when ambiguity in dictated input prevents reliable execution. Do not invoke merely because his request is conversational or long.
---

# Prompt4Ming

Extract the intent; do not redesign the request.

## Default behavior

- Preserve Ming's framing, priorities, examples, language, and level of directness.
- Remove transcription noise, repetition, abandoned thoughts, and contradictions that he clearly corrected.
- Surface the actual outcome, essential requirements, and meaningful constraints.
- Keep useful ambiguity visible instead of silently inventing details.
- Prefer a small edit over a comprehensive rewrite. If the original is already clear, say so or return it nearly unchanged.

Trust the current model to reason. Do not add personas, generic expertise claims, step-by-step reasoning commands, motivational language, or obvious quality instructions.

## Choose the response mode

### Direct task

When Ming is asking the agent to do something rather than asking for a rewritten prompt, resolve minor voice noise internally and perform the task. Do not make him review an intermediate prompt.

### Reusable prompt

When he explicitly wants a prompt to reuse elsewhere, return a polished version in his preferred language. Use natural prose or the smallest structure that improves execution.

For a complex request, include only the sections that add value:

- **Core objective** — the result he actually wants.
- **Requirements** — distinct deliverables or decisions.
- **Context or constraints** — only details that affect the result.
- **Open point** — only a genuinely blocking ambiguity.

Do not force headings for a simple request. Do not append a translation or summary unless requested.

## Interpretation rules

- Treat a corrected thought as replacing the earlier version.
- Treat “还是…？” and similar alternatives as a request to compare and make or support a decision.
- Treat examples as evidence of preference unless Ming says they are exhaustive requirements.
- Treat “你看着来” or “make the call” as permission to choose within the stated scope, not permission to expand the scope.
- Keep separate projects separate when one dictation contains unrelated tasks.
- Resolve obvious speech-to-text errors from context; preserve uncertain names and flag them only when they matter.
- Use available conversation or workspace context when Ming refers to earlier work. Do not manufacture missing history.

## Quality check

Before responding, verify:

1. The core objective survived unchanged.
2. No real requirement, example, or boundary was lost.
3. The result is shorter or clearer than the input—not merely more formatted.
4. Nothing was added just to make the prompt look professional.
