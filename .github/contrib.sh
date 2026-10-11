#!/usr/bin/env bash
# Escribe un SVG "N contributions in the last year" en Press Start 2P. Uso: contrib.sh <total> <salida.svg>
set -euo pipefail
total=$(printf '%s' "$1" | rev | sed 's/\([0-9]\{3\}\)/\1,/g; s/,$//' | rev)
rest=" contributions in the last year"
width=$(( (${#total} + ${#rest}) * 16 + 8 ))
font=$(base64 < "$(dirname "$0")/ps2p.woff2" | tr -d '\n')
cat > "$2" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="32" viewBox="0 0 $width 32" role="img" aria-label="$total$rest">
<style>@font-face { font-family: P; src: url(data:font/woff2;base64,$font) format('woff2'); } text { font-family: P, monospace; font-size: 16px; }</style>
<text x="6" y="26" fill="#980000">$total</text>
<text x="4" y="24"><tspan fill="#ff5a3c">$total</tspan><tspan fill="#8b949e">$rest</tspan></text>
</svg>
SVG
