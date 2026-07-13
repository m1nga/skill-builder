#!/bin/bash
# skill-builder daily publish — syncs Ming's self-made Claude Code skills to GitHub.
#
# Division of labor:
#   - Deterministic work (sync, secret scan, commit, push) is plain shell — never depends on an AI.
#   - Editorial work (README upkeep, judging pending skills, light GEO) goes to Codex when a
#     working `codex` is on PATH (see AGENTS.md). Without Codex the run still publishes; new
#     skills just wait in pending.list instead of being auto-promoted.
set -u
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$HOME/.claude/skills"
mkdir -p "$REPO/logs" "$REPO/skills"
LOG="$REPO/logs/publish-$(date +%F).log"

{
echo "=== $(date '+%F %T') run start ==="
cd "$REPO" || exit 1
git pull --rebase --autostash 2>/dev/null

# 1) Sync each published skill, applying the global exclude patterns.
EXCLUDES=()
while IFS= read -r pat; do
  [ -z "$pat" ] && continue; case "$pat" in \#*) continue;; esac
  EXCLUDES+=(--exclude "$pat")
done < exclude.patterns

while IFS= read -r name; do
  [ -z "$name" ] && continue; case "$name" in \#*) continue;; esac
  if [ -d "$SRC/$name" ]; then
    rsync -a --delete "${EXCLUDES[@]}" "$SRC/$name/" "skills/$name/"
  else
    echo "WARN: $name listed in publish.list but missing from $SRC (keeping last published copy)"
  fi
done < publish.list

# 2) Secret scan on exactly what would go public. Anything suspicious aborts the whole run.
if grep -rlIE "sk-ant-|ghp_[A-Za-z0-9]{20,}|gho_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY" skills/ 2>/dev/null; then
  echo "ABORT: secret-like string detected above — reverting sync, nothing published."
  git checkout -- skills/ 2>/dev/null
  exit 1
fi

# 3) Detect skills not yet on any list → pending.list (a human or Codex decides later).
for d in "$SRC"/*/; do
  n="$(basename "$d")"
  if ! grep -qx "$n" publish.list pending.list private.list 2>/dev/null; then
    echo "$n" >> pending.list
    echo "NEW skill detected: $n → pending.list"
  fi
done

# 4) Editorial pass — Codex if available, otherwise just freshen the README date stamp.
if command -v codex >/dev/null 2>&1 && codex login status >/dev/null 2>&1; then
  echo "codex available — running editorial chore"
  codex exec --full-auto "Read AGENTS.md in the current repo and perform the daily publish chore described there. Do not run git push; the wrapper script handles the push." || echo "codex chore failed (non-fatal)"
else
  echo "codex unavailable — shell fallback (README date stamp only)"
  /usr/bin/sed -i '' "s/^_Last updated: .*_$/_Last updated: $(date +%F)_/" README.md 2>/dev/null
fi

# 5) Commit and push only when something actually changed.
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "daily publish: sync skills ($(date +%F))"
  git push origin main && echo "pushed to origin/main"
else
  echo "no changes — nothing to publish today"
fi
echo "=== $(date '+%F %T') run end ==="
} >> "$LOG" 2>&1
