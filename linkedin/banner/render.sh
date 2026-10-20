#!/usr/bin/env bash
# Render the banner HTML to the PNG LinkedIn accepts.
#
#   linkedin/banner/render.sh [html] [png]
#
# Needs a Chromium-based browser for the headless screenshot. On this machine
# that is Brave; override with CHROME=/path/to/chromium if needed.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
html="${1:-$here/banner-devops-en.html}"
png="${2:-$here/banner-devops-en.png}"

chrome="${CHROME:-/Applications/Brave Browser.app/Contents/MacOS/Brave Browser}"
if [ ! -x "$chrome" ]; then
  for c in "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
           "/Applications/Chromium.app/Contents/MacOS/Chromium"; do
    [ -x "$c" ] && chrome="$c" && break
  done
fi
[ -x "$chrome" ] || { echo "No Chromium browser found. Set CHROME=/path/to/browser." >&2; exit 1; }

"$chrome" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 \
  --window-size=1584,396 --screenshot="$png" "file://$html" 2>/dev/null
echo "wrote $png"
