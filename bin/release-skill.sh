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
