#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
OUTPUT_ROOT="${OUTPUT_ROOT:-$REPO_ROOT/output}"
MEDIA_DIR="${MEDIA_DIR:-$OUTPUT_ROOT/final-cut/project/media}"
LAYER_DIR="$MEDIA_DIR/layers"
PORTRAIT="${PORTRAIT:-$MEDIA_DIR/host-portrait.png}"
BACKGROUND="${BACKGROUND:-$MEDIA_DIR/background-uk-venue.png}"
FFMPEG_BIN="${FFMPEG_BIN:-$(command -v ffmpeg || true)}"
QLMANAGE_BIN="${QLMANAGE_BIN:-$(command -v qlmanage || true)}"

if [[ -z "$FFMPEG_BIN" || -z "$QLMANAGE_BIN" ]]; then
  echo "ffmpeg and qlmanage are required; set FFMPEG_BIN/QLMANAGE_BIN or install them." >&2
  exit 127
fi
if [[ ! -f "$PORTRAIT" || ! -f "$BACKGROUND" ]]; then
  echo "Usage: PORTRAIT=/path/portrait.png BACKGROUND=/path/background.png $0" >&2
  echo "Expected portrait and background inputs; set MEDIA_DIR to change the project media folder." >&2
  exit 2
fi

mkdir -p "$LAYER_DIR"

# Rendered PNG layers use a green key color so transparency survives Quick Look.
cat > "$LAYER_DIR/foreground-overlay.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="1080" height="1080" viewBox="0 0 1080 1080">
  <rect width="1080" height="1080" fill="#00ff01"/>
  <defs><linearGradient id="edge" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#68c8e8"/><stop offset="1" stop-color="#f6a6c9"/></linearGradient></defs>
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
  <rect width="1080" height="1080" fill="#00ff01"/>
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

"$QLMANAGE_BIN" -t -s 1080 -o "$LAYER_DIR" "$LAYER_DIR/foreground-overlay.svg" "$LAYER_DIR"/avatar-head-*.svg >/dev/null 2>&1

make_alpha_png() {
  local input="$1"
  local output="${input%.png}.alpha.png"
  "$FFMPEG_BIN" -y -i "$input" -vf 'colorkey=0x00ff01:0.01:0.0,format=rgba' -frames:v 1 "$output" >/dev/null 2>&1
  mv -f "$output" "$input"
}

make_alpha_png "$LAYER_DIR/foreground-overlay.svg.png"
for i in $(seq 1 11); do
  n=$(printf '%02d' "$i")
  make_alpha_png "$LAYER_DIR/avatar-head-$n.svg.png"
done

mv -f "$LAYER_DIR/foreground-overlay.svg.png" "$LAYER_DIR/foreground-overlay.png"
for i in $(seq 1 11); do
  n=$(printf '%02d' "$i")
  mv -f "$LAYER_DIR/avatar-head-$n.svg.png" "$LAYER_DIR/avatar-head-$n.png"
done

if [[ "$BACKGROUND" != "$LAYER_DIR/background-uk-venue.png" ]]; then
  cp "$BACKGROUND" "$LAYER_DIR/background-uk-venue.png"
fi
