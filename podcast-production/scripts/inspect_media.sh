#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: inspect_media.sh INPUT" >&2
  exit 2
fi

command -v ffprobe >/dev/null 2>&1 || {
  echo "ffprobe is required but was not found on PATH" >&2
  exit 127
}

ffprobe -hide_banner -v error \
  -show_entries format=filename,duration,size,bit_rate:stream=index,codec_type,codec_name,profile,width,height,sample_rate,channels,channel_layout,bit_rate \
  -of json "$1"
