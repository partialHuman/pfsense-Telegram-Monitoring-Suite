#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

STATE_FILE="/tmp/wan_status"

# Reliable public IPs
TARGET1="8.8.8.8"
TARGET2="1.1.1.1"

STATUS="DOWN"

if ping -c 2 -t 2 $TARGET1 >/dev/null 2>&1; then
    STATUS="UP"
elif ping -c 2 -t 2 $TARGET2 >/dev/null 2>&1; then
    STATUS="UP"
fi

if [ -f "$STATE_FILE" ]; then
    PREVIOUS=$(cat "$STATE_FILE")
else
    PREVIOUS="UNKNOWN"
fi

if [ "$STATUS" != "$PREVIOUS" ]; then

    if [ "$STATUS" = "UP" ]; then

        MESSAGE="?? Internet Restored

WAN connectivity is back.

Time: $(date)"

    else

        MESSAGE="?? Internet Down

Unable to reach public Internet.

Time: $(date)"

    fi

    curl -s \
    -X POST \
    "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    --data-urlencode text="$MESSAGE" >/dev/null

    echo "$STATUS" > "$STATE_FILE"

fi