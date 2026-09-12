#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
MEDIA_DIR="$ROOT/final-cut-export/media"
LAYER_DIR="$MEDIA_DIR/layers"
PORTRAIT="$MEDIA_DIR/host-portrait.png"

mkdir -p "$LAYER_DIR"

# This is a visual layer only: subtitles stay in the FCPXML caption lane.
cat > "$LAYER_DIR/foreground-overlay.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="1080" height="1080" viewBox="0 0 1080 1080">
  <defs>
    <linearGradient id="edge" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#68c8e8"/>
      <stop offset="1" stop-color="#f6a6c9"/>
    </linearGradient>
  </defs>
  <rect x="58" y="62" width="10" height="108" rx="5" fill="#68c8e8"/>
  <text x="94" y="103" fill="#f7f4ee" font-family="PingFang TC, Noto Serif CJK TC, serif" font-size="27" letter-spacing="2">POV：一把槍，埋了 23 年</text>
  <text x="94" y="186" fill="#ffffff" font-family="PingFang TC, Noto Serif CJK TC, serif" font-size="54" font-weight="700">槍擊埋下的</text>
  <text x="94" y="250" fill="#ffffff" font-family="PingFang TC, Noto Serif CJK TC, serif" font-size="54" font-weight="700">23 年真相</text>
  <path d="M78 830 C260 755 350 920 540 830 S820 755 1000 830" fill="none" stroke="url(#edge)" stroke-width="3" opacity="0.75"/>
  <text x="540" y="982" text-anchor="middle" fill="#f6a6c9" font-family="PingFang TC, Noto Sans CJK TC, sans-serif" font-size="28" letter-spacing="4">podcast.</text>
  <text x="540" y="1028" text-anchor="middle" fill="#ffffff" font-family="PingFang TC, Noto Sans CJK TC, sans-serif" font-size="22" letter-spacing="3">UK × TW ENTERTAINMENT</text>
</svg>
EOF

PORTRAIT_DATA="$(base64 < "$PORTRAIT" | tr -d '\n')"
angles=(-4 2 -2 3 -3 1 -2 3 -4 2 -1)
scales=(0.98 1.02 1.04 1.00 1.03 1.00 1.02 1.05 1.01 1.03 1.00)

for i in $(seq 1 11); do
  n=$(printf '%02d' "$i")
  angle="${angles[$((i - 1))]}"
  scale="${scales[$((i - 1))]}"
  cat > "$LAYER_DIR/avatar-head-$n.svg" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1080" viewBox="0 0 1080 1080">
  <defs>
    <clipPath id="headClip"><circle cx="540" cy="500" r="188"/></clipPath>
    <radialGradient id="halo"><stop offset="0" stop-color="#68c8e8" stop-opacity="0.28"/><stop offset="1" stop-color="#68c8e8" stop-opacity="0"/></radialGradient>
  </defs>
  <g transform="translate(540 500) scale($scale) translate(-540 -500) rotate($angle 540 500)">
    <circle cx="540" cy="500" r="250" fill="url(#halo)"/>
    <circle cx="540" cy="500" r="202" fill="#f3eee6" fill-opacity="0.96"/>
    <image x="320" y="210" width="440" height="587" preserveAspectRatio="xMidYMid slice" clip-path="url(#headClip)" xlink:href="data:image/png;base64,$PORTRAIT_DATA"/>
    <circle cx="540" cy="500" r="202" fill="none" stroke="#f3eee6" stroke-width="8"/>
    <circle cx="730" cy="296" r="10" fill="#f6a6c9"/>
    <circle cx="350" cy="710" r="7" fill="#68c8e8"/>
  </g>
</svg>
EOF
done

/usr/bin/qlmanage -t -s 1080 -o "$LAYER_DIR" "$LAYER_DIR/foreground-overlay.svg" "$LAYER_DIR"/avatar-head-*.svg >/dev/null 2>&1

mv -f "$LAYER_DIR/foreground-overlay.svg.png" "$LAYER_DIR/foreground-overlay.png"
for i in $(seq 1 11); do
  n=$(printf '%02d' "$i")
  mv -f "$LAYER_DIR/avatar-head-$n.svg.png" "$LAYER_DIR/avatar-head-$n.png"
done

cp /Users/prada/.codex/generated_images/01a0736a-caee-7702-b74e-63350941ba78/exec-53afbaf4-a5be-4f6c-8ff7-1b8eb67ee5de.png "$LAYER_DIR/background-uk-venue.png"
