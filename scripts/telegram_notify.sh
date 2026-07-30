#!/bin/sh
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

MSG="$1"

curl -s \
-X POST \
https://api.telegram.org/bot${BOT_TOKEN}/sendMessage \
-d chat_id="${CHAT_ID}" \
-d text="${MSG}"
