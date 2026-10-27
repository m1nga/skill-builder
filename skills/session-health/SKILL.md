---
name: session-health
description: Assess whether to continue a task in its current chat, re-anchor or compact, or move to a clean session. Use on task changes, execution drift, ineffective corrections, or explicit window checks; connect necessary handoffs to work-memory.
---

# Session Health

Choose the least disruptive context change that lets the current task proceed reliably.
This applies across task types, not only coding. A window means a conversation/session,
not an operating-system window. This skill assesses and prepares continuity; it does
not create chats, move owners, send messages, or run a background monitor.

## Check lightly

Consider session health at substantive task entry, a meaningful correction, a change of
goal/phase, or evidence of drift. Reuse unchanged observations. Healthy routine turns
need neither a full skill reload nor a visible health report. Do not inspect other chats
merely because this policy applies to all tasks; an explicit multi-chat audit is separate.

Use the current request and a few relevant sources to establish:

- The current goal, actual project/work root, authoritative version, and next action.
- Whether recent work follows that goal and corrections actually change the output.
- Concrete symptoms, with a source or turn locator: persistent rejected claims,
  wrong-project rules, forgotten constraints, repeated completed work, or bulky input
  obstructing the next step. Distinguish observation from suspected cause.
- In-flight actions and unresolved results that must survive any context change.

Do not infer degradation from chat length, turn count, age, a single mistake, or an
arbitrary context percentage. Use token telemetry only when actually exposed; unknown
usage stays unknown. Latency, tool failure, missing access, provider limits, unclear
requirements and stale files may have other causes. Changing chat does not fix them.

For active context failures, read the installed `context-degradation` skill only as needed
to distinguish poisoning, confusion, clash, distraction and lost requirements. Its
published numeric heuristics are not universal switch thresholds. Do not automatically
install its adjacent skills or follow a suggestion to add agents outside task authority.
If it is unavailable, use the evidence-based checks here and disclose that diagnostic gap
only when material. [Upstream source](https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering/tree/main/skills/context-degradation).

## Choose a disposition

| Disposition | Evidence and action |
|---|---|
| **CONTINUE / 原窗口继续** | Goal and sources are coherent; corrections work; no context failure blocks progress. Continue the actual task. A large but healthy chat qualifies. |
| **REANCHOR / 整理后继续** | Same goal, but relevant state is obscured or recoverable conflicts/omissions exist. Re-read the current source, discard superseded assumptions from working state, retain a compact goal/constraints/status/next-action anchor, and verify the next substantive output. Use host compaction when supported and appropriate. |
| **NEW_SESSION / 换干净聊天** | A materially independent goal needs isolation, or verified wrong-context reasoning persists after a focused re-anchor. Prepare a minimal verified handoff; preserve the original task's continuity. A directly requested clean session does not require trying repair first. |

For a suspected failure on the same task, make one focused re-anchor attempt when practical.
Check whether the next real step follows the corrected source and goal. If it does, continue.
If the same context error persists, recommend a clean session instead of adding another
layer of corrective prose. A tool/access failure during that check is not proof that the
re-anchor failed. If a live consequential action would rely on a known contaminated fact,
hold that action while restoring verified context; do other safe work.

An unrelated quick question need not split a chat; assess whether it changes the primary
work or can be answered locally. A change of phase within one coherent goal also need not
split. If a fork inherits the problematic history, it is not a clean-context recovery.

Keep context disposition separate from execution permission and migration readiness.
NEW_SESSION may be appropriate while migration remains pending. Respect existing owners,
active runs, account identity, hold/unknown status, GUI leases, and restrictions on creating
chats or agents. Never interrupt, duplicate, release a lease, clear history, or retry an
uncertain external action as an incidental part of a health check. Move only at an allowed
safe boundary; otherwise retain the recommendation and continue feasible work.

## Connect to work-memory

Use the existing `work-memory` skill for substantive ongoing work; locate the real root,
honor an explicit session binding, and reuse that root's store. Do not make a second store
at a parent chat directory or mix facts from different projects. Recall a bounded relevant
selection (normally `--limit 2 --brief`); expand only for a concrete gap. Current instructions
and verified sources outrank retrieved memory.

Before a necessary session change, capture only meaningful sourced deltas and checkpoint
the result, context disposition, unresolved work, and next action. Preserve the evidence
for rejected assumptions without presenting them as current guidance. Record assessment
as an assistant recommendation unless the user actually chose it. Do not invent a lesson
or a successful outcome from writing a handoff.

Read [references/continuity.md](references/continuity.md) when preparing or consuming a
handoff. It gives the minimal packet, receipt checks, and recovery path. A one-off answer
does not need a memory database. If work-memory is unavailable or a write fails, preserve
the verified handoff in the current authorized private work area or chat, identify the
missing receipt, and do not call it checkpointed. Do not export a project/account bundle
unless asked.

In the receiving session, verify the root and current sources, recall the relevant records,
resolve in-flight/unknown actions through their original records, and perform the next
concrete step. Only observed successful continuation supports a handoff-success claim.
Existing holds remain holds; changing session never converts delivery into permission.

## Report only useful changes

If healthy, keep working quietly. If repair or a switch matters, state the disposition,
one or two concrete reasons, the repair/next action, and whether continuity is prepared or
still pending. Distinguish files/settings installed, host instructions loaded, and actual
cross-session continuation observed. Global instructions cover compatible local hosts
when those hosts load them; existing sessions may retain older instructions. Do not claim
every open chat, remote host, or ChatGPT web session has adopted the skill.

For maintenance, use [references/scenarios.md](references/scenarios.md) to check semantic
boundaries. It is an acceptance specification, not evidence of a model evaluation.
