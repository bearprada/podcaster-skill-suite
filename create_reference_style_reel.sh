#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SOURCE_AUDIO="/Users/prada/Desktop/槍擊埋下的23年真相_口播精剪.mp3"
SOURCE_IMAGE="/Users/prada/.codex/generated_images/01a0954b-9097-7a20-aa0e-219edc2cb1b0/exec-8956d29a-1ebf-43f7-bfc4-8bc889c23b54.png"
ASSET_DIR="$ROOT/reference-style-reel-assets"
RENDER_DIR="$ROOT/reference-style-reel-renders"
LIST_FILE="$ROOT/reference-style-reel.concat.txt"
OUTPUT="$ROOT/sample-槍擊埋下的23年真相-reference-style-reel.mp4"

mkdir -p "$ASSET_DIR" "$RENDER_DIR"
cp "$SOURCE_IMAGE" "$ASSET_DIR/host-portrait.png"

PORTRAIT_DATA="$(base64 < "$ASSET_DIR/host-portrait.png" | tr -d '\n')"

captions=(
  "劇情從二十三年前"
  "四個六年級的｜同班同學"
  "包含竹內涼真｜飾演的淳一"
  "以及井上真央｜飾演的萬季子"
  "他們在學校｜埋下了那把手槍"
  "槍擊案就此展開"
  "隨後各奔東西，試圖假裝｜一切都沒有發生"
  "但二十三年後｜淳一成為了刑警"
  "他在現場發現了｜那把手槍"
  "進而揭開二十三年前｜槍擊案的真相"
  "二十三年前的槍擊案｜真相終於浮現"
)

hooks=(
  "二十三年前"
  "四個同班同學"
  "一把被埋下的槍"
  "記憶不會消失"
  "槍擊案展開"
  "假裝沒發生"
  "23年後"
  "刑警回到現場"
  "那把手槍出現了"
  "真相被重新打開"
  "真相終於浮現"
)

angles=(-3 2 -2 3 -4 2 -2 4 -3 2 -1)
zooms=(1.00 1.03 1.06 1.02 1.05 1.01 1.04 1.07 1.03 1.06 1.02)

