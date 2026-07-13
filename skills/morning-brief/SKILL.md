---
name: morning-brief
description: 晨报 — overnight digest generated after Ming has been idle 3+ hours past midnight, waiting on his Desktop when he wakes. Summarizes yesterday's work across ALL Claude sessions and projects (tasks, conclusions, progress, open loops), then proposes up to five evidence-based ways to simplify and work more efficiently with Claude Code. Use when invoked by the scheduled task ("generate the morning brief"), or whenever Ming says 晨报 / 早报 / morning brief / 昨天干了什么 / 总结一下昨天 / daily digest / 睡前总结 / asks what happened across his sessions yesterday, or wants efficiency suggestions based on his recent Claude usage.
---

# Morning Brief (晨报)

You produce the report Ming reads with his first coffee. He went to sleep mid-battle
across several projects; you reconstruct what happened, what got decided, what's
still open — then tell him how to fight more efficiently. The report must be
finished and sitting on his Desktop before he wakes. No questions, no interaction:
this runs while he sleeps, so every judgment call is yours to make and label.

## Guards (scheduled runs only)

When invoked by the scheduled task, run these checks first and exit silently if any
fails. When Ming invokes the skill manually, skip all guards and just generate.

1. **Already delivered?** If today's report file already exists at
   `~/Desktop/晨报/YYYY-MM-DD 晨报.md`, exit. (The schedule fires hourly through the
   early morning; first successful run wins.)
2. **Is he actually asleep?** File mtimes LIE here: background agents, scheduled
   runs (including this one), and metadata-only rewrites all touch transcript
   files while Ming sleeps. The only trustworthy signal is the newest **human
   message**. For each transcript modified in the last ~4h
   (`find ~/.claude/projects -name "*.jsonl" -mmin -240`), pull the newest entry
   that is a real user message (type == "user" with actual text content, not a
   tool_result), excluding the current session's own transcript. Transcript
   timestamps are **UTC** — convert to local before comparing. If the newest human
   message is less than 180 minutes old, he's awake or just went down — exit
   silently and let a later run catch it.

## Time window

Cover everything since the previous brief (read the newest file in `~/Desktop/晨报/`
for its generation timestamp). No previous brief → cover the last 36 hours. Label
the report with the waking day's date.

## Gather (evidence before opinion)

Work from real traces, not memory. Sources, in order of preference:

1. **Filesystem transcripts** (the primary, joinable source):
   `~/.claude/projects/*/` holds `*.jsonl` transcripts. Ming usually launches
   everything from one directory, so expect MANY sessions inside ONE project dir —
   the unit of work is the session transcript, never the project directory.
   Candidate files: `find ~/.claude/projects -name "*.jsonl" -mmin -<window>`.
   mtime is only a hint — metadata rewrites (titles, last-prompt) touch files
   without new conversation. Before counting a session as active, confirm it has
   entries with internal `timestamp` fields inside the window (timestamps are
   UTC — convert to local). Then extract the skeleton with jq/grep: user messages
   carry the asks, final assistant messages carry conclusions. These files are
   large: pull roles and text fields, sample long ones (first + last portions),
   never read raw JSONL whole into context.
2. **Session-management tools** if available (`list_sessions`, `get_session`) —
   supplementary only: their IDs don't join to transcript filenames, so use them
   for titles/labels, not for enumeration.
3. **Git evidence**: for each repo active in the window (look where the transcripts
   point, plus `~/Desktop/*/`), `git log --since=<window-start> --oneline --stat`
   — commits are the hardest evidence of progress.
4. **Artifacts**: files created/modified in project directories during the window
   (reports, skills, documents) — deliverables count even without commits.

If the volume is large, fan out one subagent per confirmed-active session
transcript to extract its skeleton (project/topic, asks, decisions, progress,
open loops, frictions), then synthesize — grouping the final report by PRODUCT,
not by session file, and deduping claims that appear in several sessions. If the
window was quiet, say so in one line and keep the whole report short — never pad
a quiet day.

## The report

Write to `~/Desktop/晨报/YYYY-MM-DD 晨报.md` (create the folder if missing), in
Chinese, English terms where more precise. Structure:

```
# 晨报 YYYY-MM-DD
生成于 HH:MM · 覆盖 <窗口起点> 以来

## 一眼
3-5 行：昨天最重要的推进、最重要的结论、今天最该先碰的一件事。
只写这个数量级——这是他还没睡醒时读的部分。

## 昨日战报（按项目）
每个活跃项目一节：
- **做了什么**（任务与产出，链到产出文件/commit）
- **定了什么**（结论与决策——他半梦半醒时最容易忘的就是这个）
- **进展到哪**（完成度的诚实判断，不粉饰）
- **断在哪**（open loops：没跑完的、等他拍板的、被打断的，
  各附一句"从哪里捡起来"）

## 提效建议（最多五条）
见下方规则。

## 系统状态（可选，仅异常时出现）
后台任务失败、定时任务出错、磁盘上有异常膨胀的目录之类——
只在真有异常时才有这一节。
```

## The five efficiency suggestions — rules

The ask behind this section: look across all threads and the current projects, find
ways to simplify and work more efficiently using Claude Code. Generic advice is
worthless to him; he will delete this section from his attention the first morning
it says "考虑使用 subagents 提高效率". Every suggestion must earn its place:

1. **Evidence first.** Each suggestion cites a specific observed friction from the
   window — a step he repeated manually across sessions, context he re-explained
   twice, a permission prompt he approved ten times, a failed approach that burned
   an hour, a workflow that a skill/hook/CLAUDE.md edit would collapse. Quote or
   describe the actual moment. No observed friction → no suggestion.
2. **Name the mechanism.** Skill, hook, CLAUDE.md rule, settings permission,
   scheduled task, subagent pattern, MCP connector — say which, exactly.
3. **First step included.** Concrete enough to start in one minute: the file to
   create, the command to run, or a ready-to-paste line. Scheduled runs happen in
   a session Ming may never reopen, so phrase it as "把这行贴进任意新窗口：…" —
   never "回我一句" (there is no "me" to reply to in the morning).
4. **Cost vs. return.** One line: setup effort vs. time saved per week.
5. **No repeats.** Read `~/Desktop/晨报/_已建议.md` (suggestion log). Don't re-propose
   anything already logged unless you have materially new evidence — then say
   "再次建议，因为又发生了 X". After writing the report, append today's suggestions
   to the log, one line each in the format `YYYY-MM-DD — <标题>`.
6. **Fewer beats filler.** Two honest suggestions beat five padded ones. If the
   window only supports two, write two and say why.

Rank by leverage (time saved × frequency), highest first.

## Voice

- Direct, dense, zero filler. He reads this in 3 minutes.
- Conclusions and judgments are yours to make — label uncertainty ("从记录看不出
  是否…") instead of hedging everything.
- Numbers and file paths over adjectives. "改了 3 个文件，测试没跑" beats "取得了
  良好进展".
- 断在哪 (open loops) is the highest-value section after 一眼 — reconstruct it
  carefully; a lost open loop is a morning wasted rediscovering it.
