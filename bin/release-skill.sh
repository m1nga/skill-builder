#!/bin/bash
# Release one completed, self-authored skill immediately.
set -euo pipefail

export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="${1:-}"

if [ -z "$SOURCE" ] || [ ! -f "$SOURCE/SKILL.md" ]; then
  echo "usage: $0 <canonical-skill-directory>" >&2
  exit 2
fi

SOURCE="$(cd "$SOURCE" && pwd)"
NAME="$(awk '
  NR == 1 && $0 == "---" { frontmatter = 1; next }
  frontmatter && $0 == "---" { exit }
  frontmatter && /^name:[[:space:]]*/ {
    sub(/^name:[[:space:]]*/, ""); print; exit
  }
' "$SOURCE/SKILL.md")"
NAME="${NAME#\"}"; NAME="${NAME%\"}"; NAME="${NAME#\'}"; NAME="${NAME%\'}"

if ! [[ "$NAME" =~ ^[a-z0-9-]+$ ]] || [ "$(basename "$SOURCE")" != "$NAME" ]; then
  echo "invalid skill name or folder mismatch: name='$NAME' folder='$(basename "$SOURCE")'" >&2
  exit 2
fi

case "$SOURCE" in
  "$HOME/.agents/skills/$NAME"|"$HOME/.codex/skills/$NAME"|"$HOME/.claude/skills/$NAME") ;;
  *)
    echo "refusing non-canonical source: $SOURCE" >&2
    echo "place personal skills directly under ~/.agents/skills, ~/.codex/skills, or ~/.claude/skills" >&2
    exit 2
    ;;
esac

if grep -qx "$NAME" "$REPO/private.list"; then
  echo "refusing release: $NAME is listed in private.list" >&2
  exit 1
fi

# Pre-flight lint — fail fast BEFORE any symlink/list mutation, on the two footguns that bit
# real releases this session: an over-long description and a colon-in-YAML frontmatter break.
python3 - "$SOURCE/SKILL.md" <<'PY' || exit 2
import sys, re
try:
    import yaml
except Exception:
    yaml = None
text = open(sys.argv[1], encoding="utf-8").read()
m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
if not m:
    print("pre-flight: no --- frontmatter block found", file=sys.stderr); sys.exit(1)
fm = m.group(1)
if yaml:
    try:
        data = yaml.safe_load(fm) or {}
    except Exception as e:
        print(f"pre-flight: invalid YAML in frontmatter (quote values containing a colon) — {e}", file=sys.stderr); sys.exit(1)
    desc = data.get("description", "")
else:
    dm = re.search(r"^description:\s*(.*)$", fm, re.M)
    desc = dm.group(1) if dm else ""
n = len(str(desc))
if n == 0:
    print("pre-flight: empty description", file=sys.stderr); sys.exit(1)
if n > 1024:
    print(f"pre-flight: description is {n} chars (max 1024) — trim {n-1024}", file=sys.stderr); sys.exit(1)
print(f"pre-flight OK: description {n}/1024 chars, YAML valid")
PY

ensure_visible() {
  local root="$1" target="$1/$NAME"
  mkdir -p "$root"
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$target" -ef "$SOURCE" ]; then return; fi
    echo "conflicting skill copy exists at $target; resolve source-of-truth drift first" >&2
    exit 1
  fi
  ln -s "$SOURCE" "$target"
}

ensure_visible "$HOME/.agents/skills"
ensure_visible "$HOME/.claude/skills"
ensure_visible "$HOME/.codex/skills"

IS_NEW=0
if ! grep -qx "$NAME" "$REPO/publish.list"; then
  IS_NEW=1
  printf '%s\n' "$NAME" >> "$REPO/publish.list"
fi

if grep -qx "$NAME" "$REPO/pending.list"; then
  tmp="$(mktemp)"
  awk -v name="$NAME" '$0 != name' "$REPO/pending.list" > "$tmp"
  mv "$tmp" "$REPO/pending.list"
fi

VALIDATOR="$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
if [ -f "$VALIDATOR" ]; then
  python3 "$VALIDATOR" "$SOURCE"
fi

if [ "$IS_NEW" = "1" ]; then
  MESSAGE="release skill: $NAME"
else
  MESSAGE="update skill: $NAME"
fi

COMMIT_MESSAGE="$MESSAGE" "$REPO/bin/publish.sh"

if [ "$IS_NEW" = "1" ] && command -v npx >/dev/null 2>&1; then
  TEST_DIR="$(mktemp -d /tmp/skill-release.XXXXXX)"
  trap 'case "${TEST_DIR:-}" in /tmp/skill-release.*) rm -rf "$TEST_DIR";; esac' EXIT
  git -C "$TEST_DIR" init -q
  (
    cd "$TEST_DIR"
    npx --yes skills@latest add m1nga/skill-builder --skill "$NAME" --agent codex -y --copy
  )
  diff -ru "$REPO/skills/$NAME" "$TEST_DIR/.agents/skills/$NAME"
fi

echo "released: https://github.com/m1nga/skill-builder/tree/main/skills/$NAME"
echo "registry: https://skills.sh/m1nga/skill-builder/$NAME"
