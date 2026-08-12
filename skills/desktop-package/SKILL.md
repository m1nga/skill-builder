---
name: desktop-package
description: Package the current task/session's content into ONE new folder on Ming's macOS Desktop for human pickup (查收) — distilled Chinese documents plus copies of files produced, organized so a cold reader gets the task, conclusion, and open items without the conversation. Folder name = one emoji + short Chinese topic (Ming's desktop habit); fixed entry file 📖 先看这个.md inside. Two modes — end-of-task packaging (把前面说的内容整理到桌面), and task-start filing (这个任务单独开个桌面文件夹, outputs accumulate into it during the task). Trigger whenever Ming says 整理到桌面 / 桌面开个文件夹 / 放到桌面我要查收 / 打包到桌面 / 桌面上给我留一份 / put this in a desktop folder / make a desktop folder for this task — even without naming the skill, even when the ask is the last sentence after a long setup. NOT for AI-session handoff (conversation-package), NOT for closing an iteration (iteration-close), NOT a desktop cleaner (整理桌面 is a different job) — it only ever ADDS one new folder and never touches existing Desktop items. Works identically in Claude Code and Codex.
---

# desktop-package — 把这次任务打包到桌面，给 Ming 查收

Ming's Desktop is his pickup counter. When a task's outcome matters to him personally, he wants
ONE new folder on `~/Desktop` holding everything, organized well enough to review cold. This
skill turns "前面说的内容" into that folder. The bar: two weeks from now, Ming — or anyone he
drags the folder to — understands the task, the conclusion, and what's still open WITHOUT this
conversation. If the folder only makes sense next to the chat, it failed (built for the
requester, not the user — rebuild).

## What goes in (reconstruct, then distill)

Walk back over the session and collect three kinds of content:

1. **Files produced this session** — wherever they live (repo, scratchpad, Downloads). COPY
   them in; never move anything out of a git repo — the repo stays the source of truth. Record
   each file's original path in the entry file.
2. **Content that only exists in the conversation** — analysis, decisions, comparisons,
   recommendations, drafts, findings. DISTILL each into a clean standalone Chinese `.md`
   document. 整理 means distill, not dump: no transcripts, no "你问/我答" back-and-forth, no
   chat formatting. One document per coherent thing, written as if it were always a document.
3. **Anything Ming explicitly names** ("把那几张截图也收进去"). An explicit gather instruction
   may MOVE files already loose on the Desktop into the folder — that tidying is exactly what
   he's asking for. Everything else defaults to copy.

If the session genuinely has almost nothing worth packaging, say so instead of manufacturing
filler documents. An honest "这次没什么可打包的" beats a padded folder.

## Folder conventions (Ming's observed desktop habits — follow them)

- **One new folder per task, directly on `~/Desktop`.** Never nest inside existing folders.
- **Folder name = one emoji + space + short Chinese topic** (2–8 字), matching his existing
  style: "⚡ 补件材料", "📦 搬去新电脑". Pick the emoji for the task's nature — his
  vocabulary includes ⚡办事/急件 📦打包/搬迁 🔥进行中项目 🧰工具 📄文档 ✅完成 — and inventing a
  fitting one (☕ 💍 🎬 …) is encouraged. No dates in the name; dates live inside the entry
  file. If the name already exists on the Desktop, append a date to YOUR new folder — never
  touch the existing one.
- **Entry file, always the same name: `📖 先看这个.md`** (his own packages use
  "📖 这个包怎么用.md" — a fixed, obvious entry point beats per-package cleverness). Template
  below.
- **File names are Chinese and self-explaining.** Emoji prefixes where they aid scanning
  (✅ 结论、📋 清单、🚀 计划、📄 文档), numeric prefixes (`01_`、`02_`) when reading order
  matters.
- **Up to ~8 items stay flat; more get numbered subfolders** (`00_素材` / `10_成果` /
  `20_参考`), mirroring his own `00_/10_/20_` filing pattern.
- Documents are `.md`; produced artifacts keep their original formats.

### 📖 先看这个.md template

```markdown
# [任务名]

- **这是什么**：一句话说明这个包是干嘛的
- **日期 / 来源**：YYYY-MM-DD，来自哪个会话或任务

## 结论 / 当前状态
[2–5 行，最重要的信息放最前面]

## 包里有什么
- 📄 文件名 —— 一行说明（来自磁盘的文件注明原路径）
- …每个文件一行

## 还没完的 / 等 Ming 拍板的
[没有就写「无」]
```

## Two modes

**Mode A — 事后打包 (default).** Ming asks at or after the end of the work: reconstruct, build
the folder in one pass, deliver.

**Mode B — 开工建档.** Ming declares at the START ("这个任务单独开个桌面文件夹"): create the
folder and entry file immediately, drop outputs in as they are produced, and make the LAST act
of the task updating `📖 先看这个.md` so its 结论 and 清单 are true. For code tasks the repo
remains the only source of truth — the desktop folder holds copies, exports, and explanations,
never the only version of anything.

## The delivery moment

Finish with, in order:

1. `ls` the folder and verify everything actually landed — done is demonstrated, not asserted.
2. `open "$HOME/Desktop/该文件夹"` so Finder pops it up — that is the 查收 moment (macOS only;
   skip when headless).
3. Report in chat: 文件夹名 + 每个文件一行的清单 + anything that did NOT make it in and why.

## Boundaries

- Creates its OWN new folder only. Never reorganizes, renames, or deletes existing Desktop
  items — tidying the whole Desktop is a different job this skill must not drift into.
- Copy by default. Move only what Ming explicitly told it to gather, and never out of a repo.
- No secrets: keys, tokens, credentials, client-confidential material stay out. Desktop folders
  get screenshotted, AirDropped, and forwarded.
- For continuing work in a new AI session use `conversation-package`; for closing a product
  iteration use `iteration-close`. This folder is for Ming's eyes, not for feeding an agent.
