#!/bin/bash
# Builds the archive for OpenAI's plugin portal ("Skills only" upload). OpenAI asks for
# provider-neutral wording, so the README's Claude install section is removed; the skill
# files themselves are already neutral. Output: dist/coterie-disclosure-check-<version>-openai.zip
set -euo pipefail
repo="$(cd "$(dirname "$0")/.." && pwd)"
version="$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1]))["version"])' "$repo/coterie-disclosure-check/.claude-plugin/plugin.json")"
work="$(mktemp -d "${TMPDIR:-/tmp}/disclosure-openai.XXXXXX")"
cp -R "$repo/coterie-disclosure-check" "$work/coterie-disclosure-check"
python3 - "$work/coterie-disclosure-check/README.md" <<'PY'
import re, sys
p = sys.argv[1]
s = open(p).read()
s2 = re.sub(r"## Install\n.*?(?=## How to use it)", "", s, flags=re.S)
if s2 == s:
    sys.exit("build-openai-zip: README has no Install section to remove; check the README layout")
open(p, "w").write(s2)
PY
if grep -rniI "claude" "$work/coterie-disclosure-check" --exclude=LICENSE --exclude-dir=.claude-plugin; then
  echo "build-openai-zip: Claude-specific wording left (above); fix before uploading" >&2
  exit 1
fi
mkdir -p "$repo/dist"
out="$repo/dist/coterie-disclosure-check-$version-openai.zip"
rm -f "$out"
(cd "$work" && zip -qr -X "$out" coterie-disclosure-check -x '*.DS_Store')
echo "build-openai-zip: wrote $out"
unzip -l "$out"
