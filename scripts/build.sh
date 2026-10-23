#!/usr/bin/env bash
# Regenerate logo/svg and logo/png from scripts/mark.py.
# Needs: python3, rsvg-convert (apt install librsvg2-bin), Pillow for favicon.ico (pip install pillow).
set -euo pipefail
cd "$(dirname "$0")/.."

RED="#E5261F"; BLACK="#000000"; WHITE="#FFFFFF"
svg=logo/svg; png=logo/png
mkdir -p "$svg" "$png"

gen() { python3 scripts/mark.py "$@"; }

# Transparent marks
gen --fg "$BLACK" > "$svg/sogeor-mark-black.svg"
gen --fg "$WHITE" > "$svg/sogeor-mark-white.svg"
gen --fg "$RED"   > "$svg/sogeor-mark-red.svg"

# Marks on a background (avatars, app icons)
gen --fg "$WHITE" --bg "$BLACK" > "$svg/sogeor-avatar-white-on-black.svg"
gen --fg "$RED"   --bg "$BLACK" > "$svg/sogeor-avatar-red-on-black.svg"
gen --fg "$RED"   --bg "$WHITE" > "$svg/sogeor-avatar-red-on-white.svg"
gen --fg "$BLACK" --bg "$WHITE" > "$svg/sogeor-avatar-black-on-white.svg"

# Small sizes need a heavier line to stay legible
gen --fg "$RED" --bg "$BLACK" --stroke 130 --scale 1.1 > "$svg/sogeor-favicon.svg"

render() { rsvg-convert -w "$2" -h "$2" "$1" -o "$3"; }

for f in "$svg"/sogeor-mark-*.svg "$svg"/sogeor-avatar-*.svg; do
  base=$(basename "$f" .svg)
  for s in 1024 512 256; do render "$f" "$s" "$png/$base-$s.png"; done
done
for s in 16 32 48 64 180 192; do render "$svg/sogeor-favicon.svg" "$s" "$png/sogeor-favicon-$s.png"; done
mv "$png/sogeor-favicon-180.png" "$png/apple-touch-icon.png"

python3 - <<'PY'
from PIL import Image
imgs = [Image.open(f"logo/png/sogeor-favicon-{s}.png") for s in (16, 32, 48)]
imgs[-1].save("logo/favicon.ico", sizes=[(16, 16), (32, 32), (48, 48)], append_images=imgs[:-1])
PY
echo "Done: $svg, $png, logo/favicon.ico"
