#!/usr/bin/env bash
# Empty-state illustration placeholders (SVG + PNG) — no Blender required.
# Usage: ./empty_state.sh <slug> <title> <subtitle> <output_dir>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=brand_fonts.sh
source "$SCRIPT_DIR/brand_fonts.sh"

SLUG="${1:?Slug required (e.g. no-data)}"
TITLE="${2:?Title required}"
SUBTITLE="${3:?Subtitle required}"
OUT_DIR="${4:?Output directory required}"

TEAL="#7ebab5"
MIDNIGHT="#090a0c"
FROST="#e8f4f2"
WIDTH=480
HEIGHT=360

mkdir -p "$OUT_DIR"

SVG_OUT="${OUT_DIR}/${SLUG}.svg"
PNG_OUT="${OUT_DIR}/${SLUG}.png"

# Escape XML entities for SVG text
xml_escape() { printf '%s' "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g'; }
TITLE_XML=$(xml_escape "$TITLE")
SUBTITLE_XML=$(xml_escape "$SUBTITLE")

cat > "$SVG_OUT" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="${WIDTH}" height="${HEIGHT}" viewBox="0 0 ${WIDTH} ${HEIGHT}" role="img" aria-label="${TITLE_XML}">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="${MIDNIGHT}"/>
      <stop offset="100%" stop-color="#0d0e12"/>
    </linearGradient>
    <linearGradient id="glow" x1="50%" y1="0%" x2="50%" y2="100%">
      <stop offset="0%" stop-color="${TEAL}" stop-opacity="0.35"/>
      <stop offset="100%" stop-color="${TEAL}" stop-opacity="0"/>
    </linearGradient>
  </defs>
  <rect width="100%" height="100%" fill="url(#bg)" rx="16"/>
  <rect x="0" y="0" width="${WIDTH}" height="4" fill="${TEAL}"/>
  <ellipse cx="240" cy="130" rx="90" ry="50" fill="url(#glow)"/>
  <rect x="170" y="90" width="140" height="100" rx="18" fill="${MIDNIGHT}" stroke="${TEAL}" stroke-width="2"/>
  <circle cx="240" cy="125" r="22" fill="none" stroke="${TEAL}" stroke-width="3"/>
  <line x1="228" y1="125" x2="252" y2="125" stroke="${TEAL}" stroke-width="3" stroke-linecap="round"/>
  <line x1="240" y1="113" x2="240" y2="137" stroke="${TEAL}" stroke-width="3" stroke-linecap="round"/>
  <text x="240" y="230" text-anchor="middle" fill="${TEAL}" font-family="Arial, Helvetica, sans-serif" font-size="22" font-weight="700">${TITLE_XML}</text>
  <text x="240" y="262" text-anchor="middle" fill="${FROST}" font-family="Arial, Helvetica, sans-serif" font-size="14">${SUBTITLE_XML}</text>
</svg>
EOF

# PNG via ImageMagick draw (avoids SVG font delegate issues)
magick -size "${WIDTH}x${HEIGHT}" gradient:"${MIDNIGHT}-#0d0e12" \
  -fill "$TEAL" -draw "rectangle 0,0 ${WIDTH},4" \
  -fill "${TEAL}55" -draw "ellipse 240,130 90,50 0,360" \
  -fill "$MIDNIGHT" -stroke "$TEAL" -strokewidth 2 -draw "roundrectangle 170,90 310,190 18,18" \
  -fill none -stroke "$TEAL" -strokewidth 3 -draw "circle 240,125 262,125" \
  -stroke "$TEAL" -strokewidth 3 -draw "line 228,125 252,125" \
  -draw "line 240,113 240,137" \
  -font "${PHENO_FONT_BOLD}" -pointsize 22 -fill "$TEAL" -gravity North -annotate +0+210 "$TITLE" \
  -font "${PHENO_FONT_REGULAR}" -pointsize 14 -fill "$FROST" -gravity North -annotate +0+242 "$SUBTITLE" \
  "$PNG_OUT"

echo "✓ Empty state: $SVG_OUT"
echo "✓ Empty state: $PNG_OUT"
