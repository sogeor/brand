#!/usr/bin/env bash
# Render a social preview PNG (1280x640) from template.svg.
# Usage: render.sh <repo> "<description>"   →  out/<repo>.png
# Needs: rsvg-convert (apt install librsvg2-bin) and Inter (apt install fonts-inter).
set -euo pipefail
cd "$(dirname "$0")"

repo="${1:?repo name}"
desc="${2:?description}"

esc() { sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'; }

mapfile -t lines < <(printf '%s\n' "$desc" | fold -s -w 58 | sed 's/ *$//')
[ "${#lines[@]}" -le 2 ] || { echo "Description too long: keep it under ~110 characters" >&2; exit 1; }

len=${#repo}
size=120; [ "$len" -gt 12 ] && size=96; [ "$len" -gt 18 ] && size=76

mkdir -p out
sed -e "s|{{REPO}}|$(printf '%s' "$repo" | esc)|g" \
    -e "s|{{TITLE_SIZE}}|$size|g" \
    -e "s|{{DESC1}}|$(printf '%s' "${lines[0]:-}" | esc)|g" \
    -e "s|{{DESC2}}|$(printf '%s' "${lines[1]:-}" | esc)|g" \
    template.svg > "out/$repo.svg"
rsvg-convert -w 1280 -h 640 "out/$repo.svg" -o "out/$repo.png"
echo "out/$repo.png"
