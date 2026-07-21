# phenoDesign brand font paths (source from other scripts)
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PHENO_FONT_BOLD="/System/Library/Fonts/Supplemental/Arial Bold.ttf"
  export PHENO_FONT_REGULAR="/System/Library/Fonts/Supplemental/Arial.ttf"
elif [[ -f "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf" ]]; then
  export PHENO_FONT_BOLD="/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf"
  export PHENO_FONT_REGULAR="/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf"
else
  export PHENO_FONT_BOLD="DejaVu-Sans-Bold"
  export PHENO_FONT_REGULAR="DejaVu-Sans"
fi
