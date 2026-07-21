#!/usr/bin/env bash
# Dashboard header banner (1280×320) — ImageMagick only.
# Usage: ./dashboard_banner.sh <icon> <headline> <output.png>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=brand_fonts.sh
source "$SCRIPT_DIR/brand_fonts.sh"

ICON_INPUT="${1:?Icon PNG required}"
HEADLINE="${2:?Headline required}"
OUTPUT="${3:?Output PNG required}"

TEAL="#7ebab5"
MIDNIGHT="#090a0c"
FROST="#e8f4f2"
WIDTH=1280
HEIGHT=320

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

magick -size "${WIDTH}x${HEIGHT}" gradient:"${MIDNIGHT}-#0a0b0d" \
  -fill "$TEAL" -draw "rectangle 0,0 ${WIDTH},4" \
  "$TMPDIR/bg.png"

magick "$ICON_INPUT" -resize 180x180 -background none -gravity center -extent 180x180 "$TMPDIR/icon.png"

magick "$TMPDIR/bg.png" "$TMPDIR/icon.png" -gravity West -geometry +48+0 -composite \
  -font "${PHENO_FONT_BOLD}" -pointsize 56 -fill "$TEAL" -gravity West -annotate +260+-20 "$HEADLINE" \
  -font "${PHENO_FONT_REGULAR}" -pointsize 28 -fill "$FROST" -gravity West -annotate +260+36 "Phenotype operator dashboard" \
  "$OUTPUT"

echo "✓ Dashboard banner: $OUTPUT (${WIDTH}x${HEIGHT})"