for i in $(seq 0 10); do
  n=$(printf '%02d' "$((i + 1))")
  caption="${captions[$i]}"
  hook="${hooks[$i]}"
  angle="${angles[$i]}"
  zoom="${zooms[$i]}"
  line1="${caption%%｜*}"
  if [[ "$caption" == *"｜"* ]]; then
    line2="${caption#*｜}"
  else
    line2=""
  fi

  cat > "$ASSET_DIR/frame-$n.svg" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1080" viewBox="0 0 1080 1080">
  <defs>
    <filter id="softBlur"><feGaussianBlur stdDeviation="24"/></filter>
    <clipPath id="portraitClip"><circle cx="540" cy="500" r="188"/></clipPath>
    <linearGradient id="shade" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#08090d" stop-opacity="0.48"/>
      <stop offset="0.48" stop-color="#08090d" stop-opacity="0.25"/>
      <stop offset="1" stop-color="#08090d" stop-opacity="0.84"/>
    </linearGradient>
  </defs>
  <g>
    <image x="0" y="-420" width="1080" height="1920" preserveAspectRatio="none" xlink:href="data:image/png;base64,$PORTRAIT_DATA" filter="url(#softBlur)"/>
    <rect width="1080" height="1080" fill="url(#shade)"/>
  </g>
  <rect x="66" y="46" width="10" height="64" rx="5" fill="#68c8e8"/>
  <text x="100" y="83" fill="#f7f4ee" font-family="PingFang TC, Noto Serif CJK TC, serif" font-size="24" letter-spacing="2">POV：一把槍，埋了 23 年</text>
  <text x="100" y="145" fill="#ffffff" font-family="PingFang TC, Noto Serif CJK TC, serif" font-size="47" font-weight="700">槍擊埋下的</text>
  <text x="100" y="200" fill="#ffffff" font-family="PingFang TC, Noto Serif CJK TC, serif" font-size="47" font-weight="700">23 年真相</text>
  <g transform="rotate($angle 540 500)">
    <circle cx="540" cy="500" r="202" fill="#f3eee6" fill-opacity="0.94"/>
    <image x="320" y="210" width="440" height="587" preserveAspectRatio="xMidYMid slice" clip-path="url(#portraitClip)" xlink:href="data:image/png;base64,$PORTRAIT_DATA"/>
    <circle cx="540" cy="500" r="202" fill="none" stroke="#f3eee6" stroke-width="7"/>
  </g>
  <text x="540" y="755" text-anchor="middle" fill="#76d5f2" font-family="PingFang TC, Noto Sans CJK TC, sans-serif" font-size="34" font-weight="700">$hook</text>
  <rect x="72" y="790" width="936" height="132" rx="22" fill="#0a1118" fill-opacity="0.78" stroke="#ffffff" stroke-opacity="0.14"/>
  <text x="540" y="846" text-anchor="middle" fill="#ffffff" font-family="PingFang TC, Noto Sans CJK TC, sans-serif" font-size="30" font-weight="600">$line1</text>
  <text x="540" y="892" text-anchor="middle" fill="#d9f4ff" font-family="PingFang TC, Noto Sans CJK TC, sans-serif" font-size="30" font-weight="600">$line2</text>
  <text x="540" y="1000" text-anchor="middle" fill="#f6a6c9" font-family="PingFang TC, Noto Sans CJK TC, sans-serif" font-size="22" letter-spacing="3">podcast.</text>
  <text x="540" y="1038" text-anchor="middle" fill="#ffffff" font-family="PingFang TC, Noto Sans CJK TC, sans-serif" font-size="20" letter-spacing="2">UK × TW ENTERTAINMENT</text>
  <text x="1000" y="1036" text-anchor="end" fill="#ffffff" fill-opacity="0.62" font-family="Arial, sans-serif" font-size="17">$((i + 1))/11</text>
</svg>
EOF
  qlmanage -t -s 1080 -o "$RENDER_DIR" "$ASSET_DIR/frame-$n.svg" >/dev/null 2>&1
done

cat > "$LIST_FILE" <<EOF
file '$RENDER_DIR/frame-01.svg.png'
duration 1.62
file '$RENDER_DIR/frame-02.svg.png'
duration 2.34
file '$RENDER_DIR/frame-03.svg.png'
duration 2.28
file '$RENDER_DIR/frame-04.svg.png'
duration 2.64
file '$RENDER_DIR/frame-05.svg.png'
duration 3.10
file '$RENDER_DIR/frame-06.svg.png'
duration 1.28
file '$RENDER_DIR/frame-07.svg.png'
duration 3.66
file '$RENDER_DIR/frame-08.svg.png'
duration 3.22
file '$RENDER_DIR/frame-09.svg.png'
duration 2.72
file '$RENDER_DIR/frame-10.svg.png'
duration 3.62
file '$RENDER_DIR/frame-11.svg.png'
duration 3.28
file '$RENDER_DIR/frame-11.svg.png'
EOF

cp "$ROOT/synced-captions.srt" "$ROOT/reference-style-captions.srt"

/opt/homebrew/bin/ffmpeg -y -f concat -safe 0 -i "$LIST_FILE" -ss 8.70 -t 29.76 -i "$SOURCE_AUDIO" -loop 1 -i "$ASSET_DIR/host-portrait.png" \
  -filter_complex "[2:v]scale=1080:1920,gblur=sigma=34[bgv];[0:v]scale=1080:1080[fgv];[bgv][fgv]overlay=0:420:shortest=1,format=yuv420p[v]" -map "[v]" -map 1:a \
  -r 30 -c:v libx264 -preset medium -crf 18 -c:a aac -b:a 192k -ar 48000 -ac 2 -shortest "$OUTPUT"

/opt/homebrew/bin/ffprobe -v error -show_entries format=duration:stream=codec_name,width,height,sample_rate,channels -of default=noprint_wrappers=1 "$OUTPUT"
