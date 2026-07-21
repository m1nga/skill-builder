---
name: conclude-rounds
description: Conclude the last N rounds of the CURRENT conversation, in Chinese by default, AND hand back 5 evidence-based insights for working more efficiently with Claude Code. Read back over the recent exchanges — both the user's questions AND the assistant's answers, including code written, decisions made, and progress — then give a tight conclusion (what was asked, what was actually done and verified vs merely proposed, current state, open decisions) followed by 5 concrete Claude-Code-usage insights drawn from patterns in those rounds. N defaults to 4 and is read from what the user says (前4轮 / past 3 / 前面5个来回 / 前面两个问题). This is an IN-conversation recap, read-only — it never changes files, and it is NOT a cross-session daily digest. Run whenever the user says 总结前面N轮 / 总结一下前面 / 小结一下 / 结论一下 / 回顾前面几轮 / 前4轮 / 这几轮做了啥 / conclude the last N rounds / recap the last few rounds / summarize what we just did / catch me up on this thread — even without naming the skill. Works identically in Claude Code and Codex.
---

# conclude-rounds — conclude the last N rounds of this conversation

The user wants to step back and see the recent stretch of THIS conversation clearly: what they
asked, what actually got done, and what's still hanging. Everything you need is already in your
context — you are not reading transcripts from disk (that would be a cross-session digest, a
different job). You are re-reading the last N exchanges you can already see and distilling them.

## What counts as a "round" and how many

- A **round** = one real user message + the assistant's reply to it (one Q&A exchange).
- Count only genuine user turns — skip system notifications, tool results, and background-task
  events; they are not the user talking.
- **N** defaults to **4**. Take an explicit count from the request and honor its unit:
  `前4轮`/`past 4` → 4 exchanges; `前面两个问题` → 2; a vague `前面几轮` → judge 3–5 by where a
  natural topic boundary falls. If fewer than N real rounds exist, conclude what there is and say
  so. Most recent round is always included.
- If earlier context was summarized/compacted, work from the summary for the older rounds and say
  which rounds are reconstructed vs. read verbatim.

## The one rule that makes this useful: separate done from claimed

The reason a recap is worth more than scrolling up is that it tells the truth about STATE. For
each thing that happened, sort it honestly:
- **已完成且验证过** — done and demonstrated (tests ran, file written, command succeeded, output shown).
- **做了但没验证** — done but unproven (written but not run, claimed but not checked).
- **只是提议 / 待决定** — proposed, or waiting on the user's choice.
Never let a proposal read as a completion. If a claim's state is genuinely unclear from context,
you may briefly verify against the repo (git log, ls, read a file) — this skill is read-only and
changes nothing — but don't turn a recap into an investigation.

## Output shape (Chinese by default; match the user's language if they've switched)

Keep it tight — synthesize, don't transcribe. Adapt length to how much actually happened.

```
## 一句话结论
[这 N 轮的净结果，一句话]

## 逐轮回顾
- 第N轮：你问了什么 → 做了什么 → 现在的状态（✅已验证 / ⚠️未验证 / 💡提议）
  （若干轮，按时间顺序；同一主题可合并）

## 关键产物
[改动的文件 / 提交 / 落盘的成果，若有；没有就省略此节]

## 悬而未决 / 待你拍板
[还开着的问题、等你选择的决定；没有就写“无”]

## 5 点 Claude Code 提效洞察
[5 条，每条：模式（带本轮证据）→ Claude Code 机制 → 第一步；不足 5 条真的就少写]
```

Omit any section that would be empty rather than padding it. If the user asked for just "一句话"
or a one-line catch-up, give only the 一句话结论 and skip the insights.

## The 5 Claude Code insights — what makes them worth reading

After the recap, mine the SAME rounds for how the work itself could run better in Claude Code.
This is the reason the skill earns its keep: the recap says what happened, the insights turn that
history into a faster next session. Rules that keep them from being generic filler:

1. **Evidence from these rounds, not general advice.** Every insight cites a concrete thing that
   happened — a manual loop repeated, a re-run caused by a footgun, a friction the user voiced, a
   verification skipped. "Consider using subagents" with no evidence is banned.
2. **Tied to a real Claude Code mechanism.** Name the lever: a hook (PostToolUse / Stop), a
   `~/.claude/CLAUDE.md` rule, a skill, a slash command, a subagent or the Workflow tool for
   fan-out, an MCP, a settings change. An insight the user can't act on isn't one.
3. **Ranked by leverage**, most impactful first; each ends with a one-line first step concrete
   enough to start in a minute.
4. **At most 5, fewer if the rounds don't honestly support 5.** Three real insights beat five
   padded ones — never manufacture insights to hit the number.

Good shape: `模式（证据：本轮发生的 X）→ 机制（Claude Code 的 Y）→ 第一步（现在能做的 Z）`.

## Boundaries

- Read-only. This skill summarizes; it never edits, commits, or pushes.
- It concludes THIS conversation's recent rounds only — for a cross-session/overnight digest that
  is a different tool; for closing out a whole product iteration, that is `iteration-close`.
- Don't flatter the work. If a round ended unresolved or something failed, that is the most
  important line in the recap, not something to smooth over.
