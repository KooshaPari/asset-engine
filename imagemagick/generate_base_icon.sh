#!/usr/bin/env bash
# Generate a 512×512 brand icon without Blender (ImageMagick only).
# Usage: ./generate_base_icon.sh <output.png> [letter]
# Example: ./generate_base_icon.sh phenotype_icon.png P

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=brand_fonts.sh
source "$SCRIPT_DIR/brand_fonts.sh"

OUTPUT="${1:?Output PNG path required}"
LETTER="${2:-P}"

TEAL="#7ebab5"
MIDNIGHT="#090a0c"
FROST="#e8f4f2"
SIZE=512

magick -size "${SIZE}x${SIZE}" \
  radial-gradient:"${TEAL}-${MIDNIGHT}" \
  \( -size "${SIZE}x${SIZE}" xc:none \
     -fill "${MIDNIGHT}" -draw "roundrectangle 96,96 416,416 64,64" \
     -fill "${TEAL}40" -draw "roundrectangle 112,112 400,400 48,48" \) \
  -compose over -composite \
  \( -background none -fill "${FROST}" -font "${PHENO_FONT_BOLD}" -pointsize 220 \
     -gravity center label:"${LETTER}" \) \
  -compose over -composite \
  "$OUTPUT"

echo "✓ Base icon: $OUTPUT (${SIZE}x${SIZE})"
