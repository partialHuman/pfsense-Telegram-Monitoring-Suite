#!/bin/sh

send_telegram() {

    MESSAGE="$1"

    curl -s \
      -X POST \
      "$API_URL/bot$BOT_TOKEN/sendMessage" \
      -d chat_id="$CHAT_ID" \
      -d parse_mode="$PARSE_MODE" \
      --data-urlencode text="$MESSAGE" >/dev/null
}