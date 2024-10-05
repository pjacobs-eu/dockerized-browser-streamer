#!/bin/bash

set -xeo pipefail

# Create a new Chrome profile
mkdir -p /tmp/chrome-profile

# Start Chrome browser and point it at the URL we want to capture
exec google-chrome \
  --window-size=${SCREEN_WIDTH},${SCREEN_HEIGHT} \
  --no-sandbox \
  --disable-sync \
  --no-first-run \
  --user-data-dir=/tmp/chrome-profile \
  --remote-debugging-port=21222 \
  --kiosk \
  "file:///${pwd}/wait.html"