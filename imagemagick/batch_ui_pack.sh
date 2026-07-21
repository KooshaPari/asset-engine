#!/usr/bin/env bash
# Mass UI/UX asset batch — ImageMagick + FFmpeg only (no Blender).
# Usage: ./batch_ui_pack.sh <output_dir>
# Example: ./batch_ui_pack.sh ../out/ui-pack-2026-07-21

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${1:?Output directory required}"
ICON_LETTER="${2:-P}"

TEAL="#7ebab5"
MIDNIGHT="#090a0c"

mkdir -p "$OUT_DIR"/{favicons,banners,empty-states,social,video,icons}

echo "[phenoDesign] UI pack batch → $OUT_DIR"

# 1. Base icon (no Blender)
"$SCRIPT_DIR/generate_base_icon.sh" "$OUT_DIR/icons/phenotype_icon.png" "$ICON_LETTER"

# 2. Favicon multi-res
"$SCRIPT_DIR/favicon_multi.sh" "$OUT_DIR/icons/phenotype_icon.png" "$OUT_DIR/favicons/phenotype"

# 3. Banners (3 sizes)
"$SCRIPT_DIR/social_card.sh" \
  "$OUT_DIR/icons/phenotype_icon.png" \
  "Phenotype" \
  "Beautiful asset automation for teams" \
  "$OUT_DIR/banners/og_1200x630.png"

"$SCRIPT_DIR/feature_banner.sh" \
  "$OUT_DIR/icons/phenotype_icon.png" \
  "Asset Automation" \
  "Create beautiful branded assets instantly" \
  "$OUT_DIR/banners/hero_1920x600.png"

"$SCRIPT_DIR/dashboard_banner.sh" \
  "$OUT_DIR/icons/phenotype_icon.png" \
  "Operator Dashboard" \
  "$OUT_DIR/banners/dashboard_1280x320.png"

# 4. Empty-state placeholders (SVG + PNG)
"$SCRIPT_DIR/empty_state.sh" "no-data" "No data yet" "Connect a source to get started" "$OUT_DIR/empty-states"
"$SCRIPT_DIR/empty_state.sh" "no-results" "No results" "Try adjusting your filters" "$OUT_DIR/empty-states"
"$SCRIPT_DIR/empty_state.sh" "error" "Something went wrong" "Refresh or contact support" "$OUT_DIR/empty-states"

# 5. Brand intro video (FFmpeg leg, uses generated icon)
if command -v ffmpeg >/dev/null 2>&1; then
  "$SCRIPT_DIR/../ffmpeg/brand_intro.sh" \
    "$OUT_DIR/icons/phenotype_icon.png" \
    "Phenotype" \
    "$OUT_DIR/video/brand_intro" || echo "[warn] brand_intro skipped"
else
  echo "[warn] ffmpeg not found — skipping brand intro"
fi

# 6. Manifest summary
cat > "$OUT_DIR/MANIFEST.md" <<EOF
# Phenotype UI Pack

Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
Tooling: ImageMagick + FFmpeg (no Blender)

## Brand tokens
- Teal: \`${TEAL}\`
- Midnight: \`${MIDNIGHT}\`

## Outputs

| Asset | Path |
|-------|------|
| Base icon 512² | \`icons/phenotype_icon.png\` |
| Favicon set | \`favicons/phenotype_{16,32,64,128}.png\`, \`favicons/phenotype.ico\` |
| OG / social 1200×630 | \`banners/og_1200x630.png\` |
| Hero 1920×600 | \`banners/hero_1920x600.png\` |
| Dashboard 1280×320 | \`banners/dashboard_1280x320.png\` |
| Empty states | \`empty-states/{no-data,no-results,error}.{svg,png}\` |
| Brand intro | \`video/brand_intro.{mp4,gif}\` (if ffmpeg ran) |

## Still requires Blender
- Glass 3D app icons (\`blender/glass_icon.py\`)
- Volumetric hero renders (\`blender/hero.py\`)
- UE5 cinematics (\`unreal/render_cinematic.sh\`)
EOF

echo ""
echo "[phenoDesign] UI pack complete: $OUT_DIR"
find "$OUT_DIR" -type f \( -name '*.png' -o -name '*.svg' -o -name '*.ico' -o -name '*.mp4' -o -name '*.gif' \) | sort
