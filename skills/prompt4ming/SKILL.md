---
name: prompt4ming
description: Restructures voice-dictated multi-task prompts from Mingtao into atomic English specs without adding content, and appends a Chinese summary. Use when input is conversational, contains multiple sub-asks, buries main intent, mixes Chinese-English, or looks like raw voice transcription. Triggers: run-on sentences, mid-thought corrections ("然后", "其实", "however"), embedded examples, rhetorical questions used as decisions ("吗？", "对吧？", "你懂我意思了吗？"), references to past context ("聊天记录", "之前说过"), unstructured enumerations ("牛排三文鱼鸡肉鸡蛋"), or 3+ sub-tasks in one paragraph. Always also use when user explicitly invokes "prompt4ming" or asks to "optimize this prompt".
---

# prompt4ming — Mingtao's Personal Prompt Optimizer

## Purpose

Restructure conversational voice-dictated input into atomic, hierarchical English prompts optimized for Claude. Append a concise Chinese summary so the user can verify intent capture without reading English in full.

## Core principle

**Restructure, do not extend.** The user's input usually has enough information; what's missing is structure. Never add personas, never add "think step by step", never expand examples, never translate Chinese examples to English (preserve verbatim). Add only: format, length, language hints if missing.

## Process (4 steps, in order)

### Step 1: DECOMPOSE
Split input into atomic units. One unit = one assertion/question/constraint. Strip voice noise: "然后", "就是说", "你看", "I mean", "you know" — preserve only when semantically loaded.

### Step 2: CLASSIFY each unit
- `[CONTEXT]` — background, situation
- `[GOAL]` — end state user wants (often only 1, often buried in the LAST sentence — scan tail first)
- `[TASK]` — concrete sub-deliverable
- `[CONSTRAINT]` — must/must-not, format, style, length
- `[EXAMPLE]` — illustrative case (preserve verbatim, do not paraphrase even if Chinese)
- `[DELEGATION]` — explicit "你看着来" / "you decide" / "make your call"
- `[NOISE]` — discard

### Step 3: REORDER into fixed structure (output in English)

```
# Goal
<single sentence — the deepest intent, not the surface ask>

# Context
- <bullet list, only what main model needs to act>

# Tasks
1. <primary deliverable>
2. <secondary>
3. <...>

# Constraints
- Format: <inferred or stated>
- Length: <inferred or stated>
- Language: <preserve original language distribution in final output>
- Style: <if stated or implied via examples>

# Examples / References
<verbatim from input, preserve original language>

# Delegated decisions
- <list places user authorized you to choose>

# Open questions
<max 2, only if truly blocking; otherwise omit this section>
```

### Step 4: FILL only missing essentials
- No output format stated → infer (code task → code; analysis → markdown; brand → copy variants)
- No length stated → match input length × 1.5 as upper bound
- No language stated → mirror input language distribution

**Never add:** persona ("you are an expert..."), reasoning instructions, unrelated context, encouragement, "please" softeners.

## Mingtao-specific heuristics

1. **Buried goal pattern** — Real goal usually appears in LAST 1-2 sentences. Scan tail first.
2. **Rhetorical question = decision request** — "这个是做一个工具吗？还是..." → "Compare options X/Y/Z and recommend one."
3. **Example clusters = preference vector, not literal requirement** — "牛排三文鱼鸡肉..." means "use these as the preference baseline", not "include exactly these items".
4. **"你看着来" / "you decide" = full delegation** — Strip the open question, make the call inline, label as `[ASSUMPTION]` in the optimized output.
5. **Cross-domain mixing** — If input mixes Musashi + personal training + travel, do NOT merge. Tag each task with its project.
6. **Memory references** — "你看一下聊天记录" → Add explicit instruction: "Use conversation_search tool with query: <inferred topic>".
7. **Voice transcription artifacts to silently fix** (do not ask, just fix):
   - "claude design" / "claude cold" / "clock cold" → "Claude Code"
   - "Kelshall" / "Kelsh" → "Kalshi"
   - "poly" → "Polymarket"
   - "Musashi" → preserve (correct product name)
   - "西班牙法国英格兰阿根廷巴西" → preserve as `Spain/France/England/Argentina/Brazil`
   - Random capitalizations from ASR → normalize
8. **Multi-task input** — If input has ≥ 3 distinct tasks across different domains, output ONE unified prompt with numbered tasks; do NOT split into multiple prompts.

## Output format

Output exactly two sections, in this order, separated by `---`:

```
<optimized English prompt — no preamble, no code fence, no "Here is...">

---

## 中文摘要

**目标**: <one line>
**主要任务**: <bullet list, ≤4 items>
**关键约束**: <bullet list, ≤3 items, only if non-obvious>
**已替你决定**: <bullet list, only if you made assumptions; omit section if none>
**待确认**: <bullet list, only if open questions exist; omit section if none>
```

## Hard rules

- Output ONLY these two sections. No "Here is the optimized prompt", no closing remarks.
- Optimized prompt language: English (Claude works best in English for complex reasoning).
- Chinese summary language: Chinese, brief, scannable in <15 seconds.
- Preserve all examples verbatim in original language inside `# Examples`.
- Optimized prompt length ≤ 1.5× original. Shorter is better when intent preserved.
- If input is already well-structured (rare for voice), output the input as-is in `# Tasks` and add Chinese summary noting `[原输入已结构良好，未做重写]`.
- If user provides FEEDBACK on a previously optimized prompt (e.g. "this part is wrong", "add X", "shorter"), do NOT re-run the full process. Apply targeted edit only, output the revised prompt + updated 中文摘要 marking what changed.

## Self-check before output

Before emitting, verify:
- [ ] Goal sentence captures the deepest intent, not the surface ask
- [ ] All examples preserved verbatim in original language
- [ ] No added personas or "think step by step" instructions
- [ ] Chinese summary readable in <15 seconds
- [ ] Output is exactly: `<English prompt>` + `---` + `## 中文摘要`
